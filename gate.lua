-- gate.lua v1.3
-- made by Kevlaris

c = require("component")
event = require("event")
os = require("os")
event = require("event")
serialization = require("serialization")
sg = c.stargate
modem = c.modem
port = 123
asd = 1
lockdown = false
print("SGC Gate Computer Program v1.3 /by Kevlaris")
print("--------------------------------------------------------------------------------------------------------------------------------------------------------------")
print()

repeat
	modem.open(port)
	print("Port opened. Listening for incoming messages and events")
	print()

	_, _, _, _, _, raw = event.pull(nil, "modem_message")
	modem.close(port)
	print("Message recieved.")
	os.sleep(0.5)
	
	if raw == "sd" then
		print("Attempting to shut down wormhole")
		os.sleep(0.7)
		local status, b, c = sg.disengageGate()

		if status == "stargate_disengage" then
			print("Wormhole shutdown successful.")
		else
			print("ERROR: ".. c)
			print()
		end

	elseif raw == "lockdown" then
	repeat
		lockdown = true
		print("Lockdown protocol initiated. Port closed, Stargate control paused.")
		modem.open(port)
		local _, _, _, _, _, ld = event.pull(nil, "modem_message")
		if ld == "lockdown_over" then
			print("Lockdown protocol cancelled.")
			lockdown = false
		end
		until lockdown == false
	else
		local address = serialization.unserialize(raw)
		if type(address) == "table" then
			print()
			os.sleep(0.5)
			print("Dialing")
			for i,v in ipairs(address) do print(i,v) end
			print()

			function dialNext(dialed)
				glyph = address[dialed + 1]
				print("Engaging "..glyph.."... ")
				local statu, d, e = sg.engageSymbol(glyph)
				if statu ~= "stargate_spin" then
					print("ERROR: ".. e)
					print()
				end
			end
		end

		eventID = event.listen("stargate_spin_chevron_engaged", function(evname, address, caller, num, lock, glyph)	
			os.sleep(2)
		
			if lock then
				if (event.cancel(eventID)) then
					print("Event cancelled successfully")
				end
		
				os.sleep(2)
		
				print("Engaging...")
				local stat, ef, g = sg.engageGate()
				if stat ~= "stargate_engage" then
					print("ERROR: ".. g)
					print()
				end
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
