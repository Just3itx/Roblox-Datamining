-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local Enums = require(ProfilePlatform.Common.Enums)

local viewerRelationshipUtils = require(ProfilePlatform.Components.ProfilePlatformPage.viewerRelationshipUtils)

local useProfileJsonComponent = require(ProfilePlatform.Hooks.useProfileJsonComponent)

return function()
    local var1 = useProfileJsonComponent(Enums.Components.UserProfileHeader) or {}
    local viewerRelationship = var1.viewerRelationship
    local contextualInformation = var1.contextualInformation
    return viewerRelationshipUtils.mapViewerRelationshipAndContextToAnalyticsFriendStatus(
        viewerRelationship,
        contextualInformation
    )
end
