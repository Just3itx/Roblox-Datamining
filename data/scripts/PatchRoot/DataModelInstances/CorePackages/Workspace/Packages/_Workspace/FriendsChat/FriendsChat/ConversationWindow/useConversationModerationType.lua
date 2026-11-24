-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:01:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local React = require(FriendsChatParent.React)
local Signals = require(FriendsChatParent.Signals)
local SignalsReact = require(FriendsChatParent.SignalsReact)

local ConversationChannels = require(FriendsChatParent.AppChat.ConversationChannels)
local ExpChatConversationListAdapter = require(script.Parent.Parent.ConversationList.ExpChatConversationListAdapter)

local function toConversationModerationType(moderationType: string?): string? -- Luacid: Inlined by compiler; 1 call site recovered
    return if moderationType == ConversationChannels.ModerationType.TrustedComms
        or moderationType == ConversationChannels.ModerationType.Moderated
        or moderationType == ConversationChannels.ModerationType.Invalid
        or moderationType == ConversationChannels.ModerationType.UnknownType then moderationType else nil
end

local function useConversationModerationType(tbl1)
    local conversationId = tbl1.conversationId
    local hasConversationId = tbl1.hasConversationId

    local conversationStore = ExpChatConversationListAdapter.getConversationStore()
    local var1 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            if not hasConversationId then
                return nil
            end
            local conversation = conversationStore.getConversation(conversationId, arg1)
            if conversation == nil then
                return nil
            end
            return toConversationModerationType(conversation.moderationType)
        end)
    end, { conversationStore, conversationId, hasConversationId })

    return (SignalsReact.useSignalState(var1))
end

return useConversationModerationType
