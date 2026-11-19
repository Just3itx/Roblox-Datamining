-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:31:00Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local _Orientation = require(Foundation.Enums.Orientation)

local OptionSelectorGroupContext = require(script.Parent.OptionSelectorGroupContext)

return function()
    return React.useContext(OptionSelectorGroupContext)
end
