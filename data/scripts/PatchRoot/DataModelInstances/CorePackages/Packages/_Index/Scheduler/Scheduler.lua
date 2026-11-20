-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:40:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local ReactGlobals = require(scriptParent.ReactGlobals)

local function onlyInTestError(str1: string) -- Luacid: Inlined by compiler; 9 call sites recovered
    return function()
        error(str1 .. " is only available in tests, not in production")
    end
end

local var1 = require(script.Scheduler)(nil)
local Tracing = require(script.Tracing)
local TracingSubscriptions = require(script.TracingSubscriptions)

if ReactGlobals.__ROACT_17_MOCK_SCHEDULER__ then
    return require(script.unstable_mock)
end

local tbl1 = {
    unstable_ImmediatePriority = var1.unstable_ImmediatePriority,
    unstable_UserBlockingPriority = var1.unstable_UserBlockingPriority,
    unstable_NormalPriority = var1.unstable_NormalPriority,
    unstable_IdlePriority = var1.unstable_IdlePriority,
    unstable_LowPriority = var1.unstable_LowPriority,
    unstable_runWithPriority = var1.unstable_runWithPriority,
    unstable_next = var1.unstable_next,
    unstable_scheduleCallback = var1.unstable_scheduleCallback,
    unstable_cancelCallback = var1.unstable_cancelCallback,
    unstable_wrapCallback = var1.unstable_wrapCallback,
    unstable_getCurrentPriorityLevel = var1.unstable_getCurrentPriorityLevel,
    unstable_shouldYield = var1.unstable_shouldYield,
    unstable_requestPaint = var1.unstable_requestPaint,
    unstable_continueExecution = var1.unstable_continueExecution,
    unstable_pauseExecution = var1.unstable_pauseExecution,
    unstable_getFirstCallbackNode = var1.unstable_getFirstCallbackNode,
    unstable_now = var1.unstable_now,
    unstable_forceFrameRate = var1.unstable_forceFrameRate,
    unstable_setSchedulerFlags = var1.unstable_setSchedulerFlags,
    unstable_getSchedulerFlags = var1.unstable_getSchedulerFlags,
    unstable_flushAllWithoutAsserting = onlyInTestError("unstable_flushAllWithoutAsserting"),
    unstable_flushAll = onlyInTestError("unstable_flushAll"),
    unstable_flushNumberOfYields = onlyInTestError("unstable_flushNumberOfYields"),
    unstable_clearYields = onlyInTestError("unstable_clearYields"),
    unstable_flushUntilNextPaint = onlyInTestError("unstable_clearYields"),
    unstable_advanceTime = onlyInTestError("unstable_advanceTime"),
    unstable_flushExpired = onlyInTestError("unstable_flushExpired"),
    unstable_yieldValue = onlyInTestError("unstable_yieldValue"),
    tracing = {
        unstable_wrap = onlyInTestError("unstable_wrap"),
        __interactionsRef = {},
        __subscriberRef = {}
    }
}

for value, value2 in Tracing do
    tbl1.tracing[value] = value2
end
for k, TracingSubscription in TracingSubscriptions do
    tbl1.tracing[k] = TracingSubscription
end

return tbl1
