script_name('Ignore Chat Diamond Edit')
script_authors('akionka', 'Ningaro')
script_version('1.11.1')
local sampev = require 'lib.samp.events'
local imgui = require 'imgui'
local inicfg = require 'inicfg'
local encoding = require 'encoding' -- ��������� ����������
encoding.default = 'CP1251' -- ��������� ��������� �� ���������, ��� ������ ��������� � ���������� �����. CP1251 - ��� Windows-1251
u8 = encoding.UTF8 -- � ������ �������� ��������� ��� ����������� UTF-8

local colournews1 = 16711935 --Color news
local colournews2 = 866792362 --Color news2
local colourrn = -1394212609 --Color rn
local colourfn = 1182971050 --Color fn
local colouradmins1 = -11521878 --Color admins
local colouradmins2 = -65366 -- NonRP nickname
local colouradmins3 = -6750038 -- Change nickname donate
local colouradmins4 = -3342081 -- Admins talks
local colourgosnews = 1147587839 --Color gosnews
local colourcasino1 = -3116033 --Color casino royel
local colourcasino2 = -1358102273 --Color casino 4 dragons
local colourServerMP = 869072810
local colourPubg = -65366 -- Color Pubg
local colourGosLoto = -1 -- Color GosLoto
local colournchat = -859006465 -- /n chat
local colourkchat = -3368449 -- /k chat
local colourpolice1 = 8388607 -- System /su & /su & /ticket & /call 911 & /pt calls
local colourpolice2 = -9103105 -- Neytralizatsiya
local colourpolice3 = 1182971050 -- /takelic
local colourpolice4 = -99610369 -- /q on arrest

local ini = inicfg.load({
  settings =
  {
		ignoreall = false,
    ignorenews = false,
    ignorern = false,
    ignorefn = false,
		ignoreadmins = false,
		ignoregosnews = false,
		ignorecasino = false,
		ignoreServerMP = false,
		ignoreGosLoto = false,
		ignorenchat  = false,
		ignorekchat  = false,
		ignorepolice1 = false,
		ignorepolice2 = false,
		ignorepolice3 = false,
		ignorepolice4 = false,
		ignorepolice5 = false,
		ignorepolice6 = false,
    startmsg = true,
		dev_allPrint = false,
  },
}, "ignore-chat")

