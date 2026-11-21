-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceControlBar = script:FindFirstAncestor("AvatarExperienceControlBar")

local AvatarExperienceControlBarParent = AvatarExperienceControlBar.Parent
local React = require(AvatarExperienceControlBarParent.React)

local useAdvancedCustomizationControlBarProps = require(AvatarExperienceControlBar.useAdvancedCustomizationControlBarProps)
local BaseControlBarContainer = require(AvatarExperienceControlBar.BaseControlBarContainer)

return React.memo(function(arg1) -- name: AdvancedCustomizationControlBarContainer
    local var1 = useAdvancedCustomizationControlBarProps(arg1)
    return React.createElement(
        BaseControlBarContainer,
        {
            config = var1.config,
            onActiveMenuItemChanged = arg1.onActiveMenuItemChanged,
            LayoutOrder = arg1.LayoutOrder
        }
    )
end)
