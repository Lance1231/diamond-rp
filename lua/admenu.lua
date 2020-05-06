script_name('lastad')
script_author('Oreshka23')

require 'moonloader'
local imgui = require 'imgui'
local encoding = require 'encoding'
local sampev = require 'samp.events'

encoding.default = 'CP1251'
u8 = encoding.UTF8

edit_history = {}

imgui_window = {
    bEnable = imgui.ImBool(false),
    property = imgui.WindowFlags.NoMove + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoTitleBar,
    style_dark = function()
        local style = imgui.GetStyle()
        local colors = style.Colors
        local clr = imgui.Col
        local ImVec4 = imgui.ImVec4
        colors[clr.Text] = ImVec4(0.80, 0.80, 0.83, 1.00)
        colors[clr.TextDisabled] = ImVec4(0.24, 0.23, 0.29, 1.00)
        colors[clr.WindowBg] = ImVec4(0.06, 0.05, 0.07, 0.80)
        colors[clr.ChildWindowBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
        colors[clr.PopupBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
        colors[clr.Border] = ImVec4(0.80, 0.80, 0.83, 0.88)
        colors[clr.BorderShadow] = ImVec4(0.92, 0.91, 0.88, 0.00)
        colors[clr.FrameBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
        colors[clr.FrameBgHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
        colors[clr.FrameBgActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
        colors[clr.TitleBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
        colors[clr.TitleBgCollapsed] = ImVec4(1.00, 0.98, 0.95, 0.75)
        colors[clr.TitleBgActive] = ImVec4(0.07, 0.07, 0.09, 1.00)
        colors[clr.MenuBarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
        colors[clr.ScrollbarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
        colors[clr.ScrollbarGrab] = ImVec4(0.80, 0.80, 0.83, 0.31)
        colors[clr.ScrollbarGrabHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
        colors[clr.ScrollbarGrabActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
        colors[clr.ComboBg] = ImVec4(0.19, 0.18, 0.21, 1.00)
        colors[clr.CheckMark] = ImVec4(0.80, 0.80, 0.83, 0.31)
        colors[clr.SliderGrab] = ImVec4(0.80, 0.80, 0.83, 0.31)
        colors[clr.SliderGrabActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
        colors[clr.Button] = ImVec4(0.10, 0.09, 0.12, 1.00)
        colors[clr.ButtonHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
        colors[clr.ButtonActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
        colors[clr.Header] = ImVec4(0.10, 0.09, 0.12, 1.00)
        colors[clr.HeaderHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
        colors[clr.HeaderActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
        colors[clr.ResizeGrip] = ImVec4(0.00, 0.00, 0.00, 0.00)
        colors[clr.ResizeGripHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
        colors[clr.ResizeGripActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
        colors[clr.CloseButton] = ImVec4(0.40, 0.39, 0.38, 0.16)
        colors[clr.CloseButtonHovered] = ImVec4(0.40, 0.39, 0.38, 0.39)
        colors[clr.CloseButtonActive] = ImVec4(0.40, 0.39, 0.38, 1.00)
        colors[clr.PlotLines] = ImVec4(0.40, 0.39, 0.38, 0.63)
        colors[clr.PlotLinesHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
        colors[clr.PlotHistogram] = ImVec4(0.40, 0.39, 0.38, 0.63)
        colors[clr.PlotHistogramHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
        colors[clr.TextSelectedBg] = ImVec4(0.25, 1.00, 0.00, 0.43)
        colors[clr.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.73)
    end,
    size = imgui.ImVec2(400, 193)
}

imgui_window.style_dark()

function main()
	if not isSampLoaded() then error(thisScript().name..' needs SA:MP!') end
    while not isSampAvailable() do wait(100) end
	while true do
		imgui.Process = imgui_window.bEnable.v
		if sampIsDialogActive() and sampGetCurrentDialogId() == 749 then
			imgui_window.bEnable.v = true
		else
			imgui_window.bEnable.v = false
		end
		wait(0)
	end
end

function imgui.OnDrawFrame()
	if imgui_window.bEnable.v then
		local sw, sh = getScreenResolution()
		imgui.SetNextWindowSize(imgui_window.size, imgui.Cond.FirstUseEver)
		imgui.SetNextWindowPos(imgui.ImVec2(0.7*sw, 0.24*sh), imgui.Cond.FirstUseEver)
		-- imgui.SetNextWindowPos(imgui.ImVec2(955, 185), imgui.Cond.FirstUseEver)
        imgui.Begin("##"..thisScript().name, imgui_window.bEnable, imgui_window.property)
		for _, v in ipairs(edit_history) do
            imgui.Text(u8(v))
            if imgui.IsItemClicked() then
				if sampGetCurrentDialogId() == 749 and sampIsDialogActive() then
					sampSetCurrentDialogEditboxText(v)
				end
            end
        end
        imgui.End()
    end
end

function sampev.onSendDialogResponse(dialogId, button, listboxId, input)
	if dialogId == 749 and button == 1 then
		if #edit_history == 10 then table.remove(edit_history, 1) end
		table.insert(edit_history, input)
	end
end