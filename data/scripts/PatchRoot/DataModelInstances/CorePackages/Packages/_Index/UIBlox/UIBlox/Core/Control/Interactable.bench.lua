-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:20:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Roact = require(scriptParentParentParentParent.Roact)
local Interactable = require(scriptParent.Interactable)

local describe = require(scriptParentParentParentParent.Dev.JestGlobals).describe

local benchmarks = require(scriptParentParentParent.Utility.benchmarks)
local mountComponentTimes = benchmarks.mountComponentTimes
local scrollComponentTimes = benchmarks.scrollComponentTimes

local element = Roact.createElement(Interactable, {
    onStateChanged = function() end
})

describe("Interactable", function()
    mountComponentTimes(element, 100, "Interactable")
    scrollComponentTimes(element, 100, "Interactable")
end)
