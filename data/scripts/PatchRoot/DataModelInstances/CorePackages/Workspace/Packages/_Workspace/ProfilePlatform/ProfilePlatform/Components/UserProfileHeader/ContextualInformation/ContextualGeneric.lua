-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:21:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)

local useLocalization = require(ProfilePlatformParent.Localization).Hooks.useLocalization

local UIBlox = require(ProfilePlatformParent.UIBlox)
local Images = UIBlox.App.ImageSet.Images
local PlayerContext = UIBlox.App.Indicator.PlayerContext

local TextKeys = require(ProfilePlatform.Common.TextKeys)
local Enums = require(ProfilePlatform.Common.Enums)

local function ContextualInformation(tbl1)
    local var1 = useLocalization({
        [Enums.ContextualTypes.AccountDeleted] = TextKeys.AccountDeleted,
        [Enums.ContextualTypes.IsYourself] = TextKeys.ThisIsYou,
        [Enums.ContextualTypes.PreviousUsername] = TextKeys.Previously,
        [Enums.ContextualTypes.YouAreFollowing] = TextKeys.YouAreFollowing,
        [Enums.ContextualTypes.FollowsYou] = TextKeys.FollowsYou,
        [Enums.ContextualTypes.PlayedTogether] = TextKeys.PlayedTogether,
        [Enums.ContextualTypes.OffNetworkFriendRequest] = TextKeys.FriendInvite,
        [Enums.ContextualTypes.SentFromQrCode] = TextKeys.FromQRCode,
        [Enums.ContextualTypes.SentFromExperience] = {
            TextKeys.SentFromWithContext,
            gameName = tbl1.experienceName
        }
    })
    local contextualType = tbl1.contextualType
    local var2 = var1[contextualType]
    local iconsStatusPlayerFollowing = if contextualType == Enums.ContextualTypes.YouAreFollowing or contextualType == Enums.ContextualTypes.FollowsYou then Images["icons/status/player/following"] else nil
    return React.createElement(
        PlayerContext,
        {
            text = tbl1.textOverride or var2,
            icon = tbl1.iconOverride or iconsStatusPlayerFollowing
        }
    )
end
return ContextualInformation
