// EchoVRStats.cpp : Defines the entry point for the application.
//
#define _CRT_SECURE_NO_WARNINGS

// prefix applied to metric names ( "prefixPing" instead of just "Ping")
#define METRIC_PREFIX "EchoSession_" 


#include "EchoVRStats.h"
#include <iostream>
#include <string>
#include <fstream> 
#include <exception>
#include <sstream>
#include <stdexcept>
#include <list>
#include <curl/curl.h>
#include "curl/easy.h"
#include <nlohmann/json.hpp>
#include <prometheus/prometheus.h>
#include <cxxopts.hpp>

using json = nlohmann::json;


using namespace std;

// used by httpGet
static size_t WriteCallback(void* contents, size_t size, size_t nmemb, std::string* s)
{
    size_t newLength = size * nmemb;
    s->append((char*)contents, newLength);
    return newLength;
}

// used by ReadResponse
int httpGet(const std::string& url, std::string& strResponse)
{
    static thread_local CURL* s_curl = curl_easy_init();
    long nStatusCode = 0;


    strResponse.clear();

    if (s_curl)
    {
        curl_easy_reset(s_curl);
        curl_easy_setopt(s_curl, CURLOPT_URL, url.c_str());
        curl_easy_setopt(s_curl, CURLOPT_WRITEFUNCTION, WriteCallback);
        curl_easy_setopt(s_curl, CURLOPT_WRITEDATA, &strResponse);
        CURLcode res = curl_easy_perform(s_curl);

        if (res != CURLE_OK)
        {
            curl_easy_cleanup(s_curl);
            throw std::runtime_error("HTTP GET failed with error " + std::to_string((int)res));
        }
        curl_easy_getinfo(s_curl, CURLINFO_RESPONSE_CODE, &nStatusCode);
    }
    else
    {
        throw std::runtime_error("Unable to initialize curl");
    }
    return nStatusCode;
    
}

// parses the source string, reads the data, and parses the data into an EchoSessionData object
void ReadResponse(std::string strSource, EchoSessionData& sess)
{
    sess.m_Players.clear(); // just in case a re-used object is being passed in
    sess.m_SessionType = sess.UNKNOWN;

    std::string strResponse;
    long nStatusCode = 0;

    if (strSource.starts_with("http"))
    {
        // source will be something like "http://127.0.0.1:1234"
        std::string apiUrl = strSource + "/session";
        try
        {
            nStatusCode = httpGet(apiUrl, strResponse);
        }
        catch (std::exception& /*e*/)
        {
            //std::cerr << "Error: " << e.what() << std::endl;
            sess.m_SessionType = sess.ERR;
            nStatusCode = -1;
        }
        sess.m_strSource = strSource.substr(strSource.rfind(':') + 1);
    }
    else
    {
        std::ifstream t(strSource);
        std::stringstream buffer;
        buffer << t.rdbuf();
        strResponse = buffer.str();
        nStatusCode = 200;
        size_t slashPosition = strSource.rfind('\\');
        sess.m_strSource = (slashPosition == std::string::npos ? strSource : strSource.substr(slashPosition + 1));
    }

    sess.SetTimestampNow();
    switch (nStatusCode)
    {
    case -1:
        sess.m_SessionType = sess.ERR;
        break;
    case 404:
        sess.m_SessionType = sess.IDLE;
        break;
    case 500:
        sess.m_SessionType = sess.LOBBY;
        break;
    case 200:
        {
            auto j = json::parse(strResponse);

            sess.m_strSessionID = j["sessionid"];
            sess.m_SessionType = (j["match_type"] == "Echo_Combat") ? sess.ECHO_COMBAT : sess.ECHO_ARENA;
            sess.m_bIsPrivate = j["private_match"];

            for (auto team : j["teams"].items())
                for (auto player : team.value()["players"])
                    sess.m_Players.emplace_back(player["name"], (unsigned long long)player["userid"], player["playerid"], player["ping"], player["packetlossratio"]);
        }
        break;
    default:
        sess.m_SessionType = sess.UNKNOWN;
    }
}
// a version of ReadResponse() that returns the EchoSessionData instead of populating a reference
EchoSessionData ReadResponse2(std::string strSource)
{
    EchoSessionData sess;
    ReadResponse(strSource, sess);
    return sess;
}


/*
For prometheus:

override Registry::serialize() to fetch data from the echovr instances (datasources) on demand
*/
class MyRegistry : public prometheus::Registry
{
    std::string m_strPingLabel;
    std::string m_strPacketLossLabel;
    std::list<std::string> m_dataSources;
public:

    // set up the metric labels/measurements/whatever_term_prometheus_uses
    MyRegistry(std::list<std::string> sources) : m_dataSources(sources)
    {
        m_strPingLabel = METRIC_PREFIX"Ping";
        m_strPacketLossLabel = METRIC_PREFIX"PacketLossRatio";
    }

