script_name("family")
script_author("Shishkin")

require "lib.moonloader"
local font_flag = require('moonloader').font_flag
local sampev = require 'lib.samp.events'
require "lib.sampfuncs"
local memory = require "memory"
local inicfg = require "inicfg"
local sf = require "sampfuncs"

set = inicfg.load(nil, "2637") 
    if set == nil then
        ini = { config = { asd = "asd", asd = "asd", }, funct = { asd = true, asd = true, asd = false, asd = false }, text = { text1 = "Свободный слот под ник №1", text2 = "Свободный слот под ник №2", text3 = "Свободный слот под ник №3", text4 = "Свободный слот под ник №4", text5 = "Свободный слот под ник №5", text6 = "Свободный слот под ник №6", text7 = "Свободный слот под ник №7", text8 = "Свободный слот под ник №8", text9 = "Свободный слот под ник №9", text10 = "Свободный слот под ник №10" } }
        inicfg.save(ini, "2637")
        set = inicfg.load(nil, "2637")
    end

function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end
	wait(100)
	sampAddChatMessage("Скрипт {FF0000}Family {FFFFFF}запущен",4294967295)
	sampAddChatMessage("{00FFFF}Diamond RP",4294967295)
	sampRegisterChatCommand("mfamily", function() lua_thread.create(cmd_mfamily) end)
	wait(-1)
end

function cmd_mfamily()
       sampShowDialog(1111, "{FFFFFF}Меню {00FF00}Family", "{00FFFF}1.{FFFFFF}Участники семьи\n{00FFFF}2.{FFFFFF}Включить/Отключить рацию семьи\n{00FFFF}3.{FFFFFF}Установить обьект семьи\n{00FFFF}4.{FFFFFF}Положить очки семьи в сейф\n{00FFFF}5.{FFFFFF}Передать семейные очки\n{00FFFF}6.{FFFFFF}Передать семью\n{00FFFF}7.{FFFFFF}Продажа семейных очков\n{00FFFF}8.{FFFFFF}Рация семьи\n{00FFFF}9.{FFFFFF}Принять в фаму\n{00FFFF}10.{FFFFFF}Заключить дружеские отношения\n{00FFFF}11.{FFFFFF}Заключить вражеские отношения\n{00FFFF}12.{FFFFFF}Разорвать вражеские отношения" , "{FFFFFF}Выбрать", "{FFFFFF}Закрыть", 2)
		lua_thread.create(family)
		end
		
		
		
		function family()
		while sampIsDialogActive()do
		wait(0)
		local result, button, list, input = sampHasDialogRespond(1111)
		if result and button == 0 then
		elseif result and list == 0 then
		lua_thread.create(famil1)
		elseif result and list == 1 then
		sampSendChat("/koff")
		elseif result and list == 2 then
		sampSendChat("/fobject")
		elseif result and list == 3 then
		sampShowDialog(6666, "{FFFFFF}Количество семейных очков:", "{FFFFFF}Разработчик скрипта {00FFFF}Shishkin" , "Далее", "Назад", 1)
		lua_thread.create(family3)
		elseif result and list == 4 then
		sampShowDialog(6667, "{FFFFFF}Введите id игрока:", "{FFFFFF}Разработчик скрипта {00FFFF}Shishkin" , "Далее", "Назад", 1)
		lua_thread.create(family4)
		elseif result and list == 5 then
		sampShowDialog(6668, "{FFFFFF}Введите id игрока:", "{FFFFFF}Разработчик скрипта {00FFFF}Shishkin" , "Далее", "Назад", 1)
		lua_thread.create(family5)
		elseif result and list == 6 then
		sampShowDialog(6669, "{FFFFFF}Введите id игрока:", "{FFFFFF}Разработчик скрипта {00FFFF}Shishkin" , "Далее", "Назад", 1)
		lua_thread.create(family6)
		elseif result and list == 7 then
		sampShowDialog(6670, "{FFFFFF}Введите сообщнение:", "{FFFFFF}Разработчик скрипта {00FFFF}Shishkin" , "Далее", "Назад", 1)
		lua_thread.create(family7)
		elseif result and list == 8 then
		sampShowDialog(6671, "{FFFFFF}Введите id игрока:", "{FFFFFF}Разработчик скрипта {00FFFF}Shishkin" , "Далее", "Назад", 1)
		lua_thread.create(family8)
		elseif result and list == 9 then
		sampShowDialog(6672, "{FFFFFF}Введите id игрока:", "{FFFFFF}Разработчик скрипта {00FFFF}Shishkin" , "Далее", "Назад", 1)
		lua_thread.create(family9)
		elseif result and list == 10 then
		sampShowDialog(6673, "{FFFFFF}Введите id игрока:", "{FFFFFF}Разработчик скрипта {00FFFF}Shishkin" , "Далее", "Назад", 1)
		lua_thread.create(family10)
		elseif result and list == 11 then
		sampShowDialog(6674, "{FFFFFF}Введите id игрока:", "{FFFFFF}Разработчик скрипта {00FFFF}Shishkin" , "Далее", "Назад", 1)
		lua_thread.create(family11)
		
end
end
end


function family3()
while true do
wait(0)
InputText = sampGetCurrentDialogEditboxText()
local result, button, list, input = sampHasDialogRespond(6666)
if result and button == 1 then
sampSendChat('/putscore '  ..InputText)
end
end
end

function family4()
while true do
wait(0)
Shishkin = sampGetCurrentDialogEditboxText()
local result, button, list, input = sampHasDialogRespond(6667)
if result and button == 1 then
Shishkin1 = sampGetCurrentDialogEditboxText()
sampShowDialog(7771, "{FFFFFF}Введите количество очков:", "{FFFFFF}Разработчик скрипта {00FFFF}Shishkin" , "Далее", "Назад", 1)
lua_thread.create(family12)
end
end
end

