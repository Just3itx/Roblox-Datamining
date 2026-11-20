-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:11:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local _FillBehavior = require(Foundation.Enums.FillBehavior)

local OptionSelectorGroupSize = require(Foundation.Enums.OptionSelectorGroupSize)
local Orientation = require(Foundation.Enums.Orientation)

return React.createContext({
    value = nil,
    onValueChanged = function(_: string?)
        warn("No OptionSelectorGroupProvider found for OptionSelectorGroup")
    end,
    orientation = Orientation.Vertical,
    Selectable = true,
    testId = "",
    size = OptionSelectorGroupSize.Medium,
    fillBehavior = nil
})
