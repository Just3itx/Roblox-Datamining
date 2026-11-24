-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local bindableEventQueue = require(script.Parent.bindableEventQueue)

return function(arg1)
    local function createEvent(arg2)
        return function(...)
            local var1 = arg2(...)
            if arg1:GetAttribute("isConnected") ~= true then
                bindableEventQueue:add(var1)
                return
            end
            arg1:Fire(var1)
        end
    end

    return createEvent
end
