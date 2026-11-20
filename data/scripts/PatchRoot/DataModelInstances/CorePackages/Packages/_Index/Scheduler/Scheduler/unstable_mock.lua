-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local Tracing = require(script.Parent.Tracing)
local TracingSubscriptions = require(script.Parent.TracingSubscriptions)

local Scheduler = require(script.Parent.Scheduler)
local SchedulerHostConfigMock = require(script.Parent.forks["SchedulerHostConfig.mock"])

local var1 = Scheduler(SchedulerHostConfigMock)

local tbl1 = {
    tracing = {}
}
for value, value2 in var1 do
    tbl1[value] = value2
end
for value, value2 in Tracing do
    tbl1.tracing[value] = value2
end
for k, TracingSubscription in TracingSubscriptions do
    tbl1.tracing[k] = TracingSubscription
end

tbl1.unstable_flushAllWithoutAsserting = SchedulerHostConfigMock.unstable_flushAllWithoutAsserting
tbl1.unstable_flushNumberOfYields = SchedulerHostConfigMock.unstable_flushNumberOfYields
tbl1.unstable_flushExpired = SchedulerHostConfigMock.unstable_flushExpired
tbl1.unstable_clearYields = SchedulerHostConfigMock.unstable_clearYields
tbl1.unstable_flushUntilNextPaint = SchedulerHostConfigMock.unstable_flushUntilNextPaint
tbl1.unstable_flushAll = SchedulerHostConfigMock.unstable_flushAll
tbl1.unstable_yieldValue = SchedulerHostConfigMock.unstable_yieldValue
tbl1.unstable_advanceTime = SchedulerHostConfigMock.unstable_advanceTime
tbl1.unstable_Profiling = var1.unstable_Profiling

return tbl1
