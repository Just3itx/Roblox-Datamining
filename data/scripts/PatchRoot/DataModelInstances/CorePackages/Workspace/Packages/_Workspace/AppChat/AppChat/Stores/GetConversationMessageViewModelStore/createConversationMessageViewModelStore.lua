-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:10:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Signals = require(AppChatParent.Signals)

local _Types = require(AppChat.MessageData.Types)
local Enums = require(AppChat.MessageData.Enums)
local FFlagAppChatParseMessageTimestampsOnce = require(AppChat.Flags.FFlagAppChatParseMessageTimestampsOnce)
local FFlagAppChatGroupedVariantNeighbourIds = require(AppChat.Flags.FFlagAppChatGroupedVariantNeighbourIds)
local parseIsoDateUnixMillis = require(AppChat.Utils.parseIsoDateUnixMillis)

local _createConversationMessageStore = require(script.Parent.Parent.GetConversationMessageStore.createConversationMessageStore)

local _createConversationMessageListStore = require(script.Parent.Parent.GetConversationMessageListStore.createConversationMessageListStore)

local GroupedMessageVariant = Enums.GroupedMessageVariant
local MessageStatus = Enums.MessageStatus
local MessageType = Enums.MessageType
local MessageVisibility = Enums.MessageVisibility

local function isChatMessage(arg1): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
    return not (arg1 == nil) and arg1.type == MessageType.User
end

local function parseTimestamp(isoDate: string?) -- Luacid: Inlined by compiler; 2 call sites recovered
    if isoDate == nil then
        return nil
    end
    local dateTime = DateTime.fromIsoDate(isoDate)
    return if dateTime then dateTime.UnixTimestamp else nil
end

local function getCreatedAtUnixTimestamp(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local createdAtUnixMillis = arg1.createdAtUnixMillis
    if createdAtUnixMillis == nil then
        createdAtUnixMillis = parseIsoDateUnixMillis(arg1.created_at)
    end
    if createdAtUnixMillis == nil then
        return nil
    end
    return math.floor(createdAtUnixMillis / 1000)
end

local function timeDiffExceedsThreshold(arg1, arg2): boolean
    if arg1 == nil or arg2 == nil then
        return false
    end

    local var1 = if FFlagAppChatParseMessageTimestampsOnce then getCreatedAtUnixTimestamp(arg1) else parseTimestamp(arg1.created_at)
    local var2 = if FFlagAppChatParseMessageTimestampsOnce then getCreatedAtUnixTimestamp(arg2) else parseTimestamp(arg2.created_at)

    if var1 == nil or var2 == nil then
        return false
    end
    return math.abs(var1 - var2) > 300
end

local function isModeratedMessage(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return not (arg1 == nil) and arg1.status == MessageStatus.Moderated
end

local function isHiddenMessage(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return not (arg1 == nil) and arg1.visibility == MessageVisibility.Hidden
end

local function isReplyMessage(arg1): boolean -- Luacid: unused: defined but never referenced
    return not (arg1 == nil) and arg1.replies_to ~= nil
end

local function canGroupWithAdjacent(arg1, arg2): boolean
    local bool1

    if arg2 == nil then
        bool1 = false
    else
        bool1 = isChatMessage(arg2)

        if bool1 then
            if arg2.sender_user_id == arg1.sender_user_id then
                bool1 = not (isHiddenMessage(arg1)
                    or isHiddenMessage(arg2)
                    or isModeratedMessage(arg1)
                    or isModeratedMessage(arg2)
                    or timeDiffExceedsThreshold(arg2, arg1))
            else
                bool1 = false
            end
        end
    end

    return bool1
end

local function computeGroupedVariant(arg1, arg2, arg3)
    if not isChatMessage(arg1) then
        return nil
    end

    local bool1 = canGroupWithAdjacent(arg1, arg2) and not (not (arg2 == nil) and arg2.replies_to ~= nil)
    local bool2 = canGroupWithAdjacent(arg1, arg3) and not (not (arg1 == nil) and arg1.replies_to ~= nil)

    if not (bool1 or bool2) then
        return GroupedMessageVariant.Single
    end

    if bool1 or not bool2 then
        if bool1 and not bool2 then
            return GroupedMessageVariant.First
        end

        return GroupedMessageVariant.Middle
    end

    return GroupedMessageVariant.Last
end

local function createConversationMessageViewModelStore(conversationMessageStore, conversationMessageListStore)
    local tbl1 = ({})

    return {
        conversationMessageStore = conversationMessageStore,
        conversationMessageListStore = conversationMessageListStore,
        getGroupedVariant = function(str1: string, str2: string)
            local tbl2 = tbl1[str2]
            if tbl2 then
                local var1 = tbl2[str1]
                if var1 ~= nil then
                    return var1
                end
            else
                tbl2 = {}
                tbl1[str2] = tbl2
            end

            local computed = Signals.createComputed(function(arg1)
                local var1 = conversationMessageStore.messages(arg1)
                local var2 = var1[str1]
                if var2 == nil then
                    return nil
                end

                if not isChatMessage(var2) then
                    return nil
                end

                if FFlagAppChatGroupedVariantNeighbourIds then
                    local neighbourIds = conversationMessageListStore.getNeighbourIds(str2, str1, arg1)
                    local var3 = if neighbourIds.prevId == nil then nil else var1[neighbourIds.prevId]
                    local var4 = if neighbourIds.nextId == nil then nil else var1[neighbourIds.nextId]
                    return (computeGroupedVariant(var2, var3, var4))
                end

                if conversationMessageListStore.getIndex(str2, str1, arg1) == nil then
                    return GroupedMessageVariant.Single
                end

                local prevId = conversationMessageListStore.getPrevId(str2, str1, arg1)
                local nextId = conversationMessageListStore.getNextId(str2, str1, arg1)
                local var3 = if prevId == nil then nil else var1[prevId]
                local var4 = if nextId == nil then nil else var1[nextId]
                return (computeGroupedVariant(var2, var3, var4))
            end)

            tbl2[str1] = computed
            return computed
        end,
        evictConversation = function(str1: string)
            tbl1[str1] = nil
        end
    }
end
return createConversationMessageViewModelStore
