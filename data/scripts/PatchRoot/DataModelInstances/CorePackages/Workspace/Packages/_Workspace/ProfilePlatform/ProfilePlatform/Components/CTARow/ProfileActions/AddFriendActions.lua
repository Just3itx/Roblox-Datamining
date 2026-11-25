-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:50:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local HttpService = game:GetService("HttpService")

local Foundation = require(ProfilePlatformParent.Foundation)
local UIBlox = require(ProfilePlatformParent.UIBlox)
local SocialCommon = require(ProfilePlatformParent.SocialCommon)

local Images = UIBlox.App.ImageSet.Images
local ButtonVariant = Foundation.Enums.ButtonVariant
local ContextualInfoTypes = SocialCommon.Enums.ContextualInfoTypes
local SetCurrentToastMessage = require(ProfilePlatformParent.ToastRodux).Actions.SetCurrentToastMessage
local NetworkingFriends = require(ProfilePlatform.Networking.NetworkingFriends)
local refreshProfilePlatformActionInfo = require(ProfilePlatform.Networking.refreshProfilePlatformActionInfo)
local refreshProfilePlatform = require(ProfilePlatform.Networking.refreshProfilePlatform)
local Constants = require(ProfilePlatform.Common.Constants)
local Enums = require(ProfilePlatform.Common.Enums)
local _Types = require(ProfilePlatform.Components.CTARow.Types)
local EventNames = require(ProfilePlatform.Analytics.EventNames)
local ProfileTypes = Enums.ProfileTypes

local FFlagMigrateFriendshipStatusesRemainingActions = require(ProfilePlatformParent.SharedFlags).FFlagMigrateFriendshipStatusesRemainingActions
local friendsStoreChallengeNetwork = require(ProfilePlatform.Networking.friendsStoreChallengeNetwork)

local FFlagEnableFriendsStoreChallengeInterceptor = require(ProfilePlatformParent.SharedFlags).FFlagEnableFriendsStoreChallengeInterceptor
local var1 = require(ProfilePlatformParent.DataHydration).Friends.FriendsStore.get()

local USER_FRIENDING_ERRORS = Constants.USER_FRIENDING_ERRORS
local STATUS_CODES = Constants.STATUS_CODES

local function setErrorToast(arg1, str1: string, arg2)
    local function getErrorToastMessage(statusCode, arg3)
        if str1 == Enums.ProfileActions.AddFriend or str1 == Enums.ProfileActions.AddFriendFromContacts then
            if statusCode == STATUS_CODES.BAD_REQUEST then
                return ({
                    [USER_FRIENDING_ERRORS.INVALID_TARGET_USER_ERROR] = arg1.localized.invalidTargetUserError,
                    [USER_FRIENDING_ERRORS.ALREADY_FRIEND_ERROR] = arg1.localized.alreadyFriendError,
                    [USER_FRIENDING_ERRORS.MAX_FRIENDS_ERROR] = arg1.localized.maxFriendsError,
                    [USER_FRIENDING_ERRORS.INVALID_NICKNAME_ERROR] = arg1.localized.invalidNicknameError
                })[arg3]
            end
            if statusCode == STATUS_CODES.UNAUTHORIZED then
                return ({
                    [USER_FRIENDING_ERRORS.UNAUTHORIZED_ERROR] = arg1.localized.unauthorizedError
                })[arg3]
            end
            if statusCode == STATUS_CODES.FORBIDDEN then
                return ({
                    [USER_FRIENDING_ERRORS.USER_BANNED_ERROR] = arg1.localized.userBannedError,
                    [USER_FRIENDING_ERRORS.USER_BLOCKED_ERROR] = arg1.localized.userBlockedError,
                    [USER_FRIENDING_ERRORS.USER_NOT_PASSED_CAPTCHA_ERROR] = arg1.localized.userNotPassedCaptchaError
                })[arg3]
            end
            if statusCode == STATUS_CODES.TOO_MANY_REQUESTS then
                return ({
                    [USER_FRIENDING_ERRORS.TOO_MANY_REQUESTS_ERROR] = arg1.localized.tooManyRequestsError
                })[arg3]
            end
        end

        return nil
    end

    if arg2 == nil then
        arg1.dispatch(SetCurrentToastMessage({ toastMessage = arg1.localized.defaultFriendingError, isLocalized = true }))

        return
    end

    local statusCode = arg2.StatusCode
    local var2 = if arg2.Body then HttpService:JSONDecode(arg2.Body) else nil
    local toastMessage = getErrorToastMessage(
        statusCode,
        if var2 and var2.errors and var2.errors[1] and var2.errors[1].code then var2.errors[1].code else nil
    )
        or arg1.localized.defaultFriendingError
    arg1.dispatch(SetCurrentToastMessage({ toastMessage = toastMessage, isLocalized = true }))
