script_name("Fix DRP")
script_author("Nick_Sinner")

require "lib.moonloader"

function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end

	sampAddChatMessage("Х {0FF294}[Fix DRP] {FFFFFF}‘икс команд включен! –аботает стабильно только на DRP.", 0x0FF294)
	sampAddChatMessage("Х {0FF294}[Fix DRP] {FFFFFF}—крипт создал - {0FF294}https://vk.com/truckergadgets", 0x0FF294)

	sampRegisterChatCommand("id", id)
	sampRegisterChatCommand("ud", ud)
	sampRegisterChatCommand("pts", pts)
	sampRegisterChatCommand("med", med)
	sampRegisterChatCommand("lic", lic)
	sampRegisterChatCommand("pass", pass)
	sampRegisterChatCommand("skill", skill)
	sampRegisterChatCommand("namestore", namestore)

	while true do	wait(0)

		result, id = sampGetPlayerIdByCharHandle(PLAYER_PED)

	end
end

function id(arg)
	if arg ~= "" then
		sampSendChat("/id " .. arg)
	else
		sampSendChat("/id " .. id)
	end
end

function ud(arg)
	if arg ~= "" then
		sampSendChat("/ud " .. arg)
	else
		sampSendChat("/ud " .. id)
	end
end

function pts(arg)
	if arg ~= "" then
		sampSendChat("/pts " .. arg)
	else
		sampSendChat("/pts " .. id)
	end
end

function skill(arg)
	if arg ~= "" then
		sampSendChat("/skill " .. arg)
	else
		sampSendChat("/skill " .. id)
	end
end

function pass(arg)
	if arg ~= "" then
		sampSendChat("/pass " .. arg)
	else
		sampSendChat("/pass " .. id)
	end
end

function med(arg)
	if arg ~= "" then
		sampSendChat("/med " .. arg)
	else
		sampSendChat("/med " .. id)
	end
end

function lic(arg)
	if arg ~= "" then
		sampSendChat("/lic " .. arg)
	else
		sampSendChat("/lic " .. id)
	end
end

function namestore(arg)
	if arg ~= "" then
		sampSendChat("/namestore " .. arg)
	else
		sampSendChat("/namestore " .. id)
	end
end
