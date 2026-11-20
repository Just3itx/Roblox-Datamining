-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:40:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParentParent = script.Parent.Parent

local console = require(scriptParentParent.Shared).console
local module = {}

local _SchedulerPriorities = require(script.Parent.SchedulerPriorities)

local enableProfiling = require(script.Parent.SchedulerFeatureFlags).enableProfiling

local num1 = 0
local num2 = 0

local num3 = 0
local var1 = nil
local var2 = nil
local num4 = 1

local function logEvent(arg1)
    if var2 == nil then
        return
    end
    num4 += #arg1
    if num4 + 1 > num3 then
        num3 *= 2
        if num3 > 524288 then
            console.error(
                "Scheduler Profiling: Event log exceeded maximum size. Don't forget to call `stopLoggingProfilingEvents()`."
            )

            module.stopLoggingProfilingEvents()
            return
        end
        local tbl1 = {}
        table.insert(tbl1, var2)
        var1 = tbl1
        var2 = tbl1
    end
    table.insert(var2, arg1)
end

function module.startLoggingProfilingEvents()
    num3 = 131072
    var1 = {}
    var2 = var1
    num4 = 1
end

function module.stopLoggingProfilingEvents()
    local var3 = var1
    num3 = 0

    var1 = nil
    var2 = nil
    num4 = 1
    return var3
end

function module.markTaskStart(arg1, num5: number)
    if not enableProfiling or var2 == nil then
        return
    end

    logEvent({ 1, num5 * 1000, arg1.id, arg1.priorityLevel })
end

function module.markTaskCompleted(arg1, num5: number)
    if not enableProfiling or var2 == nil then
        return
    end

    logEvent({ 2, num5 * 1000, arg1.id })
end

function module.markTaskCanceled(arg1, num5: number)
    if not enableProfiling or var2 == nil then
        return
    end

    logEvent({ 4, num5 * 1000, arg1.id })
end

function module.markTaskErrored(arg1, num5: number)
    if not enableProfiling or var2 == nil then
        return
    end

    logEvent({ 3, num5 * 1000, arg1.id })
end

function module.markTaskRun(arg1, num5: number)
    if not enableProfiling then
        return
    end

    num1 += 1

    if var2 == nil then
        return
    end

    logEvent({ 5, num5 * 1000, arg1.id, num1 })
end

function module.markTaskYield(arg1, num5: number)
    if not enableProfiling or var2 == nil then
        return
    end

    logEvent({ 6, num5 * 1000, arg1.id, num1 })
end

function module.markSchedulerSuspended(num5: number)
    if not enableProfiling then
        return
    end

    num2 += 1

    if var2 == nil then
        return
    end

    logEvent({ 7, num5 * 1000, num2 })
end

function module.markSchedulerUnsuspended(num5: number)
    if not enableProfiling or var2 == nil then
        return
    end

    logEvent({ 8, num5 * 1000, num2 })
end

return module
