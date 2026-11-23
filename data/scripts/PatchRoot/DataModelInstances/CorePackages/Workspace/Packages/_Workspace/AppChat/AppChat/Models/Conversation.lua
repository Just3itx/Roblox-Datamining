-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:01:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local GenerateStringId = require(AppChatParent.AppCommonLib).GenerateStringId
local OrderedMap = require(AppChatParent.AppCommonLib).OrderedMap
local Constants = require(AppChat.Constants)
local DateTime = require(AppChatParent.Time).DateTime
local AppChatNetworking = require(AppChatParent.AppChatNetworking)

local Players = game:GetService("Players")

local function getMessageId(arg1)
    return arg1.id
end

local function messageSortPredicate(arg1, arg2): boolean
    return arg1.sent:GetUnixTimestamp() < arg2.sent:GetUnixTimestamp()
end

local function sendingMessageSortPredicate(arg1, arg2): boolean
    return arg1.order < arg2.order
end

local module = {
    Type = {
        MULTI_USER_CONVERSATION = "MultiUserConversation",
        ONE_TO_ONE_CONVERSATION = "OneToOneConversation"
    },
    OsaAcknowledgementStatus = AppChatNetworking.Constants.OsaAcknowledgementStatusResponse,
    UserOptedIntoChatMessagesStatus = AppChatNetworking.Constants.UserOptedIntoChatMessagesStatusResponse
}
function module.IdForFakeOneOnOne(participants: {any}): string
    local oneToOneConversation = module.Type.ONE_TO_ONE_CONVERSATION
    table.sort(participants)
    for _, participant in ipairs(participants) do
        oneToOneConversation ..= "-" .. tostring(participant)
    end
    return oneToOneConversation
end

function module.new()
    return {}
end

function module.fromUser(arg1)
    local module2 = module.new()

    module2.messages = OrderedMap.new(getMessageId, messageSortPredicate)
    module2.sendingMessages = OrderedMap.new(getMessageId, sendingMessageSortPredicate)
    module2.clientId = GenerateStringId()
    module2.initiator = nil
    module2.hasUnreadMessages = false
    module2.conversationType = module.Type.ONE_TO_ONE_CONVERSATION
    module2.participants = { tostring(Players.LocalPlayer.UserId), arg1.id }
    module2.usersTyping = {}
    module2.isUserLeaving = false
    module2.fetchingOlderMessages = false
    module2.fetchedOldestMessage = false
    module2.serverState = Constants.ServerState.NONE

    module2.id = module.IdForFakeOneOnOne(module2.participants)
    module2.lastUpdated = nil

    module2.isDefaultTitle = true

    module2.title = arg1.displayName or arg1.name

    return module2
end

function module.empty(arg1)
    local module2 = module.new()

    module2.id = "-1"
    module2.messages = OrderedMap.new(getMessageId, messageSortPredicate)
    module2.sendingMessages = OrderedMap.new(getMessageId, sendingMessageSortPredicate)
    module2.title = ""
    module2.initiator = "0"
    module2.hasUnreadMessages = false
    module2.conversationType = module.Type.MULTI_USER_CONVERSATION
    module2.participants = {}
    module2.usersTyping = {}
    module2.isUserLeaving = false
    module2.fetchingOlderMessages = false
    module2.serverState = Constants.ServerState.NONE
    module2.pinnedGame = {}

    module2.lastUpdated = DateTime.now()

    module2.isDefaultTitle = true

    module2.osaAcknowledgementStatus = module.OsaAcknowledgementStatus.NotApplicable
    module2.userOptedIntoChatMessages = module.UserOptedIntoChatMessagesStatus.NotApplicable

    if arg1 ~= nil then
        for k, value in pairs(arg1) do
            module2[k] = value
        end
    end

    return module2
end

function module.fromWeb(arg1, clientId)
    local module2 = module.new()

    module2.messages = OrderedMap.new(getMessageId, messageSortPredicate)
    module2.sendingMessages = OrderedMap.new(getMessageId, sendingMessageSortPredicate)
    module2.id = tostring(arg1.id)
    module2.clientId = clientId or GenerateStringId()
    module2.title = arg1.title
    module2.initiator = tostring(arg1.initiator.targetId)
    module2.hasUnreadMessages = arg1.hasUnreadMessages
    module2.conversationType = arg1.conversationType
    module2.participants = {}
    module2.usersTyping = {}
    module2.isUserLeaving = false
    module2.fetchingOlderMessages = false
    module2.serverState = Constants.ServerState.CREATED
    module2.pinnedGame = {}
    if arg1.conversationUniverse ~= nil then
        local pinnedGame = module2.pinnedGame
        pinnedGame.universeId = tostring(arg1.conversationUniverse.universeId)
        local pinnedGame2 = module2.pinnedGame
        pinnedGame2.rootPlaceId = tostring(arg1.conversationUniverse.rootPlaceId)
    end

    module2.lastUpdated = DateTime.fromIsoDate(arg1.lastUpdated)

    module2.titleForViewer = arg1.conversationTitle.titleForViewer
    module2.isDefaultTitle = arg1.conversationTitle.isDefaultTitle

    for _, participant in ipairs(arg1.participants) do
        table.insert(module2.participants, tostring(participant.targetId))
    end

    return module2
end

return module
