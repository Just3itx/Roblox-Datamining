-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:20:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local React = require(AppChatParent.React)
local RealtimeDelivery = require(AppChatParent.RealtimeDelivery)
local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch

local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local ChatModerationStatusRefreshCoordinator = require(AppChat.Stores.ChatModerationStatusRefreshCoordinator)
local getContainsChatSetting = require(AppChat.Utils.getContainsChatSetting)
local partyChatTimeoutReceivedSignal = require(AppChatParent.InterventionShared).Signals.partyChatTimeoutReceivedSignal

local var1 = require(AppChat.Logger):new(script.Name)

local FFlagAppChatReactiveFeatureRestrictions = require(AppChatParent.SharedFlags).FFlagAppChatReactiveFeatureRestrictions

local function AppChatInterventionEventReceiver(_)
    local var2 = useDispatch()

    local var3 = if FFlagAppChatReactiveFeatureRestrictions then React.useMemo(function()
        return ChatModerationStatusRefreshCoordinator.createOwner()
    end, { var2 }) else nil

    RealtimeDelivery.useRealtimeNamespace("UserSettingsChanged", function(arg1)
        if not arg1.SettingsChanged or not getContainsChatSetting(arg1.SettingsChanged) then
            return
        end

        if FFlagAppChatReactiveFeatureRestrictions then
            ChatModerationStatusRefreshCoordinator.enqueue(var3, function()
                return var2(AppChatNetworking.rodux.GetChatModerationStatuses.API())
            end).promise:catch(function(arg2)
                var1:warning("NetworkingChat failure in UserSettingsChanged->GetChatModerationStatuses, Status: " .. tostring(arg2))
            end)

            return
        end

        var2(AppChatNetworking.rodux.GetChatModerationStatuses.API()):catch(function(arg2)
            var1:warning("NetworkingChat failure in UserSettingsChanged->GetChatModerationStatuses, Status: " .. tostring(arg2))
        end)
    end, { if FFlagAppChatReactiveFeatureRestrictions then var3 else var2, var2 })

    React.useEffect(function()
        local connection = partyChatTimeoutReceivedSignal:connect(function(arg1)
            if FFlagAppChatReactiveFeatureRestrictions then
                ChatModerationStatusRefreshCoordinator.enqueue(var3, function()
                    return var2(AppChatNetworking.rodux.GetChatModerationStatuses.API(arg1 and { arg1 } or {}))
                end).promise:catch(function(arg2)
                    var1:warning(
                        "NetworkingChat failure in partyChatTimeoutReceivedSignal->GetChatModerationStatuses, Status: " .. tostring(arg2)
                    )
                end)

                return
            end

            var2(AppChatNetworking.rodux.GetChatModerationStatuses.API(arg1 and { arg1 } or {})):catch(function(arg2)
                var1:warning(
                    "NetworkingChat failure in partyChatTimeoutReceivedSignal->GetChatModerationStatuses, Status: " .. tostring(arg2)
                )
            end)
        end)

        return function()
            if connection then
                connection:disconnect()
            end
            if FFlagAppChatReactiveFeatureRestrictions then
                ChatModerationStatusRefreshCoordinator.cancelOwner(var3)
            end
        end
    end, { if FFlagAppChatReactiveFeatureRestrictions then var3 else var2, var2 })

    return nil
end

return AppChatInterventionEventReceiver
