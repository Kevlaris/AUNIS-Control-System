-- gate.lua v1.4 - PRIVATE
-- by Kevlaris

c = require("component")
event = require("event")
os = require("os")
event = require("event")
serialization = require("serialization")
sg = c.stargate
alarm = c.os_alarm
modem = c.modem
port = 123
aunisPort = 666
asd = 1
lockdown = false
print("SGC Gate Computer Program v1.4 /by Kevlaris")
print("--------------------------------------------------------------------------------------------------------------------------------------------------------------")
print()

repeat

	event.listen("stargate_incoming_wormhole", function()
		print("Incoming wormhole. Raising alarm")
		alarm.setAlarm("sgcalarm")
		alarm.setRange(15)
		alarm.activate()
		local _, caller = event.pull(nil, "stargate_close")
		if caller == false then
			print("No active wormhole detected. Deactivating alarm")
			alarm.deactivate()
		end
	end)

	event.listen("stargate_close", function()
		alarm.deactivate()
		os.sleep(2)
	end)

	modem.open(port)
	modem.open(666)
	print("Port opened. Listening for incoming messages and events")
	print()

	_, _, _, incomingPort, _, raw, raw_address, chev = event.pull(nil, "modem")
	modem.close(incomingPort)
	print("Message recieved.")
	os.sleep(0.5)
	
	if raw == "sd" then
		print("Attempting to shut down wormhole")
		os.sleep(0.7)
		sg.disengageGate()

elseif incomingPort == 666 then
  print("Incoming message from ".. raw_address .."'s Universe Dialer")
  print("Message: ".. raw)

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
	elseif raw == "dial" then
		if chev == "9" then
			getMaxEnergyStored()
		end
		local address = serialization.unserialize(raw_address)
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
