-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local _ReactInternalTypes = require(script.Parent.ReactInternalTypes)

local ReactFeatureFlags = require(scriptParentParent.Shared).ReactFeatureFlags
local enableProfilerTimer = ReactFeatureFlags.enableProfilerTimer
local enableProfilerCommitHooks = ReactFeatureFlags.enableProfilerCommitHooks

local Profiler = require(script.Parent.ReactWorkTags).Profiler

local unstable_now = require(scriptParentParent.Scheduler).unstable_now

local num1 = 0
local num2 = -1
local num3 = -1
local num4 = -1

function getCommitTime()
    return num1
end

function recordCommitTime()
    if not enableProfilerTimer then
        return
    end
    num1 = unstable_now()
end

function startProfilerTimer(arg1)
    if not enableProfilerTimer then
        return
    end

    num3 = unstable_now()

    if arg1.actualStartTime ~= nil and arg1.actualStartTime < 0 then
        arg1.actualStartTime = unstable_now()
    end
end

function stopProfilerTimerIfRunning(_)
    if not enableProfilerTimer then
        return
    end
    num3 = -1
end

function stopProfilerTimerIfRunningAndRecordDelta(arg1, bool1: boolean)
    if not enableProfilerTimer then
        return
    end

    if not (num3 >= 0) then
        return
    end

    local selfBaseDuration = unstable_now() - num3
    arg1.actualDuration += selfBaseDuration
    if bool1 then
        arg1.selfBaseDuration = selfBaseDuration
    end
    num3 = -1
end

function recordLayoutEffectDuration(arg1)
    if not (enableProfilerTimer and enableProfilerCommitHooks) then
        return
    end

    if not (num2 >= 0) then
        return
    end

    local var1 = unstable_now() - num2

    num2 = -1

    local _return = arg1.return_
    while _return ~= nil do
        if _return.tag == Profiler then
            local stateNode = _return.stateNode
            stateNode.effectDuration += var1
            return
        end
        _return = _return.return_
    end
end

function recordPassiveEffectDuration(arg1)
    if not (enableProfilerTimer and enableProfilerCommitHooks) then
        return
    end

    if not (num4 >= 0) then
        return
    end

    local var1 = unstable_now() - num4

    num4 = -1

    local _return = arg1.return_
    while _return ~= nil do
        if _return.tag == Profiler then
            local stateNode = _return.stateNode
            if stateNode ~= nil then
                stateNode.passiveEffectDuration += var1

                return
            end

            break
        end
        _return = _return.return_
    end
end

function startLayoutEffectTimer()
    if not (enableProfilerTimer and enableProfilerCommitHooks) then
        return
    end
    num2 = unstable_now()
end

function startPassiveEffectTimer()
    if not (enableProfilerTimer and enableProfilerCommitHooks) then
        return
    end
    num4 = unstable_now()
end

function transferActualDuration(arg1)
    local child = arg1.child
    while child do
        arg1.actualDuration += child.actualDuration
        child = child.sibling
    end
end

return {
    getCommitTime = getCommitTime,
    recordCommitTime = recordCommitTime,
    recordLayoutEffectDuration = recordLayoutEffectDuration,
    recordPassiveEffectDuration = recordPassiveEffectDuration,
    startLayoutEffectTimer = startLayoutEffectTimer,
    startPassiveEffectTimer = startPassiveEffectTimer,
    startProfilerTimer = startProfilerTimer,
    stopProfilerTimerIfRunning = stopProfilerTimerIfRunning,
    stopProfilerTimerIfRunningAndRecordDelta = stopProfilerTimerIfRunningAndRecordDelta,
    transferActualDuration = transferActualDuration
}
