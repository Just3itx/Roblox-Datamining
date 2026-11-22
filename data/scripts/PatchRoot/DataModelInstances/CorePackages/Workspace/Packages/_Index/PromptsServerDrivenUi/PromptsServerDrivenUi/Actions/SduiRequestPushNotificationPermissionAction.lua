-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:50:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PromptsServerDrivenUiParent = script:FindFirstAncestor("PromptsServerDrivenUi").Parent

local requestPushNotificationPermission = require(PromptsServerDrivenUiParent.NotificationsUpsell).requestPushNotificationPermission
local default = require(PromptsServerDrivenUiParent.LoggingProtocol).default
local SduiErrorType = require(PromptsServerDrivenUiParent.SduiCoreSystem).SduiErrors.SduiErrorType
local ModalEventConstants = require(PromptsServerDrivenUiParent.NotificationsUpsell).ModalEventConstants
local PushUpsellEventConfig = require(PromptsServerDrivenUiParent.NotificationsUpsell).PushUpsellEventConfig

local FFlagPushPermissionRequestOpensAndroidSettings = require(PromptsServerDrivenUiParent.SharedFlags).FFlagPushPermissionRequestOpensAndroidSettings

local function getOpenSettingsStatus(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return if typeof(arg1) == "table" and typeof(arg1.openSettingsStatus) == "string" then arg1.openSettingsStatus else nil
end

local function logRequestResult(source: string, str1: string, arg1)
    local openSettingsStatus = getOpenSettingsStatus(arg1)

    if openSettingsStatus ~= nil then
        default:logRobloxTelemetryEvent(PushUpsellEventConfig, {}, {
            [ModalEventConstants.ActionType] = ModalEventConstants.SettingsOpened,
            [ModalEventConstants.EntryPoint] = source,
            [ModalEventConstants.SettingsResult] = openSettingsStatus
        }, ModalEventConstants.ModalContextSettingsUpsell)
        return
    end
    default:logRobloxTelemetryEvent(
        PushUpsellEventConfig,
        {},
        {
            [ModalEventConstants.ActionType] = str1,
            [ModalEventConstants.EntryPoint] = source
        },
        ModalEventConstants.ModalContextSysUpsell
    )
end
return function(arg1, _, arg2, _)
    local source = (arg1 and arg1.actionParams or {}).source
    if source ~= nil and type(source) ~= "string" then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = "RequestPushNotificationPermission",
                message = "Invalid source",
                propName = "source"
            },
            arg2.appPage
        )
        return
    end

    local var1 = source or "SDUI"
    default:logRobloxTelemetryEvent(
        PushUpsellEventConfig,
        {},
        {
            [ModalEventConstants.ActionType] = ModalEventConstants.Opened,
            [ModalEventConstants.EntryPoint] = var1
        },
        ModalEventConstants.ModalContextSysUpsell
    )
    if FFlagPushPermissionRequestOpensAndroidSettings then
        requestPushNotificationPermission({ allowOpenSettings = true }):andThen(function(arg3)
            logRequestResult(var1, ModalEventConstants.RequestSuccess, arg3)
        end, function(arg3)
            logRequestResult(var1, ModalEventConstants.RequestFailed, arg3)
        end)

        return
    end

    requestPushNotificationPermission():andThen(function()
        default:logRobloxTelemetryEvent(
            PushUpsellEventConfig,
            {},
            {
                [ModalEventConstants.ActionType] = ModalEventConstants.RequestSuccess
            },
            ModalEventConstants.ModalContextSysUpsell
        )
    end, function()
        default:logRobloxTelemetryEvent(
            PushUpsellEventConfig,
            {},
            {
                [ModalEventConstants.ActionType] = ModalEventConstants.RequestFailed
            },
            ModalEventConstants.ModalContextSysUpsell
        )
    end)
end
