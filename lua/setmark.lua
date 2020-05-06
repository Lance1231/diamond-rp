script_name('Setmark')
script_authors('Ray.prod and Royan Millans')

require "lib.moonloader"
local sampev = require 'lib.samp.events'
local check_number_status, lastnumber = false, nil

function main()
	if not isSampfuncsLoaded() or not isSampLoaded() then return end
	while not isSampAvailable() do
		wait(0)
	end
	print("Author - Ray.prod&Royan Millans")
	sampRegisterChatCommand("semark", function(args)
		local number = args:match("^(%d+)")
		if number then
			if number:len() > 3 then
				sampSendChat("/setmark " .. number)
			else
				check_number_status = true
				sampSendChat("/number " .. number)
			end
		end
	end)
	wait(-1)
end

-- function sampev.onSendCommand(command)
-- 	-- local number = command:match("^/semark (%d+)")
-- end

function sampev.onServerMessage(color, text)
	if check_number_status then
		if text == 'Абонент доступен для звонка' then
			check_number_status = false
			-- sampSendChat("/setmark "..lastnumber..'')
			return false
		elseif text:find('{33FF1F}Номер') then
			local number = string.match(text, '{33FF1F}Номер .+: {FF5500}(%d+)')
			sampSendChat("/setmark " .. number)
			-- return false
		end
	end
end