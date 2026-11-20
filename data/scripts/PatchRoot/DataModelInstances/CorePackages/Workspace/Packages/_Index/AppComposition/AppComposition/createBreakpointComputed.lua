-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppComposition = script:FindFirstAncestor("AppComposition")
local AppCompositionParent = AppComposition.Parent
local _Foundation = require(AppCompositionParent.Foundation)
local Signals = require(AppCompositionParent.Signals)

local resolveBreakpoint = require(AppComposition.resolveBreakpoint)

local function createBreakpointComputed(func1: (...any) -> (...any))
    return (Signals.createComputed(function(arg1)
        return resolveBreakpoint(func1(arg1))
    end))
end

return createBreakpointComputed
