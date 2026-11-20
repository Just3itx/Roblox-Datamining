-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:11:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local _Orientation = require(Foundation.Enums.Orientation)

local OptionSelectorGroupContext = require(script.Parent.OptionSelectorGroupContext)

return function()
    return React.useContext(OptionSelectorGroupContext)
end
