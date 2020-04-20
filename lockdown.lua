-- lockdown.lua v1 - PRIVATE
-- made by Kevlaris

c = require("component")

-- Modify these addresses to yours, add new or delete if you have to
gateb = c.proxy("e460d574-0685-4bd2-8d86-0f802fde85c4") 
gatec = c.proxy("c1b7e2c7-c58a-4253-b554-823b13e7c0b3")
rd = c.proxy("964275ab-dadc-411a-a197-31dea660eb14")

alarm = c.os_alarm
modem = c.modem
port = 123
os = require("os")
event = require("event")

print("Enter password")
local password = io.read()
if password == "SGC123" then -- Modify SGC123 to the doors' password (use one password for all of them)
  print("Access Granted.")
else
  print("Access Denied.")
end
print()
print("Do you want to lock down the gateroom?(y/n)")
local answer = io.read()
if answer == "y" then
  print()
  modem.broadcast(port, "lockdown")
  alarm.setAlarm("sgcalarm2")
  alarm.setRange(15)
  alarm.activate()
  gateb.close(password)
  gatec.close(password)
  rd.close(password)
  print("Lockdown protocol initiated. Press SPACE to cancel lockdown.")
  local _, _, key1, key2, _ = event.pull("key_down")
  if key1 == 32 and key2 == 57 then
    print()
    print("Enter password")
    local password2 = io.read()
    if password2 == password then
	  modem.broadcast(port, "lockdown_over")
      rd.open(password2)
      gateb.open(password2)
      gatec.open(password2)
      print()
      print("Lockdown protocol cancelled.")
      os.sleep(1.5)
      alarm.deactivate()
    else
      print("Incorrect password.")
    end
   end
end
