-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:31:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local Signals = require(AppChatParent.Signals)
local SignalsReact = require(AppChatParent.SignalsReact)
local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch

local _ConversationChannels = require(AppChat.Models.ConversationChannels)
local fetchLatestConversationDetails = require(AppChat.Conversations.Thunks.fetchLatestConversationDetails)
local useGetConversationFromId = require(AppChat.Hooks.useGetConversationFromId)
local ConversationRoduxSeed = require(AppChat.Utils.ConversationRoduxSeed)

local FFlagFriendsCallingClientGate_DEV = require(AppChatParent.SharedFlags).FFlagFriendsCallingClientGate_DEV
local FFlagAppChatConversationStore = require(AppChat.Flags.FFlagAppChatConversationStore)
local GetConversationStore = if FFlagAppChatConversationStore then require(AppChat.Stores.GetConversationStore) else nil

local function useCallButtonEligibility(id: string?)
    local var1

    if FFlagFriendsCallingClientGate_DEV then
        if FFlagAppChatConversationStore then
            local var2 = React.useMemo(function()
                return Signals.createComputed(function(arg1)
                    if id then
                        return (GetConversationStore(false).getConversation(id, arg1))
                    end

                    return nil
                end)
            end, { id or false })

            var1 = SignalsReact.useSignalState(var2)
        else
            var1 = useGetConversationFromId(id)
        end
    else
        var1 = nil
    end

    if var1 == nil or var1.id ~= id then
        var1 = nil
    end

    local var2 = ConversationRoduxSeed.isFriendsPlaceholderConversationId(id)
    local callButtonEligibility = if var1 and not var2 then var1.callButtonEligibility else nil
    local var3 = useDispatch()

    React.useEffect(function()
        if FFlagFriendsCallingClientGate_DEV and id and not var2 and callButtonEligibility == nil then
            var3(fetchLatestConversationDetails(id))
        end
    end, {
        var3,
        id or false,
        callButtonEligibility or false,
        var2
    })
    return callButtonEligibility
end

return useCallButtonEligibility
