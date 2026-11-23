-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:40:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local Signals = require(AppChatParent.Signals)
local SignalsReact = require(AppChatParent.SignalsReact)

local GetConversationListStore = require(AppChat.Stores.GetConversationListStore)

local tbl1 = { oldestConversationIsFetched = false, isFetchingConversations = false }

local function useConversationList(bool1: boolean?)
    local conversationListStore = GetConversationListStore(false)
    local bool2 = bool1 ~= false

    local var1 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            if not bool2 then
                return {}
            end

            return conversationListStore.getConversations(arg1)
        end)
    end, { conversationListStore, bool2 })

    local var2 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            if not bool2 then
                return tbl1
            end

            return conversationListStore.getListStatus(arg1)
        end)
    end, { conversationListStore, bool2 })

    return {
        items = SignalsReact.useSignalState(var1),
        listStatus = SignalsReact.useSignalState(var2)
    }
end

return useConversationList
