-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local Foundation = require(ProfilePlatformParent.Foundation)
local RobloxAppEnums = require(ProfilePlatformParent.RobloxAppEnums)

local ButtonVariant = Foundation.Enums.ButtonVariant
local AppPage = RobloxAppEnums.AppPage

local UrlBuilder = require(ProfilePlatformParent.UrlBuilder).UrlBuilder
local UrlBase = require(ProfilePlatformParent.UrlBuilder).UrlBase

local default = require(ProfilePlatformParent.ExternalContentSharingProtocol).ExternalContentSharingProtocol.default
local Url = require(ProfilePlatformParent.Http).Url
local SetCurrentToastMessage = require(ProfilePlatformParent.ToastRodux).Actions.SetCurrentToastMessage
local NavigateDown = require(ProfilePlatformParent.NavigationRodux).Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(ProfilePlatformParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(ProfilePlatformParent.RobloxAppNavigation).NavigationCommands else nil
local Contexts = require(ProfilePlatformParent.SocialLuaAnalytics).Analytics.Enums.Contexts

local GroupsNetworking = require(ProfilePlatform.Networking.GroupsNetworking)
local getProfilePlatform = require(ProfilePlatform.Networking.getProfilePlatform)
local refreshProfilePlatform = require(ProfilePlatform.Networking.refreshProfilePlatform)
local getAvailableCommunityComponents = require(ProfilePlatform.Hooks.getAvailableCommunityComponents)
local TextKeys = require(ProfilePlatform.Common.TextKeys)
local Enums = require(ProfilePlatform.Common.Enums)
local _Types = require(ProfilePlatform.Components.CTARow.Types)
local EventNames = require(ProfilePlatform.Analytics.EventNames)
local makeViewGroupPage = require(ProfilePlatform.Utils.makeViewGroupPage)
local ProfileTypes = Enums.ProfileTypes

local str1 = `{Url.BASE_URL}share/g/%s`

local module = {}
module[Enums.ProfileActions.CopyLink] = function(arg1)
    local tbl1 = {
        text = arg1.localized[Enums.ProfileActions.CopyLink],
        onActivated = 0
    }
    local onActivated = {}
    onActivated[ProfileTypes.Community] = function()
        arg1.analytics.fireAnalyticsEvent(EventNames.ContextualMenuButtonCopyLink, { buttonSurface = arg1.buttonSurface })

        default:setClipboardText({ context = Contexts.ProfileCard, text = string.format(str1, arg1.profileId) })

        arg1.dispatch(SetCurrentToastMessage({ toastMessage = TextKeys.LinkCopied }))
    end

    tbl1.onActivated = onActivated
    return tbl1
end

module[Enums.ProfileActions.JoinCommunity] = function(arg1)
    local tbl1 = {
        variant = ButtonVariant.Emphasis,
        text = arg1.localized[Enums.ProfileActions.JoinCommunity],
        onActivated = 0
    }
    local onActivated = {}
    onActivated[ProfileTypes.Community] = function()
        arg1.analytics.fireAnalyticsEvent(
            EventNames.CTAButtonJoinCommunity,
            {
                buttonSurface = arg1.buttonSurface,
                btnContext = arg1.profileWrapperContext.sourceInfo.source
            }
        )
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

module[Enums.ProfileActions.CancelJoinCommunityRequest] = function(arg1)
    local tbl1 = {
        variant = ButtonVariant.Standard,
        text = arg1.localized[Enums.ProfileActions.CancelJoinCommunityRequest],
        onActivated = 0
    }
    local onActivated = {}
    onActivated[ProfileTypes.Community] = function()
        arg1.analytics.fireAnalyticsEvent(
            EventNames.CTAButtonCancelJoinCommunityRequest,
            {
                buttonSurface = arg1.buttonSurface,
                btnContext = arg1.profileWrapperContext.sourceInfo.source
            }
        )
        return arg1.dispatch(GroupsNetworking.CancelJoinGroupRequest.API({ groupId = arg1.profileId, userId = arg1.localUserId })):andThen(
            function()
                arg1.dispatch(
                    refreshProfilePlatform(
                        {
                            profileType = arg1.profileType,
                            profileId = arg1.profileId,
                            components = { Enums.Components.Actions }
                        }
                    )
                )
            end
        )
    end

    tbl1.onActivated = onActivated
    return tbl1
end

module[Enums.ProfileActions.ViewCommunity] = function(arg1)
    local tbl1 = {
        variant = ButtonVariant.SubEmphasis,
        text = arg1.localized[Enums.ProfileActions.ViewCommunity],
        onActivated = 0
    }
    local onActivated = {}
    onActivated[ProfileTypes.Community] = function()
        arg1.analytics.fireAnalyticsEvent(
            EventNames.CTAButtonViewCommunity,
            {
                buttonSurface = arg1.buttonSurface,
                btnContext = arg1.profileWrapperContext.sourceInfo.source
            }
        )
        local viewGroupPage = makeViewGroupPage(arg1.profileId, function()
            arg1.dispatch(
                getProfilePlatform.API({
                    profileType = arg1.profileType,
                    profileId = arg1.profileId,
                    components = getAvailableCommunityComponents(),
                    includeComponentOrdering = true
                })
            )
        end)
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(viewGroupPage))
            return
        end
        arg1.dispatch(NavigateDown(viewGroupPage))
    end

    tbl1.onActivated = onActivated
    return tbl1
