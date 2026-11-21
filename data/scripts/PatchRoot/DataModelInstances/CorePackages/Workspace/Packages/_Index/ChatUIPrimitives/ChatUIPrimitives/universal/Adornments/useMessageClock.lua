-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local React = require(ChatUIPrimitivesParent.React)
local Signals = require(ChatUIPrimitivesParent.Signals)

local function readWallClockMs(): number
    return DateTime.now().UnixTimestampMillis
end

local function useMessageClock(tbl1)
    local var1 = React.useRef(tbl1.getNowMs or readWallClockMs)
    var1.current = tbl1.getNowMs or readWallClockMs

    local var2 = React.useMemo(function()
        local now, setNow = Signals.createSignal(var1.current())
        return { now = now, setNow = setNow }
    end, {})

    local bool1 = tbl1.enabled ~= false
    local intervalSeconds = tbl1.intervalSeconds or 30

    React.useEffect(function()
        if not bool1 then
            return function() end
        end
        var2.setNow(var1.current())
        local var3 = nil
        local function scheduleNext() -- Luacid: Inlined by compiler; 1 call site recovered
            var3 = task.delay(intervalSeconds, function()
                var3 = nil
                var2.setNow(var1.current())
                scheduleNext()
            end)
        end

        scheduleNext()

        return function()
            if var3 ~= nil then
                task.cancel(var3)
                var3 = nil
            end
        end
    end, { bool1, intervalSeconds })

    return var2.now
end

return useMessageClock
