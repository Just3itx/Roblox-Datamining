-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:31:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local GetFFlagUseCommunitiesTranslation = require(AppChatParent.SharedFlags).GetFFlagUseCommunitiesTranslation

return function()
    return {
        label = if GetFFlagUseCommunitiesTranslation() then "Feature.SocialTab.Label.Groups" else "CommonUI.Features.Label.sGroups",
        icon = "icons/menu/groups",
        iconLarge = "icons/menu/groups_large"
    }
end