function family5()
while true do
wait(0)
InputText1 = sampGetCurrentDialogEditboxText()
local result, button, list, input = sampHasDialogRespond(6668)
if result and button == 1 then
sampSendChat('/givefamily '  ..InputText1)
end
end
end

function family6()
while true do
wait(0)
Shishkin2 = sampGetCurrentDialogEditboxText()
local result, button, list, input = sampHasDialogRespond(6669)
if result and button == 1 then
Shishkin3 = sampGetCurrentDialogEditboxText()
sampShowDialog(6661, "{FFFFFF}Введите количество очков:", "{FFFFFF}Разработчик скрипта {00FFFF}Shishkin" , "Далее", "Назад", 1)
lua_thread.create(family13)
end
end
end

function family7()
while true do
wait(0)
InputText3 = sampGetCurrentDialogEditboxText()
local result, button, list, input = sampHasDialogRespond(6670)
if result and button == 1 then
sampSendChat('/k '  ..InputText3)
end
end
end

function family8()
while true do
wait(0)
InputText4 = sampGetCurrentDialogEditboxText()
local result, button, list, input = sampHasDialogRespond(6671)
if result and button == 1 then
sampSendChat('/finvite '  ..InputText4)
end
end
end

function family9()
while true do
wait(0)
InputText5 = sampGetCurrentDialogEditboxText()
local result, button, list, input = sampHasDialogRespond(6672)
if result and button == 1 then
sampSendChat('/makefriends '  ..InputText5)
end
end
end

function family10()
while true do
wait(0)
InputText6 = sampGetCurrentDialogEditboxText()
local result, button, list, input = sampHasDialogRespond(6673)
if result and button == 1 then
sampSendChat('/makewar '  ..InputText6)
end
end
end

function family11()
while true do
wait(0)
InputText8 = sampGetCurrentDialogEditboxText()
local result, button, list, input = sampHasDialogRespond(6674)
if result and button == 1 then
sampSendChat('/unwar '  ..InputText8)
end 
end
end

function family12()
while true do
wait(0)
local result, button, list, input = sampHasDialogRespond(7771)
if result and button == 1 then
sampSendChat('/fscore ' ..Shishkin1.. ' ' ..Shishkin)
end
end
end

function family13()
while true do
wait(0)
local result, button, list, input = sampHasDialogRespond(6661) 
if result and button == 1 then
Shishkin4 = sampGetCurrentDialogEditboxText()
sampShowDialog(6662, "{FFFFFF}Введите цену:", "{FFFFFF}Разработчик скрипта {00FFFF}Shishkin" , "Далее", "Назад", 1) 
lua_thread.create(family14)
end
end
end

