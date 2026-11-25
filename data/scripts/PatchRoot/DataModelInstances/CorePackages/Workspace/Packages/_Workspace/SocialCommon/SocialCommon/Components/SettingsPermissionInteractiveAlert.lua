-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:11:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCommonParent = script:FindFirstAncestor("SocialCommon").Parent
local MessageBusService = game:GetService("MessageBusService")
local AppStorageService = game:GetService("AppStorageService")

local React = require(SocialCommonParent.React)
local Foundation = require(SocialCommonParent.Foundation)
local useLocalization = require(SocialCommonParent.Localization).Hooks.useLocalization
local useDispatch = require(SocialCommonParent.RoactUtils).Hooks.RoactRodux.useDispatch

local LinkingProtocol = require(SocialCommonParent.LinkingProtocol)
local SocialLuaAnalytics = require(SocialCommonParent.SocialLuaAnalytics)
local Dash = require(SocialCommonParent.Dash)
local useAppPolicy = require(SocialCommonParent.UniversalAppPolicy).useAppPolicy
local PermissionsProtocol = require(SocialCommonParent.PermissionsProtocol).PermissionsProtocol

local default = LinkingProtocol.LinkingProtocol.default
local SettingsRoute = LinkingProtocol.Enums.SettingsRoute

local Dialog = Foundation.Dialog
local FoundationText = Foundation.Text
local View = Foundation.View
local ButtonVariant = Foundation.Enums.ButtonVariant
local DialogSize = Foundation.Enums.DialogSize
local EnumsOrientation = Foundation.Enums.Orientation

local AnalyticsFactory = SocialLuaAnalytics.Analytics.AnalyticsFactory
local DefaultAnalyticsService = SocialLuaAnalytics.Analytics.DefaultAnalyticsService
local EventTypes = SocialLuaAnalytics.Analytics.Enums.EventTypes

local FFlagEnableRetryForLinkingProtocolFetch = require(SocialCommonParent.SharedFlags).FFlagEnableRetryForLinkingProtocolFetch
local FIntLinkingProtocolFetchRetries = require(SocialCommonParent.SharedFlags).FIntLinkingProtocolFetchRetries
local FIntLinkingProtocolFetchTimeoutMS = require(SocialCommonParent.SharedFlags).FIntLinkingProtocolFetchTimeoutMS
local FFlagQRInSearchScanner = require(SocialCommonParent.SharedFlags).FFlagQRInSearchScanner

local key = if require(SocialCommonParent.SharedFlags).FFlagRegisterQRCodeKeyInEngine then "ProfileQrCodeCameraSettingsModalSeen" else "ScreenshotEventTracking"

local messageId = MessageBusService:GetMessageId("Realtime", "appResume")

local EventStream = {
    SettingsPermissionInteractiveAlertButtonClick = {
        context = "settingsPermissionInteractiveAlert",
        eventType = EventTypes.ButtonClick,
        formatRulesForAdditionalInfo = {
            settingsRoute = Dash.identity,
            btn = Dash.identity
        }
    },
    SettingsPermissionInteractiveAlertImpression = {
        context = "settingsPermissionInteractiveAlert",
        eventType = EventTypes.SettingsPermissionInteractiveAlertImpression,
        formatRulesForAdditionalInfo = {
            settingsRoute = Dash.identity,
            settingsAppAvailable = Dash.identity
        }
    }
}

local tbl2 = {
    [SettingsRoute.Camera] = PermissionsProtocol.Permissions.CAMERA_ACCESS,
    [SettingsRoute.Contacts] = PermissionsProtocol.Permissions.CONTACTS_ACCESS
}

