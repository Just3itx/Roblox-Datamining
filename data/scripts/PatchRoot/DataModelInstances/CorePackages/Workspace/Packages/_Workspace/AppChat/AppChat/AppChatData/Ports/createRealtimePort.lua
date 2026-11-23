-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:01:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function createRealtimePort(func1: (...any) -> (...any))
    local var1 = nil

    local function getReceiver() -- Luacid: Inlined by compiler; 1 call site recovered
        local var2 = var1
        if var2 ~= nil then
            return var2
        end
        local var3 = func1()
        var1 = var3
        return var3
    end

    return {
        observe = function(str1: string, func2: (...any) -> (...any))
            local var2 = getReceiver():observeEvent(str1, func2)
            return function()
                var2:disconnect()
            end
        end
    }
end

return createRealtimePort
