-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local Foundation = require(ProfilePlatformParent.Foundation)
local Images = require(ProfilePlatformParent.UIBlox).App.ImageSet.Images
local ButtonVariant = Foundation.Enums.ButtonVariant

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
module[Enums.ProfileActions.AcceptFriendRequest] = function(arg1)
    local tbl1 = {
        text = arg1.localized[Enums.ProfileActions.AcceptFriendRequest],
        variant = ButtonVariant.Emphasis,
        onActivated = 0
    }
    local onActivated = {}
    onActivated[ProfileTypes.User] = function()
        arg1.analytics.fireAnalyticsEvent(EventNames.CTAButtonAcceptFriendRequest, {
            buttonSurface = arg1.buttonSurface,
            absolutePosition = arg1.profileWrapperContext.sourceInfo.homepageCarouselAbsolutePosition,
            isHomePageCarousel = arg1.profileWrapperContext.sourceInfo.source == Enums.Sources.HomepageFriendsCarousel,
            isRecommendation = arg1.profileWrapperContext.sourceInfo.isRecommendation,
            source = arg1.profileWrapperContext.sourceInfo.source,
            contextualInfoType = arg1.profileWrapperContext.sourceInfo.contextualInfoType,
            recommendationContextType = arg1.profileWrapperContext.sourceInfo.recommendationContextType,
            recommendationRank = arg1.profileWrapperContext.sourceInfo.recommendationRank,
            recommendationSessionId = arg1.profileWrapperContext.sourceInfo.recommendationSessionId
        })
        local var2 = if FFlagMigrateFriendshipStatusesRemainingActions then var1.AcceptFriendRequest(arg1.profileId) else arg1.dispatch(
            NetworkingFriends.AcceptFriendRequestFromUserId.API({ targetUserId = arg1.profileId, currentUserId = arg1.localUserId })
        )

        return var2:andThen(function()
            arg1.dispatch(
                SetCurrentToastMessage({
                    toastMessage = arg1.localized.friendAcceptedToast,
                    toastIcon = Images["icons/actions/friends/friendAdd"],
                    isLocalized = true
                })
            )
            return arg1.dispatch(refreshProfilePlatformActionInfo(arg1.profileId, arg1.actionsComponentRequest))
        end)
    end

    tbl1.onActivated = onActivated
    return tbl1
end

module[Enums.ProfileActions.AcceptOffNetworkFriendRequest] = function(arg1)
    local tbl1 = {
        text = arg1.localized[Enums.ProfileActions.AcceptOffNetworkFriendRequest],
        onActivated = 0
    }
    local onActivated = {}
    onActivated[ProfileTypes.User] = function()
        arg1.analytics.fireAnalyticsEvent(
            EventNames.CTAButtonAddFriendFromContacts,
            {
                shareLinkId = arg1.profileWrapperContext.sourceInfo.shareLinkId
            }
        )

        return arg1.dispatch(
            NetworkingFriends.AcceptFriendRequestWithToken.API({
                targetUserId = arg1.profileId,
                currentUserId = arg1.localUserId,
                friendingToken = arg1.profileWrapperContext.offNetworkFriendRequestToken
            })
        ):andThen(
            function()
                arg1.dispatch(
                    SetCurrentToastMessage({
                        toastMessage = arg1.localized.friendAcceptedToast,
                        toastIcon = Images["icons/actions/friends/friendAdd"],
                        isLocalized = true
                    })
                )
                return arg1.dispatch(refreshProfilePlatformActionInfo(arg1.profileId, arg1.actionsComponentRequest))
            end
        )
    end

    tbl1.onActivated = onActivated
    return tbl1
end

return module
