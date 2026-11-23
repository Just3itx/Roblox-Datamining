-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:41:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local useSignalState = require(AppChatParent.SignalsReact).useSignalState
local Cryo = require(AppChatParent.Cryo)
local Signals = require(AppChatParent.Signals)
local SignalsExperimental = require(AppChatParent.SignalsExperimental)
local DateTime = require(AppChatParent.Time).DateTime

local filterForLinksWithPolicy = require(AppChat.Components.ChatConversation.Utils.filterForLinksWithPolicy)
local populateMessageWithState = require(AppChat.Conversations.populateMessageWithState)
local GetConversationMessageViewModelStore = require(AppChat.Stores.GetConversationMessageViewModelStore)
local _Types = require(AppChat.MessageData.Types)
local Enums = require(AppChat.MessageData.Enums)
local FFlagAppChatPerfTracking = require(AppChat.Flags.FFlagAppChatPerfTracking)
local FFlagAppChatMessageTTIMilestones = require(AppChat.Flags.FFlagAppChatMessageTTIMilestones)
local FFlagAppChatIncrementalMessageItemList = require(AppChat.Flags.FFlagAppChatIncrementalMessageItemList)
local FFlagAppChatParseMessageTimestampsOnce = require(AppChat.Flags.FFlagAppChatParseMessageTimestampsOnce)
local FFlagAppChatFixMessageItemListStaleRefs = require(AppChat.Flags.FFlagAppChatFixMessageItemListStaleRefs)
local FFlagAppChatMessageItemListCurrentOnSwitch = require(AppChat.Flags.FFlagAppChatMessageItemListCurrentOnSwitch)
local AppChatPerfTracker = require(AppChat.Telemetry.AppChatPerfTracker)
local MessageStatus = Enums.MessageStatus
local MessageType = Enums.MessageType

local function toLuaDateTime(createdAt: string?) -- Luacid: Inlined by compiler; 7 call sites recovered
    if createdAt == nil or createdAt == "" then
        return nil
    end
    local success, result = pcall(function()
        return DateTime.fromIsoDate(createdAt)
    end)
    return if success then result else nil
end

