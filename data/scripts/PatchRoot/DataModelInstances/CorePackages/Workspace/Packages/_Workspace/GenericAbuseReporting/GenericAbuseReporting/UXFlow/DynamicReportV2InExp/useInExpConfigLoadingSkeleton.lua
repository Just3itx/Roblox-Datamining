-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:10:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent

local React = require(GenericAbuseReportingParent.React)

local function scheduleCancellableDelay(num1: number, callback: (...any) -> (...any)) -- Luacid: Inlined by compiler; 2 call sites recovered
    local bool1 = false
    local bool2 = false
    local var1 = task.delay(num1, function()
        if not bool1 then
            bool2 = true
            callback()
        end
    end)

    return function()
        bool1 = true
        if not bool2 then
            task.cancel(var1)
        end
    end
end

return {
    useInExpConfigLoadingSkeleton = function(current: boolean, bool1: boolean): boolean
        local var1, var2 = React.useState("idle")
        local var3 = React.useRef(current)
        local var4 = React.useRef(bool1)
        var3.current = current
        var4.current = bool1

        React.useEffect(function()
            if not current then
                var2("idle")
            elseif bool1 then
                if var1 == "idle" then
                    var2("waiting")
                end
            elseif var1 == "waiting" or var1 == "visible" then
                var2("idle")
            end
        end, { current, bool1, var1 })

        React.useEffect(function()
            if var1 == "waiting" then
                return scheduleCancellableDelay(0.35, function()
                    if var3.current and var4.current then
                        var2("minimum")
                        return
                    end
                    var2("idle")
                end)
            elseif var1 == "minimum" then
                return scheduleCancellableDelay(0.5, function()
                    if var3.current and var4.current then
                        var2("visible")
                        return
                    end
                    var2("idle")
                end)
            end

            return nil
        end, { var1 })

        return current and (var1 == "minimum" or var1 == "visible")
    end,
    CONFIG_LOADING_DELAY_SECONDS = 0.35,
    CONFIG_LOADING_MINIMUM_DISPLAY_SECONDS = 0.5
}