local function SettingsPermissionInteractiveAlert(tbl3)
    local var1 = useDispatch()

    local settingsRoute = tbl3.settingsRoute or tbl3.navigation and tbl3.navigation.getParam("settingsRoute")
    local source = tbl3.source or tbl3.navigation and tbl3.navigation.getParam("source")

    local var4 = React.useCallback(function()
        if tbl3.closeCentralOverlayThunk then
            return (var1(tbl3.closeCentralOverlayThunk()))
        end

        return tbl3.navigation and tbl3.navigation.pop()
    end, { var1, tbl3.closeCentralOverlayThunk, tbl3.navigation })

    local var5 = React.useMemo(function()
        return AnalyticsFactory.setUpAnalyticsFactory({
            eventLists = { EventStream = EventStream },
            analyticsImpl = {
                EventStream = DefaultAnalyticsService.EventStream
            },
            staticInfoForAllEvents = FFlagQRInSearchScanner and { source = source } or nil
        })()
    end)

    local bool1 = false
    local var6 = nil
    local var7 = nil

    if var7 == nil then
        if FFlagEnableRetryForLinkingProtocolFetch then
            for _ = 0, FIntLinkingProtocolFetchRetries do
                local var8 = task.spawn(function()
                    bool1, var6 = default:supportsSwitchToSettingsApp(settingsRoute):await()
                end)
                task.wait(FIntLinkingProtocolFetchTimeoutMS / 1000)
                task.cancel(var8)

                if var6 ~= nil then
                    break
                end
            end
        else
            bool1, var6 = default:supportsSwitchToSettingsApp(settingsRoute):await()
        end

        var7 = bool1 and var6
    end

    React.useEffect(function()
        var5.fireAnalyticsEvent(
            "SettingsPermissionInteractiveAlertImpression",
            { settingsRoute = settingsRoute, settingsAppAvailable = var7 }
        )
        AppStorageService:SetItem(key, "true")
        AppStorageService:Flush()

        local var8 = MessageBusService:Subscribe(messageId, function()
            PermissionsProtocol.default:hasPermissions({ tbl2[settingsRoute] }):andThen(function(arg1)
                if arg1 and arg1.status == PermissionsProtocol.Status.AUTHORIZED then
                    var4()
                end
            end)
        end, false, true)
        return function()
            var8:Disconnect()
        end
    end, {})

    local var8 = useAppPolicy(function(arg1)
        return arg1.getShouldShowSettingsPermissionsAdditionalInstructions()
    end)

    local var9 = var7

    local var10 = useLocalization({
        notNow = if var9 then "CommonUI.Controls.Action.Cancel" else "Feature.SettingsHub.Action.NotNow",
        ok = "Feature.SettingsHub.Action.Ok",
        openSettings = if var9 then "Feature.SettingsHub.Action.AllowInSettings" else "Feature.SettingsHub.Action.OpenSettings",
        titleCamera = if var9 then "Feature.SettingsHub.Prompt.AllowAccessToCamera" else "Feature.SettingsHub.Prompt.NeedCameraAccess",
        titleContacts = if var9 then "Feature.SettingsHub.Prompt.AllowAccessToContacts" else "Feature.SettingsHub.Prompt.NeedContactsAccess",
        bodyTextCamera = if var9 then "Feature.SettingsHub.Description.CameraPermissionRequestQRCode" else "Feature.SettingsHub.Description.QRCodeCameraPermissionIOS",
        bodyTextContacts = if var9 then "Feature.SettingsHub.Description.ContactsPermissionRequest" else "Feature.SettingsHub.Description.ContactsPermissionIOS",
        additionalInstructionsContactsDeeplinkSupported = "Feature.SettingsHub.Description.ContactsPermissionAndroid",
        additionalInstructionsContactsDeeplinkNotSupported = "Feature.SettingsHub.Description.ContactsPermissionAndroidDeeplinkNotSupported",
        additionalInstructionsCameraDeeplinkSupported = "Feature.SettingsHub.Description.QRCodeCameraPermissionAndroid",
        additionalInstructionsCameraDeeplinkNotSupported = "Feature.SettingsHub.Description.QRCodeCameraPermissionAndroidDeeplinkNotSupported"
    })

    local tbl4 = {
        [SettingsRoute.Camera] = var10.titleCamera,
        [SettingsRoute.Contacts] = var10.titleContacts
    }

    local tbl5 = {
        [SettingsRoute.Camera] = var10.bodyTextCamera,
        [SettingsRoute.Contacts] = var10.bodyTextContacts
    }

    local tbl6 = {
        [SettingsRoute.Contacts] = {
            deepLinkSupported = var10.additionalInstructionsContactsDeeplinkSupported,
            deepLinkNotSupported = var10.additionalInstructionsContactsDeeplinkNotSupported
        },
        [SettingsRoute.Camera] = {
            deepLinkSupported = var10.additionalInstructionsCameraDeeplinkSupported,
            deepLinkNotSupported = var10.additionalInstructionsCameraDeeplinkNotSupported
        }
    }

    local onActivated = React.useCallback(function()
        var5.fireAnalyticsEvent(
            "SettingsPermissionInteractiveAlertButtonClick",
            { settingsRoute = settingsRoute, btn = "notNow" }
        )

        return var4()
    end, { tbl3.navigation })

    local var2 = React.useCallback(function()
        var5.fireAnalyticsEvent("SettingsPermissionInteractiveAlertButtonClick", { settingsRoute = settingsRoute, btn = "ok" })

        return var4()
    end, { tbl3.navigation })

    local var3 = React.useCallback(function()
        var5.fireAnalyticsEvent(
            "SettingsPermissionInteractiveAlertButtonClick",
            { settingsRoute = settingsRoute, btn = "openSettings" }
        )

        return default:switchToSettingsApp(settingsRoute)
    end, { tbl3.navigation })

    local actions = var7
        and {
            {
                text = var10.openSettings,
                variant = ButtonVariant.Emphasis,
                onActivated = var3
            },
            {
                text = var10.notNow,
                variant = ButtonVariant.Standard,
                onActivated = onActivated
            }
        }
        or {{
            text = var10.ok,
            variant = ButtonVariant.Emphasis,
            onActivated = var2
        }}

    local createElement = React.createElement
    local root = Dialog.Root
    local tbl8 = {
        size = DialogSize.Small,
        hasBackdrop = false,
        disablePortal = true
    }

    local tbl9 = {
        DialogTitle = React.createElement(Dialog.Title, { LayoutOrder = 1, text = tbl4[settingsRoute] }),
        DialogContent = 0,
        DialogActions = 0
    }
    local createElement2 = React.createElement
    local content = Dialog.Content
    local tbl10 = { LayoutOrder = 2 }

    local tbl11 = {
        Body = React.createElement(View, { tag = "col gap-small size-full-0 auto-y" }, {
            BodyText = React.createElement(Dialog.Text, { LayoutOrder = 1, Text = tbl5[settingsRoute] }),
            AdditionalInstructions = if var8 then React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = tbl6[settingsRoute][if var7 then "deepLinkSupported" else "deepLinkNotSupported"],
                tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-emphasis"
            }) else nil
        })
    }
    tbl9.DialogContent = createElement2(content, tbl10, tbl11)

    tbl9.DialogActions = React.createElement(Dialog.Actions, { LayoutOrder = 3, orientation = EnumsOrientation.Vertical, actions = actions })
    return createElement(root, tbl8, tbl9)
end

return SettingsPermissionInteractiveAlert
