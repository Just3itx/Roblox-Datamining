-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local AbuseVector = require(AppChatParent.UniversalFeatureRestrictions.AbuseVector)
local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local partyChatTimeoutReceivedSignal = require(AppChatParent.InterventionShared).Signals.partyChatTimeoutReceivedSignal
local React = require(AppChatParent.React)
local showFeatureRestriction = require(AppChatParent.UniversalFeatureRestrictions.showFeatureRestriction)
local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch

local ChatModerationStatusRefreshCoordinator = require(AppChat.Stores.ChatModerationStatusRefreshCoordinator)
local getResponseBody = require(AppChat.Stores.Ingestion.getResponseBody)
local serializeChatTimeoutRange = require(AppChat.Utils.serializeChatTimeoutRange)

local FFlagAppChatReactiveFeatureRestrictions = require(AppChatParent.SharedFlags).FFlagAppChatReactiveFeatureRestrictions

local var1 = require(AppChat.Logger):new(script.Name)

local function usePartyChatReactiveFeatureRestriction(bool1: boolean)
    local var2 = useDispatch()

    React.useEffect(function()
        if not (FFlagAppChatReactiveFeatureRestrictions and bool1) then
            return nil
        end

        local bool2 = false

        local owner = ChatModerationStatusRefreshCoordinator.createOwner()
        local var3 = ChatModerationStatusRefreshCoordinator.enqueue(owner, function()
            return var2(AppChatNetworking.rodux.GetChatModerationStatuses.API())
        end)

        var3.promise:andThen(function(arg1)
            local responseBody = getResponseBody(arg1)
            local userTimeoutRange = if responseBody then responseBody.user_timeout_range else nil
            local var4 = if userTimeoutRange then serializeChatTimeoutRange(userTimeoutRange) else nil

            if bool2
                or not ChatModerationStatusRefreshCoordinator.isLatestGeneration(var3.generation)
                or var4 == nil
                or var4.requiresAcknowledgement ~= true
            then
                return
            end
            showFeatureRestriction(AbuseVector.PartyChat, {
                onAcknowledgementSuccess = function()
                    partyChatTimeoutReceivedSignal:fire(nil)
                end
            })
        end):catch(function()
            var1:warning("Failed to refresh Party Chat moderation status on entry")
        end)

        return function()
            bool2 = true
            ChatModerationStatusRefreshCoordinator.cancelOwner(owner)
        end
    end, { var2, bool1 })
end

return usePartyChatReactiveFeatureRestriction
