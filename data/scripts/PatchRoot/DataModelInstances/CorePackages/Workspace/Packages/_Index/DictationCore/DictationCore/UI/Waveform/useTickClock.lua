-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:01:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")

local DictationCoreParent = script:FindFirstAncestor("DictationCore").Parent

local React = require(DictationCoreParent.React)

local function advanceClock(num1: number, num2: number, num3: number): (number, number) -- Luacid: Inlined by compiler; 1 call site recovered
    num1 += num2
    if num3 <= 0 then
        return 0, num1
    end
    local num4 = math.floor(num1 / num3)
    return num4, num1 - num4 * num3
end

return {
    useTickClock = function(tbl1)
        local var1 = React.useRef(tbl1.onTick)
        var1.current = tbl1.onTick

        local var2 = React.useRef(tbl1.onFrame)
        var2.current = tbl1.onFrame

        local intervalSec = tbl1.intervalSec
        local enabled = tbl1.enabled
        local var3 = tbl1.testHeartbeat or RunService.Heartbeat

        React.useEffect(function()
            if not enabled then
                return
            end

            local num1 = 0
            local connection = var3:Connect(function(num2: number)
                local num3, num4 = advanceClock(num1, num2, intervalSec)
                num1 = num4

                for _ = 1, num3 do
                    var1.current()
                end

                local var4 = if intervalSec > 0 then num1 / intervalSec else 0
                var2.current(var4)
            end)

            return function()
                connection:Disconnect()
            end
        end, { enabled, intervalSec, var3 })
    end,
    advanceClock = advanceClock
}
