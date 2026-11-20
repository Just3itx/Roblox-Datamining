-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:31:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
local scriptParentParent = script.Parent.Parent
local WeakMap = require(scriptParentParent.LuauPolyfill).WeakMap

local _ReactFiberLane = require(script.Parent.ReactFiberLane)

local _ReactInternalTypes = require(script.Parent.ReactInternalTypes)

local _Shared = require(scriptParentParent.Shared)

local enableSchedulingProfiler = require(scriptParentParent.Shared).ReactFeatureFlags.enableSchedulingProfiler
local ReactVersion = require(scriptParentParent.Shared).ReactVersion
local getComponentName = require(scriptParentParent.Shared).getComponentName

local bool1 = _G.performance ~= nil
local var1 = _G.performance or {
    mark = function(arg1)
        debug.profilebegin(arg1)
        debug.profileend()
    end
}

function formatLanes(arg1): string
    return tostring(arg1)
end

local var2 = nil
local profilerEventTypes = {
    CommitStart = 0,
    CommitStop = 1,
    LayoutEffectsStart = 2,
    LayoutEffectsStop = 3,
    PassiveEffectsStart = 4,
    PassiveEffectsStop = 5,
    RenderStart = 6,
    RenderYield = 7,
    RenderStop = 8
}

if enableSchedulingProfiler and bool1 then
    var1.mark("--react-init-" .. tostring(ReactVersion))
end

function module.markCommitStarted(arg1)
    if not enableSchedulingProfiler then
        return
    end

    if bool1 then
        var1.mark("--commit-start-" .. formatLanes(arg1))
    end

    if var2 then
        var2(profilerEventTypes.CommitStart)
    end
end

function module.markCommitStopped(arg1)
    if not enableSchedulingProfiler then
        return
    end

    if bool1 then
        var1.mark("--commit-stop")
    end

    if var2 then
        var2(profilerEventTypes.CommitStop, arg1)
    end
end

local weakMap = WeakMap.new()
local num1 = 0
function getWakeableID(arg1)
    if not weakMap:has(arg1) then
        weakMap:set(arg1, num1)
        num1 += 1
    end
    return weakMap:get(arg1)
end

function module.markComponentSuspended(arg1, arg2)
    if not enableSchedulingProfiler or not bool1 then
        return
    end

    local wakeableId = getWakeableID(arg2)
    local componentName = getComponentName(arg1.type) or "Unknown"

    var1.mark("--suspense-suspend-" .. tostring(wakeableId) .. "-" .. componentName)

    arg2:andThen(function()
        var1.mark("--suspense-resolved-" .. tostring(wakeableId) .. "-" .. componentName)
    end, function()
        var1.mark("--suspense-rejected-" .. tostring(wakeableId) .. "-" .. componentName)
    end)
end

function module.markLayoutEffectsStarted(arg1)
    if not enableSchedulingProfiler then
        return
    end

    if bool1 then
        var1.mark("--layout-effects-start-" .. formatLanes(arg1))
    end

    if var2 then
        var2(profilerEventTypes.LayoutEffectsStart)
    end
end

function module.markLayoutEffectsStopped()
    if not enableSchedulingProfiler then
        return
    end

    if bool1 then
        var1.mark("--layout-effects-stop")
    end

    if var2 then
        var2(profilerEventTypes.LayoutEffectsStop)
    end
end

function module.markPassiveEffectsStarted(arg1)
    if not enableSchedulingProfiler then
        return
    end

    if bool1 then
        var1.mark("--passive-effects-start-" .. formatLanes(arg1))
    end

    if var2 then
        var2(profilerEventTypes.PassiveEffectsStart)
    end
end

function module.markPassiveEffectsStopped(arg1)
    if not enableSchedulingProfiler then
        return
    end

    if bool1 then
        var1.mark("--passive-effects-stop")
    end

    if var2 then
        var2(profilerEventTypes.PassiveEffectsStop, arg1)
    end
end

function module.markRenderStarted(arg1)
    if not enableSchedulingProfiler then
        return
    end

    if bool1 then
        var1.mark("--render-start-" .. formatLanes(arg1))
    end

    if var2 then
        var2(profilerEventTypes.RenderStart)
    end
end

function module.markRenderYielded()
    if not enableSchedulingProfiler then
        return
    end

    if bool1 then
        var1.mark("--render-yield")
    end

    if var2 then
        var2(profilerEventTypes.RenderYield)
    end
end

function module.markRenderStopped()
    if not enableSchedulingProfiler then
        return
    end

    if bool1 then
        var1.mark("--render-stop")
    end

    if var2 then
        var2(profilerEventTypes.RenderStop)
    end
end

function module.markRenderScheduled(arg1)
    if enableSchedulingProfiler and bool1 then
        var1.mark("--schedule-render-" .. formatLanes(arg1))
    end
end

function module.markForceUpdateScheduled(arg1, arg2)
    if enableSchedulingProfiler and bool1 then
        local componentName = getComponentName(arg1.type) or "Unknown"

        var1.mark("--schedule-forced-update-" .. formatLanes(arg2) .. "-" .. componentName)
    end
end

function module.markStateUpdateScheduled(arg1, arg2)
    if enableSchedulingProfiler and bool1 then
        local componentName = getComponentName(arg1.type) or "Unknown"

        var1.mark("--schedule-state-update-" .. formatLanes(arg2) .. "-" .. componentName)
    end
end

module.profilerEventTypes = profilerEventTypes

function module.registerProfilerEventCallback(func1: (...any) -> (...any))
    if var2 then
        warn("SchedulingProfiler: Another event callback was already registered.")
    end
    var2 = func1
end

return module
