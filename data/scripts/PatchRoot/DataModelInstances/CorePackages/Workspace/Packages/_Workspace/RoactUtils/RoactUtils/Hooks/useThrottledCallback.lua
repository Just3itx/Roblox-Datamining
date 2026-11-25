-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoactUtilsParent = script:FindFirstAncestor("RoactUtils").Parent

local React = require(RoactUtilsParent.React)
local Promise = require(RoactUtilsParent.Promise)

local function useThrottledCallback(current: (...any) -> (...any), current2: number)
    local var1 = React.useRef(current)
    local var2 = React.useRef(current2)
    var1.current = current
    var2.current = current2

    local var3 = React.useRef(nil)
    local var4 = React.useRef(0)

    local var5 = React.useCallback(function()
        if var3.current then
            return
        end

        local current3 = var2.current or 0
        local var5 = var4.current + current3 - tick()

        local function runCallback() -- Luacid: Inlined by compiler; 1 call site recovered
            var1.current()
            var4.current = tick()
            var3.current = nil
        end

        if var5 > 0 then
            var3.current = Promise.delay(var5):andThen(runCallback)
            return
        end

        runCallback()
    end)

    React.useEffect(function()
        return function()
            local current3 = var3.current
            if current3 then
                current3:cancel()

                var1.current()
            end
        end
    end, {})

    return var5
end

return useThrottledCallback