function sampev.onServerMessage(color, text)
  if ini.settings.dev_allPrint then	print(text .. " " .. color) end
	if ini.settings.ignoreall then print("[Ignored]: " .. text) return false end
  if ini.settings.ignorenews and color == colournews1 and text:find("�����������:") then print("[Ignored]: " .. text) return false end
	if ini.settings.ignorenews and color == colournews2 and text:find("���������� ��������:") then print("[Ignored]: " .. text) return false end
  if ini.settings.ignorern and color == colourrn and text:find("%[R%] %(%(") then print("[Ignored]: " .. text) return false end
  if ini.settings.ignorefn and color == colourfn and text:find("%[F%] %(%(") then print("[Ignored]: " .. text) return false end
	if ini.settings.ignoreadmins and color == colouradmins1 and (text:find("�������������") or text:find("�������������a")) then print("[Ignored]: " .. text) return false end
	if ini.settings.ignoreadmins and color == colouradmins2 and text:find("�����") then print("[Ignored]: " .. text) return false end
	if ini.settings.ignoreadmins and color == colouradmins3 and text:find("���") then print("[Ignored]: " .. text) return false end
	if ini.settings.ignoreadmins and color == colouradmins4 and text:find("�������������") then print("[Ignored]: " .. text) return false end
	if ini.settings.ignoregosnews and color == colourgosnews and text:find("%[���.�������%]") then print("[Ignored]: " .. text) return false end
	if ini.settings.ignorecasino and color == colourcasino1 and text:find("������") then print("[Ignored]: " .. text) return false end
	if ini.settings.ignorecasino and color == colourcasino2 and text:find("������") then print("[Ignored]: " .. text) return false end
	if ini.settings.ignoreServerMP and color == colourServerMP then print("[Ignored]: " .. text) return false end
	if ini.settings.ignoreServerMP and color == colourPubg and text:find("PUBG") then print("[Ignored]: " .. text) return false end
	if ini.settings.ignoreGosLoto and color == colourGosLoto and text:find("�������") then print("[Ignored]: " .. text) return false end
	if ini.settings.ignorenchat and color == colournchat and text:find("%(%(") then print("[Ignored]: " .. text) return false end
	if ini.settings.ignorekchat and color == colourkchat then print("[Ignored]: " .. text) return false end
	if ini.settings.ignorepolice1 and color == colourpolice1 and text:find("��������") then print("[Ignored]: " .. text) return false end
	if ini.settings.ignorepolice1 and color == colourpolice1 and text:find("������ �����") then print("[Ignored]: " .. text) return false end
	if ini.settings.ignorepolice1 and color == colourpolice1 and text:find("�������") then print("[Ignored]: " .. text) return false end
	if ini.settings.ignorepolice2 and color == colourpolice1 and text:find("�������� � ������ +") and text:find("%(") then print("[Ignored]: " .. text) return false end
	if ini.settings.ignorepolice3 and color == colourpolice1 and text:find("�������� � ������ +") then print("[Ignored]: " .. text) return false end
	if ini.settings.ignorepolice3 and color == colourpolice1 and text:find("����������%:") then print("[Ignored]: " .. text) return false end
	if ini.settings.ignorepolice4 and color == colourpolice4 and text:find("�����") then print("[Ignored]: " .. text) return false end
	if ini.settings.ignorepolice4 and color == colourpolice2 and text:find("�������������") then print("[Ignored]: " .. text) return false end
	if ini.settings.ignorepolice4 and color == colourpolice2 and text:find("������") then print("[Ignored]: " .. text) return false end
	if ini.settings.ignorepolice5 and color == colourpolice1 and text:find("����� � �������") then print("[Ignored]: " .. text) return false end
	if ini.settings.ignorepolice6 and color == colourpolice3 and text:find("������") then print("[Ignored]: " .. text) return false end
end

local main_window_state = imgui.ImBool(false)
local startmsg = imgui.ImBool(ini.settings.startmsg)
local ignoreall = imgui.ImBool(ini.settings.ignoreall)
local dev_allPrint = imgui.ImBool(ini.settings.dev_allPrint)
local ignorenews = imgui.ImBool(ini.settings.ignorenews)
local ignorern = imgui.ImBool(ini.settings.ignorern)
local ignorefn = imgui.ImBool(ini.settings.ignorefn)
local ignoreadmins = imgui.ImBool(ini.settings.ignoreadmins)
local ignoregosnews = imgui.ImBool(ini.settings.ignoregosnews)
local ignorecasino = imgui.ImBool(ini.settings.ignorecasino)
local ignoreServerMP = imgui.ImBool(ini.settings.ignoreServerMP)
local ignoreGosLoto = imgui.ImBool(ini.settings.ignoreGosLoto)
local ignorenchat = imgui.ImBool(ini.settings.ignorenchat)
local ignorekchat = imgui.ImBool(ini.settings.ignorekchat)
local ignorepolice1 = imgui.ImBool(ini.settings.ignorepolice1)
local ignorepolice2 = imgui.ImBool(ini.settings.ignorepolice2)
local ignorepolice3 = imgui.ImBool(ini.settings.ignorepolice3)
local ignorepolice4 = imgui.ImBool(ini.settings.ignorepolice4)
local ignorepolice5 = imgui.ImBool(ini.settings.ignorepolice5)
local ignorepolice6 = imgui.ImBool(ini.settings.ignorepolice6)

