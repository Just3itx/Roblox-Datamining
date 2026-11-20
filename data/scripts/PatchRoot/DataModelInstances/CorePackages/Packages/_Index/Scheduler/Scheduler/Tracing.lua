-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParentParent = script.Parent.Parent
local Set = require(scriptParentParent.LuauPolyfill).Set
local module = {}

local enableSchedulerTracing = require(scriptParentParent.Shared).ReactFeatureFlags.enableSchedulerTracing

local num1 = 0
local num2 = 0

local var1 = nil

local var2 = nil

if enableSchedulerTracing then
    var1 = {
        current = Set.new()
    }
    var2 = { current = nil }
end

module.__interactionsRef = var1
module.__subscriberRef = var2

function module.unstable_clear(callback: (...any) -> (...any))
    if not enableSchedulerTracing then
        return callback()
    end

    local current = var1.current
    var1.current = Set.new()

    local success, result = pcall(callback)

    var1.current = current

    if not success then
        error(result)
    end

    return result
end

function module.unstable_getCurrent()
    return if enableSchedulerTracing then var1.current else nil
end

function module.unstable_getThreadID(): number
    num2 += 1
    return num2
end

function module.unstable_trace(name: string, timestamp: number, func1: (...any) -> (...any), num3: number?)
    local var3 = if num3 == nil then 0 else num3

    if not enableSchedulerTracing then
        return func1()
    end

    local tbl1 = { __count = 1, id = num1, name = name, timestamp = timestamp }

    num1 += 1

    local current = var1.current

    local set = Set.new(current)
    set:add(tbl1)
    var1.current = set

    local current2 = var2.current
    local var4 = nil

    local success, result = pcall(function()
        if current2 ~= nil then
            current2.onInteractionTraced(tbl1)
        end
    end)

    local success2, result2 = pcall(function()
        if current2 ~= nil then
            current2.onWorkStarted(set, var3)
        end
    end)

    local success3, result3 = pcall(function()
        var4 = func1()
    end)

    var1.current = current

    local success4, result4 = pcall(function()
        if current2 ~= nil then
            current2.onWorkStopped(set, var3)
        end
    end)

    tbl1.__count -= 1

    if current2 ~= nil and tbl1.__count == 0 then
        current2.onInteractionScheduledWorkCompleted(tbl1)
    end

    if not success4 then
        error(result4)
    end

    if not success3 then
        error(result3)
    end

    if not success2 then
        error(result2)
    end

    if not success then
        error(result)
    end

    return var4
end

function module.unstable_wrap(func1: (...any) -> (...any), num3: number)
    num3 = if num3 == nil then 0 else num3

    if not enableSchedulerTracing then
        return func1
    end

    local current = var1.current

    local current2 = var2.current
    if current2 ~= nil then
        current2.onWorkScheduled(current, num3)
    end

    for _, value in current do
        value.__count += 1
    end

    local bool1 = false

    local function cancel()
        current2 = var2.current

        local success, result = pcall(function()
            if current2 ~= nil then
                current2.onWorkCanceled(current, num3)
            end
        end)

        for _, value in current do
            value.__count -= 1

            if current2 ~= nil and value.__count == 0 then
                current2.onInteractionScheduledWorkCompleted(value)
            end
        end

        if not success then
            error(result)
        end
    end

    local result = {}

    setmetatable(result, {
        __call = function(_, ...) -- name: _wrapped
            local current3 = var1.current
            var1.current = current

            current2 = var2.current

            local success, result2 = pcall(function(...)
                local var3 = nil

                local success, result2 = pcall(function()
                    if current2 ~= nil then
                        current2.onWorkStarted(current, num3)
                    end
                end)

                local success2, result3 = pcall(function(...)
                    var3 = func1(...)
                end, ...)

                var1.current = current3

                if current2 ~= nil then
                    current2.onWorkStopped(current, num3)
                end

                if not success2 then
                    error(result3)
                end

                if not success then
                    error(result2)
                end

                return var3
            end, ...)

            if not bool1 then
                bool1 = true

                for _, value in current do
                    value.__count -= 1

                    if current2 ~= nil and value.__count == 0 then
                        current2.onInteractionScheduledWorkCompleted(value)
                    end
                end
            end

            if not success then
                error(result2)
            end

            return result2
        end
    })

    result.cancel = cancel

    return result
end

return module
