require "lib.moonloader"
local key = require "vkeys"
local imgui = require 'imgui'
local encoding = require 'encoding'
local main_window_state = imgui.ImBool(false)
local text_buffer = imgui.ImBuffer(256)
encoding.default = 'CP1251'
u8 = encoding.UTF8
function main()
	while not isSampAvailable() do wait(0) end
	sampRegisterChatCommand("taxhelper", function()
		main_window_state.v = not main_window_state.v
	end)

		while true do
				wait(0)
				if wasKeyPressed(key.VK_F2) then
					sampSendChat("/lock")
				end
				if wasKeyPressed(key.VK_F3) then
					sampSendChat("/st")
				end
				imgui.Process = main_window_state.v
				if wasKeyPressed(key.VK_INSERT) then
					main_window_state.v = not main_window_state.v
					sampAddChatMessage("Скрипт успешно загружен.", 0x00FF40AA)
				end
				if main_window_state.v == false then
					imgui.Process = main_window_state.v
				end
		end
end


function taxhr(arg)
	main_window_state.v = not main_window_state.v
	imgui.Process = main_window_state.v
	sampAddChatMessage("Скрипт успешно загружен!", 0x008000)
end

function imgui.OnDrawFrame()
	if main_window_state.v then
		imgui.SetNextWindowSize(imgui.ImVec2(420, 250), imgui.Cond.FirstUseEver)
		imgui.SetNextWindowPos(imgui.ImVec2(550, 300), imgui.Cond.FirstUseEver)
imgui.Begin("TaxiHelper", main_window_state)
imgui.Text(u8"Введите id пассажира")
imgui.InputText(u8"id пассажира", text_buffer)
imgui.Text(u8"id - " .. text_buffer.v)
imgui.Text(u8"Биндер для показа документов")
		imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(176/255, 48/255, 96/255, 1.0))
		if imgui.Button(u8"Паспорт") then
			sampSendChat("/pass " .. text_buffer.v)
		end
		imgui.PopStyleColor()
		imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(176/255, 48/255, 96/255, 1.0))
		if imgui.Button(u8"Лицензии") then
			sampSendChat("/lic " .. text_buffer.v)
		end
		imgui.PopStyleColor()
		imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(176/255, 48/255, 96/255, 1.0))
		if imgui.Button(u8"Мед. карта ") then
			sampSendChat("/med " .. text_buffer.v)
		end
		imgui.PopStyleColor()
	imgui.SetCursorPos(imgui.ImVec2(480 / 2, 178 / 2))
	imgui.Text(u8"Команды таксиста")
	end
		imgui.SetCursorPos(imgui.ImVec2(480 / 2, 210 / 2))
		imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(160/255, 36/255, 36/255, 1.0))
		if imgui.Button(u8"Запросить местоположение") then
			sampSendChat("/taxi " .. text_buffer.v)
		end
		imgui.PopStyleColor()
		imgui.SetCursorPos(imgui.ImVec2(480 / 2, 260 / 2))
		imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(160/255, 36/255, 36/255, 1.0))
		if imgui.Button(u8"Включить счетчик") then
			sampSendChat("/count")
		end
		imgui.PopStyleColor()
		imgui.SetCursorPos(imgui.ImVec2(480 / 2, 310 / 2))
		imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(160/255, 36/255, 36/255, 1.0))
		if imgui.Button(u8"Список заказов") then
			sampSendChat("/taxilist")
		end
		imgui.PopStyleColor()
		imgui.SetCursorPos(imgui.ImVec2(15 / 2, 450 / 2))
		imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0/255, 0/255, 128/255, 1.0))
		if imgui.Button(u8"Я в Вконтакте") then
			sampAddChatMessage("https://vk.com/d.nosov98", 0x0000FF)
		end
		imgui.PopStyleColor()
		imgui.SetCursorPos(imgui.ImVec2(15 / 2, 380 / 2))
		imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(25/255, 25/255, 112/255, 1.0))
		if imgui.Button(u8"Приветствие") then
			sampSendChat("Здравствуйте! Куда едем?")
		end
		imgui.PopStyleColor()
		imgui.SetCursorPos(imgui.ImVec2(240 / 2, 380 / 2))
		imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(25/255, 25/255, 112/255, 1.0))
		if imgui.Button(u8"Едем!") then
			sampSendChat("Хорошо, едем!")
		end
		imgui.PopStyleColor()
		imgui.SetCursorPos(imgui.ImVec2(400 / 2, 380 / 2))
		imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(25/255, 25/255, 112/255, 1.0))
		if imgui.Button(u8"Приехали") then
			sampSendChat("Приехали, всего доброго!")
		end
		imgui.PopStyleColor()
imgui.End()
end
