-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local GenerateStringId = require(AppChatParent.AppCommonLib).GenerateStringId
local OrderedMap = require(AppChatParent.AppCommonLib).OrderedMap
local Constants = require(AppChat.Constants)
local DateTime = require(AppChatParent.Time).DateTime

local Conversation = require(script.Parent.Conversation)

local function getMessageId(arg1)
    return arg1.id
end

local function messageSortPredicate(arg1, arg2): boolean
    return arg1.sent:GetUnixTimestamp() < arg2.sent:GetUnixTimestamp()
end

local function sendingMessageSortPredicate(arg1, arg2): boolean
    return arg1.order < arg2.order
end

local module = {}
module.__index = module

function module.mock(tbl1)
    local conversation = Conversation.new()

    conversation.messages = OrderedMap.new(getMessageId, messageSortPredicate)
    conversation.sendingMessages = OrderedMap.new(getMessageId, sendingMessageSortPredicate)
    conversation.id = GenerateStringId()

    conversation.clientId = GenerateStringId()
    conversation.title = ""
    conversation.initiator = GenerateStringId()
    conversation.hasUnreadMessages = false
    conversation.conversationType = Conversation.Type.MULTI_USER_CONVERSATION
    conversation.participants = {}
    conversation.usersTyping = {}
    conversation.isUserLeaving = false
    conversation.fetchingOlderMessages = false
    conversation.fetchedOldestMessage = false
    conversation.serverState = Constants.ServerState.NONE
    conversation.pinnedGame = {}
    conversation.pinnedGame.universeId = GenerateStringId()
    conversation.pinnedGame.rootPlaceId = GenerateStringId()

    conversation.lastUpdated = DateTime.now()

    conversation.titleForViewer = "title"
    conversation.isDefaultTitle = true

    if tbl1 ~= nil then
        for k, value in pairs(tbl1) do
            conversation[k] = value
        end
    end

    setmetatable(conversation, { __index = Conversation })

    return conversation
end

return module
