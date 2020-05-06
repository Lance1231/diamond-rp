script_name("AutoTimeOn")
script_author("Nick_Sweet")
script_description("Сижу на DRP | Emerald :)")

require "lib.moonloader"
local sampev = require 'lib.samp.events'

function main()

    if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(100) end
    timeon = lua_thread.create_suspended(timeon)

end

function sampev.onServerMessage(color, text)
    if text:match("Добро пожаловать на Diamond Role Play!") then
        timeon:run()
    end
    if text:match("У вас нет часов Screen") then
        return false
    end
end

function timeon()
    wait(0)
    sampSendChat("/timeon")
end