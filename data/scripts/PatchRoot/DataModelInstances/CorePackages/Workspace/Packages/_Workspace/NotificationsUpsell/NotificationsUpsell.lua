-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:31:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local FFlagChatPushUpsellPromptsEnabled = require(script.Parent.SharedFlags).FFlagChatPushUpsellPromptsEnabled

return {
    ["jest.config"] = script["jest.config"],
    setupNotificationsUpsell = require(script.setupNotificationsUpsell),
    setupPushNotificationsUpsell = require(script.setupPushNotificationsUpsell),
    NotificationsUpsellConstants = require(script.NotificationsUpsellConstants),
    ModalEventConstants = require(script.Analytics.ModalEventConstants),
    PushUpsellEventConfig = require(script.Analytics.RobloxTelemetryConfigs.PushUpsellEventName),
    requestPushNotificationPermission = require(script.requestPushNotificationPermission),
    NativePushNotificationPermissionPrompt = require(script.NativePushNotificationPermissionPrompt),
    ChatPushUpsellLegacyPrompt = if FFlagChatPushUpsellPromptsEnabled then require(script.ChatPushUpsellLegacyPrompt) else nil,
    PushPermissionClientAttributes = require(script.PushPermissionClientAttributes.buildPushPermissionClientAttributes),
    usePushPermissionClientAttributes = require(script.PushPermissionClientAttributes.usePushPermissionClientAttributes)
}
