-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local AppChat = require(FriendsChatParent.AppChat)
local AppChatNetworking = require(FriendsChatParent.AppChatNetworking)
local ConversationChannels = require(FriendsChatParent.AppChat.ConversationChannels)
local createConversationFromFriendPlaceholder = require(FriendsChatParent.AppChat.createConversationFromFriendPlaceholder)
local fetchConversationDetailsToSignals = require(FriendsChatParent.AppChat.fetchConversationDetailsToSignals)
local fetchConversationListPageToSignals = require(FriendsChatParent.AppChat.fetchConversationListPageToSignals)
local getConversationTitle = require(FriendsChatParent.AppChat.getConversationTitle)
local GetConversationStore = require(FriendsChatParent.AppChat.GetConversationStore)
local logger = AppChat.Components.ChatConversation.logger

local function getConversationStore() -- Luacid: Inlined by compiler; 4 call sites recovered
    return GetConversationStore(false)
end

local function getMessageTimestamp(arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
    if type(arg1.created_at) == "string" then
        local success, result = pcall(function(): DateTime
            return DateTime.fromIsoDate(arg1.created_at)
        end)
        if success then
            return result
        end
    end

    return nil
end

local function getUnixTime(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    if arg1 == nil then
        return nil
    elseif typeof(arg1) == "DateTime" then
        return arg1.UnixTimestamp
    elseif type(arg1) == "table" and arg1.GetUnixTimestamp ~= nil then
        return arg1:GetUnixTimestamp()
    end
    return nil
end

local function getPreviewContent(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    return arg1.preview_content or arg1.content
end

local function getMessageUnixTime(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local messageTimestamp = getMessageTimestamp(arg1)
    return if messageTimestamp == nil then nil else messageTimestamp.UnixTimestamp
end

local function isPreviewableMessage(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not (arg1 == nil or arg1.id == nil or arg1.is_previewable ~= true) and getPreviewContent(arg1) ~= nil
end

local function getNewestPreviewableMessage(tbl1)
    local var1 = nil
    local var2 = nil
    for _, value in tbl1 do
        if not isPreviewableMessage(value) then
            continue
        end

        local messageUnixTime = getMessageUnixTime(value)

        if var1 == nil or messageUnixTime ~= nil and (var2 == nil or var2 < messageUnixTime) then
            var2 = messageUnixTime
            var1 = value
        end
    end

    return var1
end

local function shouldUpdatePreview(conversation, dateTime): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    if dateTime == nil then
        return true
    end

    local unixTime = getUnixTime(conversation.lastUpdated)
    return unixTime == nil or unixTime <= dateTime.UnixTimestamp
end

local function isUnreadCandidateMessage(arg1, tbl1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1 == nil or arg1.is_badgeable ~= true then
        return false
    end
    local senderUserId = arg1.sender_user_id
    return not (senderUserId == nil)
        and (tbl1 == nil or tbl1.localUserId == nil or tostring(senderUserId) ~= tostring(tbl1.localUserId))
end

local function hasNewerUnreadMessage(tbl1, tbl2)
    if tbl2 == nil or tbl2.hasUnreadMessages ~= true then
        return false
    end

    local unixTime = getUnixTime(tbl2.unreadFreshnessLastUpdated) or 0

    for _, value in tbl1 do
        if not isUnreadCandidateMessage(value, tbl2) then
            continue
        end

        local messageUnixTime = getMessageUnixTime(value)

        if messageUnixTime ~= nil and unixTime < messageUnixTime then
            return true
        end
    end
    return false
end

return {
    ConversationSource = ConversationChannels.Source,
    createConversationFromFriendPlaceholder = createConversationFromFriendPlaceholder,
    fetchConversationDetailsToSignals = fetchConversationDetailsToSignals,
    fetchConversationListPageToSignals = fetchConversationListPageToSignals,
    getConversationStore = getConversationStore,
    getConversationTitle = getConversationTitle,
    isFriendPlaceholder = function(str1: string?, arg1): boolean
        if str1 == nil or str1 == "" then
            return false
        end

        local var1 = getConversationStore().getConversation(str1, arg1 or false)

        if var1 == nil then
            return string.sub(str1, 1, 8) == "friends:"
        end

        return var1.source == ConversationChannels.Source.Friends
    end,
    markConversationRead = function(str1: string, bool1: boolean?)
        local conversationStore = getConversationStore()

        local conversation = conversationStore.getConversation(str1, false)
        local bool2 = bool1 == true
        if conversation == nil then
            if not bool2 then
                return
            end
        elseif conversation.hasUnreadMessages == true then
            local var1 = table.clone(conversation)
            var1.hasUnreadMessages = false
            conversationStore.upsertConversation(var1, false)
            bool2 = true
        end

        if bool2 then
            return AppChatNetworking.http.MarkConversationRead(nil, str1):catch(function(arg1)
                logger:warning(`Failed to mark conversation read for {str1}: {tostring(arg1)}`)
            end)
        end
    end,
    removeConversation = function(str1: string)
        getConversationStore().removeConversation(str1)
    end,
    updateConversationPreviewFromMessages = function(str1: string, tbl1, tbl2)
        local conversationStore = getConversationStore()

        local conversation = conversationStore.getConversation(str1, false)
        if conversation == nil then
            if tbl2 ~= nil and tbl2.refreshListOnMissingConversation == true then
                fetchConversationListPageToSignals():catch(function(arg1)
                    logger:warning(`Failed to refresh conversation list after realtime update: {tostring(arg1)}`)
                end)
            end

            return false, (hasNewerUnreadMessage(tbl1, tbl2))
        end

        local var1 = nil

        local newestPreviewableMessage = getNewestPreviewableMessage(tbl1)
        if newestPreviewableMessage ~= nil then
            local lastUpdated = getMessageTimestamp(newestPreviewableMessage)

            if shouldUpdatePreview(conversation, lastUpdated) then
                var1 = table.clone(conversation)
                local id = newestPreviewableMessage.id
                var1.previewMessageId = tostring(id)
                var1.previewContent = getPreviewContent(newestPreviewableMessage)
                var1.lastUpdated = lastUpdated or DateTime.now()
            end
        end

        local bool1 = hasNewerUnreadMessage(tbl1, tbl2)
        if conversation.hasUnreadMessages ~= true and bool1 then
            var1 = var1 or table.clone(conversation)
            var1.hasUnreadMessages = true
        end

        if var1 == nil then
            return false, bool1
        end

        conversationStore.upsertConversation(var1, false)
        return true, bool1
    end
}
