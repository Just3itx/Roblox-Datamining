-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:40:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSlotBasedEditorParent = script:FindFirstAncestor("AvatarExperienceSlotBasedEditor").Parent

local React = require(AvatarExperienceSlotBasedEditorParent.React)

local OutfitDetailsTopBar = require(script.Parent.OutfitDetailsTopBar)
local useOutfitDetailsTopBarProps = require(script.Parent.useOutfitDetailsTopBarProps)

local function OutfitDetailsTopBarContainer(arg1)
    local var1 = useOutfitDetailsTopBarProps(arg1)
    return React.createElement(OutfitDetailsTopBar, var1)
end

return OutfitDetailsTopBarContainer
