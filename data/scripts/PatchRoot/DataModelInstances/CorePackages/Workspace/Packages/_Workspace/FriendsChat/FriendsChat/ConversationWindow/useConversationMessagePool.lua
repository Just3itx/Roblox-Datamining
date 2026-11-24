-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local React = require(FriendsChatParent.React)
local Signals = require(FriendsChatParent.Signals)

local GetConversationMessageListStore = require(FriendsChatParent.AppChat.GetConversationMessageListStore)
local GetConversationStore = require(FriendsChatParent.AppChat.GetConversationStore)

local useMessagePool = require(FriendsChatParent.ChatUIPrimitives).useMessagePool
local useMessageDisplayStore = require(script.Parent.Parent.Message.MessageDisplayStore.useMessageDisplayStore)
local FriendsChatTextMessage = require(script.Parent.Parent.Message.FriendsChatTextMessage)
local FriendsChatOsaSystemMessage = require(script.Parent.FriendsChatOsaSystemMessage)
local getOsaParticipantUserId = require(script.Parent.getOsaParticipantUserId)
local useLocalize = require(script.Parent.Parent.Utils.useLocalize)

local element = React.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder })

local function useConversationMessagePool(tbl1)
    local conversationId = tbl1.conversationId
    local shouldReadMessages = tbl1.shouldReadMessages

    local var1 = React.useMemo(function()
        return if shouldReadMessages then function(arg1)
            return GetConversationMessageListStore(arg1).getOrderedIds(conversationId, arg1)
        end else function()
            return {}
        end
    end, { conversationId, shouldReadMessages })

    local localize = useLocalize()

    local var3 = useMessageDisplayStore(var1, conversationId)

    local createSlotElement = React.useCallback(function(arg1)
        return React.createElement(FriendsChatTextMessage, {
            getDisplayId = arg1.getMessageId,
            getDisplayFromId = var3.getDisplayFromId,
            getMessageIdFromDisplayId = var3.getMessageIdFromDisplayId,
            getLayoutOrder = arg1.getLayoutOrder,
            chatWindowSettings = tbl1.chatWindowSettings,
            textTransparency = tbl1.textTransparency,
            isSpatialUIEnabled = tbl1.isSpatialUIEnabled,
            localize = localize
        })
    end, {
        var3,
        tbl1.chatWindowSettings,
        tbl1.textTransparency,
        tbl1.isSpatialUIEnabled,
        localize
    })

    local var5 = useMessagePool({ messageIdsSignal = var3.getDisplayIds, createSlotElement = createSlotElement, maxSlots = 50 })

    return (React.useMemo(function()
        return Signals.createComputed(function(arg1)
            local var6 = table.clone(var5(arg1))
            var6["$layout"] = element
            local var7 = GetConversationStore(arg1).getConversation(conversationId, arg1)
            local userId = getOsaParticipantUserId(var7)
            if userId then
                var6[`osa-system-message-{conversationId}`] = React.createElement(FriendsChatOsaSystemMessage, {
                    conversationId = conversationId,
                    userId = userId,
                    chatWindowSettings = tbl1.chatWindowSettings,
                    textTransparency = tbl1.textTransparency,
                    isSpatialUIEnabled = tbl1.isSpatialUIEnabled,
                    localize = localize
                })
            end
            return var6
        end)
    end, {
        var5,
        conversationId,
        tbl1.chatWindowSettings,
        tbl1.textTransparency,
        tbl1.isSpatialUIEnabled,
        localize
    }))
end
return useConversationMessagePool
