script_name("IgnoreSMS for Diamond RP")
script_author("Lucifer Melton")

function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then error("need sampfuncs") end
	while not isSampAvailable() do wait(100) end
	if not doesDirectoryExist("moonloader/config") then createDirectory("moonloader/config") end
	if doesFileExist("moonloader/config/IgnoreSMS.json") then
		local f = io.open("moonloader/config/IgnoreSMS.json")
		config = decodeJson(f:read("*a"))
		f:close()
	else
		config = {["Lucifer_Melton"] = os.date("%d.%m.%Y | %H:%M:%S")}
		savejson(config, "moonloader/config/IgnoreSMS.json")
	end
	sampRegisterChatCommand("sig", function() lua_thread.create(cmd_sig) end)
	wait(-1)
end

function cmd_sig()
	::dialog_1::
	players = {"{00ff45}Ник\t{00ff45}Дата"}
	collectplayers = 0
	table.foreach(config, function(nick, date) table.insert(players, string.format("%s\t%s", nick, date)); collectplayers = collectplayers + 1 end)
	sampShowDialog(4321,  string.format("{FFFFFF}Всего игроков: {00ff45}%d {FFFFFF}| Автор: {9D633A}%s", collectplayers, table.concat(thisScript().authors, ", ")), table.concat(players, "\n").."\n \n{00ff45}+ Добавить игрока", "{6495ED}Выбрать", "{6495ED}Закрыть", 5)
	repeat
		wait(0)
		local result, button, list, input = sampHasDialogRespond(4321)
		if result then
			if button == 0 then
				return
			else
				local text = sampGetListboxItemText(list)
				if text:find("%w+_%w+") then
					::dialog_2::
					sampShowDialog(4322, "{6495ED}"..text, "{FFFFFF}Вынести игрока из списка игнора?", "{6495ED}Да", "{6495ED}Нет", 0)
					repeat
						wait(0)
						local result, button, _, input = sampHasDialogRespond(4322)
						if result then
							if button == 1 then
								config[text] = nil
								savejson(config, "moonloader/config/IgnoreSMS.json")
								sampAddChatMessage("Игрок "..text.." вынесен из списка.", 13553358)
								goto dialog_1
							else goto dialog_1 end
						end
					until result
				elseif text:find("Добавить игрока") then
					::dialog_3::
					sampShowDialog(4323, "{6495ED}Добавить игрока", "Введите в поле ниже Nick (Например: Lucifer_Melton) или ID игрока", "{6495ED}Далее", "{6495ED}Назад", 1)
					repeat
						wait(0)
						local result, button, _, input = sampHasDialogRespond(4323)
						if result then
							if button == 1 then
								if input ~= "" then
									if input:find("%d+") then
										if sampIsPlayerConnected(input) then
											name = sampGetPlayerNickname(tonumber(input))
										else sampAddChatMessage("Игрок с данным ID не подключен к серверу.", 13553358); goto dialog_3 end
									elseif input:find("%w+_%w+") then
										name = tostring(input)
									else sampAddChatMessage("Введите в поле только Nick (Например: Lucifer_Melton) или ID игрока", 13553358); goto dialog_3 end
									config[name] = os.date("%d.%m.%Y | %H:%M:%S")
									savejson(config, "moonloader/config/IgnoreSMS.json")
									sampAddChatMessage("Игрок "..name.." вынесен из списка.", 13553358)
									goto dialog_1
								else goto dialog_1 end
							else goto dialog_1 end
						end
					until result
				else sampAddChatMessage("А тут пусто.", 13553358); goto dialog_1 end
			end
		end
	until result
end

function onReceiveRpc(id, bs)
    if id == 93 then
        local color = raknetBitStreamReadInt32(bs)
        local strlen = raknetBitStreamReadInt32(bs)
        local text = raknetBitStreamReadString(bs, strlen)
		if color == -65366 then
			for nick, date in pairs(config) do
				if text:find("%{FF8C00%}SMS: %{FFFF00%}(.*) %{FF8C00%}%| %{FFFF00%}Отправитель: "..nick.." %(тел%. (%d+)%)") then
					return false
				end
			end
		end
    end
end

function savejson(table, path)
    local f = io.open(path, "w")
    f:write(encodeJson(table))
    f:close()
end