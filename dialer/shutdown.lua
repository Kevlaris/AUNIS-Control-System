local c = require("component")
local modem = c.modem
local port = 123

print("SGC Wormhole Shutdown Program v1")
print()
print("Ordering Stargate computer to shut down wormhole..")
modem.broadcast(port, "sd")