    virtual void serialize(std::ostream& out) override
    {
        using namespace prometheus;
        // there's no way to know what metrics might be used each iteration, so clear them all out
        this->RemoveAll();

        std::vector<EchoSessionData> sessions;
        std::vector<std::future<EchoSessionData>> futures;

        // for each data source...
        for (auto src : m_dataSources)
        {
            // spawn a thread for each data source to capture it's own session data
            //  (don't like returning the EchoSessionData via copy, but that's a tradeoff of shoving it in a thread safely)
            futures.push_back(std::async(std::launch::async, ReadResponse2, src));
        }
        // wait until all the sessions are read before populating any metrics. This ensures things stay in
        // order (if that matters)
        
        for (auto& f : futures)
            sessions.push_back(f.get());
        futures.clear();

        for (auto &sess : sessions)
        {
            switch (sess.m_SessionType)
            {
            case EchoSessionData::UNKNOWN:
                cout << "?";
                break;
            case EchoSessionData::ERR:
                cout << "E";
                break;
            case EchoSessionData::IDLE:
                // cout << "."; nop
                break;
            case EchoSessionData::LOBBY:
                cout << "L";
                break;
            case EchoSessionData::ECHO_COMBAT:
            case EchoSessionData::ECHO_ARENA:
                for (auto p : sess.m_Players)
                {
                    gauge_metric_t b_gauge(*this, m_strPingLabel, "ping rate, in milliseconds, reported by the echovr app",
                        {
                            {"matchtype", ((sess.m_SessionType == sess.ECHO_COMBAT) ? "Echo Combat" : "Echo Arena")},
                            {"sessionid", sess.m_strSessionID },
                            {"isprivate", (sess.m_bIsPrivate ? "true" : "false")},
                            {"userid", std::to_string(p.m_llUserId)},
                            {"playername", p.GetPlayerNameEscaped()},
                            {"server", sess.m_strSource }
                        });
                    b_gauge.Set(p.m_nPing);

                    gauge_t<double&> c_gauge(*this, m_strPacketLossLabel, "packet loss ratio reported by the echovr app",
                        {
                            {"matchtype", ((sess.m_SessionType == sess.ECHO_COMBAT) ? "Echo Combat" : "Echo Arena")},
                            {"sessionid", sess.m_strSessionID },
                            {"isprivate", (sess.m_bIsPrivate ? "true" : "false")},
                            {"userid", std::to_string(p.m_llUserId)},
                            {"playername", p.GetPlayerNameEscaped()},
                            {"server", sess.m_strSource }
                        });
                    c_gauge.Set(p.m_dPacketLossRatio);
                }
                cout << (char)((sess.m_SessionType == sess.ECHO_COMBAT) ? 'C' : 'A');

                break;
            default:
                cout << "?";
                break;
            } // switch
        }  // for each sessions     
        // call the parent's serialize
        Registry::serialize(out);
    }
};

void SpinUpPrometheusListener(std::string strIPSpecToListenOn, std::list<std::string>& sources)
{
    using namespace prometheus;

    MyRegistry registry(sources);

    // add a single dummy metric. This will get removed later
    gauge_metric_t a_gauge(registry, "hello", "dummy metric", { {"status", "starting up"} });

    // This actually spawns a thread, but doesn't expose the thread object.  
    http_server_t server(registry, strIPSpecToListenOn);
    
    // there appears to be no way to get the thread info to wait for it, so just spin forever
    while(true)
        std::this_thread::sleep_for(std::chrono::seconds(1));
}



int main(int argc, char **argv)
{
    cxxopts::Options opts("EchoVRStats", "Program to monitor EchoVR.exe servers and make their API data available to Prometheus");

    opts.add_options()
        ( "p,port", "EchoVR.exe API port to poll. Use multiple times for multiple servers", cxxopts::value<std::vector<unsigned>>())
        ( "f,file", "File that contains API /session data. Used for debugging, usually in place of a port. Use multiple times for multiple files.", cxxopts::value<std::vector<std::string>>())
        ("l,listen", "prometheus compatible IP spec to listen on.  ie: 0.0.0.0:9100", cxxopts::value<std::string>()->default_value("0.0.0.0:9100"))
        ;

    try
    {
        auto paramResult = opts.parse(argc, argv);

        bool bNeedsHelp = false;

        std::list<std::string> sources;
        if (paramResult["port"].count())
            for (auto port : paramResult["port"].as<std::vector<unsigned>>())
            {
                // echovr API _must_ be localhost
                sources.emplace_back("http://127.0.0.1:" + std::to_string(port));
            }
        if (paramResult["file"].count())
            for (auto file : paramResult["file"].as<std::vector<std::string>>())
            {
                sources.emplace_back(file);
            }
        if (!sources.size() || bNeedsHelp)
        {
            cout << opts.help() << endl;
        }
        else
        {
            cout << "Will listen on http://" << paramResult["listen"].as<std::string>() << "/metrics and poll servers in response.\n";
            cout << "Polling servers at:\n";
            for (auto s : sources)
                cout << "\t" << s << endl;

            cout <<  "\nStatus indicators:\n\tA - Arena Game\n\tC - Combat Game\n\tL - Lobby\n\tE - Error (AKA sprockee's fault)\n\t? - Unknown\n\t    Idle servers won't show status\n\n";

            curl_global_init(CURL_GLOBAL_DEFAULT);

            SpinUpPrometheusListener(paramResult["listen"].as<std::string>(), sources);
            curl_global_cleanup();
        }
    }
    catch (std::exception& e)
    {
        std::cerr << "Error: " << e.what() << std::endl;
    }

    return 0;
}


