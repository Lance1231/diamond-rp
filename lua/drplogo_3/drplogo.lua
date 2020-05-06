script_name("DRP Logo")
script_author("gabrielito")

tid = {138, 141, 145, 143, 151, 140, 144, 149, 146, 150, 142, 147, 148, 159, 139, 158, 156, 157, 154, 153, 152, 155}

function main()
    if not isSampfuncsLoaded() or not isSampLoaded() then return end
    while not isSampAvailable() do wait(100) end
    while sampGetCurrentServerName() == "SA-MP" do wait(0) end
    if not sampGetCurrentServerName():lower():match("diamond") then
       thisScript():unload()
        return
    end
    IsLoaded = loadTextureDictionary('logo')
    if not IsLoaded then sampAddChatMessage("‘айл txd не был найден(мб его нету?)", -1) return 
    elseif IsLoaded then
        lua_thread.create(function()
            while true do
                wait(5000)
                sprite = loadSprite(string.match(sampGetCurrentServerName(), 'Diamond Role Play | (.+) | VOICE'))
                return
            end
        end)
    end
    while true do
        wait(0)
        for key, val in pairs(tid) do sampTextdrawDelete(val) end
        if sprite ~= nil then
            drawSprite(sprite, 589, 20, 57, 57, 255, 255, 255, 255)
        end
    end
end