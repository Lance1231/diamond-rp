script_name("imguiFind")
script_author("Lucifer Melton")
script_version_number(0.1)

local res = pcall(require, "lib.sampfuncs")
assert(res, "Library lib.sampfuncs not found")
---------------------------------------------------------------
local res = pcall(require, "lib.moonloader")
assert(res, "Library lib.moonloader not found")
---------------------------------------------------------------
local res, bit = pcall(require, "bit")
assert(res, "Library bit not found")
---------------------------------------------------------------
local res, imgui = pcall(require, "imgui")
assert(res, "Library imgui not found")
---------------------------------------------------------------
local res, encoding = pcall(require, "encoding")
assert(res, "Library encoding not found")
---------------------------------------------------------------
local res, fa = pcall(require, "faIcons")
assert(res, "Library faIcons not found")
---------------------------------------------------------------
encoding.default = "CP1251"
u8 = encoding.UTF8

local fa_font = nil
local fa_glyph_ranges = imgui.ImGlyphRanges({ fa.min_range, fa.max_range })
function imgui.BeforeDrawFrame()
	if fa_font == nil then
		local font_config = imgui.ImFontConfig()
		font_config.MergeMode = true

		fa_font = imgui.GetIO().Fonts:AddFontFromFileTTF("moonloader/resource/fonts/fontawesome-webfont.ttf", 13.0, font_config, fa_glyph_ranges)
	end
end

function apply_custom_style()
	imgui.SwitchContext()
	local style = imgui.GetStyle()
	local colors = style.Colors
	local clr = imgui.Col
	local ImVec4 = imgui.ImVec4

	style.WindowRounding = 8.0
	style.WindowTitleAlign = imgui.ImVec2(0.5, 0.54)
	style.FrameRounding = 5.0

	colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
	colors[clr.TitleBgActive]          = ImVec4(0.16, 0.29, 0.48, 1.00)
	colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
	colors[clr.Button]                 = ImVec4(0.26, 0.59, 0.98, 0.40)
	colors[clr.ButtonHovered]          = ImVec4(0.26, 0.59, 0.98, 1.00)
	colors[clr.ButtonActive]           = ImVec4(0.06, 0.53, 0.98, 1.00)
	colors[clr.Header]                 = ImVec4(0.26, 0.59, 0.98, 0.31)
	colors[clr.HeaderHovered]          = ImVec4(0.26, 0.59, 0.98, 0.80)
	colors[clr.HeaderActive]           = ImVec4(0.26, 0.59, 0.98, 1.00)
	colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.59, 0.98, 0.35)
	colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
	colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
	colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
	colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
	colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
	colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
	colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
end
apply_custom_style()

function load_json()
	if not doesDirectoryExist("moonloader/resource") then createDirectory("moonloader/resource") end
	if doesFileExist("moonloader/resource/ImguiFind.json") then
		local f = io.open("moonloader/resource/ImguiFind.json")
		config = decodeJson(f:read("*a"))
		f:close()
	else
		config = { ["friends"] = { "Lucifer_Melton" }, ["color"] = 0x00FF00, ["script_enable"] = true }
	end
	main_window_state, main_settings_state, script_enable = imgui.ImBool(false), imgui.ImBool(false), imgui.ImBool(config["script_enable"])
	local r, g, b = imgui.ImColor(config["color"]):GetFloat4()
	color = imgui.ImFloat3(r, g, b)
end

function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then error("need sampfuncs") end
	while not isSampAvailable() do wait(0) end
	load_json()
	while true do
		wait(0)
		imgui.Process = main_window_state.v or main_settings_state.v
		if main_window_state.v and sampIsChatInputActive() then
			main_window_state.v = false
		end
		if main_window_state.v and not script_enable.v then
			main_window_state.v = false
			main_settings_state.v = false
			sampSendChat("/find")
		end
	end
end

