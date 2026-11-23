-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:21:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuyParent = script:FindFirstAncestor("AvatarExperienceInspectAndBuy").Parent
local React = require(AvatarExperienceInspectAndBuyParent.React)

local SelectableItemCardRowView = require(script.Parent.SelectableItemCardRowView)
local useSelectableRowViewModel = require(script.Parent.useSelectableRowViewModel)

local function SelectableCardRowContainer(arg1)
    local var1 = useSelectableRowViewModel(arg1)
    return React.createElement(SelectableItemCardRowView, var1)
end

return SelectableCardRowContainer
