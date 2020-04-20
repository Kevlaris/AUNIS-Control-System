-- dial.lua v2.1
-- made by Kevlaris

local c = require("component")
local event = require("event")
local serialization = require("serialization")
local modem = c.modem
local port = 123
local os = require("os")

local address

print("SGC Dialing program v2.1 /by Kevlaris")
print("")
print("How many symbols do you want to dial?(7/8/9)")
num = io.read()
print()
if num == "7" then
	print("The program will require 6 symbols from you (7th symbol is automatic). Start typing now.")
	chev1 = io.read()
	chev2 = io.read()
	chev3 = io.read()
	chev4 = io.read()
	chev5 = io.read()
	chev6 = io.read()
	chev7 = "Point of Origin"
		if chev1 == chev2 or chev1 == chev3 or chev1 == chev4 or chev1 == chev6 or chev1 == chev7 or chev2 == chev3 or chev2 == chev4 or chev2 == chev6 or chev2 == chev7 or chev3 == chev4 or chev3 == chev5 or chev3 == chev6 or chev3 == chev7 or chev4 == chev5 or chev4 == chev6 or chev4 == chev7 or chev5 == chev6 or chev5 == chev7 or chev6 == chev7 then
			print("ERROR: Two symbols are the same")
		else
	
	address_raw = {chev1, chev2, chev3, chev4, chev5, chev6, chev7}
	print()
	print("Confirm address: ".. chev1 ..", ".. chev2 ..", ".. chev3 ..", ".. chev4 ..", ".. chev5 ..", ".. chev6 ..", ".. chev7 .." (y/n)")
	local answer = io.read()
	if answer == "y" then
		address = serialization.serialize(address_raw)
		modem.broadcast(port, "dial", address)
		print("Address sent to gate computer.")
	end
	end
elseif num == "8" then
	print("The program will require 7 symbols from you (8th symbol is automatic). Write the symbols' full names.")
	chev1 = io.read()
	chev2 = io.read()
	chev3 = io.read()
	chev4 = io.read()
	chev5 = io.read()
	chev6 = io.read()
	chev7 = io.read()
	chev8 = "Point of Origin"
	if chev1 == chev2 or chev1 == chev3 or chev1 == chev4 or chev1 == chev6 or chev1 == chev7 or chev1 == chev8 or chev2 == chev3 or chev2 == chev4 or chev2 == chev6 or chev2 == chev7 or chev2 == chev8 or chev3 == chev4 or chev3 == chev5 or chev3 == chev6 or chev3 == chev7 or chev3 == chev8 or chev4 == chev5 or chev4 == chev6 or chev4 == chev7 or chev4 == chev8 or chev5 == chev6 or chev5 == chev7 or chev5 == chev8 or chev6 == chev7 or chev6 == chev8 or chev7 == chev8 then
			print("ERROR: Two symbols are the same")
		else
	
	address_raw = {chev1, chev2, chev3, chev4, chev5, chev6, chev7, chev8}
	print()
	print("Confirm address: ".. chev1 ..", ".. chev2 ..", ".. chev3 ..", ".. chev4 ..", ".. chev5 ..", ".. chev6 ..", ".. chev7 ..", ".. chev8 .." (y/n)")
	local answer = io.read()
	if answer == "y" then
		address = serialization.serialize(address_raw)
		modem.broadcast(port, "dial", address)
		print("Address sent to gate computer.")
	end
	end
elseif num == "9" then
	print("The program will require 8 symbols from you (9th symbol is automatic). Start typing now.")
	chev1 = io.read()
	chev2 = io.read()
	chev3 = io.read()
	chev4 = io.read()
	chev5 = io.read()
	chev6 = io.read()
	chev7 = io.read()
	chev8 = io.read()
	chev9 = "Point of Origin"
		if chev1 == chev2 or chev1 == chev3 or chev1 == chev4 or chev1 == chev6 or chev1 == chev7 or chev1 == chev8 or chev1 == chev9 or chev2 == chev3 or chev2 == chev4 or chev2 == chev6 or chev2 == chev7 or chev2 == chev8 or chev2 == chev9 or chev3 == chev4 or chev3 == chev5 or chev3 == chev6 or chev3 == chev7 or chev3 == chev8 or chev3 == chev9 or chev4 == chev5 or chev4 == chev6 or chev4 == chev7 or chev4 == chev8 or chev4 == chev9 or chev5 == chev6 or chev5 == chev7 or chev5 == chev8 or chev5 == chev9 or chev6 == chev7 or chev6 == chev8 or chev6 == chev9 or chev7 == chev8 or chev7 == chev9 or chev8 == chev9 then
			print("ERROR: Two symbols are the same")
		else
	
	address_raw = {chev1, chev2, chev3, chev4, chev5, chev6, chev7, chev8, chev9}
	print()
	print("Confirm address: ".. chev1 ..", ".. chev2 ..", ".. chev3 ..", ".. chev4 ..", ".. chev5 ..", ".. chev6 ..", ".. chev7 ..", ".. chev8 ..", ".. chev9 .." (y/n)")
	local answer = io.read()
	if answer == "y" then
		address = serialization.serialize(address_raw)
		modem.broadcast(port, "dial", address, 9)
		print("Address sent to gate computer.")
	end
	end
elseif num ~= "9" or num ~= "8" or num ~= "7" then
print("ERROR: number is not 7 or 8")
else
print("UNKNOWN ERROR")
end
