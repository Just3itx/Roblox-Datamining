-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:11:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Rodux = require(CorePackages.Packages.Rodux)

local scriptParentParent = script.Parent.Parent
if require(scriptParentParent.Flags.FFlagTopBarDeprecateChatRodux) then
    return nil
end

local Actions = script.Parent.Parent.Actions
local UpdateChatMessages = require(Actions.UpdateChatMessages)
local UpdateUnreadMessagesBadge = require(Actions.UpdateUnreadMessagesBadge)
local UpdateChatVisible = require(Actions.UpdateChatVisible)
local SetCanChat = require(Actions.SetCanChat)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[UpdateUnreadMessagesBadge.name] = function(arg1, arg2): {canChat: any, lastReadMessages: number, unreadMessages: any, visible: boolean} | {canChat: any, lastReadMessages: number, unreadMessages: number, visible: boolean}
    return if arg1.visible then {
        canChat = arg1.canChat,
        visible = true,
        lastReadMessages = 0,
        unreadMessages = 0
    } else {
        canChat = arg1.canChat,
        visible = false,
        lastReadMessages = 0,
        unreadMessages = arg2.messages
    }
end

tbl1[UpdateChatMessages.name] = function(arg1, arg2)
    if arg1.visible then
        return {
            canChat = arg1.canChat,
            visible = true,
            lastReadMessages = arg2.messages,
            unreadMessages = 0
        }
    end

    return {
        canChat = arg1.canChat,
        visible = false,
        lastReadMessages = arg1.lastReadMessages,
        unreadMessages = arg2.messages - arg1.lastReadMessages
    }
end

tbl1[UpdateChatVisible.name] = function(arg1, arg2)
    if arg2.visible then
        return {
            canChat = arg1.canChat,
            visible = true,
            lastReadMessages = arg1.lastReadMessages + arg1.unreadMessages,
            unreadMessages = 0
        }
    end

    return {
        canChat = arg1.canChat,
        visible = false,
        lastReadMessages = arg1.lastReadMessages,
        unreadMessages = arg1.unreadMessages
    }
end

tbl1[SetCanChat.name] = function(arg1, arg2)
    return {
        canChat = arg2.canChat,
        visible = arg1.visible,
        lastReadMessages = arg1.lastReadMessages,
        unreadMessages = arg1.unreadMessages
    }
end

return (createReducer({ canChat = false, visible = true, lastReadMessages = 0, unreadMessages = 0 }, tbl1))
