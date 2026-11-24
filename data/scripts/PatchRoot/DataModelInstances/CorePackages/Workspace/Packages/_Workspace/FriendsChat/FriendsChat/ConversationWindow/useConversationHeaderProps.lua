-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local Cryo = require(FriendsChatParent.Cryo)
local React = require(FriendsChatParent.React)
local Signals = require(FriendsChatParent.Signals)
local SignalsReact = require(FriendsChatParent.SignalsReact)

local ExpChatConversationListAdapter = require(script.Parent.Parent.ConversationList.ExpChatConversationListAdapter)
local getFriendsChatHeaderProps = require(script.Parent.Parent.HeaderBar.getFriendsChatHeaderProps)

local function areSelectedHeaderFieldsEqual(tbl1, tbl2): boolean
    if tbl1 == tbl2 then
        return true
    end
    if tbl1 == nil or tbl2 == nil then
        return false
    end

    return tbl1.title == tbl2.title
        and tbl1.titleForViewer == tbl2.titleForViewer
        and Cryo.List.equals(tbl1.participants or {}, tbl2.participants or {})
end

local function useConversationHeaderProps(tbl1)
    local conversationId = tbl1.conversationId
    local hasConversationId = tbl1.hasConversationId
    local localUserId = tbl1.localUserId

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

            return {
                title = conversation.title,
                titleForViewer = conversation.titleForViewer,
                participants = conversation.participants
            }
        end, areSelectedHeaderFieldsEqual)
    end, { conversationStore, conversationId, hasConversationId })
    local var2 = SignalsReact.useSignalState(var1)

    return React.useMemo(function()
        if var2 == nil then
            return nil
        end
        return getFriendsChatHeaderProps(var2, localUserId)
    end, { var2, localUserId })
end

return useConversationHeaderProps
