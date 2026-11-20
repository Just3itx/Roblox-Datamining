-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:31:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)
local Array = require(scriptParentParent.LuauPolyfill).Array

local _ReactInternalTypes = require(script.Parent.ReactInternalTypes)

local Scheduler = require(scriptParentParent.Scheduler)

local ReactFeatureFlags = require(scriptParentParent.Shared).ReactFeatureFlags

local decoupleUpdatePriorityFromScheduler = ReactFeatureFlags.decoupleUpdatePriorityFromScheduler
local invariant = require(scriptParentParent.Shared).invariant
local describeError = require(scriptParentParent.Shared).describeError
local ReactFiberLane = require(script.Parent.ReactFiberLane)
local SyncLanePriority = ReactFiberLane.SyncLanePriority
local getCurrentUpdateLanePriority = ReactFiberLane.getCurrentUpdateLanePriority
local setCurrentUpdateLanePriority = ReactFiberLane.setCurrentUpdateLanePriority

local unstable_runWithPriority = Scheduler.unstable_runWithPriority
local unstable_scheduleCallback = Scheduler.unstable_scheduleCallback
local unstable_cancelCallback = Scheduler.unstable_cancelCallback
local unstable_shouldYield = Scheduler.unstable_shouldYield
local unstable_requestPaint = Scheduler.unstable_requestPaint
local unstable_now = Scheduler.unstable_now
local unstable_getCurrentPriorityLevel = Scheduler.unstable_getCurrentPriorityLevel
local unstable_ImmediatePriority = Scheduler.unstable_ImmediatePriority
local unstable_UserBlockingPriority = Scheduler.unstable_UserBlockingPriority
local unstable_NormalPriority = Scheduler.unstable_NormalPriority
local unstable_LowPriority = Scheduler.unstable_LowPriority
local unstable_IdlePriority = Scheduler.unstable_IdlePriority

local ReactFiberSchedulerPrioritiesRoblox = require(script.Parent["ReactFiberSchedulerPriorities.roblox"])
local ImmediatePriority = ReactFiberSchedulerPrioritiesRoblox.ImmediatePriority
local UserBlockingPriority = ReactFiberSchedulerPrioritiesRoblox.UserBlockingPriority
local NormalPriority = ReactFiberSchedulerPrioritiesRoblox.NormalPriority
local LowPriority = ReactFiberSchedulerPrioritiesRoblox.LowPriority
local IdlePriority = ReactFiberSchedulerPrioritiesRoblox.IdlePriority
local NoPriority = ReactFiberSchedulerPrioritiesRoblox.NoPriority

local var1 = nil

local tbl1 = {}

local var2 = nil
local var3 = nil
local bool1 = false
local var4 = unstable_now()

function reactPriorityToSchedulerPriority(arg1)
    if arg1 == ImmediatePriority then
        return unstable_ImmediatePriority
    end

    if arg1 == UserBlockingPriority then
        return unstable_UserBlockingPriority
    end

    if arg1 == NormalPriority then
        return unstable_NormalPriority
    end

    if arg1 == LowPriority then
        return unstable_LowPriority
    end

    if arg1 == IdlePriority then
        return unstable_IdlePriority
    end
    invariant(false, "Unknown priority level.")

    return nil
end

local function runWithPriority(arg1, func1: (...any) -> (...any)) -- Luacid: Inlined by compiler; 2 call sites recovered
    local var5 = reactPriorityToSchedulerPriority(arg1)
    return unstable_runWithPriority(var5, func1)
end

local function scheduleSyncCallback(func1: (...any) -> (...any))
    if var2 == nil then
        var2 = { func1 }

        var3 = unstable_scheduleCallback(unstable_ImmediatePriority, var1)
    else
        table.insert(var2, func1)
    end
    return tbl1
end

local function flushSyncCallbackQueue()
    if var3 ~= nil then
        local var5 = var3
        var3 = nil
        unstable_cancelCallback(var5)
    end
    return var1()
end

