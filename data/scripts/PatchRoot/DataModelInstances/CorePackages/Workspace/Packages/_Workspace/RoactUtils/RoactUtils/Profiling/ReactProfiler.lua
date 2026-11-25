-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoactUtilsParent = script:FindFirstAncestor("RoactUtils").Parent
local React = require(RoactUtilsParent.React)

local ReactProfilerContext = require(script.Parent.ReactProfilerContext)
local isReactProfilingEnabled = require(script.Parent.isReactProfilingEnabled)

local context = React.createContext(nil)

local function ReactProfiler(tbl1)
    local exclusiveRenderDurationRef = React.useRef(0)
    local exclusiveEffectDurationRef = React.useRef(0)

    local var3 = React.useContext(context)

    local var4 = React.useContext(ReactProfilerContext)

    local onRender = React.useCallback(function(profilerId: string, _: string, duration: number, _: number, startTime: number, commitTime: number)
        if var3 ~= nil then
            local exclusiveRenderDurationRef = var3.exclusiveRenderDurationRef
            exclusiveRenderDurationRef.current -= duration
        end

        local var5 = exclusiveRenderDurationRef
        var5.current += duration

        if var4 ~= nil then
            var4.onRender:fire({
                profilerId = profilerId,
                startTime = startTime,
                commitTime = commitTime,
                duration = duration,
                exclusiveDuration = exclusiveRenderDurationRef.current
            })
        end

        exclusiveRenderDurationRef.current = 0
    end, {})

    local onCommit = React.useCallback(function(profilerId: string, _: string, duration: number, commitTime: number)
        if var3 ~= nil then
            local exclusiveEffectDurationRef = var3.exclusiveEffectDurationRef
            exclusiveEffectDurationRef.current -= duration
        end

        local var6 = exclusiveEffectDurationRef
        var6.current += duration

        if var4 ~= nil then
            var4.onCommit:fire({
                profilerId = profilerId,
                commitTime = commitTime,
                duration = duration,
                exclusiveDuration = exclusiveEffectDurationRef.current
            })
        end

        exclusiveEffectDurationRef.current = 0
    end, {})

    local value = React.useMemo(function()
        return {
            exclusiveRenderDurationRef = exclusiveRenderDurationRef,
            exclusiveEffectDurationRef = exclusiveEffectDurationRef
        }
    end, {})

    return React.createElement(
        React.Profiler,
        {
            id = tbl1.id,
            onRender = onRender,
            onCommit = onCommit
        },
        React.createElement(context.Provider, { key = "ExclusiveDurationsContext", value = value }, tbl1.children)
    )
end

return function(tbl1)
    if isReactProfilingEnabled then
        return React.createElement(ReactProfiler, { id = tbl1.id }, tbl1.children)
    end
    return React.createElement(React.Fragment, nil, tbl1.children)
end
