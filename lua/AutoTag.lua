script_name("AutoTag")
script_author("Lucifer Melton")
script_version("v.2.0")

require "lib.moonloader"
local sf = require "sampfuncs"
local inicfg = require "inicfg"

set = inicfg.load(nil, "AutoTag")
    if set == nil then
        ini = { config = { TagRadioR = "TagRadioR", TagRadioF = "TagRadioF", }, funct = { TagRadioR = true, TagRadioF = true, RPr = false, RPf = false }, text = { textRPr = "/me достал рацию из-за пояса, нажал кнопку и что-то произнёс", textRPf = "" } }
        inicfg.save(ini, "AutoTag")
        set = inicfg.load(nil, "AutoTag")
    end

function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then error("need sampfuncs") end
  	while not isSampAvailable() do wait(100) end
	sampRegisterChatCommand("r", function(text) lua_thread.create(cmd_r, text) end)
	sampRegisterChatCommand("f", function(text) lua_thread.create(cmd_f, text) end)
	sampRegisterChatCommand("rn", function(text) lua_thread.create(cmd_rn, text) end)
	sampRegisterChatCommand("fn", function(text) lua_thread.create(cmd_fn, text) end)
	sampRegisterChatCommand("bb", function() 
		lua_thread.create(function()
			submenus_show(dialog, "{6495ED}Настройки скрипта | Автор: {9D633A}"..table.concat(thisScript().authors, ", "), "{6495ED}Выбрать", "{6495ED}Закрыть", "{6495ED}Назад")
		end)
	end)
	wait(-1)
end

function cmd_r(text)
	if text ~= "" then
		if set.text.textRPr == "" or not set.funct.RPr then
			if set.config.TagRadioR == "" or not set.funct.TagRadioR then
				big_text("/r", text, "")
			else
				big_text("/r", "["..set.config.TagRadioR.."]: "..text, "["..set.config.TagRadioR.."]:")
			end
		else
			sampSendChat(set.text.textRPr)
			wait(1000)
			if set.config.TagRadioR == "" or not set.funct.TagRadioR then
				big_text("/r", text, "")
			else
				big_text("/r", "["..set.config.TagRadioR.."]: "..text, "["..set.config.TagRadioR.."]:")
			end
		end
	else
		sampAddChatMessage("Используйте: /r [текст]", 4291743438)
	end
end
function cmd_f(text)
	if text ~= "" then
		if set.text.textRPf == "" or not set.funct.RPf then
			if set.config.TagRadioF == "" or not set.funct.TagRadioF then
				big_text("/f", text, "")
			else
				big_text("/f", "["..set.config.TagRadioF.."]: "..text, "["..set.config.TagRadioF.."]:")
			end
		else
			sampSendChat(set.text.textRPf)
			wait(1000)
			if set.config.TagRadioF == "" or not set.funct.TagRadioF then
				big_text("/f", text, "")
			else
				big_text("/f", "["..set.config.TagRadioF.."]: "..text, "["..set.config.TagRadioF.."]:")
			end
		end
	else
		sampAddChatMessage("Используйте: /f [текст]", 4291743438)
	end
end

function cmd_rn(text)
	if text ~= "" then
		big_text("/rn", text, "")
	else
		sampAddChatMessage("Используйте: /rn [текст]", 4291743438)
	end
end
function cmd_fn(text)
	if text ~= "" then
		big_text("/fn", text, "")
	else
		sampAddChatMessage("Используйте: /fn [текст]", 4291743438)
	end
end

function big_text(cmd, text, prefix) -- взял из ExtraMessages.lua (by AppleThe). Но немножко под себя переделал :D
	length = text:len()
	if length <= 83 then
		sampSendChat(string.format("%s %s", cmd, text))
	else
		local one, two = string.match(text:sub(1, 83), "(.*) (.*)")
		if two == nil then two = "" end
		local one, two = one .. "...", "..." .. two .. text:sub(83 + 1, text:len())
		sampSendChat(string.format("%s %s", cmd, one))
		wait(1150)
		sampSendChat(string.format("%s %s %s", cmd, prefix, two))
	end
end

