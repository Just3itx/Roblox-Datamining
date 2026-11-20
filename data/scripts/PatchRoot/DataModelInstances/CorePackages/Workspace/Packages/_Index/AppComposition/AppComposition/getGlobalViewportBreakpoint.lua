-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppComposition = script:FindFirstAncestor("AppComposition")
local AppCompositionParent = AppComposition.Parent
local Display = require(AppCompositionParent.Display)
local Signals = require(AppCompositionParent.Signals)
local _Foundation = require(AppCompositionParent.Foundation)
local FFlagAppCompositionContainerWidth = require(AppCompositionParent.SharedFlags).FFlagAppCompositionContainerWidth

local createBreakpointComputed = require(AppComposition.createBreakpointComputed)
local resolveBreakpoint = require(AppComposition.resolveBreakpoint)

if FFlagAppCompositionContainerWidth then
    return (createBreakpointComputed(function(arg1)
        return Display.GetDisplayStore(arg1).getDesignSpaceViewportWidth(arg1)
    end))
end

return (Signals.createComputed(function(arg1)
    local var1 = Display.GetDisplayStore(arg1).getDesignSpaceViewportWidth(arg1)
    return resolveBreakpoint(var1)
end))
