-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:40:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local module = {}
local scriptParentParent = script.Parent.Parent
local Object = require(scriptParentParent.LuauPolyfill).Object

local Tracing = require(script.Parent.Tracing)

local enableSchedulerTracing = require(scriptParentParent.Shared).ReactFeatureFlags.enableSchedulerTracing
local __subscriberRef = Tracing.__subscriberRef

local tbl1 = ({})
tbl1 = enableSchedulerTracing and {} or tbl1

function module.unstable_subscribe(arg1)
    if not enableSchedulerTracing then
        return
    end

    tbl1[arg1] = true

    if #Object.keys(tbl1) ~= 1 then
        return
    end

    __subscriberRef.current = {
        onInteractionScheduledWorkCompleted = onInteractionScheduledWorkCompleted,
        onInteractionTraced = onInteractionTraced,
        onWorkCanceled = onWorkCanceled,
        onWorkScheduled = onWorkScheduled,
        onWorkStarted = onWorkStarted,
        onWorkStopped = onWorkStopped
    }
end

function module.unstable_unsubscribe(arg1)
    if not enableSchedulerTracing then
        return
    end

    tbl1[arg1] = nil

    if #Object.keys(tbl1) == 0 then
        __subscriberRef.current = nil
    end
end

function onInteractionTraced(arg1)
    local bool1 = false
    local var1 = nil

    for value, _ in tbl1 do
        local success, result = pcall(value.onInteractionTraced, arg1)

        if not (success or bool1) then
            var1 = result
            bool1 = true
        end
    end

    if bool1 then
        error(var1)
    end
end

function onInteractionScheduledWorkCompleted(arg1)
    local bool1 = false
    local var1 = nil

    for value, _ in tbl1 do
        local success, result = pcall(value.onInteractionScheduledWorkCompleted, arg1)

        if not (success or bool1) then
            var1 = result
            bool1 = true
        end
    end

    if bool1 then
        error(var1)
    end
end

function onWorkScheduled(tbl2, num1: number)
    local bool1 = false
    local var1 = nil

    for value, _ in tbl1 do
        local success, result = pcall(value.onWorkScheduled, tbl2, num1)

        if not (success or bool1) then
            var1 = result
            bool1 = true
        end
    end

    if bool1 then
        error(var1)
    end
end

function onWorkStarted(tbl2, num1: number)
    local bool1 = false
    local var1 = nil

    for value, _ in tbl1 do
        local success, result = pcall(value.onWorkStarted, tbl2, num1)

        if not (success or bool1) then
            var1 = result
            bool1 = true
        end
    end

    if bool1 then
        error(var1)
    end
end

function onWorkStopped(tbl2, num1: number)
    local bool1 = false
    local var1 = nil

    for value, _ in tbl1 do
        local success, result = pcall(value.onWorkStopped, tbl2, num1)

        if not (success or bool1) then
            var1 = result
            bool1 = true
        end
    end

    if bool1 then
        error(var1)
    end
end

function onWorkCanceled(tbl2, num1: number)
    local bool1 = false
    local var1 = nil

    for value, _ in tbl1 do
        local success, result = pcall(value.onWorkCanceled, tbl2, num1)

        if not (success or bool1) then
            var1 = result
            bool1 = true
        end
    end

    if bool1 then
        error(var1)
    end
end

return module