var1 = function(): boolean
    if bool1 or var2 == nil then
        return false
    end

    bool1 = true
    local num1 = 1
    if decoupleUpdatePriorityFromScheduler then
        local currentUpdateLanePriority = getCurrentUpdateLanePriority()

        local result = nil
        local success

        if not ReactGlobals.__YOLO__ then
            local var5 = var2

            setCurrentUpdateLanePriority(SyncLanePriority)
            success, result = xpcall(runWithPriority, describeError, ImmediatePriority, function()
                for value, value2 in var5 do
                    num1 = value

                    repeat
                        value2 = value2(true)
                    until value2 == nil
                end
            end)

            if not ReactFeatureFlags.keepSyncQueueOnError or success then
                var2 = nil
            end
        else
            success = true

            local var5 = var2

            setCurrentUpdateLanePriority(SyncLanePriority)

            runWithPriority(ImmediatePriority, function()
                for value, value2 in var5 do
                    num1 = value

                    repeat
                        value2 = value2(true)
                    until value2 == nil
                    num1 += 1
                end
            end)
            var2 = nil
        end

        setCurrentUpdateLanePriority(currentUpdateLanePriority)
        bool1 = false

        if not success then
            if var2 ~= nil then
                var2 = Array.slice(var2, num1 + 1)
            end

            unstable_scheduleCallback(unstable_ImmediatePriority, flushSyncCallbackQueue)

            error(result)
        end
    else
        local result = nil
        local success

        if not ReactGlobals.__YOLO__ then
            local var5 = var2

            success, result = xpcall(runWithPriority, describeError, ImmediatePriority, function()
                for value, value2 in var5 do
                    num1 = value

                    repeat
                        value2 = value2(true)
                    until value2 == nil
                end
            end)

            if not ReactFeatureFlags.keepSyncQueueOnError or success then
                var2 = nil
            end
        else
            success = true

            local var5 = var2

            runWithPriority(ImmediatePriority, function()
                for value, value2 in var5 do
                    num1 = value

                    repeat
                        value2 = value2(true)
                    until value2 == nil
                end
            end)
            var2 = nil
        end

        bool1 = false

        if not success then
            if var2 ~= nil then
                var2 = Array.slice(var2, num1 + 1)
            end

            unstable_scheduleCallback(unstable_ImmediatePriority, flushSyncCallbackQueue)

            error(result)
        end
    end
    return true
end

return {
    ImmediatePriority = ImmediatePriority,
    UserBlockingPriority = UserBlockingPriority,
    NormalPriority = NormalPriority,
    LowPriority = LowPriority,
    IdlePriority = IdlePriority,
    NoPriority = NoPriority,
    getCurrentPriorityLevel = function()
        local var5 = unstable_getCurrentPriorityLevel()
        if var5 == unstable_ImmediatePriority then
            return ImmediatePriority
        end

        if var5 == unstable_UserBlockingPriority then
            return UserBlockingPriority
        end

        if var5 == unstable_NormalPriority then
            return NormalPriority
        end

        if var5 == unstable_LowPriority then
            return LowPriority
        end

        if var5 == unstable_IdlePriority then
            return IdlePriority
        end
        invariant(false, "Unknown priority level.")

        return NoPriority
    end,
    flushSyncCallbackQueue = flushSyncCallbackQueue,
    runWithPriority = runWithPriority,
    scheduleCallback = function(arg1, func1: (...any) -> (...any), tbl2)
        local var5 = reactPriorityToSchedulerPriority(arg1)
        return unstable_scheduleCallback(var5, func1, tbl2)
    end,
    scheduleSyncCallback = scheduleSyncCallback,
    cancelCallback = function(arg1)
        if arg1 ~= tbl1 then
            unstable_cancelCallback(arg1)
        end
    end,
    now = function()
        return unstable_now() - var4
    end,
    requestPaint = unstable_requestPaint == nil and function() end or unstable_requestPaint,
    shouldYield = unstable_shouldYield
}
