-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")
local AppStorageService = game:GetService("AppStorageService")

local scriptParentParent = script.Parent.Parent
local NotificationModalsManager = require(scriptParentParent.NotificationModalsManager)
local default = require(scriptParentParent.PermissionsProtocol).PermissionsProtocol.default
local default2 = require(scriptParentParent.LoggingProtocol).default
local Localization = require(scriptParentParent.RobloxAppLocales).Localization
local sendEventDeferred = require(scriptParentParent.NotificationsCommon).sendEventDeferred

local PushNotificationsUpsellModal = require(script.Parent.Components.PushNotificationsUpsellModal)
local NotificationsUpsellConstants = require(script.Parent.NotificationsUpsellConstants)
local ModalEventConstants = require(script.Parent.Analytics.ModalEventConstants)
local PushUpsellEventName = require(script.Parent.Analytics.RobloxTelemetryConfigs.PushUpsellEventName)

local PushNotificationsUpsellUtils = require(script.Parent.Util.PushNotificationsUpsellUtils)
local mergeEventFields = require(script.Parent.Util.mergeEventFields)
local Promise = require(scriptParentParent.Promise)
local getAppFeaturePolicies = require(scriptParentParent.UniversalAppPolicy).getAppFeaturePolicies

local FIntPushUpsellCooldownPeriod = require(script.Parent.Flags.FIntPushUpsellCooldownPeriod)
local FIntPushUpsellMaxPromptCount = require(script.Parent.Flags.FIntPushUpsellMaxPromptCount)
local FIntPushUpsellChatCooldownPeriod = require(script.Parent.Flags.FIntPushUpsellChatCooldownPeriod)
local FIntPushUpsellChatMaxPromptCount = require(script.Parent.Flags.FIntPushUpsellChatMaxPromptCount)

local GetFFlagEnablePushNotificationsUpsellModal = require(scriptParentParent.SharedFlags).GetFFlagEnablePushNotificationsUpsellModal

local GetFFlagLuaAppPushUpsellDeprecateOldEvents = require(scriptParentParent.SharedFlags).GetFFlagLuaAppPushUpsellDeprecateOldEvents

local FFlagNotificationsUpsellUseRequestPushPermissionHelper = require(scriptParentParent.SharedFlags).FFlagNotificationsUpsellUseRequestPushPermissionHelper
local requestPushNotificationPermission = if FFlagNotificationsUpsellUseRequestPushPermissionHelper then require(script.Parent.requestPushNotificationPermission) else nil
local FFlagPushNotificationsUpsellPassClientAttributesToPrompts = require(scriptParentParent.SharedFlags).FFlagPushNotificationsUpsellPassClientAttributesToPrompts
local bool1 = game:DefineFastFlag("CacheShouldShowPushUpsellHideResponse", false)

local num1 = game:DefineFastInt("ShouldShowPushUpsellHideResponseCacheExpirationTime", 6)

local bool2 = false
local num2 = 0
local var1 = nil

local function getPushNotificationPermissionUpsellStatus()
    if var1 ~= nil then
        return var1
    end

    local var2 = default:shouldShowUpsell({ default.Permissions.POST_NOTIFICATIONS }):andThen(function(arg1)
        return arg1.upsellStatus or "UNKNOWN"
    end, function(): string
        return "ERROR"
    end)
    var1 = var2
    var2:finally(function()
        if var1 == var2 then
            var1 = nil
        end
    end)

    return var2
end

local function shouldShowUpsellHome(bool3: boolean?)
    if bool1 and (os.time() - num2) / 3600 < num1 and bool2 then
        return Promise.resolve(false)
    end

    local pushUpsellPromptedCount = PushNotificationsUpsellUtils.getPushUpsellPromptedCount(
        AppStorageService,
        NotificationsUpsellConstants.LocalStorageKeys.PromptShownCount
    )
    local var2 = if bool3 then PushNotificationsUpsellUtils.getPushEduUpsellResponseTimestamp(AppStorageService) else PushNotificationsUpsellUtils.getPushSysUpsellPromptTimestamp(AppStorageService)
    local bool4

    if pushUpsellPromptedCount >= 0 and var2 >= 0 then
        local var3 = (os.time() - var2) / 86400
        if pushUpsellPromptedCount < FIntPushUpsellMaxPromptCount then
            bool4 = FIntPushUpsellCooldownPeriod <= var3 or var2 == 0
        else
            bool4 = false
        end
    else
        bool4 = false
    end

    if not bool4 then
        return Promise.resolve(false)
    end

    if FFlagPushNotificationsUpsellPassClientAttributesToPrompts then
        return getPushNotificationPermissionUpsellStatus():andThen(function(show)
            return Promise.resolve(show == default.UpsellStatus.SHOW)
        end)
    end

    return default:shouldShowUpsell({ default.Permissions.POST_NOTIFICATIONS }):andThen(function(arg1)
        if arg1.upsellStatus and arg1.upsellStatus == default.UpsellStatus.SHOW then
            return Promise.resolve(true)
        end

        if bool1 then
            bool2 = true
            num2 = os.time()
        end
        return Promise.resolve(false)
    end, function(_)
        return Promise.resolve(false)
    end)
