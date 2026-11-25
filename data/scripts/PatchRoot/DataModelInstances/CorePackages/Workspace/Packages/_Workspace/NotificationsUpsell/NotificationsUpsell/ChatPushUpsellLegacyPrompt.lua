-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local default = require(scriptParentParent.LoggingProtocol).default
local React = require(scriptParentParent.React)
local SharedFlags = require(scriptParentParent.SharedFlags)
local Signals = require(scriptParentParent.Signals)
local createSessionScopedSignal = require(scriptParentParent.SignalsUtils).createSessionScopedSignal

local ModalEventConstants = require(script.Parent.Analytics.ModalEventConstants)
local PushUpsellEventName = require(script.Parent.Analytics.RobloxTelemetryConfigs.PushUpsellEventName)
local NotificationsUpsellConstants = require(script.Parent.NotificationsUpsellConstants)
local setupPushNotificationsUpsell = require(script.Parent.setupPushNotificationsUpsell)

local tbl1 = {
    [ModalEventConstants.EntryPoint] = ModalEventConstants.EntryPointChat,
    [ModalEventConstants.Variant] = ModalEventConstants.VariantLegacy
}

local var1, var2 = createSessionScopedSignal(false)

local var3, var4 = createSessionScopedSignal(false)

local function openLegacyUpsell() -- Luacid: Inlined by compiler; 1 call site recovered
    local pushUpsellChat = NotificationsUpsellConstants.ModalKey.PushUpsellChat
    setupPushNotificationsUpsell.ShouldShowUpsell(pushUpsellChat):andThen(function(arg1)
        if not arg1 then
            return
        end
        default:logRobloxTelemetryEvent(PushUpsellEventName, {}, {
            [ModalEventConstants.ActionType] = ModalEventConstants.ShouldRequest,
            [ModalEventConstants.EntryPoint] = ModalEventConstants.EntryPointChat,
            [ModalEventConstants.Variant] = ModalEventConstants.VariantLegacy
        }, ModalEventConstants.ModalContextPushEduUpsell)
        setupPushNotificationsUpsell.OpenModal(pushUpsellChat, true, ModalEventConstants.EntryPointChat, tbl1)
    end)
end

return {
    handlePromptsResponse = function(arg1)
        if var1(false) or type(arg1) ~= "table" then
            return
        end

        local customPrompts = arg1.custom_prompts

        if type(customPrompts) ~= "table" or customPrompts[SharedFlags.FStringChatPushUpsellLegacyCustomPromptName] == nil then
            return
        end

        var2(true)
        var4(true)
    end,
    useOpenPendingLegacyUpsell = function()
        React.useEffect(function()
            return Signals.createEffect(function(arg1)
                if var3(arg1) then
                    var4(false)
                    openLegacyUpsell()
                end
            end)
        end, {})
    end
}