local function toLuaDateTimeFromMessage(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    local createdAtUnixMillis = arg1.createdAtUnixMillis
    if createdAtUnixMillis == nil then
        return toLuaDateTime(arg1.created_at)
    end
    return DateTime.fromUnixTimestampMillis(createdAtUnixMillis)
end

local function buildLegacyRepliesTo(arg1, tbl1)
    local repliesTo = arg1.replies_to
    if repliesTo == nil then
        return nil
    end

    local var1 = tbl1[repliesTo.id]
    if var1 ~= nil then
        return Cryo.Dictionary.join(var1, {
            senderTargetId = tostring(var1.sender_user_id),
            sent = if FFlagAppChatParseMessageTimestampsOnce then toLuaDateTimeFromMessage(var1) else toLuaDateTime(var1.created_at),
            messageType = if var1.type == MessageType.System then "System" else "PlainText"
        })
    end

    return {
        id = repliesTo.id,
        content = repliesTo.content,
        messageType = if repliesTo.type == MessageType.System then "System" else "PlainText",
        senderTargetId = tostring(repliesTo.sender_user_id),
        sent = if FFlagAppChatParseMessageTimestampsOnce then toLuaDateTimeFromMessage(repliesTo) else toLuaDateTime(repliesTo.created_at)
    }
end

local function toLegacyMessage(arg1, tbl1)
    local str1 = if arg1.type == MessageType.System then "System" else "PlainText"
    return Cryo.Dictionary.join(arg1, {
        senderTargetId = tostring(arg1.sender_user_id),
        senderType = arg1.type,
        messageType = arg1.messageType or str1,
        sent = if FFlagAppChatParseMessageTimestampsOnce then toLuaDateTimeFromMessage(arg1) else toLuaDateTime(arg1.created_at),
        moderationType = arg1.moderation_type,
        moderated = arg1.status == MessageStatus.Moderated,
        failed = arg1.status == MessageStatus.Failed,
        isSending = arg1.status == MessageStatus.Pending,
        filteredForReceivers = arg1.filtered_for_receivers,
        contentToDisplay = arg1.content_to_display,
        repliesTo = buildLegacyRepliesTo(arg1, tbl1)
    })
end

local function applyGroupedVariant(arg1, str1: string?) -- Luacid: Inlined by compiler; 1 call site recovered
    if str1 == nil then
        return arg1
    end

    local groupedMessageVariant = Enums.GroupedMessageVariant
    if str1 == groupedMessageVariant.Single then
        arg1.isNewSender = true
        arg1.isLastMessageInMessageGroup = true
        return arg1
    end

    if str1 == groupedMessageVariant.First then
        arg1.isNewSender = true
        arg1.isLastMessageInMessageGroup = false
        return arg1
    end

    if str1 == groupedMessageVariant.Middle then
        arg1.isNewSender = false
        arg1.isLastMessageInMessageGroup = false
        return arg1
    end

    if str1 == groupedMessageVariant.Last then
        arg1.isNewSender = false
        arg1.isLastMessageInMessageGroup = true
    end

    return arg1
end

local function buildPopulatedMessage(arg1, str1: string?, arg2, arg3, arg4, users, localUserId: string, num1: number)
    local var1 = populateMessageWithState(
        { Users = users, LocalUserId = localUserId },
        arg1,
        arg1.id,
        arg4,
        arg2,
        arg1.isSending == true,
        arg3
    )
    applyGroupedVariant(var1, str1)
    var1.stable_key = `{var1.stableKey or var1.messageId}_{num1}`
    return var1
end

local function buildMessageRows(arg1, arg2, arg3, str1: string?, arg4, users, localUserId: string)
    local var1 = filterForLinksWithPolicy(arg1)
    local var2 = table.create(#var1)
    for value, value2 in var1 do
        local var3 = var1[value + 1] or arg2
        local var4 = if #var1 == 1 then str1 else nil
        arg3 = buildPopulatedMessage(value2, var4, arg3, var3, arg4, users, localUserId, value)

        table.insert(var2, arg3)
    end

    return var2
end

local function buildMessageItemList(tbl1, tbl2, func1: (...any) -> (...any), arg1, users, localUserId: string)
    if #tbl1 == 0 or arg1 == nil then
        return {}
    end

    local var1 = Cryo.List.filterMap(tbl1, function(arg2)
        local var1 = tbl2[arg2]
        if var1 == nil then
            return nil
        end
        return toLegacyMessage(var1, tbl2)
    end)

    local tbl3 = {}
    local var2 = nil

    for i = #var1, 1, -1 do
        local var3 = var1[i]
        local var4 = if i > 1 then var1[i - 1] else nil
        local messageRows = buildMessageRows(var3, var4, var2, func1(var3.id), arg1, users, localUserId)

        for _, messageRow in messageRows do
            table.insert(tbl3, messageRow)
        end
        var2 = messageRows[#messageRows] or var2
    end

    return Cryo.List.reverse(tbl3)
end

local function createIncrementalMessageItemList()
    local tbl1 = {}
    local tbl2 = {}
    local num1 = 0
    local id = nil
    local conversationType = nil
    local currentLocalUserId = nil

    return function(tbl3, tbl4, func1: (...any) -> (...any), arg1, users, localUserId: string)
        if #tbl3 == 0 or arg1 == nil then
            tbl1 = {}
            num1 = 0
            if #tbl2 > 0 then
                tbl2 = {}
            end
            return tbl2
        end

        if arg1.id ~= id or arg1.conversationType ~= conversationType or localUserId ~= currentLocalUserId then
            tbl1 = {}
            id = arg1.id
            conversationType = arg1.conversationType
            currentLocalUserId = localUserId
        end

        local tbl5 = {}
        for _, value in tbl3 do
            local var1 = tbl4[value]
            if var1 ~= nil then
                table.insert(tbl5, var1)
            end
        end

        local function getReplyTarget(message) -- Luacid: Inlined by compiler; 4 call sites recovered
            if message.replies_to == nil then
                return nil
            end

            return tbl4[message.replies_to.id]
        end

        local tbl6 = {}
        local function getLegacyMessage(message) -- Luacid: Inlined by compiler; 2 call sites recovered
            local var1 = tbl6[message.id]
            if var1 ~= nil then
                return var1
            end
            local var2 = tbl1[message.id]
            local var3 = if var2 ~= nil and var2.message == message and var2.replyTarget == getReplyTarget(message) then var2.legacyMessage else toLegacyMessage(message, tbl4)
            tbl6[message.id] = var3
            return var3
        end

        local tbl7 = {}
        local bool1 = false
        local var1 = nil
        local num2 = 0

        for i = #tbl5, 1, -1 do
            local message = tbl5[i]
            local olderMessage = tbl5[i + 1]
            local newerMessage = tbl5[i - 1]
            local replyTarget = getReplyTarget(message)
            local groupedVariant = func1(message.id)
            local bool2 = not (users == nil) and users[tostring(message.sender_user_id)] ~= nil
            local showsOldestDateTime = olderMessage == nil and arg1.fetchedOldestMessage == true
            local tbl8 = tbl1[message.id]
            if tbl8 == nil
                or tbl8.message ~= message
                or tbl8.replyTarget ~= replyTarget
                or tbl8.olderMessage ~= olderMessage
                or tbl8.newerMessage ~= newerMessage
                or tbl8.groupedVariant ~= groupedVariant
                or tbl8.hasSender ~= bool2
                or tbl8.showsOldestDateTime ~= showsOldestDateTime
            then
                bool1 = true
                local legacyMessage = getLegacyMessage(message)
                local legacyMessage2 = if newerMessage == nil then nil else getLegacyMessage(newerMessage)
                tbl8 = {
                    message = message,
                    replyTarget = replyTarget,
                    legacyMessage = legacyMessage,
                    olderMessage = olderMessage,
                    newerMessage = newerMessage,
                    groupedVariant = groupedVariant,
                    hasSender = bool2,
                    showsOldestDateTime = showsOldestDateTime,
                    rows = buildMessageRows(legacyMessage, legacyMessage2, var1, groupedVariant, arg1, users, localUserId)
                }
            end

            tbl7[message.id] = tbl8
            num2 += #tbl8.rows
            var1 = tbl8.rows[#tbl8.rows] or var1
        end

        tbl1 = tbl7
        if not bool1 and #tbl5 == num1 then
            return tbl2
        end
        num1 = #tbl5

        local var2 = table.create(num2)
        for _, value in tbl5 do
            local rows = tbl7[value.id].rows
            for i = #rows, 1, -1 do
                table.insert(var2, rows[i])
            end
        end
        tbl2 = var2
        return var2
    end
end

local function isSameItemListConversation(arg1, arg2): boolean
    if arg1 == nil or arg2 == nil then
        return arg1 == arg2
    end

    return arg1.id == arg2.id
        and arg1.fetchedOldestMessage == arg2.fetchedOldestMessage
        and arg1.conversationType == arg2.conversationType
end

local function isSameUserIdSet(tbl1, tbl2)
    for value in tbl1 do
        if not tbl2[value] then
            return false
        end
    end
    for value in tbl2 do
        if not tbl1[value] then
            return false
        end
    end
    return true
end

local function useItemListInputs(str1: string?, current, current2, arg1)
    local conversationMessageStore = arg1.conversationMessageStore
    local conversationMessageListStore = arg1.conversationMessageListStore

    local var1 = React.useMemo(function()
        local getConversation, setConversation = Signals.createSignal(current, isSameItemListConversation)
        local getUsers, setUsers = Signals.createSignal(current2)

        return {
            getConversation = getConversation,
            setConversation = setConversation,
            getUsers = getUsers,
            setUsers = setUsers,
            getKnownSenderIds = Signals.createComputed(function(arg2)
                local result = ({})
                local var5 = getUsers(arg2)
                if str1 == nil or var5 == nil then
                    return result
                end
                local var6 = conversationMessageStore.messages(arg2)
                for _, value in conversationMessageListStore.getOrderedIds(str1, arg2) do
                    local var7 = var6[value]
                    if var7 == nil then
                        continue
                    end

                    local str2 = tostring(var7.sender_user_id)
                    if var5[str2] ~= nil then
                        result[str2] = true
                    end
                end

                return result
            end, isSameUserIdSet)
        }
    end, { str1, conversationMessageStore, conversationMessageListStore })

    React.useLayoutEffect(function()
        SignalsExperimental.batch(function()
            var1.setConversation(current)
            var1.setUsers(current2)
        end)
    end, { var1, current, current2 })

    return var1
end

return {
    useMessageItemList = function(conversationId: string?, current, str2: string?, current2)
        local var1 = React.useMemo(function()
            return GetConversationMessageViewModelStore(false)
        end, {})
        local conversationMessageStore = var1.conversationMessageStore
        local conversationMessageListStore = var1.conversationMessageListStore

        local var2 = React.useRef(current2)
        var2.current = current2
        local var3 = React.useRef(current)
        var3.current = current

        local var4 = if FFlagAppChatFixMessageItemListStaleRefs then useItemListInputs(conversationId, current2, current, var1) else nil

        local var5 = React.useMemo(function()
            if conversationId == nil then
                return Signals.createComputed(function()
                    return {}
                end)
            end

            local func1 = if FFlagAppChatIncrementalMessageItemList then createIncrementalMessageItemList() else buildMessageItemList

            return Signals.createComputed(function(arg1)
                local orderedIds = conversationMessageListStore.getOrderedIds(conversationId, arg1)
                local var5 = conversationMessageStore.messages(arg1)
                local str3 = tostring(str2 or "")

                local current3 = var2.current
                local current4 = var3.current
                if FFlagAppChatFixMessageItemListStaleRefs then
                    local var6 = var4
                    current3 = var6.getConversation(arg1)
                    var6.getKnownSenderIds(arg1)
                    current4 = var6.getUsers(false)
                end

                if current3 == nil then
                    return {}
                end

                local var6 = FFlagAppChatPerfTracking
                    and FFlagAppChatMessageTTIMilestones
                    and AppChatPerfTracker.isActive(AppChatPerfTracker.Events.ChatConversationTTI, { conversationId = conversationId })

                if var6 then
                    local tbl1 = { conversationId = conversationId }
                    AppChatPerfTracker.trackMilestone(
                        AppChatPerfTracker.Events.ChatConversationTTI,
                        AppChatPerfTracker.Milestone.DataProcessingStarted.Name,
                        tbl1
                    )

                    AppChatPerfTracker.trackSubphase(
                        AppChatPerfTracker.Events.ChatConversationTTI,
                        AppChatPerfTracker.Milestone.DataProcessingStarted.Name,
                        AppChatPerfTracker.Milestone.DataProcessingStarted.Subphase.DataUpdate,
                        tbl1
                    )
                end

                local var7 = func1(orderedIds, var5, function(arg2)
                    return var1.getGroupedVariant(arg2, conversationId)(arg1)
                end, current3, current4, str3)

                if var6 then
                    local tbl1 = { conversationId = conversationId }
                    AppChatPerfTracker.trackMilestone(
                        AppChatPerfTracker.Events.ChatConversationTTI,
                        AppChatPerfTracker.Milestone.DataProcessingCompleted.Name,
                        tbl1
                    )

                    AppChatPerfTracker.trackSubphase(
                        AppChatPerfTracker.Events.ChatConversationTTI,
                        AppChatPerfTracker.Milestone.DataProcessingCompleted.Name,
                        AppChatPerfTracker.Milestone.DataProcessingCompleted.Subphase.DataUpdate,
                        tbl1
                    )
                end

                return var7
            end)
        end, {
            conversationId,
            str2,
            var1,
            conversationMessageStore,
            conversationMessageListStore,
            var4
        })

        if not FFlagAppChatMessageItemListCurrentOnSwitch then
            return useSignalState(var5)
        end

        useSignalState(var5)
        return var5(false)
    end,
    buildMessageItemList = buildMessageItemList,
    createIncrementalMessageItemList = createIncrementalMessageItemList
}
