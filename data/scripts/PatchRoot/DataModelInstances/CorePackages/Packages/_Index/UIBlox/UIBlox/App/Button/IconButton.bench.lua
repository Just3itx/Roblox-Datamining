-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:30:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local IconButton = require(scriptParent.IconButton)

local describe = require(scriptParentParentParentParent.Dev.JestGlobals).describe

local benchmarks = require(scriptParentParentParent.Utility.benchmarks)
local mountComponentTimes = benchmarks.mountComponentTimes
local scrollComponentTimes = benchmarks.scrollComponentTimes

local element = React.createElement(IconButton, {
    onActivated = function() end,
    icon = "rbxassetid://7173696656978"
})

describe("IconButton", function()
    mountComponentTimes(element, 1000, "IconButton")
    scrollComponentTimes(element, 1000, "IconButton")
end)
