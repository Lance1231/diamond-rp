script_name('SMSHelper')
script_authors('Royan Millans')

--===============================ÎÒÊËŞ×ÈÒÜ ÑÎÎÁÙÅÍÈÅ ÏĞÈ ÂÕÎÄÅ Â ÈÃĞÓ====================================--
message_on_start_game = true -- ÓÑÒÀÍÎÂÈÒÅ - "false" ÂÌÅÑÒÎ "true" ×ÒÎÁÛ ÎÒÊËŞ×ÈÒÜ ÑÎÎÁÙÅÍÈÅ
--=======================================================================================================--

require "lib.moonloader"
local sampev = require 'lib.samp.events'
lastnumber = nil
check_number_status = false
send_sms_message = nil

function main()
	if not isSampfuncsLoaded() or not isSampLoaded() then return end
	while not isSampAvailable() do
		wait(0)
	end
	print("Author - Royan Millans")
	if message_on_start_game then sampAddChatMessage("{FF8C00}[SMS Helper]{FFFFFF} by {FF8C00}R{FFFFFF}oyan {FF8C00}M{FFFFFF}illans", -1) end
	while true do
		wait(0)
	end
end

function sampev.onSendCommand(command)
	if command:find('/sms') then
		local number, message = string.match(command, '/sms (%d+) (.+)')
		if number ~= nil and string.len(number) > 3 then
			lastnumber = number
		elseif number == nil and lastnumber ~= nil then
			local message = string.match(command, '/sms (.+)')
			return {'/sms '..lastnumber..' '..message}
		elseif number ~= nil and string.len(number) <= 3 then
			check_number_status = true
			send_sms_message = message
			return {'/number '..number}
		end
	end
end

function sampev.onServerMessage(color, text)
	if check_number_status and text:find('{33FF1F}Íîìåğ') or text == 'Àáîíåíò äîñòóïåí äëÿ çâîíêà' then
		if text:find('{33FF1F}Íîìåğ') then
			local _, number = string.match(text, '{33FF1F}Íîìåğ (.+): {FF5500}(%d+)')
			lastnumber = number
			return false	
		end
		if text == 'Àáîíåíò äîñòóïåí äëÿ çâîíêà' and send_sms_message ~= nil then
			check_number_status = false
			sampSendChat("/sms "..lastnumber..' '..send_sms_message)
			send_sms_message = nil
			return false
		end
	end
	if text:find('{FF8C00}SMS: {FFFF00}')
	then
		local _, _, number = string.match(text, '{FF8C00}SMS: {FFFF00}(.+){FF8C00}| {FFFF00}Îòïğàâèòåëü: (.+) %(òåë%. (%d+)%)')
		if number ~= nil then
			lastnumber = number	
		end
	end
end