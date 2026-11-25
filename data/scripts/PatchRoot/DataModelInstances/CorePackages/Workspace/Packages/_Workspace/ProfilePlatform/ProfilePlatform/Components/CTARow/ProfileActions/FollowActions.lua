-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local Foundation = require(ProfilePlatformParent.Foundation)
local FFlagSocialFollowAttribution = require(ProfilePlatformParent.SharedFlags).FFlagSocialFollowAttribution
local FollowAttribution = if FFlagSocialFollowAttribution then require(ProfilePlatformParent.SocialCommon.FollowAttribution) else nil
local ButtonVariant = Foundation.Enums.ButtonVariant

local SetCurrentToastMessage = require(ProfilePlatformParent.ToastRodux).Actions.SetCurrentToastMessage
local GroupsNetworking = require(ProfilePlatform.Networking.GroupsNetworking)
local getProfilePlatform = require(ProfilePlatform.Networking.getProfilePlatform)
local refreshProfilePlatformActionInfo = require(ProfilePlatform.Networking.refreshProfilePlatformActionInfo)
local getAvailableCommunityComponents = require(ProfilePlatform.Hooks.getAvailableCommunityComponents)
local Enums = require(ProfilePlatform.Common.Enums)
local _Types = require(ProfilePlatform.Components.CTARow.Types)
local EventNames = require(ProfilePlatform.Analytics.EventNames)
local ProfileTypes = Enums.ProfileTypes

local FFlagProfilePlatformEnableUserFollow = require(ProfilePlatform.Flags.FFlagProfilePlatformEnableUserFollow)
local Following = require(ProfilePlatformParent.DataHydration.Following)
local FollowingStore = Following.FollowingStore
local FollowingUpdateErrorTypeEnum = Following.FollowingUpdateErrorTypeEnum
local createChallengeNetwork = require(ProfilePlatformParent.GenericChallenges).Middleware.createChallengeNetwork

local function handleUpdateUserFollowStatus(arg1, func1: (...any) -> (...any), toastMessage: string, callback: ((...any) -> (...any))?)
    return func1(arg1.profileId, createChallengeNetwork()):andThen(function()
        if FFlagSocialFollowAttribution and callback then
            callback()
        end
        arg1.dispatch(SetCurrentToastMessage({ toastMessage = toastMessage, isLocalized = true }))

        return arg1.dispatch(refreshProfilePlatformActionInfo(arg1.profileId, arg1.actionsComponentRequest))
    end, function(arg2)
        arg1.dispatch(
            SetCurrentToastMessage({
                toastMessage = if arg2 ~= nil and arg2.errorType == FollowingUpdateErrorTypeEnum.Captcha then arg1.localized.userNotPassedCaptchaError else arg1.localized.somethingIsWrongToast,
                isLocalized = true
            })
        )
    end)
end

local module = {}
module[Enums.ProfileActions.Follow] = function(arg1)
    local tbl1 = {
        variant = ButtonVariant.Standard,
        text = arg1.localized[Enums.ProfileActions.Follow],
        onActivated = 0
    }

    local onActivated = {
        [ProfileTypes.User] = FFlagProfilePlatformEnableUserFollow and function()
            arg1.analytics.fireAnalyticsEvent(EventNames.CTAButtonFollow, { buttonSurface = arg1.buttonSurface })

            return handleUpdateUserFollowStatus(
                arg1,
                FollowingStore.get().Follow,
                arg1.localized.followedToast,
                FFlagSocialFollowAttribution and function()
                    FollowAttribution.reportFollowSuccess(
                        {
                            surface = FollowAttribution.Surface.Profile,
                            source = arg1.profileWrapperContext.sourceInfo.source
                        }
                    )
                end or nil
            )
        end or nil
    }

    onActivated[ProfileTypes.Community] = function()
        arg1.analytics.fireAnalyticsEvent(EventNames.CTAButtonFollow, { buttonSurface = arg1.buttonSurface })

        return arg1.dispatch(GroupsNetworking.JoinGroup.API({ groupId = arg1.profileId })):andThen(function()
            arg1.dispatch(
                getProfilePlatform.API({
                    profileType = arg1.profileType,
                    profileId = arg1.profileId,
                    components = getAvailableCommunityComponents(),
                    includeComponentOrdering = true
                })
            )
        end)
    end

    tbl1.onActivated = onActivated
    return tbl1
end

module[Enums.ProfileActions.Unfollow] = function(arg1): {onActivated: number, text: any}?
    if arg1.profileType == ProfileTypes.Community and arg1.viewerOwnsOpenCommunity then
        return nil
    end

    local tbl1 = {
        text = arg1.localized[Enums.ProfileActions.Unfollow],
        onActivated = 0
    }

    local onActivated = {
        [ProfileTypes.User] = FFlagProfilePlatformEnableUserFollow and function()
            arg1.analytics.fireAnalyticsEvent(EventNames.ContextualMenuButtonUnfollow, { buttonSurface = arg1.buttonSurface })

            return handleUpdateUserFollowStatus(arg1, FollowingStore.get().Unfollow, arg1.localized.unfollowedToast)
        end or nil
    }

    onActivated[ProfileTypes.Community] = function()
        arg1.analytics.fireAnalyticsEvent(EventNames.ContextualMenuButtonUnfollow, { buttonSurface = arg1.buttonSurface })

        return arg1.dispatch(GroupsNetworking.LeaveGroup.API({ groupId = arg1.profileId, userId = arg1.localUserId })):andThen(
            function()
                arg1.dispatch(
                    getProfilePlatform.API({
                        profileType = arg1.profileType,
                        profileId = arg1.profileId,
                        components = getAvailableCommunityComponents(),
                        includeComponentOrdering = true
                    })
                )
            end
        )
    end

    tbl1.onActivated = onActivated
    return tbl1
end

return module
