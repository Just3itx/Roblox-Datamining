-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:01:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local reportMomentsRealtimeEvent = require(script.Parent.reportMomentsRealtimeEvent)

local tbl1 = {
    schedule = function(num1: number, func1: (...any) -> (...any))
        return task.delay(num1, func1)
    end,
    cancel = function(thread1: thread)
        task.cancel(thread1)
    end
}

local function createMomentsSessionHeartbeat(num1: number?, func1: ((...any) -> (...any))?, tbl2)
    local num2 = num1 or 60

    local var1 = func1 or reportMomentsRealtimeEvent.reportMomentsSessionHeartbeat
    local var2 = tbl2 or tbl1

    local var3 = nil
    local var4 = nil

    local function tick()
        if var4 == nil then
            return
        end
        var1(var4)
        var3 = var2.schedule(num2, tick)
    end

    local function stop() -- Luacid: Inlined by compiler; 1 call site recovered
        if var3 ~= nil then
            var2.cancel(var3)
            var3 = nil
        end
        var4 = nil
    end

    return {
        start = function(str1: string)
            stop()
            var4 = str1
            var3 = var2.schedule(num2, tick)
        end,
        stop = stop
    }
end

return createMomentsSessionHeartbeat
