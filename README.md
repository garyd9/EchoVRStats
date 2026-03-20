This is intended to be run on the same machine that's running echovr.exe servers.  The servers should have API enabled. Note which port(s) are listening for API requests...

Then, at minimum, run this console app in another window providing a "-p" parameter for each API port.  So, if you have 2 echovr.exe instances and they're using ports 6792 and 6794 for API, run:

echovrstats.exe -p 6792 -p 6794

This program will then listen for a prometheus (or promestheus compatible) server requesting metrics from the "/metrics" endpoint on port 9100 (by default.)  

For example, if the machine running echovr has an IP of 192.168.0.5, then promethues should be configured to scrape from "http://192.168.0.5:9100/metrics"

When echovrStats.exe gets a request on that /metrics endpoint, it will poll all the configured echovr.exe API ports for /session data and return that data to promethues.  
