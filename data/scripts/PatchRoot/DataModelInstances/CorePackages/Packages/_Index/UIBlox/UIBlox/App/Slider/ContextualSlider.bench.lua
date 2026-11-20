-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:51:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local ContextualSlider = require(scriptParent.ContextualSlider)
local SystemSlider = require(scriptParent.SystemSlider)

local describe = require(scriptParentParentParentParent.Dev.JestGlobals).describe

local benchmarks = require(scriptParentParentParent.Utility.benchmarks)
local mountComponentTimes = benchmarks.mountComponentTimes
local scrollComponentTimes = benchmarks.scrollComponentTimes

local element = React.createElement(ContextualSlider, {
    min = 0,
    max = 100,
    value = 0,
    onValueChanged = function() end
})
local element2 = React.createElement(SystemSlider, {
    min = 0,
    max = 100,
    value = 0,
    onValueChanged = function() end
})

describe("ContextualSlider", function()
    mountComponentTimes(element, 100, "ContextualSlider")
    scrollComponentTimes(element, 100, "ContextualSlider")
end)
describe("SystemSlider", function()
    mountComponentTimes(element2, 100, "SystemSlider")
    scrollComponentTimes(element2, 100, "SystemSlider")
end)
