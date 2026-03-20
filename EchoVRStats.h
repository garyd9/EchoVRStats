// EchoVRStats.h : Include file for standard system include files,
// or project specific include files.

#pragma once
#include <string>
#include <list>
#include <chrono>

class EchoPlayerData
{
public:
    std::string m_strName;
    unsigned long long m_llUserId;
    unsigned m_nPlayerID;
    unsigned m_nPing;
    double m_dPacketLossRatio;

    std::string GetPlayerNameEscaped(void) const
    {
        std::string str = m_strName;
        for (size_t i = 0; i < str.length(); i++)
            if (str[i] == ' ')
                // Replace the single space character with the 2-character sequence "\\ "
                str.replace(i++, 1, "\\ ");
        return str;
    };

    // make a simple constructor with ALL the elements for use with emplace
    EchoPlayerData(std::string name,
        unsigned long long userID,
        unsigned playerID,
        unsigned ping,
        double packetloss) : m_strName(name), m_llUserId(userID), m_nPlayerID(playerID), m_nPing(ping), m_dPacketLossRatio(packetloss)
    {
    };

};

class EchoSessionData
{


public:
    enum SessionType
    {
        UNKNOWN = 0,
        ERR,
        IDLE,
        ECHO_ARENA,
        ECHO_COMBAT,
        LOBBY
    };

    SessionType m_SessionType{ SessionType::IDLE };
    std::string m_strSessionID{};
    bool m_bIsPrivate{ false };
    long long   m_nTimestamp{ 0 };
    std::string m_strSource{};

    void SetTimestampNow(void)
    {
        auto now = std::chrono::system_clock::now();
        auto epoch_milliseconds = std::chrono::time_point_cast<std::chrono::milliseconds>(now);
        m_nTimestamp = epoch_milliseconds.time_since_epoch().count();
        m_nTimestamp *= 1000000;
    };

	std::list<EchoPlayerData> m_Players;

    EchoSessionData()
    {
        SetTimestampNow();
        m_Players.clear();
    };
};

