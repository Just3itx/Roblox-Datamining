-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:31:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStorageService = game:GetService("AppStorageService")

local scriptParentParentParent = script.Parent.Parent.Parent

local React = require(scriptParentParentParent.React)
local ReactRoblox = require(scriptParentParentParent.ReactRoblox)
local UIBlox = require(scriptParentParentParent.UIBlox)
local default = require(scriptParentParentParent.PermissionsProtocol).PermissionsProtocol.default
local default2 = require(scriptParentParentParent.LoggingProtocol).default

local useState = React.useState
local useCallback = React.useCallback
local useLocalization = require(scriptParentParentParent.Localization).Hooks.useLocalization
local sendEventDeferred = require(scriptParentParentParent.NotificationsCommon).sendEventDeferred
local ModalEventConstants = require(script.Parent.Parent.Analytics.ModalEventConstants)
local PushUpsellEventName = require(script.Parent.Parent.Analytics.RobloxTelemetryConfigs.PushUpsellEventName)
local PushNotificationsUpsellUtils = require(script.Parent.Parent.Util.PushNotificationsUpsellUtils)
local mergeEventFields = require(script.Parent.Parent.Util.mergeEventFields)

local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType

local GetFFlagLuaAppPushUpsellDeprecateOldEvents = require(scriptParentParentParent.SharedFlags).GetFFlagLuaAppPushUpsellDeprecateOldEvents

return function(arg1)
    local var1 = useLocalization(arg1.TranslationKeys)
    local onActivated = useCallback(function()
        PushNotificationsUpsellUtils.setPushEduUpsellResponse(AppStorageService, "Deny")
        PushNotificationsUpsellUtils.setPushEduUpsellResponseTimestamp(AppStorageService, os.time())
        if not GetFFlagLuaAppPushUpsellDeprecateOldEvents() then
            sendEventDeferred(ModalEventConstants.ModalContextPushEduUpsell, ModalEventConstants.OptInPushEventName, {
                [ModalEventConstants.ActionType] = ModalEventConstants.Clicked,
                [ModalEventConstants.Button] = ModalEventConstants.Cancel
            })
        end

        default2:logRobloxTelemetryEvent(
            PushUpsellEventName,
            {},
            mergeEventFields({
                [ModalEventConstants.ActionType] = ModalEventConstants.Clicked,
                [ModalEventConstants.Button] = ModalEventConstants.Cancel
            }, arg1.ExtraEventFields),
            ModalEventConstants.ModalContextPushEduUpsell
        )
        arg1.CloseModal()
    end, { arg1.CloseModal, arg1.ExtraEventFields })

    local var2 = useCallback(function()
        if not GetFFlagLuaAppPushUpsellDeprecateOldEvents() then
            sendEventDeferred(ModalEventConstants.ModalContextPushEduUpsell, ModalEventConstants.OptInPushEventName, {
                [ModalEventConstants.ActionType] = ModalEventConstants.Clicked,
                [ModalEventConstants.Button] = ModalEventConstants.Confirm
            })
        end

        default2:logRobloxTelemetryEvent(
            PushUpsellEventName,
            {},
            mergeEventFields({
                [ModalEventConstants.ActionType] = ModalEventConstants.Clicked,
                [ModalEventConstants.Button] = ModalEventConstants.Confirm
            }, arg1.ExtraEventFields),
            ModalEventConstants.ModalContextPushEduUpsell
        )

        PushNotificationsUpsellUtils.setPushEduUpsellResponse(AppStorageService, "Allow")
        PushNotificationsUpsellUtils.setPushEduUpsellResponseTimestamp(AppStorageService, os.time())

        default2:logRobloxTelemetryEvent(
            PushUpsellEventName,
            {},
            mergeEventFields({
                [ModalEventConstants.ActionType] = ModalEventConstants.Opened,
                [ModalEventConstants.EntryPoint] = "LuaPushUpsellModal"
            }, arg1.ExtraEventFields),
            ModalEventConstants.ModalContextSysUpsell
        )

        default:requestPermissions({ default.Permissions.POST_NOTIFICATIONS }):andThen(function(_)
            PushNotificationsUpsellUtils.setPushSysUpsellPromptTimestamp(AppStorageService, os.time())
            if not GetFFlagLuaAppPushUpsellDeprecateOldEvents() then
                sendEventDeferred(
                    ModalEventConstants.ModalContextSysUpsell,
                    ModalEventConstants.OptInPushEventName,
                    {
                        [ModalEventConstants.ActionType] = ModalEventConstants.Opened
                    }
                )
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
                mergeEventFields({ [ModalEventConstants.ActionType] = ModalEventConstants.RequestSuccess }, arg1.ExtraEventFields),
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
                mergeEventFields({ [ModalEventConstants.ActionType] = ModalEventConstants.RequestFailed }, arg1.ExtraEventFields),
                ModalEventConstants.ModalContextSysUpsell
            )
        end)

        arg1.CloseModal()
    end, { arg1.CloseModal, arg1.ExtraEventFields, var1 })

    local screenSize, var5 = useState(Vector2.new(800, 600))
    local var6 = useCallback(function(arg2)
        var5(arg2.AbsoluteSize)
    end, { var5 })

    return React.createElement(
        "Frame",
        {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            [ReactRoblox.Change.AbsoluteSize] = var6
        },
        {
            ConfirmationPrompt = React.createElement(InteractiveAlert, {
                screenSize = screenSize,
                title = var1.Heading,
                bodyText = var1.Body,
                richText = true,
                buttonStackInfo = {
                    buttons = {
                        {
                            props = {
                                onActivated = onActivated,
                                text = var1.CancelAction
                            },
                            isDefaultChild = true
                        },
                        {
                            buttonType = ButtonType.PrimarySystem,
                            props = {
                                onActivated = var2,
                                text = var1.ConfirmAction
                            },
                            isDefaultChild = false
                        }
                    }
                }
            })
        }
    )
end
