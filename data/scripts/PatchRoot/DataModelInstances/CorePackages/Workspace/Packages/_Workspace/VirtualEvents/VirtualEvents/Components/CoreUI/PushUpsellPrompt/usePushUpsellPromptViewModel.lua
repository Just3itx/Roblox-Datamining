-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")
local VirtualEventsParent = VirtualEvents.Parent
local React = require(VirtualEventsParent.React)
local Localization = require(VirtualEventsParent.Localization)
local default = require(VirtualEventsParent.LoggingProtocol).default
local NotificationsUpsell = require(VirtualEventsParent.NotificationsUpsell)
local PermissionsProtocol = require(VirtualEventsParent.PermissionsProtocol).PermissionsProtocol
local MouseIconOverrideService = require(VirtualEventsParent.CoreScriptsCommon).MouseIconOverrideService
local useScreenSize = require(VirtualEventsParent.CoreScriptsRoactCommon).useScreenSize

local fetchInGameRsvpPushUpsell = require(VirtualEvents.Common.fetchInGameRsvpPushUpsell)
local _InGameRsvpPushUpsellTypes = require(VirtualEvents.Common.InGameRsvpPushUpsellTypes)
local _PushUpsellPromptView = require(script.Parent.PushUpsellPromptView)

local ModalEventConstants = NotificationsUpsell.ModalEventConstants
local PushUpsellEventConfig = NotificationsUpsell.PushUpsellEventConfig
local requestPushNotificationPermission = NotificationsUpsell.requestPushNotificationPermission
local useLocalization = Localization.Hooks.useLocalization

local function usePushUpsellPromptViewModel(tbl1)
    local promptData = tbl1.promptData
    local closePrompt = tbl1.closePrompt
    local bool1 = promptData.path == "Settings"

    local screenSize = useScreenSize()
    local var2 = useLocalization({ notNowButton = "Feature.VirtualEvents.NotNowButton" })

    local var3 = React.useCallback(function(tbl2, str1: string)
        local var3 = table.clone(tbl2)
        var3[ModalEventConstants.EntryPoint] = ModalEventConstants.EntryPointInGameRsvp
        local universeId = ModalEventConstants.UniverseId
        var3[universeId] = tostring(game.GameId)
        var3[ModalEventConstants.EventId] = promptData.eventId
        default:logRobloxTelemetryEvent(PushUpsellEventConfig, {}, var3, str1)
    end, { promptData.eventId })

    React.useEffect(function()
        MouseIconOverrideService.push("PushUpsellPromptOverride", Enum.OverrideMouseIconBehavior.ForceShow)
        return function()
            MouseIconOverrideService.pop("PushUpsellPromptOverride")
        end
    end, {})

    React.useEffect(function()
        fetchInGameRsvpPushUpsell.reportImpression(promptData.promptType)
        var3({ [ModalEventConstants.ActionType] = ModalEventConstants.Opened }, ModalEventConstants.ModalContextPushEduUpsell)
    end, {})

    local onConfirm = React.useCallback(function()
        closePrompt()
        var3({
            [ModalEventConstants.ActionType] = ModalEventConstants.Clicked,
            [ModalEventConstants.Button] = ModalEventConstants.Confirm
        }, ModalEventConstants.ModalContextPushEduUpsell)
        if bool1 then
            PermissionsProtocol.default:openNotificationSettings():andThen(function(arg1)
                local status = if typeof(arg1) == "table" then arg1.status else nil
                local var4 = var3
                local tbl2 = {
                    [ModalEventConstants.ActionType] = ModalEventConstants.SettingsOpened
                }
                local settingsResult = ModalEventConstants.SettingsResult

                if typeof(status) ~= "string" then
                    status = PermissionsProtocol.OpenSettingsStatus.FAILED
                end

                tbl2[settingsResult] = status
                var4(tbl2, ModalEventConstants.ModalContextSettingsUpsell)
            end, function()
                var3({
                    [ModalEventConstants.ActionType] = ModalEventConstants.SettingsOpened,
                    [ModalEventConstants.SettingsResult] = PermissionsProtocol.OpenSettingsStatus.FAILED
                }, ModalEventConstants.ModalContextSettingsUpsell)
            end)

            return
        end

        local function logRequestResult(str1: string, arg1)
            local openSettingsStatus = if typeof(arg1) == "table" then arg1.openSettingsStatus else nil

            if typeof(openSettingsStatus) == "string" then
                var3({
                    [ModalEventConstants.ActionType] = ModalEventConstants.SettingsOpened,
                    [ModalEventConstants.SettingsResult] = openSettingsStatus
                }, ModalEventConstants.ModalContextSettingsUpsell)
                return
            end
            var3({ [ModalEventConstants.ActionType] = str1 }, ModalEventConstants.ModalContextSysUpsell)
        end

        var3({ [ModalEventConstants.ActionType] = ModalEventConstants.Opened }, ModalEventConstants.ModalContextSysUpsell)

        requestPushNotificationPermission({ allowOpenSettings = true }):andThen(function(arg1)
            logRequestResult(ModalEventConstants.RequestSuccess, arg1)
        end, function(arg1)
            logRequestResult(ModalEventConstants.RequestFailed, arg1)
        end)
    end, { closePrompt, var3, bool1 })

    local onCancel = React.useCallback(function()
        closePrompt()
        fetchInGameRsvpPushUpsell.reportDismiss(promptData.promptType)
        var3({
            [ModalEventConstants.ActionType] = ModalEventConstants.Clicked,
            [ModalEventConstants.Button] = ModalEventConstants.Cancel
        }, ModalEventConstants.ModalContextPushEduUpsell)
    end, { closePrompt, var3, promptData.promptType })

    local translations = promptData.translations
    return {
        title = translations.title,
        bodyText = translations.body,
        confirmText = translations.confirm,
        cancelText = translations.cancel or var2.notNowButton,
        screenSize = screenSize,
        onConfirm = onConfirm,
        onCancel = onCancel
    }
end

return usePushUpsellPromptViewModel
