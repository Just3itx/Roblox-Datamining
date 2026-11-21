-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSlotBasedEditorParent = script:FindFirstAncestor("AvatarExperienceSlotBasedEditor").Parent

local React = require(AvatarExperienceSlotBasedEditorParent.React)

local OutfitDetailsActionBar = require(script.Parent.OutfitDetailsActionBar)
local useOutfitDetailsActionBarProps = require(script.Parent.useOutfitDetailsActionBarProps)

local function OutfitDetailsActionBarContainer(arg1)
    local var1 = useOutfitDetailsActionBarProps(arg1)
    return React.createElement(OutfitDetailsActionBar, var1)
end

return OutfitDetailsActionBarContainer