--Forma GUI
function imgui.OnDrawFrame()
  if main_window_state.v then
    imgui.Begin(thisScript().name.." v"..thisScript().version, main_window_state, imgui.WindowFlags.AlwaysAutoResize)
    if imgui.Checkbox(u8'������ ������� /ad', ignorenews) then
      ini.settings.ignorenews = ignorenews.v
      inicfg.save(ini, 'ignore-chat')
    end
		if imgui.Checkbox(u8'������ ��������� /n ����', ignorenchat) then
      ini.settings.ignorenchat = ignorenchat.v
      inicfg.save(ini, 'ignore-chat')
    end
    if imgui.Checkbox(u8'������ ��������� OOC ����� /rn', ignorern) then
      ini.settings.ignorern = ignorern.v
      inicfg.save(ini, 'ignore-chat')
    end
    if imgui.Checkbox(u8'������ ����������� OOC ����� /fn', ignorefn) then
      ini.settings.ignorefn = ignorefn.v
      inicfg.save(ini, 'ignore-chat')
    end
		if imgui.Checkbox(u8'������ ��������� �������� ����� /k', ignorekchat) then
      ini.settings.ignorekchat = ignorekchat.v
      inicfg.save(ini, 'ignore-chat')
    end
		if imgui.Checkbox(u8'������ �������� �������������', ignoreadmins) then
      ini.settings.ignoreadmins = ignoreadmins.v
      inicfg.save(ini, 'ignore-chat')
    end
		if imgui.Checkbox(u8'������ ���. �������', ignoregosnews) then
      ini.settings.ignoregosnews = ignoregosnews.v
      inicfg.save(ini, 'ignore-chat')
    end
		if imgui.Checkbox(u8'������ ���������� ������', ignorecasino) then
      ini.settings.ignorecasino = ignorecasino.v
      inicfg.save(ini, 'ignore-chat')
    end
		if imgui.Checkbox(u8'������ ���������� � ��������� ������������', ignoreServerMP) then
      ini.settings.ignoreServerMP = ignoreServerMP.v
      inicfg.save(ini, 'ignore-chat')
    end
		if imgui.Checkbox(u8'������ ���������� � �������', ignoreGosLoto) then
      ini.settings.ignoreGosLoto = ignoreGosLoto.v
      inicfg.save(ini, 'ignore-chat')
    end
		if imgui.CollapsingHeader(u8'��������� ��������� �������') then
			if imgui.Checkbox(u8'����� 9-1-1', ignorepolice1) then
	      ini.settings.ignorepolice1 = ignorepolice1.v
	      inicfg.save(ini, 'ignore-chat')
	    end
			if imgui.Checkbox(u8'��������� ������', ignorepolice2) then
	      ini.settings.ignorepolice2 = ignorepolice2.v
	      inicfg.save(ini, 'ignore-chat')
	    end
			if imgui.Checkbox(u8'������ /su', ignorepolice3) then
	      ini.settings.ignorepolice3 = ignorepolice3.v
	      inicfg.save(ini, 'ignore-chat')
	    end
			if imgui.Checkbox(u8'������������� � ����� �� ������', ignorepolice4) then
	      ini.settings.ignorepolice4 = ignorepolice4.v
	      inicfg.save(ini, 'ignore-chat')
	    end
			if imgui.Checkbox(u8'������ /ticket', ignorepolice5) then
	      ini.settings.ignorepolice5 = ignorepolice5.v
	      inicfg.save(ini, 'ignore-chat')
	    end
			if imgui.Checkbox(u8'������� ���� /takelic', ignorepolice6) then
	      ini.settings.ignorepolice6 = ignorepolice6.v
	      inicfg.save(ini, 'ignore-chat')
	    end
    end
    if imgui.CollapsingHeader(u8'�������������� ���������') then
			if imgui.Button(u8'��������� ���') then  for i = 1, 20 do	sampAddChatMessage("", -1)  end  end
      if imgui.Checkbox(u8"��������� ���������", startmsg) then
        ini.settings.startmsg = startmsg.v
        inicfg.save(ini, "ignore-chat")
      end
			if imgui.Checkbox(u8"�������� ��� ��������� � �������", dev_allPrint) then
        ini.settings.dev_allPrint = dev_allPrint.v
        inicfg.save(ini, "ignore-chat")
      end
			if imgui.Checkbox(u8"������������ ��� ��������� �� ����", ignoreall) then
        ini.settings.ignoreall = ignoreall.v
        inicfg.save(ini, "ignore-chat")
      end
			imgui.Text(u8'P.s. ��� "������������ ��������� � ������� SAMPFUNCS"')
      imgui.Separator()
    end
		imgui.Text(u8'������������:')
		if imgui.Button(u8'akionka (������������ �����������)') then os.execute('explorer "https://vk.com/akionka"') end
		if imgui.Button(u8'Ningaro (������ ��� Diamond)') then os.execute('explorer "https://forum.diamondrp.ru/members/ningaro.18031/"') end
    imgui.End()
  end
