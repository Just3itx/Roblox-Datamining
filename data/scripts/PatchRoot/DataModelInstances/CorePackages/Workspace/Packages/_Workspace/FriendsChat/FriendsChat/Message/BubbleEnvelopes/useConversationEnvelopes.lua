-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:20:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local React = require(FriendsChatParent.React)
local GetConversationMessageListStore = require(FriendsChatParent.AppChat.GetConversationMessageListStore)

local FIntFriendsChatBubbleMaxMessages = require(script.Parent.Parent.Parent.Flags.FIntFriendsChatBubbleMaxMessages)
local createGetIsGroup = require(script.Parent.Parent.MessageDisplayStore.createGetIsGroup)
local useLocalize = require(script.Parent.Parent.Parent.Utils.useLocalize)
local createConversationEnvelopes = require(script.Parent.createConversationEnvelopes)

local function useConversationEnvelopes(tbl1)
    local conversationId = tbl1.conversationId
    local shouldReadMessages = tbl1.shouldReadMessages
    local localize = useLocalize()

    return React.useMemo(function()
        return createConversationEnvelopes.create(function(arg1) -- name: getMessageIds
            if not shouldReadMessages then
                return {}
            end
            return GetConversationMessageListStore(arg1).getOrderedIds(conversationId, arg1)
        end, {
            localize = localize,
            maxMessages = FIntFriendsChatBubbleMaxMessages,
            getIsGroup = createGetIsGroup(conversationId)
        })
    end, { conversationId, shouldReadMessages, localize })
end

return useConversationEnvelopes
