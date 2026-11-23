-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent
local React = require(AvatarExperienceCommonParent.React)

local AXTooltip = require(AvatarExperienceCommonParent.AvatarExperienceUIKit).AXTooltipComponents.AXTooltip

local useAXTooltipViewModel = require(script.Parent.useAXTooltipViewModel)

return function(arg1)
    local var1 = useAXTooltipViewModel(arg1)
    return React.createElement(AXTooltip, var1)
end
