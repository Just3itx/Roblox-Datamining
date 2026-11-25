-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local Images = require(ProfilePlatformParent.UIBlox).App.ImageSet.Images

local SetCurrentToastMessage = require(ProfilePlatformParent.ToastRodux).Actions.SetCurrentToastMessage
local NetworkingFriends = require(ProfilePlatform.Networking.NetworkingFriends)
local refreshProfilePlatformActionInfo = require(ProfilePlatform.Networking.refreshProfilePlatformActionInfo)
local Enums = require(ProfilePlatform.Common.Enums)
local _Types = require(ProfilePlatform.Components.CTARow.Types)
local EventNames = require(ProfilePlatform.Analytics.EventNames)
local ProfileTypes = Enums.ProfileTypes

local FFlagMigrateFriendshipStatusesRemainingActions = require(ProfilePlatformParent.SharedFlags).FFlagMigrateFriendshipStatusesRemainingActions
local var1 = require(ProfilePlatformParent.DataHydration).Friends.FriendsStore.get()

local module = {}
module[Enums.ProfileActions.Unfriend] = function(arg1)
    local tbl1 = {
        text = arg1.localized[Enums.ProfileActions.Unfriend],
        onActivated = 0
    }
    local onActivated = {}
    onActivated[ProfileTypes.User] = function()
        arg1.analytics.fireAnalyticsEvent(EventNames.ContextualMenuButtonUnfriend, { buttonSurface = arg1.buttonSurface })
        local var2 = if FFlagMigrateFriendshipStatusesRemainingActions then var1.Unfriend(arg1.profileId) else arg1.dispatch(
            NetworkingFriends.UnfriendTargetUserId.API({ targetUserId = arg1.profileId, currentUserId = arg1.localUserId })
        )

        return var2:andThen(function()
            arg1.dispatch(
                SetCurrentToastMessage({
                    toastMessage = arg1.localized.friendRemovedToast,
                    toastIcon = Images["icons/actions/friends/friendRemove"],
                    isLocalized = true
                })
            )
            return arg1.dispatch(refreshProfilePlatformActionInfo(arg1.profileId, arg1.actionsComponentRequest))
        end)
    end

    tbl1.onActivated = onActivated
    return tbl1
end

return module
