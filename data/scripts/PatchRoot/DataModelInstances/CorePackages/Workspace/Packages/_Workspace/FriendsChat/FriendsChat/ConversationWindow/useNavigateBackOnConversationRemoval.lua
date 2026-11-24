-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:10:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local React = require(FriendsChatParent.React)
local Signals = require(FriendsChatParent.Signals)
local SignalsReact = require(FriendsChatParent.SignalsReact)

local ExpChatConversationListAdapter = require(script.Parent.Parent.ConversationList.ExpChatConversationListAdapter)

local function useNavigateBackOnConversationRemoval(tbl1)
    local conversationId = tbl1.conversationId
    local onBack = tbl1.onBack

    local conversationStore = ExpChatConversationListAdapter.getConversationStore()
    local var1 = React.useMemo(function()
        return Signals.createComputed(function(arg1): boolean
            return conversationStore.getConversation(conversationId, arg1) ~= nil
        end)
    end, { conversationStore, conversationId })
    local var2 = SignalsReact.useSignalState(var1)

    local var3 = React.useRef(false)
    React.useEffect(function()
        var3.current = false
    end, { conversationId })
    React.useEffect(function()
        if var2 then
            var3.current = true
        elseif var3.current and onBack then
            var3.current = false
            onBack()
        end
    end, { var2, onBack })
end

return useNavigateBackOnConversationRemoval