end

module[Enums.ProfileActions.ViewFullProfile] = function(arg1)
    local tbl1 = {
        variant = ButtonVariant.SubEmphasis,
        text = arg1.localized[Enums.ProfileActions.ViewFullProfile],
        onActivated = 0
    }
    local onActivated = {}
    onActivated[ProfileTypes.Community] = function()
        arg1.analytics.fireAnalyticsEvent(
            EventNames.CTAButtonViewFullProfile,
            {
                buttonSurface = arg1.buttonSurface,
                btnContext = arg1.profileWrapperContext.sourceInfo.source
            }
        )
        local tbl3 = {
            name = AppPage.GenericWebPage,
            detail = UrlBuilder.new({ base = UrlBase.WWW, path = `profiles/{arg1.profileId}` })(),
            extraProps = {
                titleKey = TextKeys.Profile,
                onClose = function()
                    arg1.dispatch(
                        getProfilePlatform.API({
                            profileType = arg1.profileType,
                            profileId = arg1.profileId,
                            components = getAvailableCommunityComponents(),
                            includeComponentOrdering = true
                        })
                    )
                end
            }
        }
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl3))
            return
        end
        arg1.dispatch(NavigateDown(tbl3))
    end

    tbl1.onActivated = onActivated
    return tbl1
end

module[Enums.ProfileActions.LeaveCommunity] = function(arg1): {onActivated: number, text: any}?
    if arg1.profileType == ProfileTypes.Community and arg1.viewerOwnsOpenCommunity then
        return nil
    end

    local tbl1 = {
        text = arg1.localized[Enums.ProfileActions.LeaveCommunity],
        onActivated = 0
    }
    local onActivated = {}
    onActivated[ProfileTypes.Community] = function()
        arg1.analytics.fireAnalyticsEvent(
            EventNames.ContextualMenuButtonLeaveCommunity,
            {
                buttonSurface = arg1.buttonSurface,
                btnContext = arg1.profileWrapperContext.sourceInfo.source
            }
        )
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

module[Enums.ProfileActions.MakePrimaryCommunity] = function(arg1)
    local tbl1 = {
        text = arg1.localized[Enums.ProfileActions.MakePrimaryCommunity],
        onActivated = 0
    }
    local onActivated = {}
    onActivated[ProfileTypes.Community] = function()
        arg1.analytics.fireAnalyticsEvent(
            EventNames.ContextualMenuButtonMakePrimaryCommunity,
            {
                buttonSurface = arg1.buttonSurface,
                btnContext = arg1.profileWrapperContext.sourceInfo.source
            }
        )
        return arg1.dispatch(GroupsNetworking.MakePrimaryGroup.API({ groupId = arg1.profileId })):andThen(function()
            arg1.dispatch(
                refreshProfilePlatform(
                    {
                        profileType = arg1.profileType,
                        profileId = arg1.profileId,
                        components = { Enums.Components.Actions }
                    }
                )
            )
        end)
    end

    tbl1.onActivated = onActivated
    return tbl1
end

module[Enums.ProfileActions.RemovePrimaryCommunity] = function(arg1)
    local tbl1 = {
        text = arg1.localized[Enums.ProfileActions.RemovePrimaryCommunity],
        onActivated = 0
    }
    local onActivated = {}
    onActivated[ProfileTypes.Community] = function()
        arg1.analytics.fireAnalyticsEvent(
            EventNames.ContextualMenuButtonRemovePrimaryCommunity,
            {
                buttonSurface = arg1.buttonSurface,
                btnContext = arg1.profileWrapperContext.sourceInfo.source
            }
        )
        return arg1.dispatch(GroupsNetworking.RemovePrimaryGroup.API()):andThen(function()
            arg1.dispatch(
                refreshProfilePlatform(
                    {
                        profileType = arg1.profileType,
                        profileId = arg1.profileId,
                        components = { Enums.Components.Actions }
                    }
                )
            )
        end)
    end

    tbl1.onActivated = onActivated
    return tbl1
end

return module
