-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:21:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local Button = require(scriptParent.Button)

local describe = require(scriptParentParentParentParent.Dev.JestGlobals).describe

local benchmarks = require(scriptParentParentParent.Utility.benchmarks)
local mountComponentTimes = benchmarks.mountComponentTimes
local scrollComponentTimes = benchmarks.scrollComponentTimes

local element = React.createElement(Button, {
    onActivated = function() end,
    text = "Button"
})

describe("Button", function()
    mountComponentTimes(element, 100, "Button")
    scrollComponentTimes(element, 100, "Button")
end)
