-- gate.lua v1.1
-- made by Kevlaris

c = require("component")
event = require("event")
os = require("os")
event = require("event")
serialization = require("serialization")
sg = c.stargate
modem = c.modem
port = 123
local asd = 1
print("SGC Gate Computer Program v1.1 /by Kevlaris")
print("--------------------------------------------------------------------------------------------------------------------------------------------------------------")
print()

repeat
	modem.open(port)
	print("Port opened. Listening for incoming messages and events")
	print()

	local _, _, _, _, _, raw, address_raw = event.pull(nil, "modem_message")
	modem.close(port)
	print("Message recieved.")
	os.sleep(0.5)
	
	if raw == "sd" then
		print("Attempting to shut down wormhole")
		os.sleep(0.7)
		sg.disengageGate()
	elseif raw == "dial" then
		local address = serialization.unserialize(address_raw)
		print()
		os.sleep(0.5)
		print("Dialing")
		for i,v in ipairs(address) do print(i,v) end
		print()

		function dialNext(dialed)
			glyph = address[dialed + 1]
			print("Engaging "..glyph.."... ")

			sg.engageSymbol(glyph)
		end

		eventID = event.listen("stargate_spin_chevron_engaged", function(evname, address, caller, num, lock, glyph)	
			os.sleep(2)
		
			if lock then
				if (event.cancel(eventID)) then
					print("Event cancelled successfully")
				end
		
				os.sleep(2)
		
				print("Engaging...")
				sg.engageGate()
		
				doing = false
			else
				dialNext(num)
			end
		end)

		dialNext(0)
		doing = true
		print()
		while doing do os.sleep(0.1) end
	end
until asd == 2
