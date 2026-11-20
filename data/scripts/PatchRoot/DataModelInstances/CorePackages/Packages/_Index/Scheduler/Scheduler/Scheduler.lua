-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:40:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1)
    local scriptParentParent = script.Parent.Parent
    local reactGlobals = require(scriptParentParent.ReactGlobals)
    local shared = require(scriptParentParent.Shared)

    local describeError = shared.describeError
    local reactFeatureFlags = shared.ReactFeatureFlags

    local schedulerFeatureFlags = require(script.Parent.SchedulerFeatureFlags)
    local enableSchedulerDebugging = schedulerFeatureFlags.enableSchedulerDebugging
    local enableProfiling = schedulerFeatureFlags.enableProfiling

    local var1 = arg1 or require(script.Parent.SchedulerHostConfig)
    local requestHostCallback = var1.requestHostCallback
    local requestHostTimeout = var1.requestHostTimeout
    local cancelHostTimeout = var1.cancelHostTimeout
    local shouldYieldToHost = var1.shouldYieldToHost
    local getCurrentTime = var1.getCurrentTime
    local forceFrameRate = var1.forceFrameRate
    local requestPaint = var1.requestPaint
    local setSchedulerFlags = var1.setSchedulerFlags
    local getSchedulerFlags = var1.getSchedulerFlags

    local noYield = require(script.Parent.NoYield)

    local var2 = nil
    local var3 = nil
    local var4 = nil

    local function func1<T>(tbl1, tbl2) -- Luacid: Inlined by compiler; 3 call sites recovered
        local num1 = #tbl1 + 1
        tbl1[num1] = tbl2

        var3(tbl1, tbl2, num1)
    end

    local function unstableGetFirstCallbackNode<T>(tbl1): T -- Luacid: Inlined by compiler; 10 call sites recovered
        return tbl1[1]
    end

    local function func3(tbl1) -- Luacid: Inlined by compiler; 4 call sites recovered
        local var5 = tbl1[1]
        if var5 == nil then
            return nil
        end

        local var6 = tbl1[#tbl1]
        tbl1[#tbl1] = nil

        if var6 ~= var5 then
            tbl1[1] = var6
            var4(tbl1, var6, 1)
        end
        return var5
    end

    var3 = function(tbl1, tbl2, num1: number)
        while true do
            local num2 = math.floor(num1 / 2)
            local var5 = tbl1[num2]
            if var5 == nil or not (var2(var5, tbl2) > 0) then
                break
            end
            tbl1[num2] = tbl2
            tbl1[num1] = var5
            num1 = num2
        end
    end

    var4 = function(tbl1, tbl2, num1: number)
        local num2 = #tbl1
        while num1 < num2 do
            local num3 = num1 * 2
            local var5 = tbl1[num3]
            local num4 = num3 + 1
            local var6 = tbl1[num4]

            if var5 ~= nil and var2(var5, tbl2) < 0 then
                if var6 ~= nil and var2(var6, var5) < 0 then
                    tbl1[num1] = var6
                    tbl1[num4] = tbl2
                else
                    tbl1[num1] = var5
                    tbl1[num3] = tbl2
                    num4 = num3
                end
            else
                if var6 == nil or not (var2(var6, tbl2) < 0) then
                    return
                end

                tbl1[num1] = var6
                tbl1[num4] = tbl2
            end

            num1 = num4
        end
    end

    var2 = function(tbl1, tbl2)
        local var5 = tbl1.sortIndex - tbl2.sortIndex

        if var5 == 0 then
            return tbl1.id - tbl2.id
        end

        return var5
    end

    local schedulerPriorities = require(script.Parent.SchedulerPriorities)
    local immediatePriority = schedulerPriorities.ImmediatePriority
    local userBlockingPriority = schedulerPriorities.UserBlockingPriority
    local normalPriority = schedulerPriorities.NormalPriority
    local lowPriority = schedulerPriorities.LowPriority
    local idlePriority = schedulerPriorities.IdlePriority

    local schedulerProfiling = require(script.Parent.SchedulerProfiling)
    local markTaskRun = schedulerProfiling.markTaskRun
    local markTaskYield = schedulerProfiling.markTaskYield
    local markTaskCompleted = schedulerProfiling.markTaskCompleted
    local markTaskCanceled = schedulerProfiling.markTaskCanceled
    local markTaskErrored = schedulerProfiling.markTaskErrored
    local markSchedulerSuspended = schedulerProfiling.markSchedulerSuspended
    local markSchedulerUnsuspended = schedulerProfiling.markSchedulerUnsuspended
    local markTaskStart = schedulerProfiling.markTaskStart
    local stopLoggingProfilingEvents = schedulerProfiling.stopLoggingProfilingEvents
    local startLoggingProfilingEvents = schedulerProfiling.startLoggingProfilingEvents

    local tbl1 = {}
    local tbl2 = {}

    local num1 = 1

    local bool1 = false

    local var5 = nil
    local unstableGetCurrentPriorityLevel = normalPriority

    local bool2 = false

    local bool3 = false
    local bool4 = false

    local var7 = nil
    local var8 = nil

    local function advanceTimers(startTime)
        local var9 = unstableGetFirstCallbackNode(tbl2)

        while var9 ~= nil do
            if var9.callback == nil then
                func3(tbl2)
            else
                if not (var9.startTime <= startTime) then
                    return
                end

                func3(tbl2)
                var9.sortIndex = var9.expirationTime
                func1(tbl1, var9)
                if enableProfiling then
                    markTaskStart(var9, startTime)
                    var9.isQueued = true
                end
            end

            var9 = unstableGetFirstCallbackNode(tbl2)
        end
    end

    local function func4(startTime)
        bool4 = false
        advanceTimers(startTime)

        if bool3 then
            return
        end

        if unstableGetFirstCallbackNode(tbl1) ~= nil then
            bool3 = true
            requestHostCallback(var7)
            return
        end

        local var9 = unstableGetFirstCallbackNode(tbl2)
        if var9 ~= nil then
            requestHostTimeout(func4, var9.startTime - startTime)
        end
    end

    var7 = function(arg2, arg3)
        if enableProfiling then
            markSchedulerUnsuspended(arg3)
        end

        bool3 = false
        if bool4 then
            bool4 = false
            cancelHostTimeout()
        end

        bool2 = true
        local var9 = unstableGetCurrentPriorityLevel
        local result, success

        if reactGlobals.__YOLO__ then
            result = var8(arg2, arg3)
            success = true
        elseif enableProfiling then
            success, result = xpcall(var8, describeError, arg2, arg3)

            if not success and var5 ~= nil then
                local currentTime = getCurrentTime()
                markTaskErrored(var5, currentTime)
                var5.isQueued = false
            end
        else
            result = var8(arg2, arg3)
            success = true
        end

        var5 = nil
        unstableGetCurrentPriorityLevel = var9
        bool2 = false
        if enableProfiling then
            local currentTime = getCurrentTime()
            markSchedulerSuspended(currentTime)
        end

        if not success then
            error(result)
        end

        return result
    end

    var8 = function(arg2, arg3): boolean
        local catchYieldingInDev = reactGlobals.__DEV__ and reactFeatureFlags.catchYieldingInDEV

        advanceTimers(arg3)
        var5 = unstableGetFirstCallbackNode(tbl1)

        while var5 ~= nil
            and not (enableSchedulerDebugging and bool1)
            and (not (arg3 < var5.expirationTime) or arg2 and not shouldYieldToHost()) do
            local callback = var5.callback
            if typeof(callback) == "function" then
                var5.callback = nil
                unstableGetCurrentPriorityLevel = var5.priorityLevel
                local bool5 = var5.expirationTime <= arg3
                markTaskRun(var5, arg3)
                local var6 = if catchYieldingInDev then noYield(callback, bool5) else callback(bool5)
                arg3 = getCurrentTime()
                if typeof(var6) == "function" then
                    var5.callback = var6
                    markTaskYield(var5, arg3)
                else
                    if enableProfiling then
                        markTaskCompleted(var5, arg3)
                        var5.isQueued = false
                    end

                    if var5 == unstableGetFirstCallbackNode(tbl1) then
                        func3(tbl1)
                    end
                end

                advanceTimers(arg3)
            else
                func3(tbl1)
            end

            var5 = unstableGetFirstCallbackNode(tbl1)
        end

        if var5 ~= nil then
            return true
        end

        local var9 = unstableGetFirstCallbackNode(tbl2)
        if var9 ~= nil then
            requestHostTimeout(func4, var9.startTime - arg3)
        end

        return false
    end

    return {
        unstable_ImmediatePriority = immediatePriority,
        unstable_UserBlockingPriority = userBlockingPriority,
        unstable_NormalPriority = normalPriority,
        unstable_IdlePriority = idlePriority,
        unstable_LowPriority = lowPriority,
        unstable_runWithPriority = function(arg2, callback)
            if arg2 ~= immediatePriority
                and arg2 ~= userBlockingPriority
                and arg2 ~= normalPriority
                and arg2 ~= lowPriority
                and arg2 ~= idlePriority
            then
                arg2 = normalPriority
            end

            local var9 = unstableGetCurrentPriorityLevel
            unstableGetCurrentPriorityLevel = arg2
            local success, result

            if not reactGlobals.__YOLO__ then
                success, result = xpcall(callback, describeError)
            else
                result = callback()
                success = true
            end

            unstableGetCurrentPriorityLevel = var9

            if not success then
                error(result)
            end

            return result
        end,
        unstable_next = function(callback)
            local var9 = if unstableGetCurrentPriorityLevel == immediatePriority
                or unstableGetCurrentPriorityLevel == userBlockingPriority
                or unstableGetCurrentPriorityLevel == normalPriority then normalPriority else unstableGetCurrentPriorityLevel
            local var10 = unstableGetCurrentPriorityLevel
            unstableGetCurrentPriorityLevel = var9
            local success, result

            if not reactGlobals.__YOLO__ then
                success, result = xpcall(callback, describeError)
            else
                result = callback()
                success = true
            end

            unstableGetCurrentPriorityLevel = var10

            if not success then
                error(result)
            end

            return result
        end,
        unstable_scheduleCallback = function(priorityLevel, callback, arg2)
            local currentTime = getCurrentTime()
            local var9

            if typeof(arg2) == "table" then
                local delay = arg2.delay
                if typeof(delay) == "number" and delay > 0 then
                    var9 = currentTime + delay
                else
                    var9 = currentTime
                end
            else
                var9 = currentTime
            end

            local var10 = var9 + (if priorityLevel == immediatePriority then -1 elseif priorityLevel == userBlockingPriority then 250 elseif priorityLevel == idlePriority then 1073741823 elseif priorityLevel == lowPriority then 10000 else 5000)

            local tbl3 = {
                id = num1,
                callback = callback,
                priorityLevel = priorityLevel,
                startTime = var9,
                expirationTime = var10,
                sortIndex = -1
            }

            num1 += 1

            if enableProfiling then
                tbl3.isQueued = false
            end

            if currentTime < var9 then
                tbl3.sortIndex = var9
                func1(tbl2, tbl3)

                if #tbl1 == 0 and tbl3 == unstableGetFirstCallbackNode(tbl2) then
                    if bool4 then
                        cancelHostTimeout()
                    else
                        bool4 = true
                    end

                    requestHostTimeout(func4, var9 - currentTime)
                    return tbl3
                end
            else
                tbl3.sortIndex = var10
                func1(tbl1, tbl3)
                if enableProfiling then
                    markTaskStart(tbl3, currentTime)
                    tbl3.isQueued = true
                end

                if not (bool3 or bool2) then
                    bool3 = true
                    requestHostCallback(var7)
                end
            end

            return tbl3
        end,
        unstable_cancelCallback = function(arg2)
            if enableProfiling and arg2.isQueued then
                local currentTime = getCurrentTime()
                markTaskCanceled(arg2, currentTime)
                arg2.isQueued = false
            end

            arg2.callback = nil
        end,
        unstable_wrapCallback = function(callback)
            local var9 = unstableGetCurrentPriorityLevel

            return function(...)
                local var10 = unstableGetCurrentPriorityLevel
                unstableGetCurrentPriorityLevel = var9
                local success, result

                if not reactGlobals.__YOLO__ then
                    success, result = xpcall(callback, describeError, ...)
                else
                    result = callback(...)
                    success = true
                end

                unstableGetCurrentPriorityLevel = var10

                if not success then
                    error(result)
                end

                return result
            end
        end,
        unstable_getCurrentPriorityLevel = function()
            return unstableGetCurrentPriorityLevel
        end,
        unstable_shouldYield = shouldYieldToHost,
        unstable_requestPaint = requestPaint,
        unstable_continueExecution = function()
            bool1 = false
            if not (bool3 or bool2) then
                bool3 = true
                requestHostCallback(var7)
            end
        end,
        unstable_pauseExecution = function()
            bool1 = true
        end,
        unstable_getFirstCallbackNode = function()
            return (unstableGetFirstCallbackNode(tbl1))
        end,
        unstable_now = getCurrentTime,
        unstable_forceFrameRate = forceFrameRate,
        unstable_setSchedulerFlags = setSchedulerFlags,
        unstable_getSchedulerFlags = getSchedulerFlags,
        unstable_Profiling = enableProfiling
            and {
                startLoggingProfilingEvents = startLoggingProfilingEvents,
                stopLoggingProfilingEvents = stopLoggingProfilingEvents
            }
            or nil
    }
end