end
local module = {}
module[Enums.ProfileActions.AddFriend] = function(arg1)
    local tbl1 = {
        text = arg1.localized[Enums.ProfileActions.AddFriend],
        variant = ButtonVariant.Emphasis,
        onActivated = 0
    }
    local onActivated = {}
    onActivated[ProfileTypes.User] = function()
        arg1.analytics.fireAnalyticsEvent(EventNames.CTAButtonAddFriend, {
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

        arg1.dispatch(
            SetCurrentToastMessage({
                toastMessage = arg1.localized.friendRequestSentToast,
                toastIcon = Images["icons/actions/friends/friendAdd"],
                isLocalized = true
            })
        )
        local var2

        if FFlagMigrateFriendshipStatusesRemainingActions then
            var2 = var1.RequestFriendship(
                arg1.profileId,
                arg1.profileWrapperContext.sourceInfo.friendshipOriginSourceType,
                nil,
                if FFlagEnableFriendsStoreChallengeInterceptor then friendsStoreChallengeNetwork else nil
            )
        else
            var2 = arg1.dispatch(
                NetworkingFriends.RequestFriendshipFromUserId.API({
                    targetUserId = arg1.profileId,
                    currentUserId = arg1.localUserId,
                    friendshipOriginSourceType = arg1.profileWrapperContext.sourceInfo.friendshipOriginSourceType
                })
            )
        end

        return var2:andThen(function()
            return arg1.dispatch(refreshProfilePlatformActionInfo(arg1.profileId, arg1.actionsComponentRequest))
        end):catch(function(arg2)
            setErrorToast(arg1, Enums.ProfileActions.AddFriend, arg2)
        end)
    end

    tbl1.onActivated = onActivated
    return tbl1
end

module[Enums.ProfileActions.AddFriendFromContacts] = function(arg1)
    local tbl1 = {
        variant = ButtonVariant.Emphasis,
        text = arg1.localized[Enums.ProfileActions.AddFriendFromContacts],
        onActivated = 0
    }
    local onActivated = {}
    onActivated[ProfileTypes.Contact] = function()
        arg1.dispatch(
            SetCurrentToastMessage({
                toastMessage = arg1.localized.friendRequestSentToast,
                toastIcon = Images["icons/actions/friends/friendAdd"],
                isLocalized = true
            })
        )
        local var2 = if FFlagMigrateFriendshipStatusesRemainingActions then var1.RequestFriendship(
            arg1.profileId,
            nil,
            { isContact = true },
            if FFlagEnableFriendsStoreChallengeInterceptor then friendsStoreChallengeNetwork else nil
        ) else arg1.dispatch(
            NetworkingFriends.RequestFriendshipFromContactId.API(
                {
                    currentUserId = arg1.localUserId,
                    contactId = arg1.profileId,
                    contextType = ContextualInfoTypes.Contacts
                }
            )
        )

        return var2:andThen(function()
            return arg1.dispatch(
                refreshProfilePlatform({
                    profileType = arg1.profileType,
                    profileId = arg1.profileId,
                    components = { Enums.Components.ContactProfileHeader, Enums.Components.Actions, Enums.Components.ContactDescription }
                })
            )
        end):catch(function(arg2)
            setErrorToast(arg1, Enums.ProfileActions.AddFriendFromContacts, arg2)
        end)
    end

    tbl1.onActivated = onActivated
    return tbl1
end

module[Enums.ProfileActions.AddFriendFromContactsSent] = function(arg1)
    local tbl1 = {
        variant = ButtonVariant.Subtle,
        text = arg1.localized[Enums.ProfileActions.AddFriendFromContactsSent],
        onActivated = 0,
        isDisabled = true
    }
    local onActivated = {}
    onActivated[ProfileTypes.Contact] = function() end

    tbl1.onActivated = onActivated
    return tbl1
end

module[Enums.ProfileActions.CannotAddFriend] = function(arg1)
    local tbl1 = {
        text = arg1.localized[Enums.ProfileActions.CannotAddFriend],
        onActivated = 0,
        isDisabled = true
    }
    local onActivated = {}
    onActivated[ProfileTypes.User] = function() end

    tbl1.onActivated = onActivated
    return tbl1
end

return module
