-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:21:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local Foundation = require(ProfilePlatformParent.Foundation)
local TextKeys = require(ProfilePlatform.Common.TextKeys)
local SocialCountEnableKeys = require(ProfilePlatform.Common.Enums).SocialCountEnableKeys
local AvatarGroupType = Foundation.Enums.AvatarGroupType

local FFlagEnableSocialTabsPage = require(ProfilePlatformParent.SharedFlags).FFlagEnableSocialTabsPage

return {
    RowConfig = {
        mutualFriendsCount = {
            layoutOrder = 1,
            textKey = TextKeys.MutualsText,
            singleTextKey = TextKeys.MutualText,
            enabledKey = SocialCountEnableKeys.IsMutualFriendsCountEnabled,
            getIsDisabled = function(_: boolean, _: boolean, bool1: boolean): boolean
                return not bool1
            end,
            getLeading = function(tbl1): {props: {avatars: {[any]: any}, max: number, type: any}, type: string}?
                local avatars = { table.unpack(tbl1.mutualFriendIds, 1, math.min(2, #tbl1.mutualFriendIds)) }
                return if avatars and #avatars > 0 then {
                    type = "AvatarGroup",
                    props = {
                        avatars = avatars,
                        type = AvatarGroupType.Stacked,
                        max = 2
                    }
                } else nil
            end
        },
        friendsCount = {
            layoutOrder = 2,
            textKey = TextKeys.Friends,
            singleTextKey = TextKeys.Friend,
            enabledKey = SocialCountEnableKeys.IsFriendsCountEnabled,
            getIsDisabled = function(bool1: boolean, bool2: boolean, bool3: boolean): boolean
                return not bool3 or not FFlagEnableSocialTabsPage and not bool2 and not bool1
            end
        },
        followersCount = {
            layoutOrder = 3,
            textKey = TextKeys.Followers,
            singleTextKey = TextKeys.Follower,
            enabledKey = SocialCountEnableKeys.IsFollowersCountEnabled,
            getIsDisabled = function(bool1: boolean, _: boolean, bool2: boolean): boolean
                return not bool2 or not bool1
            end
        },
        followingsCount = {
            layoutOrder = 4,
            textKey = TextKeys.Following,
            singleTextKey = TextKeys.Following,
            enabledKey = SocialCountEnableKeys.IsFollowingsCountEnabled,
            getIsDisabled = function(bool1: boolean, _: boolean, bool2: boolean): boolean
                return not bool2 or not bool1
            end
        }
    }
}
