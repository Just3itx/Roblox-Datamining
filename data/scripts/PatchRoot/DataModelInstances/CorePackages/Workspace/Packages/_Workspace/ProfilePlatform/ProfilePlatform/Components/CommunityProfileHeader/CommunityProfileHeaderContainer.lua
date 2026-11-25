-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:41:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)
local UserLib = require(ProfilePlatformParent.UserLib)
local Constants = UserLib.Utils.Constants
local getRbxthumbWithTypeSizeAndOptions = UserLib.Utils.getRbxthumbWithTypeSizeAndOptions
local VerifiedBadges = require(ProfilePlatformParent.VerifiedBadges)

local Enums = require(ProfilePlatform.Common.Enums)
local getDeepValue = require(ProfilePlatform.Utils.getDeepValue)
local useProfileJsonComponent = require(ProfilePlatform.Hooks.useProfileJsonComponent)
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)

local FFlagEnablePressingCommunityOwnerInPeekView = require(ProfilePlatform.Flags.FFlagEnablePressingCommunityOwnerInPeekView)

local CommunityProfileHeader = require(ProfilePlatform.Components.CommunityProfileHeader.CommunityProfileHeader)

local function CommunityProfileHeaderContainer(tbl1)
    local profileId = useProfileWrapperContext().profileId

    local var1 = useProfileJsonComponent(Enums.Components.CommunityProfileHeader)
    local name = if var1.isVerified then `{var1.name}{VerifiedBadges.emoji.verified}` else var1.name
    local ownerName = if var1.ownerIsVerified then `{var1.ownerName}{VerifiedBadges.emoji.verified}` else var1.ownerName
    local membersCount = getDeepValue(var1, "counts.membersCount") or 0

    local thumbnail = getRbxthumbWithTypeSizeAndOptions(profileId, Constants.RbxthumbTypes.GroupIcon, 150)
    local ownerUserId = if FFlagEnablePressingCommunityOwnerInPeekView then var1.ownerUserId else nil
    local createElement = React.createElement
    local var4 = CommunityProfileHeader
    local tbl2 = {
        layoutOrder = tbl1.layoutOrder,
        name = name,
        ownerName = ownerName,
        membersCount = membersCount,
        hasSocialModules = var1.hasSocialModules,
        thumbnail = thumbnail,
        ownerUserId = 0
    }

    if not FFlagEnablePressingCommunityOwnerInPeekView then
        ownerUserId = nil
    end

    tbl2.ownerUserId = ownerUserId
    return createElement(var4, tbl2)
end

return CommunityProfileHeaderContainer
