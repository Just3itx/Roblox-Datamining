-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:21:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local React = require(ServerDrivenUiParent.React)
local Signals = require(ServerDrivenUiParent.Signals)

local function useOptimisticUpdateStatus<T>(func1: (...any) -> (...any), callback: (...any) -> (...any))
    local var1 = React.useRef(nil)

    React.useEffect(function()
        return function()
            if var1.current then
                var1.current()
            end
        end
    end, {})

    return React.useCallback(function(...)
        if var1.current then
            var1.current()
            var1.current = nil
        end

        local var2 = func1(...)

        if not var2 then
            return
        end

        var1.current = Signals.createEffect(function(arg1)
            local var3 = var2(arg1)
            if var3 ~= nil then
                callback(var3)
            end
        end)
    end, { func1, callback })
end

return useOptimisticUpdateStatus
