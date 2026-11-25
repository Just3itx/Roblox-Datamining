-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:40:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local default = require(scriptParentParent.LoggingProtocol).default
local NotificationsCommon = require(scriptParentParent.NotificationsCommon)
local SharedFlags = require(scriptParentParent.SharedFlags)

local ModalEventConstants = require(script.Parent.Analytics.ModalEventConstants)
local PushUpsellEventName = require(script.Parent.Analytics.RobloxTelemetryConfigs.PushUpsellEventName)
local NotificationsUpsellConstants = require(script.Parent.NotificationsUpsellConstants)
local setupPushNotificationsUpsell = require(script.Parent.setupPushNotificationsUpsell)

local FFlagPushNotificationsUpsellHomePromptsExperiment = SharedFlags.FFlagPushNotificationsUpsellHomePromptsExperiment
local bool1 = false

local function isEnabled() -- Luacid: Inlined by compiler; 1 call site recovered
    return FFlagPushNotificationsUpsellHomePromptsExperiment and SharedFlags.FFlagNotificationsUpsellUseRequestPushPermissionHelper
end

local function requestPermission()
    if bool1 then
        return
    end

    bool1 = true
    NotificationsCommon.ixpHelper.logUserLayerExposure(SharedFlags.FStringPushNotificationsUpsellHomePromptsExperimentLayer)

    default:logRobloxTelemetryEvent(
        PushUpsellEventName,
        {},
        {
            [ModalEventConstants.ActionType] = ModalEventConstants.ShouldRequest,
            [ModalEventConstants.EntryPoint] = "Home"
        },
        ModalEventConstants.ModalContextSysUpsell
    )
    setupPushNotificationsUpsell.OpenModal(NotificationsUpsellConstants.ModalKey.PushUpsellHome, false, "Home")
end

return {
    isEnabled = isEnabled,
    handlePromptsResponse = function(arg1)
        if not isEnabled() or type(arg1) ~= "table" then
            return
        end

        local customPrompts = arg1.custom_prompts

        if type(customPrompts) ~= "table" or customPrompts[SharedFlags.FStringPushNotificationsUpsellHomeCustomPromptName] == nil then
            return
        end

        requestPermission()
    end
}