function family14()
while true do
wait(0)
local result, button, list, input = sampHasDialogRespond(6662) 
if result and button == 1 then
sampSendChat('/sellscore ' ..Shishkin3.. ' ' ..Shishkin4.. ' ' ..Shishkin2)
end
end
end
        
	    function famil1()
	   submenus_show(dialog, "{FFFFFF}Выберите игрока для {00FF00}взаимодействия {00FFFF}"..table.concat(thisScript().authors, ", "), "{FFFFFF}Выбрать", "{FFFFFF}Назад", "{FFFFFF}Назад")
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
                    if type(item.submenu) == 'table' then 
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
                if button == 0 then -- if button == 0
              sampShowDialog(1111, "{FFFFFF}Меню {00FF00}Family", "{00FFFF}1.{FFFFFF}Участники семьи\n{00FFFF}2.{FFFFFF}Включить/Отключить рацию семьи\n{00FFFF}3.{FFFFFF}Установить обьект семьи\n{00FFFF}4.{FFFFFF}Положить очки семьи в сейф\n{00FFFF}5.{FFFFFF}Передать семейные очки\n{00FFFF}6.{FFFFFF}Передать семью\n{00FFFF}7.{FFFFFF}Продажа семейных очков\n{00FFFF}8.{FFFFFF}Рация семьи\n{00FFFF}9.{FFFFFF}Принять в фаму\n{00FFFF}10.{FFFFFF}Заключить дружеские отношения\n{00FFFF}11.{FFFFFF}Заключить вражеские отношения\n{00FFFF}12.{FFFFFF}Разорвать вражеские отношения" , "{FFFFFF}Выбрать", "{FFFFFF}Закрыть", 2)
		lua_thread.create(family)
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
	    title = set.text.text1,
		submenu = {
		 {
            title = "{00FFFF}1.{FFFFFF}Изменить ник участинка семьи ["..set.text.text1.."]", 
		    onclick = function(menu, row)
			::text1::
			sampShowDialog(41400, "{FFFFFF}Изменить ник игрока", "{F3F3F3}Введите ник игрока.", "{FFFFFF}Выбрать", "{FFFFFF}Назад", sf.DIALOG_STYLE_INPUT)
			sampSetCurrentDialogEditboxText(set.text.text1)
			repeat
				wait(0)
				local result, button, list, input = sampHasDialogRespond(41400)
				if result then
					if button == 1 then
						if input == "" then
							sampShowDialog(663, "{FFFFFF}Изменить ник игрока", "{F3F3F3}Введенная вами поля пустое и из за этого будет замена на свободный слот", "{FFFFFF}Да", "{FFFFFF}Нет", sf.DIALOG_STYLE_MSGBOX)
							repeat
								wait(0)
								local result, button, list, input = sampHasDialogRespond(663)
								if result then
									if button == 1 then
                                       sampAddChatMessage("{FFFFFF}Название слота изменено. Для изменение названия слота в меню 'Выбор игрока' перезайдите", 4294967295)
										set.text.text1 = "Свободный слот под ник №1"
										inicfg.save(set, "2637")
						             	menu[row].title = "{00FFFF}1.{FFFFFF}Изменить ник участинка семьи ["..set.text.text1.."]" 
									else
										goto text1
									end
								end
							until result
						else
						sampAddChatMessage("{FFFFFF}Название слота изменено. Для изменение названия слота в меню 'Выбор игрока' перезайдите", 4294967295)
							set.text.text1 = input 
							inicfg.save(set, "2637")
						    menu[row].title = "{00FFFF}1.{FFFFFF}Изменить ник участинка семьи ["..set.text.text1.."]"
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
        title = "{00FFFF}2.{FFFFFF}Взаимодействие с участником семьи",
        onclick = function(menu, row)
		sampShowDialog(1133, "{FFFFFF}Выберите что делать с {FFFF00}игроком:", "{00FFFF}1.{FFFFFF}Увольнение\n{00FFFF}2.{FFFFFF}Назначить заместителем\n{00FFFF}3.{FFFFFF}Назначить вторым заместителем\n{00FFFF}4.{FFFFFF}Убрать с заместителя\n{00FFFF}5.{FFFFFF}Убрать со второго заместителя" , "{FFFFFF}Выбрать", "{FFFFFF}Назад", 2)
		lua_thread.create(part2)
		end
		}
	}	
	 },
	 
       {
	    title = set.text.text2,
		submenu = {
		 {
            title = "{00FFFF}1.{FFFFFF}Изменить ник участинка семьи ["..set.text.text2.."]", 
		     onclick = function(menu, row)
			::text2::
			sampShowDialog(41400, "{FFFFFF}Изменить ник игрока", "{F3F3F3}Введите ник игрока.", "{FFFFFF}Выбрать", "{FFFFFF}Назад", sf.DIALOG_STYLE_INPUT)
			sampSetCurrentDialogEditboxText(set.text.text2)
			repeat
				wait(0)
				local result, button, list, input = sampHasDialogRespond(41400)
				if result then
					if button == 1 then
						if input == "" then
							sampShowDialog(31400, "{FFFFFF}Изменить ник игрока", "{F3F3F3}Введенная вами поля пустое и из за этого будет замена на свободный слот", "{FFFFFF}Да", "{FFFFFF}Нет", sf.DIALOG_STYLE_MSGBOX)
							repeat
								wait(0)
								local result, button, list, input = sampHasDialogRespond(31400)
								if result then
									if button == 1 then
					                       	sampAddChatMessage("{FFFFFF}Название слота изменено. Для изменение названия слота в меню 'Выбор игрока' перезайдите", 4294967295)
										set.text.text2 = "Свободный слот под ник №2"
										inicfg.save(set, "2637")
						             	menu[row].title = "{00FFFF}1.{FFFFFF}Изменить ник участинка семьи ["..set.text.text2.."]"
									else
										goto text2
									end
								end
							until result
						else
								sampAddChatMessage("{FFFFFF}Название слота изменено. Для изменение названия слота в меню 'Выбор игрока' перезайдите", 4294967295)
							set.text.text2 = input 
							inicfg.save(set, "2637")
						    menu[row].title = "{00FFFF}1.{FFFFFF}Изменить ник участинка семьи ["..set.text.text2.."]"

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
        title = "{00FFFF}2.{FFFFFF}Взаимодействие с участником семьи",
        onclick = function(menu, row)
		sampShowDialog(16666, "{FFFFFF}Выберите что делать с {FFFF00}игроком:", "{00FFFF}1.{FFFFFF}Увольнение\n{00FFFF}2.{FFFFFF}Назначить заместителем\n{00FFFF}3.{FFFFFF}Назначить вторым заместителем\n{00FFFF}4.{FFFFFF}Убрать с заместителя\n{00FFFF}5.{FFFFFF}Убрать со второго заместителя" , "{FFFFFF}Выбрать", "{FFFFFF}Назад", 2)
		lua_thread.create(part3)
	end	
	 }
	 }
	 },
        {	 
		title = set.text.text3,
		submenu = {
            {
            title = "{00FFFF}1.{FFFFFF}Изменить ник участинка семьи ["..set.text.text3.."]",
				onclick = function(menu, row)
					::text3::
					sampShowDialog(31342, "{FFFFFF}Изменить ник игрока", "{F3F3F3}Введите ник игрока.", "{FFFFFF}Выбрать", "{FFFFFF}Назад", sf.DIALOG_STYLE_INPUT)
					sampSetCurrentDialogEditboxText(set.text.text3)
					repeat
						wait(0)
						local result, button, list, input = sampHasDialogRespond(31342)
						if result then
							if button == 1 then
								if input == "" then
									sampShowDialog(31343, "{FFFFFF}Изменить ник игрока", "{F3F3F3}Введенная вами поля пустое и из за этого будет замена на свободный слот", "{FFFFFF}Да", "{FFFFFF}Нет", sf.DIALOG_STYLE_MSGBOX)
									repeat
										wait(0)
										local result, button, list, input = sampHasDialogRespond(31343)
										if result then
											if button == 1 then
											sampAddChatMessage("{FFFFFF}Название слота изменено. Для изменение названия слота в меню 'Выбор игрока' перезайдите", 4294967295)
												set.text.text3 = "Свободный слот под ник №3"
												inicfg.save(set, "2637")
						             	        menu[row].title = "{00FFFF}1.{FFFFFF}Изменить ник участинка семьи ["..set.text.text3.."]"
											else
												goto text3
											end
										end
									until result
								else
								sampAddChatMessage("{FFFFFF}Название слота изменено. Для изменение названия слота в меню 'Выбор игрока' перезайдите", 4294967295)
									set.text.text3 = input
									inicfg.save(set, "2637")
						            menu[row].title = "{00FFFF}1.{FFFFFF}Изменить ник участинка семьи ["..set.text.text3.."]"
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
                title = "{00FFFF}2.{FFFFFF}Взаимодействие с участником семьи",
                onclick = function(menu, row)
		sampShowDialog(112, "{FFFFFF}Выберите что делать с {FFFF00}игроком:", "{00FFFF}1.{FFFFFF}Увольнение\n{00FFFF}2.{FFFFFF}Назначить заместителем\n{00FFFF}3.{FFFFFF}Назначить вторым заместителем\n{00FFFF}4.{FFFFFF}Убрать с заместителя\n{00FFFF}5.{FFFFFF}Убрать со второго заместителя" , "{FFFFFF}Выбрать", "{FFFFFF}Назад", 2)
		lua_thread.create(part4)
	end	
	        }   	
}
},
        {	 
		title = set.text.text4,
		submenu = {
            {
            title = "{00FFFF}1.{FFFFFF}Изменить ник участинка семьи ["..set.text.text4.."]", 
				onclick = function(menu, row)
					::text4::
					sampShowDialog(3134, "{FFFFFF}Изменить ник игрока", "{F3F3F3}Введите ник игрока.", "{FFFFFF}Выбрать", "{FFFFFF}Назад", sf.DIALOG_STYLE_INPUT)
					sampSetCurrentDialogEditboxText(set.text.text4)
					repeat
						wait(0)
						local result, button, list, input = sampHasDialogRespond(3134)
						if result then
							if button == 1 then
								if input == "" then
									sampShowDialog(3135, "{FFFFFF}Изменить ник игрока", "{F3F3F3}Введенная вами поля пустое и из за этого будет замена на свободный слот", "{FFFFFF}Да", "{FFFFFF}Нет", sf.DIALOG_STYLE_MSGBOX)
									repeat
										wait(0)
										local result, button, list, input = sampHasDialogRespond(3135)
										if result then
											if button == 1 then
											sampAddChatMessage("{FFFFFF}Название слота изменено. Для изменение названия слота в меню 'Выбор игрока' перезайдите", 4294967295)
												set.text.text4 = "Свободный слот под ник №4"
												inicfg.save(set, "2637")
						             	menu[row].title = "{00FFFF}1.{FFFFFF}Изменить ник участинка семьи ["..set.text.text4.."]"
											else
												goto text4
											end
										end
									until result
								else
								sampAddChatMessage("{FFFFFF}Название слота изменено. Для изменение названия слота в меню 'Выбор игрока' перезайдите", 4294967295)
									set.text.text4 = input
									inicfg.save(set, "2637")
						            menu[row].title = "{00FFFF}1.{FFFFFF}Изменить ник участинка семьи ["..set.text.text4.."]"
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
                title = "{00FFFF}2.{FFFFFF}Взаимодействие с участником семьи",
                onclick = function(menu, row)
		sampShowDialog(515, "{FFFFFF}Выберите что делать с {FFFF00}игроком:", "{00FFFF}1.{FFFFFF}Увольнение\n{00FFFF}2.{FFFFFF}Назначить заместителем\n{00FFFF}3.{FFFFFF}Назначить вторым заместителем\n{00FFFF}4.{FFFFFF}Убрать с заместителя\n{00FFFF}5.{FFFFFF}Убрать со второго заместителя" , "{FFFFFF}Выбрать", "{FFFFFF}Назад", 2)
		lua_thread.create(part5)
	end	
	 }
	 }
	 },
	         {	 
		title = set.text.text5,
		submenu = {
            {
            title = "{00FFFF}1.{FFFFFF}Изменить ник участинка семьи ["..set.text.text5.."]", 
				onclick = function(menu, row)
					::text5::
					sampShowDialog(1263, "{FFFFFF}Изменить ник игрока", "{F3F3F3}Введите ник игрока.", "{FFFFFF}Выбрать", "{FFFFFF}Назад", sf.DIALOG_STYLE_INPUT)
					sampSetCurrentDialogEditboxText(set.text.text5)
					repeat
						wait(0)
						local result, button, list, input = sampHasDialogRespond(1263)
						if result then
							if button == 1 then
								if input == "" then
									sampShowDialog(1631, "{FFFFFF}Изменить ник игрока", "{F3F3F3}Введенная вами поля пустое и из за этого будет замена на свободный слот", "{FFFFFF}Да", "{FFFFFF}Нет", sf.DIALOG_STYLE_MSGBOX)
									repeat
										wait(0)
										local result, button, list, input = sampHasDialogRespond(1631)
										if result then
											if button == 1 then
											sampAddChatMessage("{FFFFFF}Название слота изменено. Для изменение названия слота в меню 'Выбор игрока' перезайдите", 4294967295)
												set.text.text5 = "Свободный слот под ник №5"
												inicfg.save(set, "2637")
						             	menu[row].title = "{00FFFF}1.{FFFFFF}Изменить ник участинка семьи ["..set.text.text5.."]"
											else
												goto text5
											end
										end
									until result
								else
								sampAddChatMessage("{FFFFFF}Название слота изменено. Для изменение названия слота в меню 'Выбор игрока' перезайдите", 4294967295)
									set.text.text5 = input
									inicfg.save(set, "2637")
						            menu[row].title = "{00FFFF}1.{FFFFFF}Изменить ник участинка семьи ["..set.text.text5.."]"
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
                title = "{00FFFF}2.{FFFFFF}Взаимодействие с участником семьи",
                onclick = function(menu, row)
		sampShowDialog(712, "{FFFFFF}Выберите что делать с {FFFF00}игроком:", "{00FFFF}1.{FFFFFF}Увольнение\n{00FFFF}2.{FFFFFF}Назначить заместителем\n{00FFFF}3.{FFFFFF}Назначить вторым заместителем\n{00FFFF}4.{FFFFFF}Убрать с заместителя\n{00FFFF}5.{FFFFFF}Убрать со второго заместителя" , "{FFFFFF}Выбрать", "{FFFFFF}Назад", 2)
		lua_thread.create(part6)
	end	
	 }
	 }
	 },
	 	         {	 
		title = set.text.text6,
		submenu = {
            {
            title = "{00FFFF}1.{FFFFFF}Изменить ник участинка семьи ["..set.text.text6.."]", 
				onclick = function(menu, row)
					::text6::
					sampShowDialog(6512, "{FFFFFF}Изменить ник игрока", "{F3F3F3}Введите ник игрока.", "{FFFFFF}Выбрать", "{FFFFFF}Назад", sf.DIALOG_STYLE_INPUT)
					sampSetCurrentDialogEditboxText(set.text.text6)
					repeat
						wait(0)
						local result, button, list, input = sampHasDialogRespond(6512)
						if result then
							if button == 1 then
								if input == "" then
									sampShowDialog(3712, "{FFFFFF}Изменить ник игрока", "{F3F3F3}Введенная вами поля пустое и из за этого будет замена на свободный слот", "{FFFFFF}Да", "{FFFFFF}Нет", sf.DIALOG_STYLE_MSGBOX)
									repeat
										wait(0)
										local result, button, list, input = sampHasDialogRespond(3712)
										if result then
											if button == 1 then
											sampAddChatMessage("{FFFFFF}Название слота изменено. Для изменение названия слота в меню 'Выбор игрока' перезайдите", 4294967295)
												set.text.text6 = "Свободный слот под ник №6"
												inicfg.save(set, "2637")
						             	menu[row].title = "{00FFFF}1.{FFFFFF}Изменить ник участинка семьи ["..set.text.text6.."]"
											else
												goto text6
											end
										end
									until result
								else
								sampAddChatMessage("{FFFFFF}Название слота изменено. Для изменение названия слота в меню 'Выбор игрока' перезайдите", 4294967295)
									set.text.text6 = input
									inicfg.save(set, "2637")
						            menu[row].title = "{00FFFF}1.{FFFFFF}Изменить ник участинка семьи ["..set.text.text6.."]"
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
                title = "{00FFFF}2.{FFFFFF}Взаимодействие с участником семьи",
                onclick = function(menu, row)
		sampShowDialog(481, "{FFFFFF}Выберите что делать с {FFFF00}игроком:", "{00FFFF}1.{FFFFFF}Увольнение\n{00FFFF}2.{FFFFFF}Назначить заместителем\n{00FFFF}3.{FFFFFF}Назначить вторым заместителем\n{00FFFF}4.{FFFFFF}Убрать с заместителя\n{00FFFF}5.{FFFFFF}Убрать со второго заместителя" , "{FFFFFF}Выбрать", "{FFFFFF}Назад", 2)
		lua_thread.create(part7)
	end	
	 }
	 }
	 },
	 	 	         {	 
		title = set.text.text7,
		submenu = {
            {
            title = "{00FFFF}1.{FFFFFF}Изменить ник участинка семьи ["..set.text.text7.."]", 
				onclick = function(menu, row)
					::text7::
					sampShowDialog(2612, "{FFFFFF}Изменить ник игрока", "{F3F3F3}Введите ник игрока.", "{FFFFFF}Выбрать", "{FFFFFF}Назад", sf.DIALOG_STYLE_INPUT)
					sampSetCurrentDialogEditboxText(set.text.text7)
					repeat
						wait(0)
						local result, button, list, input = sampHasDialogRespond(2612)
						if result then
							if button == 1 then
								if input == "" then
									sampShowDialog(1841, "{FFFFFF}Изменить ник игрока", "{F3F3F3}Введенная вами поля пустое и из за этого будет замена на свободный слот", "{FFFFFF}Да", "{FFFFFF}Нет", sf.DIALOG_STYLE_MSGBOX)
									repeat
										wait(0)
										local result, button, list, input = sampHasDialogRespond(1841)
										if result then
											if button == 1 then
											sampAddChatMessage("{FFFFFF}Название слота изменено. Для изменение названия слота в меню 'Выбор игрока' перезайдите", 4294967295)
												set.text.text7 = "Свободный слот под ник №7"
												inicfg.save(set, "2637")
						             	menu[row].title = "{00FFFF}1.{FFFFFF}Изменить ник участинка семьи ["..set.text.text7.."]"
											else
												goto text7
											end
										end
									until result
								else
								sampAddChatMessage("{FFFFFF}Название слота изменено. Для изменение названия слота в меню 'Выбор игрока' перезайдите", 4294967295)
									set.text.text7 = input
									inicfg.save(set, "2637")
						            menu[row].title = "{00FFFF}1.{FFFFFF}Изменить ник участинка семьи ["..set.text.text7.."]"
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
                title = "{00FFFF}2.{FFFFFF}Взаимодействие с участником семьи",
                onclick = function(menu, row)
		sampShowDialog(178, "{FFFFFF}Выберите что делать с {FFFF00}игроком:", "{00FFFF}1.{FFFFFF}Увольнение\n{00FFFF}2.{FFFFFF}Назначить заместителем\n{00FFFF}3.{FFFFFF}Назначить вторым заместителем\n{00FFFF}4.{FFFFFF}Убрать с заместителя\n{00FFFF}5.{FFFFFF}Убрать со второго заместителя" , "{FFFFFF}Выбрать", "{FFFFFF}Назад", 2)
		lua_thread.create(part8)
	end	
	 }
	 }
	 },
	                     {	 
		title = set.text.text8,
		submenu = {
            {
            title = "{00FFFF}1.{FFFFFF}Изменить ник участинка семьи ["..set.text.text8.."]", 
				onclick = function(menu, row)
					::text8::
					sampShowDialog(3612, "{FFFFFF}Изменить ник игрока", "{F3F3F3}Введите ник игрока.", "{FFFFFF}Выбрать", "{FFFFFF}Назад", sf.DIALOG_STYLE_INPUT)
					sampSetCurrentDialogEditboxText(set.text.text8)
					repeat
						wait(0)
						local result, button, list, input = sampHasDialogRespond(3612)
						if result then
							if button == 1 then
								if input == "" then
									sampShowDialog(6312, "{FFFFFF}Изменить ник игрока", "{F3F3F3}Введенная вами поля пустое и из за этого будет замена на свободный слот", "{FFFFFF}Да", "{FFFFFF}Нет", sf.DIALOG_STYLE_MSGBOX)
									repeat
										wait(0)
										local result, button, list, input = sampHasDialogRespond(6312)
										if result then
											if button == 1 then
											sampAddChatMessage("{FFFFFF}Название слота изменено. Для изменение названия слота в меню 'Выбор игрока' перезайдите", 4294967295)
												set.text.text8 = "Свободный слот под ник №8"
												inicfg.save(set, "2637")
						             	menu[row].title = "{00FFFF}1.{FFFFFF}Изменить ник участинка семьи ["..set.text.text8.."]"
											else
												goto text8
											end
										end
									until result
								else
								sampAddChatMessage("{FFFFFF}Название слота изменено. Для изменение названия слота в меню 'Выбор игрока' перезайдите", 4294967295)
									set.text.text8 = input
									inicfg.save(set, "2637")
						            menu[row].title = "{00FFFF}1.{FFFFFF}Изменить ник участинка семьи ["..set.text.text8.."]"
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
                title = "{00FFFF}2.{FFFFFF}Взаимодействие с участником семьи",
                onclick = function(menu, row)
		sampShowDialog(773, "{FFFFFF}Выберите что делать с {FFFF00}игроком:", "{00FFFF}1.{FFFFFF}Увольнение\n{00FFFF}2.{FFFFFF}Назначить заместителем\n{00FFFF}3.{FFFFFF}Назначить вторым заместителем\n{00FFFF}4.{FFFFFF}Убрать с заместителя\n{00FFFF}5.{FFFFFF}Убрать со второго заместителя" , "{FFFFFF}Выбрать", "{FFFFFF}Назад", 2)
		lua_thread.create(part9)
	end	
	 }
	 }
	 },
	 	                     {	 
		title = set.text.text9,
		submenu = {
            {
            title = "{00FFFF}1.{FFFFFF}Изменить ник участинка семьи ["..set.text.text9.."]", 
				onclick = function(menu, row)
					::text9::
					sampShowDialog(7423, "{FFFFFF}Изменить ник игрока", "{F3F3F3}Введите ник игрока.", "{FFFFFF}Выбрать", "{FFFFFF}Назад", sf.DIALOG_STYLE_INPUT)
					sampSetCurrentDialogEditboxText(set.text.text9)
					repeat
						wait(0)
						local result, button, list, input = sampHasDialogRespond(7423)
						if result then
							if button == 1 then
								if input == "" then
									sampShowDialog(1761, "{FFFFFF}Изменить ник игрока", "{F3F3F3}Введенная вами поля пустое и из за этого будет замена на свободный слот", "{FFFFFF}Да", "{FFFFFF}Нет", sf.DIALOG_STYLE_MSGBOX)
									repeat
										wait(0)
										local result, button, list, input = sampHasDialogRespond(1761)
										if result then
											if button == 1 then
											sampAddChatMessage("{FFFFFF}Название слота изменено. Для изменение названия слота в меню 'Выбор игрока' перезайдите", 4294967295)
												set.text.text9 = "Свободный слот под ник №9"
												inicfg.save(set, "2637")
						             	menu[row].title = "{00FFFF}1.{FFFFFF}Изменить ник участинка семьи ["..set.text.text9.."]"
											else
												goto text9
											end
										end
									until result
								else
								sampAddChatMessage("{FFFFFF}Название слота изменено. Для изменение названия слота в меню 'Выбор игрока' перезайдите", 4294967295)
									set.text.text9 = input
									inicfg.save(set, "2637")
						            menu[row].title = "{00FFFF}1.{FFFFFF}Изменить ник участинка семьи ["..set.text.text9.."]"
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
                title = "{00FFFF}2.{FFFFFF}Взаимодействие с участником семьи",
                onclick = function(menu, row)
		sampShowDialog(612, "{FFFFFF}Выберите что делать с {FFFF00}игроком:", "{00FFFF}1.{FFFFFF}Увольнение\n{00FFFF}2.{FFFFFF}Назначить заместителем\n{00FFFF}3.{FFFFFF}Назначить вторым заместителем\n{00FFFF}4.{FFFFFF}Убрать с заместителя\n{00FFFF}5.{FFFFFF}Убрать со второго заместителя" , "{FFFFFF}Выбрать", "{FFFFFF}Назад", 2)
		lua_thread.create(part10)
	end	
	 }
	 }
	 },
	 	 	                     {	 
		title = set.text.text10,
		submenu = {
            {
            title = "{00FFFF}1.{FFFFFF}Изменить ник участинка семьи ["..set.text.text10.."]", 
				onclick = function(menu, row)
					::text10::
					sampShowDialog(2352, "{FFFFFF}Изменить ник игрока", "{F3F3F3}Введите ник игрока.", "{FFFFFF}Выбрать", "{FFFFFF}Назад", sf.DIALOG_STYLE_INPUT)
					sampSetCurrentDialogEditboxText(set.text.text10)
					repeat
						wait(0)
						local result, button, list, input = sampHasDialogRespond(2352)
						if result then
							if button == 1 then
								if input == "" then
									sampShowDialog(8412, "{FFFFFF}Изменить ник игрока", "{F3F3F3}Введенная вами поля пустое и из за этого будет замена на свободный слот", "{FFFFFF}Да", "{FFFFFF}Нет", sf.DIALOG_STYLE_MSGBOX)
									repeat
										wait(0)
										local result, button, list, input = sampHasDialogRespond(8412)
										if result then
											if button == 1 then
											sampAddChatMessage("{FFFFFF}Название слота изменено. Для изменение названия слота в меню 'Выбор игрока' перезайдите", 4294967295)
												set.text.text10 = "Свободный слот под ник №10"
												inicfg.save(set, "2637")
						             	menu[row].title = "{00FFFF}1.{FFFFFF}Изменить ник участинка семьи ["..set.text.text10.."]"
											else
												goto text10
											end
										end
									until result
								else
								sampAddChatMessage("{FFFFFF}Название слота изменено. Для изменение названия слота в меню 'Выбор игрока' перезайдите", 4294967295)
									set.text.text10 = input
									inicfg.save(set, "2637")
						            menu[row].title = "{00FFFF}1.{FFFFFF}Изменить ник участинка семьи ["..set.text.text10.."]"
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
                title = "{00FFFF}2.{FFFFFF}Взаимодействие с участником семьи",
                onclick = function(menu, row)
		sampShowDialog(632, "{FFFFFF}Выберите что делать с {FFFF00}игроком:", "{00FFFF}1.{FFFFFF}Увольнение\n{00FFFF}2.{FFFFFF}Назначить заместителем\n{00FFFF}3.{FFFFFF}Назначить вторым заместителем\n{00FFFF}4.{FFFFFF}Убрать с заместителя\n{00FFFF}5.{FFFFFF}Убрать со второго заместителя" , "{FFFFFF}Выбрать", "{FFFFFF}Назад", 2)
		lua_thread.create(part11)
	end	
	 }
	 }
	 }
	 }


		function part2()
		while sampIsDialogActive()do
		wait(0)
		local result, button, list, input = sampHasDialogRespond(1133)
		if result and button == 0 then
		submenus_show(dialog, "{FFFFFF}Выберите игрока для {00FF00}взаимодействия {00FFFF}"..table.concat(thisScript().authors, ", "), "{FFFFFF}Выбрать", "{FFFFFF}Назад", "{FFFFFF}Назад")
		elseif result and list == 0 then
		sampSendChat("/funinvite  "..set.text.text1)
		elseif result and list == 1 then
		sampSendChat("/selestzam  "..set.text.text1)
		elseif result and list == 2 then
		sampSendChat("/selestzam2  "..set.text.text1)
		elseif result and list == 3 then
		sampSendChat("/delzam  "..set.text.text1)
		elseif result and list == 4 then
		sampSendChat("/delzam2 "..set.text.text1)
		end
		end
		end
		
		function part3()
		while sampIsDialogActive()do
		wait(0)
		local result, button, list, input = sampHasDialogRespond(16666)
		if result and button == 0 then
		submenus_show(dialog, "{FFFFFF}Выберите игрока для {00FF00}взаимодействия {00FFFF}"..table.concat(thisScript().authors, ", "), "{FFFFFF}Выбрать", "{FFFFFF}Назад", "{FFFFFF}Назад")
		elseif result and list == 0 then
		sampSendChat("/funinvite  "..set.text.text2)
		elseif result and list == 1 then
		sampSendChat("/selestzam  "..set.text.text2)
		elseif result and list == 2 then
		sampSendChat("/selestzam2  "..set.text.text2)
		elseif result and list == 3 then
		sampSendChat("/delzam  "..set.text.text2)
		elseif result and list == 4 then
		sampSendChat("/delzam2 "..set.text.text2)
		end
		end
		end
		
		function part4()
		while sampIsDialogActive()do
		wait(0)
		local result, button, list, input = sampHasDialogRespond(112)
		if result and button == 0 then
		submenus_show(dialog, "{FFFFFF}Выберите игрока для {00FF00}взаимодействия {00FFFF}"..table.concat(thisScript().authors, ", "), "{FFFFFF}Выбрать", "{FFFFFF}Назад", "{FFFFFF}Назад")
		elseif result and list == 0 then
		sampSendChat("/funinvite  "..set.text.text3)
		elseif result and list == 1 then
		sampSendChat("/selestzam  "..set.text.text3)
		elseif result and list == 2 then
		sampSendChat("/selestzam2  "..set.text.text3)
		elseif result and list == 3 then
		sampSendChat("/delzam  "..set.text.text3)
		elseif result and list == 4 then
		sampSendChat("/delzam2 "..set.text.text3)
		end
		end
		end
		
		function part5()
		while sampIsDialogActive()do
		wait(0)
		local result, button, list, input = sampHasDialogRespond(515)
		if result and button == 0 then
		submenus_show(dialog, "{FFFFFF}Выберите игрока для {00FF00}взаимодействия {00FFFF}"..table.concat(thisScript().authors, ", "), "{FFFFFF}Выбрать", "{FFFFFF}Назад", "{FFFFFF}Назад")
		elseif result and list == 0 then
		sampSendChat("/funinvite  "..set.text.text4)
		elseif result and list == 1 then
		sampSendChat("/selestzam  "..set.text.text4)
		elseif result and list == 2 then
		sampSendChat("/selestzam2  "..set.text.text4)
		elseif result and list == 3 then
		sampSendChat("/delzam  "..set.text.text4)
		elseif result and list == 4 then
		sampSendChat("/delzam2 "..set.text.text4)
		end
		end
		end
		
		function part6()
		while sampIsDialogActive()do
		wait(0)
		local result, button, list, input = sampHasDialogRespond(712)
		if result and button == 0 then
		submenus_show(dialog, "{FFFFFF}Выберите игрока для {00FF00}взаимодействия {00FFFF}"..table.concat(thisScript().authors, ", "), "{FFFFFF}Выбрать", "{FFFFFF}Назад", "{FFFFFF}Назад")
		elseif result and list == 0 then
		sampSendChat("/funinvite  "..set.text.text5)
		elseif result and list == 1 then
		sampSendChat("/selestzam "..set.text.text5)
		elseif result and list == 2 then
		sampSendChat("/selestzam2  "..set.text.text5)
		elseif result and list == 3 then
		sampSendChat("/delzam  "..set.text.text5)
		elseif result and list == 4 then
		sampSendChat("/delzam2 "..set.text.text5)
		end
		end
		end
		
		function part7()
		while sampIsDialogActive()do
		wait(0)
		local result, button, list, input = sampHasDialogRespond(481)
		if result and button == 0 then
		submenus_show(dialog, "{FFFFFF}Выберите игрока для {00FF00}взаимодействия {00FFFF}"..table.concat(thisScript().authors, ", "), "{FFFFFF}Выбрать", "{FFFFFF}Назад", "{FFFFFF}Назад")
		elseif result and list == 0 then
		sampSendChat("/funinvite  "..set.text.text6)
		elseif result and list == 1 then
		sampSendChat("/selestzam  "..set.text.text6)
		elseif result and list == 2 then
		sampSendChat("/selestzam2  "..set.text.text6)
		elseif result and list == 3 then
		sampSendChat("/delzam  "..set.text.text6)
		elseif result and list == 4 then
		sampSendChat("/delzam2 "..set.text.text6)
		end
		end
		end
		
		function part8()
		while sampIsDialogActive()do
		wait(0)
		local result, button, list, input = sampHasDialogRespond(178)
		if result and button == 0 then
		submenus_show(dialog, "{FFFFFF}Выберите игрока для {00FF00}взаимодействия {00FFFF}"..table.concat(thisScript().authors, ", "), "{FFFFFF}Выбрать", "{FFFFFF}Назад", "{FFFFFF}Назад")
		elseif result and list == 0 then
		sampSendChat("/funinvite  "..set.text.text7)
		elseif result and list == 1 then
		sampSendChat("/selestzam  "..set.text.text7)
		elseif result and list == 2 then
		sampSendChat("/selestzam2  "..set.text.text7)
		elseif result and list == 3 then
		sampSendChat("/delzam  "..set.text.text7)
		elseif result and list == 4 then
		sampSendChat("/delzam2 "..set.text.text7)
		end
		end
		end
		
		function part9()
		while sampIsDialogActive()do
		wait(0)
		local result, button, list, input = sampHasDialogRespond(773)
		if result and button == 0 then
		submenus_show(dialog, "{FFFFFF}Выберите игрока для {00FF00}взаимодействия {00FFFF}"..table.concat(thisScript().authors, ", "), "{FFFFFF}Выбрать", "{FFFFFF}Назад", "{FFFFFF}Назад")
		elseif result and list == 0 then
		sampSendChat("/funinvite  "..set.text.text8)
		elseif result and list == 1 then
		sampSendChat("/selestzam  "..set.text.text8)
		elseif result and list == 2 then
		sampSendChat("/selestzam2  "..set.text.text8)
		elseif result and list == 3 then
		sampSendChat("/delzam  "..set.text.text8)
		elseif result and list == 4 then
		sampSendChat("/delzam2 "..set.text.text8)
		end
		end
		end
		
		function part10()
		while sampIsDialogActive()do
		wait(0)
		local result, button, list, input = sampHasDialogRespond(612)
		if result and button == 0 then
		submenus_show(dialog, "{FFFFFF}Выберите игрока для {00FF00}взаимодействия {00FFFF}"..table.concat(thisScript().authors, ", "), "{FFFFFF}Выбрать", "{FFFFFF}Назад", "{FFFFFF}Назад")
		elseif result and list == 0 then
		sampSendChat("/funinvite  "..set.text.text9)
		elseif result and list == 1 then
		sampSendChat("/selestzam  "..set.text.text9)
		elseif result and list == 2 then
		sampSendChat("/selestzam2  "..set.text.text9)
		elseif result and list == 3 then
		sampSendChat("/delzam "..set.text.text9)
		elseif result and list == 4 then
		sampSendChat("/delzam2 "..set.text.text9)
		end
		end
		end
		
		function part11()
		while sampIsDialogActive()do
		wait(0)
		local result, button, list, input = sampHasDialogRespond(632)
		if result and button == 0 then
		submenus_show(dialog, "{FFFFFF}Выберите игрока для {00FF00}взаимодействия {00FFFF}"..table.concat(thisScript().authors, ", "), "{FFFFFF}Выбрать", "{FFFFFF}Назад", "{FFFFFF}Назад")
		elseif result and list == 0 then
		sampSendChat("/funinvite  "..set.text.text10)
		elseif result and list == 1 then
		sampSendChat("/selestzam  "..set.text.text10)
		elseif result and list == 2 then
		sampSendChat("/selestzam2  "..set.text.text10)
		elseif result and list == 3 then
		sampSendChat("/delzam  "..set.text.text10)
		elseif result and list == 4 then
		sampSendChat("/delzam2 "..set.text.text10)
		end
		end
		end
