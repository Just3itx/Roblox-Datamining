-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:00:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxAppHooksParent = script:FindFirstAncestor("RobloxAppHooks").Parent

local React = require(RobloxAppHooksParent.React)
local Signals = require(RobloxAppHooksParent.Signals)

local function useSignalsEffect(func1: (...any) -> (...any), current: (...any) -> (...any), current2: ((...any) -> (...any))?)
    local var1 = React.useRef(current)
    var1.current = current
    local var2 = React.useRef(current2)
    var2.current = current2

    local var3 = React.useRef(nil)

    React.useEffect(function()
        local function readChange(arg1)
            local var4 = func1(arg1)
            local current3 = var3.current
            local current4 = var2.current
            local bool1

            if current3 == nil then
                bool1 = false
            else
                if current4 then
                    return var4, (current4(current3.value, var4))
                end

                bool1 = current3.value == var4
            end

            return var4, bool1
        end

        return Signals.createEffect(function(arg1)
            local success, result, result2 = xpcall(readChange, debug.traceback, arg1)
            if not success then
                task.spawn(error, result, 0)
                return
            end

            if result2 then
                return
            end

            var3.current = { value = result }
            local current3 = var1.current
            task.spawn(function()
                current3(result)
            end)
        end)
    end, { func1 })
end

return useSignalsEffect
