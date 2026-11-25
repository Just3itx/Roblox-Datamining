-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:51:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local UIBlox = require(ProfilePlatformParent.UIBlox)
local SharedFlags = require(ProfilePlatformParent.SharedFlags)
local RobloxAppEnums = require(ProfilePlatformParent.RobloxAppEnums)
local DataHydration = require(ProfilePlatformParent.DataHydration)
local SocialLuaAnalytics = require(ProfilePlatformParent.SocialLuaAnalytics)

local Images = UIBlox.App.ImageSet.Images
local AppPage = RobloxAppEnums.AppPage
local Sources = SocialLuaAnalytics.Analytics.Enums.Sources

local SetCurrentToastMessage = require(ProfilePlatformParent.ToastRodux).Actions.SetCurrentToastMessage
local refreshProfilePlatformActionInfo = require(ProfilePlatform.Networking.refreshProfilePlatformActionInfo)
local Enums = require(ProfilePlatform.Common.Enums)
local _Types = require(ProfilePlatform.Components.CTARow.Types)
local EventNames = require(ProfilePlatform.Analytics.EventNames)
local ProfileTypes = Enums.ProfileTypes

local FFlagProfilePlatformAddTC = SharedFlags.FFlagProfilePlatformAddTC
local FFlagFixTFLinksVRGating = require(ProfilePlatform.Flags.FFlagFixTFLinksVRGating)
local FFlagProfileTFCardUseQrScanContext = SharedFlags.FFlagProfileTFCardUseQrScanContext

local var1 = DataHydration.TrustedConnections.TrustedConnectionsStore.get()

local module = {}
module[Enums.ProfileActions.RemoveTrustedConnection] = function(arg1)
    local tbl1 = {
        text = arg1.localized[Enums.ProfileActions.RemoveTrustedConnection],
        onActivated = 0
    }
    local onActivated = {}
    onActivated[ProfileTypes.User] = function()
        arg1.analytics.fireAnalyticsEvent(
            EventNames.ContextualMenuButtonRemoveTrustedConnection,
            {
                buttonSurface = arg1.buttonSurface
            }
        )

        return var1.removeTrustedConnectionRequest(arg1.profileId):andThen(function()
            arg1.dispatch(
                SetCurrentToastMessage({
                    toastMessage = arg1.localized.trustedConnectionRemovedToast,
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

module[Enums.ProfileActions.AddTrustedConnection] = FFlagProfilePlatformAddTC and function(arg1)
    local tbl1 = {
        text = arg1.localized[Enums.ProfileActions.AddTrustedConnection],
        onActivated = 0
    }
    local onActivated = {}
    onActivated[ProfileTypes.User] = function()
        arg1.analytics.fireAnalyticsEvent(
            EventNames.ContextualMenuButtonAddTrustedConnection,
            {
                buttonSurface = arg1.buttonSurface
            }
        )

        local props = {
            userId = arg1.profileId,
            source = Sources.ProfilePlatform,
            onRequestSent = function()
                return arg1.dispatch(refreshProfilePlatformActionInfo(arg1.profileId, arg1.actionsComponentRequest))
            end
        }

        if FFlagProfileTFCardUseQrScanContext and arg1.profileWrapperContext.sourceInfo.source == Enums.Sources.QrCode then
            props.sentFromQrCode = true
        end
        arg1.navigation.push(AppPage.TrustedContactsModal, { props = props })
    end

    tbl1.onActivated = onActivated
    return tbl1
end or nil

module[Enums.ProfileActions.AddTrustedConnectionViaLink] = not FFlagFixTFLinksVRGating and function(arg1)
    local tbl1 = {
        text = arg1.localized[Enums.ProfileActions.AddTrustedConnection],
        onActivated = 0
    }
    local onActivated = {}
    onActivated[ProfileTypes.User] = function()
        arg1.analytics.fireAnalyticsEvent(
            EventNames.ContextualMenuButtonAddTrustedConnection,
            {
                buttonSurface = arg1.buttonSurface,
                modalVariantOverride = Sources.ShareLinkSender
            }
        )

        arg1.navigation.push(AppPage.TrustedContactsModal, {
            props = {
                userId = arg1.profileId,
                source = Sources.ProfilePlatform,
                modalVariantOverride = Sources.ShareLinkSender,
                onRequestSent = function()
                    return arg1.dispatch(refreshProfilePlatformActionInfo(arg1.profileId, arg1.actionsComponentRequest))
                end
            }
        })
    end

    tbl1.onActivated = onActivated
    return tbl1
end or FFlagProfilePlatformAddTC and function(arg1)
    local tbl1 = {
        text = arg1.localized[Enums.ProfileActions.AddTrustedConnection],
        onActivated = 0
    }
    local onActivated = {}
    onActivated[ProfileTypes.User] = function()
        arg1.analytics.fireAnalyticsEvent(
            EventNames.ContextualMenuButtonAddTrustedConnection,
            {
                buttonSurface = arg1.buttonSurface,
                modalVariantOverride = Sources.ShareLinkSender
            }
        )

        local props = {
            userId = arg1.profileId,
            source = Sources.ProfilePlatform,
            modalVariantOverride = Sources.ShareLinkSender,
            onRequestSent = function()
                return arg1.dispatch(refreshProfilePlatformActionInfo(arg1.profileId, arg1.actionsComponentRequest))
            end
        }

        if FFlagProfileTFCardUseQrScanContext and arg1.profileWrapperContext.sourceInfo.source == Enums.Sources.QrCode then
            props.sentFromQrCode = true
        end
        arg1.navigation.push(AppPage.TrustedContactsModal, { props = props })
    end

    tbl1.onActivated = onActivated
    return tbl1
end or nil

module[Enums.ProfileActions.AddIncomingTrustedConnection] = FFlagProfilePlatformAddTC and function(arg1)
    local tbl1 = {
        text = arg1.localized[Enums.ProfileActions.AddIncomingTrustedConnection],
        onActivated = 0
    }
    local onActivated = {}
    onActivated[ProfileTypes.User] = function()
        arg1.analytics.fireAnalyticsEvent(
            EventNames.ContextualMenuButtonAddIncomingTrustedConnection,
            {
                buttonSurface = arg1.buttonSurface
            }
        )
        arg1.navigation.push(AppPage.TrustedContactsModal, {
            props = {
                userId = arg1.profileId,
                onRequestAccepted = function()
                    return arg1.dispatch(refreshProfilePlatformActionInfo(arg1.profileId, arg1.actionsComponentRequest))
                end
            }
        })
    end

    tbl1.onActivated = onActivated
    return tbl1
end or nil

module[Enums.ProfileActions.PendingTrustedConnection] = FFlagProfilePlatformAddTC and function(arg1)
    local tbl1 = {
        text = arg1.localized[Enums.ProfileActions.AddTrustedConnection],
        isDisabled = true,
        onActivated = 0
    }
    local onActivated = {}
    onActivated[ProfileTypes.User] = function() end

    tbl1.onActivated = onActivated
    return tbl1
end or nil

module[Enums.ProfileActions.PendingIncomingTrustedConnection] = function(arg1)
    local tbl1 = {
        text = arg1.localized[Enums.ProfileActions.AddIncomingTrustedConnection],
        isDisabled = true,
        onActivated = 0
    }
    local onActivated = {}
    onActivated[ProfileTypes.User] = function() end

    tbl1.onActivated = onActivated
    return tbl1
end

return module