function imgui.OnDrawFrame()
	local sw, sh = getScreenResolution()
	if main_window_state.v then
		imgui.Begin(u8(tFind["title"]), main_window_state, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoResize)
		imgui.NewLine(); afk = 0; voice = 0; distance = 0; imgui.Columns(tFind["mo"] and 9 or 8)
		imgui.SetColumnWidth(-1, 35); imgui.CenterColumnText("{f0e48d}ID"); imgui.NextColumn()
		imgui.SetColumnWidth(-1, 170); imgui.CenterColumnText("{f0e48d}Ник"); imgui.NextColumn()
		imgui.SetColumnWidth(-1, 60); imgui.CenterColumnText("{f0e48d}Уровень"); imgui.NextColumn()
		imgui.SetColumnWidth(-1, 85); imgui.CenterColumnText("{f0e48d}Ранг");  imgui.NextColumn()
		imgui.SetColumnWidth(-1, 70); imgui.CenterColumnText("{f0e48d}Выговоры"); imgui.NextColumn()
		if tFind["mo"] then
			imgui.SetColumnWidth(-1, 100); imgui.CenterColumnText("{f0e48d}Уволь./Розыск"); imgui.NextColumn()
		end
		imgui.SetColumnWidth(-1, 65); imgui.CenterColumnText("{f0e48d}Телефон"); imgui.NextColumn()
		imgui.SetColumnWidth(-1, 140); imgui.CenterColumnText("{f0e48d}AFK/VOICE"); imgui.NextColumn()
		imgui.SetColumnWidth(-1, 95); imgui.CenterColumnText("{f0e48d}Расстояние"); imgui.NextColumn(); imgui.Separator()
		for text in tFind["text"]:gmatch("[^\r\n]+") do
			id, lvl, number, rang, reprimands, leaving_search, nick, additional = text:match("{.*}(%d+)%s(%d+)%s%s(%d+)%s(.*)%s(%d+%/3)(.*)%s(%a+.%a+.%a+)(.*)")
			if id ~= nil then
				local res, fnumber = friends(nick)
				if imgui.Selectable(id, false, imgui.SelectableFlags.SpanAllColumns + imgui.SelectableFlags.AllowDoubleClick) then
					imgui.OpenPopup(u8("Информация об игроке %s[%d]"):format(nick, id))
				end
				if imgui.BeginPopupModal(u8("Информация об игроке %s[%d]"):format(nick, id), false, imgui.WindowFlags.AlwaysAutoResize) then
					imgui.Text(u8("ID в игре: %s\nУровень: %s\nРанг: %s\nPing в игре: %s                                                         "):format(id, lvl, u8(rang), sampGetPlayerPing(tonumber(id))))
					imgui.Separator()
					imgui.SetCursorPosX((imgui.GetWindowWidth() - 120) / 2);
					if imgui.Button(u8"Закрыть", imgui.ImVec2(120, 0)) then
						imgui.CloseCurrentPopup()
					end
					imgui.EndPopup();
				end
				if imgui.BeginPopupContextItem("##"..id) then
					imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(("%s[%d]"):format(nick, id)).x) / 2);
					imgui.TextColoredRGB(("{%0.6x}%s[%d]"):format(bit.band(sampGetPlayerColor(tonumber(id)), 0xffffff), nick, id))
					if nick == "Lucifer_Melton" then
						imgui.SameLine(nil, 3); imgui.TextQuestion(u8"Это автор скрипта")
					end
					imgui.Separator()
					if imgui.Button(u8"Скопировать ник", imgui.ImVec2(160.00, 0 --[[ 20.00 ]])) then
						setClipboardText(nick); imgui.CloseCurrentPopup()
					end
					if imgui.Button(u8"Скопировать ник «_»", imgui.ImVec2(160.00, 0 --[[ 20.00 ]])) then
						setClipboardText(nick:gsub("_", " "));  imgui.CloseCurrentPopup()
					end
					if tonumber(id) ~= tonumber(select(2, sampGetPlayerIdByCharHandle(playerPed))) then
						if imgui.Button(u8"Написать сообщение", imgui.ImVec2(160.00, 0 --[[ 20.00 ]])) then
							imgui.CloseCurrentPopup(); main_window_state.v = false
							sampSetChatInputEnabled(true); sampSetChatInputText("/sms " .. number .. " ")
						end
					end
					if res then
						if imgui.Button(u8"Удалить из друзей", imgui.ImVec2(160.00, 0 --[[ 20.00 ]])) then
							imgui.CloseCurrentPopup(); config["friends"][fnumber] = nil
						end
					elseif tonumber(id) == tonumber(select(2, sampGetPlayerIdByCharHandle(playerPed))) then
						-- ...
					else
						if imgui.Button(u8"Добавить в друзья", imgui.ImVec2(160.00, 0 --[[ 20.00 ]])) then
							imgui.CloseCurrentPopup(); config["friends"][#config["friends"] + 1] = nick
						end
					end
					imgui.EndPopup()
				end
				imgui.NextColumn();
				if res then
					imgui.TextColoredRGB(("{%06X}%s"):format(config["color"], nick))
				else imgui.TextColoredRGB(("{%0.6x}%s"):format(bit.band(sampGetPlayerColor(tonumber(id)), 0xffffff), nick)) end
				if additional:find("%{FF764B%}%[ Бан чата %]%{FFFFFF%}") then
					imgui.SameLine(nil, 3); imgui.TextColored(imgui.ImVec4(1, 1, 1, 0.25), fa.ICON_BAN); additional = additional:gsub("%{FF764B%}%[ Бан чата %]%{FFFFFF%}", "")
					if imgui.IsItemHovered() then
						imgui.BeginTooltip()
						imgui.PushTextWrapPos(450.0)
						imgui.Text(u8"У него бан чата")
						imgui.PopTextWrapPos()
						imgui.EndTooltip()
					end
				end
				imgui.NextColumn(); imgui.CenterColumnText(lvl); imgui.NextColumn();
				if tonumber(rang:match("%d+")) >= 10 and tonumber(rang:match("%d+")) <= 12 then
					imgui.CenterColumnText(("{ff0000}%s"):format(rang:gsub("%s+(.*)%s+", "%1")));
				else imgui.CenterColumnText(rang:gsub("%s+(.*)%s+", "%1")); end
				imgui.NextColumn(); imgui.CenterColumnText(reprimands); imgui.NextColumn();
				if tFind["mo"] then
					imgui.CenterColumnText(leaving_search); imgui.NextColumn();
				end
				imgui.CenterColumnText(number); imgui.NextColumn();
				additional = additional:gsub("{ffa800}", ""); additional = additional:gsub("{FFFFFF}", "");
				if additional:find("AFK") or additional:find("VOICE") then
					imgui.CenterColumnText(additional);
				else imgui.CenterColumnText("-") end
				imgui.NextColumn()
				if tonumber(id) == tonumber(select(2, sampGetPlayerIdByCharHandle(playerPed))) then
					imgui.CenterColumnText("{00FF00}Это вы")
				else
					if getDistanceToPlayer(id) ~= nil then
						imgui.CenterColumnText(("{00FF00}%d метров"):format(getDistanceToPlayer(id))); distance = distance + 1
					else imgui.CenterColumnText("{FF0000}Неизвестно"); end
				end
				imgui.NextColumn();
				if additional:find("AFK") then
					afk = afk + 1
				elseif additional:find("VOICE") then
					voice = voice + 1
				end
			end
		end
		imgui.Columns(1); imgui.NewLine()
		imgui.Text(u8"Связь с автором")
		if imgui.IsItemClicked() then
			os.execute("start https://vk.com/a.abishaev")
		end
		imgui.SameLine(nil, 3); imgui.Text("|"); imgui.SameLine(nil, 3); imgui.Text(u8"Обновить список")
		if imgui.IsItemClicked() then
			sampSendChat("/find")
		end
		imgui.SameLine(nil, 3); imgui.Text("|"); imgui.SameLine(nil, 3); imgui.Text(u8"Настройки")
		if imgui.IsItemClicked() then
			main_settings_state.v = not main_settings_state.v
		end
		text = u8("Всего Online: %d | Всего в AFK: [%d/%d] | Всего рядом: [%d/%d]"):format(tFind["online"], afk, tFind["online"], distance, tFind["online"])
		imgui.SameLine();
		imgui.SetCursorPosX( imgui.GetWindowWidth() - imgui.CalcTextSize(text).x - (tFind["online"] >= 40 and 22 or 9) )
		imgui.Text(text)
		imgui.SetWindowSize(u8(tFind["title"]), imgui.ImVec2(tFind["mo"] and 825 or 720, tFind["online"] >= 40 and 500 or -1))
		imgui.SetWindowPos(u8(tFind["title"]), imgui.ImVec2(sw / 2 - imgui.GetWindowSize().x / 2, sh / 2 - imgui.GetWindowSize().y / 2))
		imgui.End()
	end
	if main_settings_state.v then
		imgui.SetNextWindowSize(imgui.ImVec2(-1, -1), imgui.Cond.FirstUseEver)
		imgui.SetNextWindowPos(imgui.ImVec2((sw / 8), sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(u8"Настройки", main_settings_state, imgui.WindowFlags.NoResize)
		if imgui.Checkbox("Script enable", script_enable) then
			config["script_enable"], script_enable.v = script_enable.v, script_enable.v
		end
		imgui.Text(u8"Изменить цвет друзей:"); imgui.SameLine(nil, 3);
		if imgui.ColorEdit3("##color", color, imgui.ColorEditFlags.NoInputs)then
			config["color"] = join_argb(0, color.v[1] * 255, color.v[2] * 255, color.v[3] * 255)
		end
		imgui.End()
	end
end

function join_argb(a, r, g, b)
	return tonumber(("0x%06X"):format(bit.bor(bit.bor(bit.bor(b, bit.lshift(g, 8)), bit.lshift(r, 16)), bit.lshift(a, 24))))
end

function getDistanceToPlayer(id)
	if sampIsPlayerConnected(id) then
		local result, ped = sampGetCharHandleBySampPlayerId(id)
		if result and doesCharExist(ped) then
			local pos = {getCharCoordinates(ped)}
			return math.floor(getDistanceBetweenCoords3d(pos[1], pos[2], pos[3], getCharCoordinates(playerPed)))
		end
	end
	return nil
end

function imgui.TextQuestion(text)
  imgui.TextDisabled(fa.ICON_QUESTION_CIRCLE_O)
  if imgui.IsItemHovered() then
    imgui.BeginTooltip()
    imgui.PushTextWrapPos(450)
    imgui.TextUnformatted(text)
    imgui.PopTextWrapPos()
    imgui.EndTooltip()
  end
end

function imgui.CenterColumnText(text)
	size = text:gsub("{.*}", ""); imgui.SetCursorPosX((imgui.GetColumnOffset() + (imgui.GetColumnWidth() / 2)) - imgui.CalcTextSize(u8(size)).x / 2)
	imgui.TextColoredRGB(text)
end

function onWindowMessage(msg, wparam, lparam)
	if ( msg == 0x100 or msg == 0x101 ) then
		if ( wparam == 0x1B and main_window_state.v ) and not isPauseMenuActive() then
			consumeWindowMessage(true, false)
			if (msg == 0x101) then
				main_window_state.v = false
			end
		elseif ( ( wparam == 0x09 and not isKeyDown(0x09) or wparam == 0x0D and not isKeyDown(0x0D) ) and main_window_state.v ) and not isPauseMenuActive() then
			consumeWindowMessage(true, false)
			main_window_state.v = false
		end
	end
end

-- взял функцию из скрипта [D-RP] ImGui Dashboard.lua автор - AppleThe
function imgui.TextColoredRGB(string)
	local style = imgui.GetStyle()
	local colors = style.Colors
	local clr = imgui.Col

	local function color_imvec4(color)
		if color:upper() == 'SSSSSS' then return colors[clr.Text] end
		local color, rgb = type(color) == 'number' and ('%X'):format(color):upper() or color:upper(), {}
		for i = 1, #color/2 do rgb[#rgb+1] = tonumber(color:sub(2*i-1, 2*i), 16) end
		return imgui.ImVec4(rgb[1]/255, rgb[2]/255, rgb[3]/255, rgb[4] and rgb[4]/255 or colors[clr.Text].w)
	end

	local function render_text(string)
		local text, color, m = {}, {}, 1
		while string:find('{......}') do
			local n, k = string:find('{......}')
			text[#text], text[#text+1] = string:sub(m, n-1), string:sub(k+1, #string)
			color[#color+1] = color_imvec4(string:sub(n+1, k-1))
			local t1, t2 = string:sub(1, n-1), string:sub(k+1, #string)
			string = t1..t2
			m = k-7
		end
		if text[0] then
			for i, _ in ipairs(text) do
				imgui.TextColored(color[i] or colors[clr.Text], u8(text[i]))
				imgui.SameLine(nil, 0)
			end
			imgui.NewLine()
		else imgui.Text(u8(string)) end
	end
	render_text(string)
end

function friends(nick)
	for i, j in pairs(config["friends"]) do if j == nick then return true, i end end return false
end

function save_json()
    local f = io.open("moonloader/resource/ImguiFind.json", "w")
    f:write(encodeJson(config))
    f:close()
end

-- взял от eazy_news by trefa
function onReceiveRpc(id, bs)
	if RPC[id] ~= nil then
        return RPC[id](bs)
    end
end

function onSendRpc(id, bs)
    if RPC[id] ~= nil then
        return RPC[id](bs)
    end
end

RPC = {
    [50] = function(bs)
        if raknetBitStreamReadString(bs, raknetBitStreamReadInt32(bs)):find("/find.settings") then
			main_settings_state.v = not main_settings_state.v
		end
    end,
	[61] = function(bs)
		id, _, title, _, _, text = raknetBitStreamReadInt16(bs), raknetBitStreamReadInt8(bs), raknetBitStreamReadString(bs, raknetBitStreamReadInt8(bs)), raknetBitStreamReadString(bs, raknetBitStreamReadInt8(bs)), raknetBitStreamReadString(bs, raknetBitStreamReadInt8(bs)), raknetBitStreamDecodeString(bs, 4096)
		if text:find("{FFFFFF}Всего Online: {f0e48d}%d+") and script_enable.v then
			if tonumber(text:match("{FFFFFF}Всего Online: {f0e48d}(%d+)")) > 0 then
				tFind = { ["title"] = title:gsub("{.*}", ""), ["text"] = text, ["online"] = tonumber(text:match("{FFFFFF}Всего Online: {f0e48d}(%d+)")), ["mo"] = text:find("Увольнительное%/Розыск") }
				sampSendDialogResponse(id, 1, 0, 0)
				main_window_state.v = true
				return false
			else return true, 61, bs end
		else return true, 61, bs end
	end,
	[93] = function(bs)
		local color, message = raknetBitStreamReadInt32(bs) , raknetBitStreamReadString(bs, raknetBitStreamReadInt32(bs))
		if message:find("• {FFC800}%[Подсказка%] {ffffff}Всего Online: %d+") and script_enable.v then
			return false
		end
	end
}

function onExitScript()
	save_json()
end