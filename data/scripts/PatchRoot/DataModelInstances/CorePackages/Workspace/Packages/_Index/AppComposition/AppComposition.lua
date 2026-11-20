-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParent = script.Parent
local FFlagEnableSplitPane = require(scriptParent.SharedFlags).FFlagEnableSplitPane

local CompositionTags = require(script.CompositionTags)
local useCompositionLayout = require(script.useCompositionLayout)
local CompositionConfig = if FFlagEnableSplitPane then require(script.CompositionConfig) else nil
local resolveBreakpoint = if FFlagEnableSplitPane then require(script.resolveBreakpoint) else nil
local setupCompositionStyleRules = require(script.setupCompositionStyleRules)
local CompositionStyleSheet = require(script.CompositionStyleSheet)

local _AppCompositionTypes = require(script.AppCompositionTypes)
local AppCompositionEnums = require(script.AppCompositionEnums)

return {
    CompositionTags = CompositionTags,
    useCompositionLayout = useCompositionLayout,
    resolveBreakpoint = resolveBreakpoint,
    getRegionOverrides = if FFlagEnableSplitPane then CompositionConfig.getRegionOverrides else nil,
    RegionName = if FFlagEnableSplitPane then AppCompositionEnums.RegionName else nil,
    CompositionStyleSheet = CompositionStyleSheet,
    setupCompositionStyleRules = setupCompositionStyleRules,
    ["jest.config"] = script["jest.config"]
}
