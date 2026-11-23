-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:31:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)
local DateTime = require(AppChatParent.Time).DateTime

local ConversationChannels = require(AppChat.Models.ConversationChannels)

local module = {}

local function hasIteratorMember(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return type(arg1) == "table" and arg1.CreateIterator ~= nil
end

function module.isFriendsPlaceholderConversationId(arg1): boolean
    return type(arg1) == "string" and string.sub(arg1, 1, 8) == "friends:"
end

function module.isFriendsPlaceholderConversation(arg1, arg2)
    if arg2 ~= nil then
        return arg2.source == ConversationChannels.Source.Friends
    end
    return module.isFriendsPlaceholderConversationId(arg1)
end

function module.normalizeStoreConversationForRodux(arg1)
    local lastUpdated = arg1.lastUpdated
    local unixTimestamp = nil
    if typeof(lastUpdated) == "DateTime" then
        unixTimestamp = DateTime.fromUnixTimestamp(lastUpdated.UnixTimestamp)
    elseif type(lastUpdated) == "table" and typeof(lastUpdated.dateTime) == "DateTime" then
        unixTimestamp = DateTime.fromUnixTimestamp(lastUpdated.dateTime.UnixTimestamp)
    end

    local messages = if hasIteratorMember(arg1.messages) then arg1.messages else ConversationChannels.getEmptyMessages()
    local sendingMessages = if hasIteratorMember(arg1.sendingMessages) then arg1.sendingMessages else ConversationChannels.getEmptySendingMessages()

    if unixTimestamp == nil and messages == arg1.messages and sendingMessages == arg1.sendingMessages then
        return arg1
    end

    return Cryo.Dictionary.join(
        arg1,
        {
            lastUpdated = unixTimestamp or lastUpdated,
            messages = messages,
            sendingMessages = sendingMessages
        }
    )
end
return module
