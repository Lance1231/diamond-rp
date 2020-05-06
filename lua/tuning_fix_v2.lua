-- _______          _                __ _      
--|__   __|        (_)              / _(_)     
--   | |_   _ _ __  _ _ __   __ _  | |_ ___  __
--   | | | | | '_ \| | '_ \ / _` | |  _| \ \/ /
--   | | |_| | | | | | | | | (_| | | | | |>  < 
--   |_|\__,_|_| |_|_|_| |_|\__, | |_| |_/_/\_\
--                           __/ |             
--                          |___/              

--https://blast.hk/members/50819/
--https://vk.com/trefa.code

local memory = require "memory"

function onReceiveRpc(id,bs)
    if id == 91 then
        local handle = storeCarCharIsInNoSave(playerPed)
        if handle > 0 then
            local RPC = ReadRPC(bs)
            local pint = getCarPointer(handle) --0x4A0
            if memory.getfloat(pint + 0x49C) == 0 and memory.getfloat(pint + 0x4A0) == 0 then
                return false
            end
            local distance = math.abs(math.sqrt(RPC.x ^ 2 + RPC.y ^ 2 + RPC.z ^ 2))
            local vx,vy,vz = getCarSpeedVector(handle)
            if vx ~= 0 and vy ~= 0 and vz ~= 0 then
                k = distance / math.sqrt((vx ^ 2) + (vy ^ 2) + (vz ^ 2))
                return WriteRPC({x = vx * k,y = vy * k,z = vz * k})
            end
            return false
        end
    end
end

function ReadRPC(bs)
    raknetBitStreamSetReadOffset(bs, 8)
    return {
        x = raknetBitStreamReadFloat(bs),
        y = raknetBitStreamReadFloat(bs),
        z = raknetBitStreamReadFloat(bs)
    }
end

function WriteRPC(velocity)
    local bs = raknetNewBitStream()
    raknetBitStreamWriteBool(bs,false)
    raknetBitStreamWriteFloat(bs,velocity.x)
    raknetBitStreamWriteFloat(bs,velocity.y)
    raknetBitStreamWriteFloat(bs,velocity.z)
    return bs
end