end

local function userHasRespondedToPushUpsellChat(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local pushUpsellPromptedCount = PushNotificationsUpsellUtils.getPushUpsellPromptedCount(
        AppStorageService,
        NotificationsUpsellConstants.LocalStorageKeys.ChatPromptShownCount
    )
    return pushUpsellPromptedCount < 0 or FIntPushUpsellChatMaxPromptCount <= pushUpsellPromptedCount
end

local function userHasRespondedToUpsellPromptLessThanCooldownPeriod(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local pushSysUpsellPromptTimestamp = PushNotificationsUpsellUtils.getPushSysUpsellPromptTimestamp(AppStorageService)

    return pushSysUpsellPromptTimestamp >= 0
        and (os.time() - pushSysUpsellPromptTimestamp) / 86400 < FIntPushUpsellChatCooldownPeriod
end

local function shouldShowRationale()
    return default:shouldShowRationale({ default.Permissions.POST_NOTIFICATIONS }):andThen(function(arg1)
        return Promise.resolve(arg1.upsellStatus == default.UpsellStatus.SHOW)
    end):catch(function(_)
        return Promise.resolve(false)
    end)
end

local function shouldShowUpsellChat(_: boolean?)
    if userHasRespondedToPushUpsellChat() or userHasRespondedToUpsellPromptLessThanCooldownPeriod() then
        return Promise.resolve(false)
    end

    return shouldShowRationale():andThen(function(arg1)
        if arg1 then
            return (Promise.resolve(true))
        end

        return (Promise.resolve(false))
    end):catch(function(_)
        return Promise.resolve(false)
    end)
end

return {
    OpenModal = function(str1: string, bool3: boolean?, str2: string?, extraEventFields) -- name: openModal
        if not GetFFlagEnablePushNotificationsUpsellModal() then
            return
        end

        if bool3 then
            local function closeCallback()
                if not GetFFlagLuaAppPushUpsellDeprecateOldEvents() then
                    sendEventDeferred(
                        ModalEventConstants.ModalContextPushEduUpsell,
                        ModalEventConstants.OptInPushEventName,
                        {
                            [ModalEventConstants.ActionType] = ModalEventConstants.Closed
                        }
                    )
                end
                default2:logRobloxTelemetryEvent(
                    PushUpsellEventName,
                    {},
                    mergeEventFields({ [ModalEventConstants.ActionType] = ModalEventConstants.Closed }, extraEventFields),
                    ModalEventConstants.ModalContextPushEduUpsell
                )
            end
            local function closeModal()
                NotificationModalsManager.CloseModal(str1)
            end

            if not GetFFlagLuaAppPushUpsellDeprecateOldEvents() then
                sendEventDeferred(
                    ModalEventConstants.ModalContextPushEduUpsell,
                    ModalEventConstants.OptInPushEventName,
                    {
                        [ModalEventConstants.ActionType] = ModalEventConstants.Opened
                    }
                )
            end
            default2:logRobloxTelemetryEvent(
                PushUpsellEventName,
                {},
                mergeEventFields(
                    {
                        [ModalEventConstants.ActionType] = ModalEventConstants.Opened,
                        [ModalEventConstants.EntryPoint] = str2 or ""
                    },
                    extraEventFields
                ),
                ModalEventConstants.ModalContextPushEduUpsell
            )

            if str1 == NotificationsUpsellConstants.ModalKey.PushUpsellHome then
                PushNotificationsUpsellUtils.incrementPushUpsellPromptedCount(
                    AppStorageService,
                    NotificationsUpsellConstants.LocalStorageKeys.PromptShownCount
                )
            elseif str1 == NotificationsUpsellConstants.ModalKey.PushUpsellChat then
                PushNotificationsUpsellUtils.incrementPushUpsellPromptedCount(
                    AppStorageService,
                    NotificationsUpsellConstants.LocalStorageKeys.ChatPromptShownCount
                )
            end

            NotificationModalsManager.OpenModal(str1, PushNotificationsUpsellModal, {
                CloseCallback = closeCallback,
                Props = {
                    CloseModal = closeModal,
                    TranslationKeys = NotificationsUpsellConstants.TranslationKeys[str1],
                    ExtraEventFields = extraEventFields
                },
                DisableBackgroundDismiss = true,
                DisplayOrder = 2,
                Localization = Localization.new(LocalizationService.RobloxLocaleId)
            })
            return
        end

        if not GetFFlagLuaAppPushUpsellDeprecateOldEvents() then
            sendEventDeferred(
                ModalEventConstants.ModalContextSysUpsell,
                ModalEventConstants.OptInPushEventName,
                {
                    [ModalEventConstants.ActionType] = ModalEventConstants.Opened
                }
            )
        end

        default2:logRobloxTelemetryEvent(
            PushUpsellEventName,
            {},
            mergeEventFields(
                {
                    [ModalEventConstants.ActionType] = ModalEventConstants.Opened,
                    [ModalEventConstants.EntryPoint] = str2 or ""
                },
                extraEventFields
            ),
            ModalEventConstants.ModalContextSysUpsell
        )

        if FFlagNotificationsUpsellUseRequestPushPermissionHelper then
            requestPushNotificationPermission():andThen(function()
                if not GetFFlagLuaAppPushUpsellDeprecateOldEvents() then
                    sendEventDeferred(
                        ModalEventConstants.ModalContextSysUpsell,
                        ModalEventConstants.OptInPushEventName,
                        {
                            [ModalEventConstants.ActionType] = ModalEventConstants.RequestSuccess
                        }
                    )
                end
                default2:logRobloxTelemetryEvent(
                    PushUpsellEventName,
                    {},
                    mergeEventFields({ [ModalEventConstants.ActionType] = ModalEventConstants.RequestSuccess }, extraEventFields),
                    ModalEventConstants.ModalContextSysUpsell
                )
            end, function()
                if not GetFFlagLuaAppPushUpsellDeprecateOldEvents() then
                    sendEventDeferred(
                        ModalEventConstants.ModalContextSysUpsell,
                        ModalEventConstants.OptInPushEventName,
                        {
                            [ModalEventConstants.ActionType] = ModalEventConstants.RequestFailed
                        }
                    )
                end
                default2:logRobloxTelemetryEvent(
                    PushUpsellEventName,
                    {},
                    mergeEventFields({ [ModalEventConstants.ActionType] = ModalEventConstants.RequestFailed }, extraEventFields),
                    ModalEventConstants.ModalContextSysUpsell
                )
            end)
            return
        end

        default:requestPermissions({ default.Permissions.POST_NOTIFICATIONS }):andThen(function(_)
            PushNotificationsUpsellUtils.setPushSysUpsellPromptTimestamp(AppStorageService, os.time())
            PushNotificationsUpsellUtils.incrementPushUpsellPromptedCount(
                AppStorageService,
                NotificationsUpsellConstants.LocalStorageKeys.PromptShownCount
            )
            if not GetFFlagLuaAppPushUpsellDeprecateOldEvents() then
                sendEventDeferred(
                    ModalEventConstants.ModalContextSysUpsell,
                    ModalEventConstants.OptInPushEventName,
                    {
                        [ModalEventConstants.ActionType] = ModalEventConstants.RequestSuccess
                    }
                )
            end

            default2:logRobloxTelemetryEvent(
                PushUpsellEventName,
                {},
                mergeEventFields({ [ModalEventConstants.ActionType] = ModalEventConstants.RequestSuccess }, extraEventFields),
                ModalEventConstants.ModalContextSysUpsell
            )
        end, function(_)
            if not GetFFlagLuaAppPushUpsellDeprecateOldEvents() then
                sendEventDeferred(
                    ModalEventConstants.ModalContextSysUpsell,
                    ModalEventConstants.OptInPushEventName,
                    {
                        [ModalEventConstants.ActionType] = ModalEventConstants.RequestFailed
                    }
                )
            end

            default2:logRobloxTelemetryEvent(
                PushUpsellEventName,
                {},
                mergeEventFields({ [ModalEventConstants.ActionType] = ModalEventConstants.RequestFailed }, extraEventFields),
                ModalEventConstants.ModalContextSysUpsell
            )
        end)
    end,
    CloseModal = function(str1: string) -- name: closeModal
        NotificationModalsManager.CloseModal(str1)
    end,
    ShouldShowUpsell = function(str1: string, bool3: boolean?) -- name: shouldShowUpsell
        if not GetFFlagEnablePushNotificationsUpsellModal() then
            return Promise.resolve(false)
        end

        local appFeaturePolicies = getAppFeaturePolicies()
        if not (appFeaturePolicies.getNotificationsCanReceivePush() and appFeaturePolicies.getPushNotificationsUpsell()) then
            return Promise.resolve(false)
        end

        if str1 == NotificationsUpsellConstants.ModalKey.PushUpsellHome then
            return shouldShowUpsellHome(bool3)
        end

        if str1 == NotificationsUpsellConstants.ModalKey.PushUpsellChat then
            return shouldShowUpsellChat(bool3)
        end
    end,
    GetPushNotificationPermissionUpsellStatus = if FFlagPushNotificationsUpsellPassClientAttributesToPrompts then getPushNotificationPermissionUpsellStatus else nil
}