end

function apply_custom_style()
	imgui.SwitchContext()
	local a=imgui.GetStyle()
	local b=a.Colors;
	local c=imgui.Col;
	local d=imgui.ImVec4;
	a.WindowRounding=0.0;
	a.WindowTitleAlign=imgui.ImVec2(0.5,0.5)a.ChildWindowRounding=0.0;
	a.FrameRounding=0.0;
	a.ItemSpacing=imgui.ImVec2(5.0,5.0)a.ScrollbarSize=13.0;
	a.ScrollbarRounding=0;a.GrabMinSize=8.0;
	a.GrabRounding=0.0;
	b[c.TitleBg]=d(0.41,0.76,0.20,1.00)
	b[c.TitleBgActive]=d(0.41,0.76,0.20,1.00)
	b[c.TitleBgCollapsed]=d(0.41,0.76,0.20,1.00)
	b[c.CheckMark]=d(0.41,0.76,0.20,1.00)
	b[c.Button]=d(0.41,0.76,0.20,0.31)
	b[c.ButtonHovered]=d(0.41,0.76,0.20,0.80)
	b[c.ButtonActive]=d(0.41,0.76,0.20,1.00)
	b[c.WindowBg]=d(0.13,0.13,0.13,0.90)
	b[c.Header]=d(0.41,0.76,0.20,0.31)
	b[c.HeaderHovered]=d(0.41,0.76,0.20,0.80)
	b[c.HeaderActive]=d(0.41,0.76,0.20,1.00)
	b[c.FrameBg]=d(0.41,0.76,0.20,0.31)
	b[c.FrameBgHovered]=d(0.41,0.76,0.20,0.80)
	b[c.FrameBgActive]=d(0.41,0.76,0.20,1.00)
	b[c.ScrollbarBg]=d(0.41,0.76,0.20,0.31)
	b[c.ScrollbarGrab]=d(0.41,0.76,0.20,0.31)
	b[c.ScrollbarGrabHovered]=d(0.41,0.76,0.20,0.80)
	b[c.ScrollbarGrabActive]=d(0.41,0.76,0.20,1.00)
	b[c.Text]=d(1.00,1.00,1.00,1.00)
	b[c.Border]=d(0.41,0.76,0.20,0.00)
	b[c.BorderShadow]=d(0.00,0.00,0.00,0.00)
	b[c.CloseButton]=d(0.41,0.76,0.20,0.31)
	b[c.CloseButtonHovered]=d(0.41,0.76,0.20,0.80)
	b[c.CloseButtonActive]=d(0.41,0.76,0.20,1.00)
end

--Loading Script
function main()
  if not isSampfuncsLoaded() or not isSampLoaded() then return end
  while not isSampAvailable() do wait(0) end
	apply_custom_style()
  sampRegisterChatCommand("igmenu", function()
    main_window_state.v = not main_window_state.v
    -- print(main_window_state.v)
  end)

  if ini.settings.startmsg then
    sampAddChatMessage("[IC]: ������ {00FF00}�������{FFFFFF} ��������. ������: {2980b9}"..thisScript().version.."{FFFFFF}.", - 1)
    sampAddChatMessage("[IC]: ����� - {2980b9}Akionka & Ningaro{FFFFFF}. ��������� ������ ��������� ����� � {2980b9}/igmenu{FFFFFF} ��� {2980b9}Ctrl + T{FFFFFF}.", - 1)
  end

  while true do
    wait(0)
    imgui.Process = main_window_state.v
		if isKeyDown(0x11) and isKeyDown(0x54) then -- CTRL+T
			while isKeyDown(0x11) and isKeyDown(0x54) do wait(80) end
			main_window_state.v = not main_window_state.v
			-- print(main_window_state.v)
		end
  end
end