function submenus_show(menu, caption, select_button, close_button, back_button) -- THE FYP
    select_button, close_button, back_button = select_button or 'Select', close_button or 'Close', back_button or 'Back'
    prev_menus = {}
    function display(menu, id, caption)
        local string_list = {}
        for i, v in ipairs(menu) do
            table.insert(string_list, type(v.submenu) == 'table' and v.title .. '  ' or v.title)
        end
        sampShowDialog(id, caption, table.concat(string_list, '\n'), select_button, (#prev_menus > 0) and back_button or close_button, sf.DIALOG_STYLE_TABLIST)
        repeat
            wait(0)
            local result, button, list = sampHasDialogRespond(id)
            if result then
                if button == 1 and list ~= -1 then
                    local item = menu[list + 1]
                    if type(item.submenu) == 'table' then -- submenu
                        table.insert(prev_menus, {menu = menu, caption = caption})
                        if type(item.onclick) == 'function' then
                            item.onclick(menu, list + 1, item.submenu)
                        end
                        return display(item.submenu, id + 1, item.submenu.title and item.submenu.title or item.title)
                    elseif type(item.onclick) == 'function' then
                        local result = item.onclick(menu, list + 1)
                        if not result then return result end
                        return display(menu, id, caption)
                    end
                else -- if button == 0
                    if #prev_menus > 0 then
                        local prev_menu = prev_menus[#prev_menus]
                        prev_menus[#prev_menus] = nil
                        return display(prev_menu.menu, id - 1, prev_menu.caption)
                    end
                    return false
                end
            end
        until result
    end
    return display(menu, 31337, caption or menu.title)
end

dialog = {
	{
		title = "{6495ED}Изменить тэг рации вольный R:\t{32C13E}["..set.config.TagRadioR.."]",
		onclick = function(menu, row)
			::TagRadioR::
			sampShowDialog(31338, "{6495ED}Изменить тэг рации вольный R", "{F3F3F3}Введите Вашу тэг в поле ниже и нажмите {6495ED}Enter или Выбрать{F3F3F3}.", "{6495ED}Выбрать", "{6495ED}Назад", sf.DIALOG_STYLE_INPUT)
			sampSetCurrentDialogEditboxText(set.config.TagRadioR)
			repeat
				wait(0)
				local result, button, list, input = sampHasDialogRespond(31338)
				if result then
					if button == 1 then
						if input == "" then
							sampShowDialog(31339, "{6495ED}Изменить тэг рации вольный R", "{F3F3F3}Введенная вами поля пустая, оставить так?", "{6495ED}Да", "{6495ED}Нет", sf.DIALOG_STYLE_MSGBOX)
							repeat
								wait(0)
								local result, button, list, input = sampHasDialogRespond(31339)
								if result then
									if button == 1 then
										set.config.TagRadioR = ""
										inicfg.save(set, "AutoTag")
										menu[row].title = "{6495ED}Изменить тэг рации вольный R:\t{32C13E}["..set.config.TagRadioR.."]"
									else
										goto TagRadioR
									end
								end
							until result
						else
							set.config.TagRadioR = input
							inicfg.save(set, "AutoTag")
							menu[row].title = "{6495ED}Изменить тэг рации вольный R:\t{32C13E}["..set.config.TagRadioR.."]"
						end
					else
						return true
					end
				end
			until result
			return true
		end
	},
	{
		title = "{6495ED}Вкл/Выкл тэг рации вольный R:\t"..(set.funct.TagRadioR and "{32C13E}[Enabled]" or "{E21F1F}[Disabled]"),
		onclick = function(menu, row)
			set.funct.TagRadioR = not set.funct.TagRadioR
			inicfg.save(set, "AutoTag")
			menu[row].title = "{6495ED}Вкл/Выкл тэг рации вольный R:\t"..(set.funct.TagRadioR and "{32C13E}[Enabled]" or "{E21F1F}[Disabled]")
			return true
		end
	},
	{
		title = " ",
		onclick = function()
			sampAddChatMessage("А тут пусто.", 4291743438)
			return true
		end
	},
	{
		title = "{6495ED}Изменить тэг рации вольный F:\t{32C13E}["..set.config.TagRadioF.."]",
		onclick = function(menu, row)
			::TagRadioF::
			sampShowDialog(31340, "{6495ED}Изменить тэг рации вольный F", "{F3F3F3}Введите Вашу тэг в поле ниже и нажмите {6495ED}Enter или Выбрать{F3F3F3}.", "{6495ED}Выбрать", "{6495ED}Назад", sf.DIALOG_STYLE_INPUT)
			sampSetCurrentDialogEditboxText(set.config.TagRadioF)
			repeat
				wait(0)
				local result, button, list, input = sampHasDialogRespond(31340)
				if result then
					if button == 1 then
						if input == "" then
							sampShowDialog(31341, "{6495ED}Изменить тэг рации вольный F", "{F3F3F3}Введенная вами поля пустая, оставить так?", "{6495ED}Да", "{6495ED}Нет", sf.DIALOG_STYLE_MSGBOX)
							repeat
								wait(0)
								local result, button, list, input = sampHasDialogRespond(31341)
								if result then
									if button == 1 then
										set.config.TagRadioF = ""
										inicfg.save(set, "AutoTag")
										menu[row].title = "{6495ED}Изменить тэг рации вольный F:\t{32C13E}["..set.config.TagRadioF.."]"
									else
										goto TagRadioF
									end
								end
							until result
						else
							set.config.TagRadioF = input
							inicfg.save(set, "AutoTag")
							menu[row].title = "{6495ED}Изменить тэг рации вольный F:\t{32C13E}["..set.config.TagRadioF.."]"
						end
					else
						return true
					end
				end
			until result
			return true
		end
	},
	{
		title = "{6495ED}Вкл/Выкл тэг рации вольный F:\t"..(set.funct.TagRadioF and "{32C13E}[Enabled]" or "{E21F1F}[Disabled]"),
		onclick = function(menu, row)
			set.funct.TagRadioF = not set.funct.TagRadioF
			inicfg.save(set, "AutoTag")
			menu[row].title = "{6495ED}Вкл/Выкл тэг рации вольный F:\t"..(set.funct.TagRadioF and "{32C13E}[Enabled]" or "{E21F1F}[Disabled]")
			return true
		end
	},
	{
		title = " ",
		onclick = function()
			sampAddChatMessage("А тут пусто.", 4291743438)
			return true
		end
	},
	{
		title = "{6495ED}Дополнительные",
		submenu = {
            {
                title = "{6495ED}Изменить RP отыгровку рации R\t{32C13E}"..set.text.textRPr,
				onclick = function(menu, row)
					::textRPr::
					sampShowDialog(31342, "{6495ED}Изменить RP отыгровку рации R", "{F3F3F3}Введите RP отыгровку в поле ниже и нажмите {6495ED}Enter или Выбрать{F3F3F3}.", "{6495ED}Выбрать", "{6495ED}Назад", sf.DIALOG_STYLE_INPUT)
					sampSetCurrentDialogEditboxText(set.text.textRPr)
					repeat
						wait(0)
						local result, button, list, input = sampHasDialogRespond(31342)
						if result then
							if button == 1 then
								if input == "" then
									sampShowDialog(31343, "{6495ED}Изменить RP отыгровку рации R", "{F3F3F3}Введенная вами поля пустая, оставить так?", "{6495ED}Да", "{6495ED}Нет", sf.DIALOG_STYLE_MSGBOX)
									repeat
										wait(0)
										local result, button, list, input = sampHasDialogRespond(31343)
										if result then
											if button == 1 then
												set.text.textRPr = ""
												inicfg.save(set, "AutoTag")
												menu[row].title = "{6495ED}Изменить RP отыгровку рации R\t{32C13E}"..set.text.textRPr
											else
												goto textRPr
											end
										end
									until result
								else
									set.text.textRPr = input
									inicfg.save(set, "AutoTag")
									menu[row].title = "{6495ED}Изменить RP отыгровку рации R\t{32C13E}"..set.text.textRPr
								end
							else
								return true
							end
						end
					until result
					return true
				end
            },
            {
                title = "{6495ED}Вкл/Выкл RP отыгровку рации R:\t"..(set.funct.RPr and "{32C13E}[Enabled]" or "{E21F1F}[Disabled]"),
				onclick = function(menu, row)
					set.funct.RPr = not set.funct.RPr
					inicfg.save(set, "AutoTag")
					menu[row].title = "{6495ED}Вкл/Выкл RP отыгровку рации R:\t"..(set.funct.RPr and "{32C13E}[Enabled]" or "{E21F1F}[Disabled]")
					return true
				end
            },
            {
                title = " ",
                onclick = function()
                    sampAddChatMessage("А тут пусто.", 4291743438)
					return true
                end
            },
            {
                title = "{6495ED}Изменить RP отыгровку рации F\t{32C13E}"..set.text.textRPf,
                onclick = function(menu, row)
					::textRPf::
					sampShowDialog(31344, "{6495ED}Изменить RP отыгровку рации F", "{F3F3F3}Введите RP отыгровку в поле ниже и нажмите {6495ED}Enter или Выбрать{F3F3F3}.", "{6495ED}Выбрать", "{6495ED}Назад", sf.DIALOG_STYLE_INPUT)
					sampSetCurrentDialogEditboxText(set.text.textRPf)
					repeat
						wait(0)
						local result, button, list, input = sampHasDialogRespond(31344)
						if result then
							if button == 1 then
								if input == "" then
									sampShowDialog(31345, "{6495ED}Изменить RP отыгровку рации F", "{F3F3F3}Введенная вами поля пустая, оставить так?", "{6495ED}Да", "{6495ED}Нет", sf.DIALOG_STYLE_MSGBOX)
									repeat
										wait(0)
										local result, button, list, input = sampHasDialogRespond(31345)
										if result then
											if button == 1 then
												set.text.textRPf = ""
												inicfg.save(set, "AutoTag")
												menu[row].title = "{6495ED}Изменить RP отыгровку рации F\t{32C13E}"..set.text.textRPf
											else
												goto textRPf
											end
										end
									until result
								else
									set.text.textRPf = input
									inicfg.save(set, "AutoTag")
									menu[row].title = "{6495ED}Изменить RP отыгровку рации F\t{32C13E}"..set.text.textRPf
								end
							else
								return true
							end
						end
					until result
					return true
				end
            },
            {
                title = "{6495ED}Вкл/Выкл RP отыгровку рации F:\t"..(set.funct.RPf and "{32C13E}[Enabled]" or "{E21F1F}[Disabled]"),
				onclick = function(menu, row)
					set.funct.RPf = not set.funct.RPf
					inicfg.save(set, "AutoTag")
					menu[row].title = "{6495ED}Вкл/Выкл RP отыгровку рации F:\t"..(set.funct.RPf and "{32C13E}[Enabled]" or "{E21F1F}[Disabled]")
					return true
				end

            }
		}
	}
}