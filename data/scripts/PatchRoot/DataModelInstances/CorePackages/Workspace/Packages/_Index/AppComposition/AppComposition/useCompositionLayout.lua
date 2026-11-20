-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:40:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppComposition = script:FindFirstAncestor("AppComposition")
local AppCompositionParent = AppComposition.Parent
local Display = require(AppCompositionParent.Display)
local Foundation = require(AppCompositionParent.Foundation)
local React = require(AppCompositionParent.React)
local _Signals = require(AppCompositionParent.Signals)
local SignalsReact = require(AppCompositionParent.SignalsReact)
local FFlagAppCompositionContainerWidth = require(AppCompositionParent.SharedFlags).FFlagAppCompositionContainerWidth

local _AppCompositionTypes = require(AppComposition.AppCompositionTypes)
local CompositionConfig = require(AppComposition.CompositionConfig)
local createBreakpointComputed = require(AppComposition.createBreakpointComputed)
local getGlobalViewportBreakpoint = require(AppComposition.getGlobalViewportBreakpoint)

local useTokens = Foundation.Hooks.useTokens

local function useCompositionLayout(arg1)
    local var1 = useTokens()

    local var2 = if FFlagAppCompositionContainerWidth then React.useMemo(function()
        if arg1 then
            return (createBreakpointComputed(function(arg2)
                return arg1(arg2) / Display.GetDisplayStore(arg2).getPlatformScale(arg2)
            end))
        end

        return getGlobalViewportBreakpoint
    end, { arg1 }) else nil

    local useSignalState = SignalsReact.useSignalState
    if not FFlagAppCompositionContainerWidth then
        var2 = getGlobalViewportBreakpoint
    end

    local var3 = useSignalState(var2)

    return React.useMemo(function()
        return CompositionConfig.getBaseConfig(var3, var1)
    end, { var3, var1 })
end

return useCompositionLayout
