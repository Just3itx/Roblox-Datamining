-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:30:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local _types = require(AppChat.types)
local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)

local MessageContextMenu = require(script.Parent.MessageContextMenu)

local useLocalUserId = require(AppChatParent.RobloxAppHooks).useLocalUserId
local useGetConversationFromId = require(AppChat.Hooks.useGetConversationFromId)

local tbl1 = { messageId = "", conversationId = "", inputBoxRef = nil }

function MessageContextMenuContainer(tbl2)
    local var1 = Cryo.Dictionary.union(tbl1, tbl2)

    local var2 = useGetConversationFromId(var1.conversationId)
    local message = if var2 and var2.messages then var2.messages:Get(var1.messageId) else nil
    local var4 = useLocalUserId()

    if not message then
        return nil
    end

    local userOwnsMessage = message.senderTargetId == var4

    return React.createElement(
        MessageContextMenu,
        Cryo.Dictionary.union(var1, { message = message, userOwnsMessage = userOwnsMessage })
    )
end
return React.memo(MessageContextMenuContainer)
