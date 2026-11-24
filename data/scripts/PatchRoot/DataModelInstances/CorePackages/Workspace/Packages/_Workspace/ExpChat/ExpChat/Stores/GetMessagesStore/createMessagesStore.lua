-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:31:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Signals = require(ExpChatParent.Signals)
local SignalsExperimental = require(ExpChatParent.SignalsExperimental)
local SharedFlags = require(ExpChatParent.SharedFlags)
local isWhiteSpaceOnly = require(ExpChat.isWhiteSpaceOnly)

local GetChatConfigurationStore = require(ExpChat.Stores.GetChatConfigurationStore)
local computeNameColor = require(ExpChatParent.ChatUIPrimitives).Utils.computeNameColor
local _TextChatMessageChatActionType = require(ExpChat.TextChatMessageChatActionType)
local ExpChatShared = require(ExpChat.Parent.ExpChatShared)
local shouldRenderTextChannelInDefaultWindow = ExpChatShared.shouldRenderTextChannelInDefaultWindow
local getTextChannelDisplayMode = ExpChatShared.getTextChannelDisplayMode
local getTextAndTranslation = require(ExpChat.getTextAndTranslation)
local getServerTimeNowMillis = require(ExpChat.BubbleChat.Helpers.getServerTimeNowMillis)
local Config = require(ExpChat.Config)
local sanitizeForRichText = require(ExpChat.sanitizeForRichText)
local generateRichSystemMessageTextFormat = require(ExpChat.generateRichSystemMessageTextFormat)

local TextChatService = game:GetService("TextChatService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local llama = require(ExpChatParent.llama)
local List = llama.List
local Dictionary = llama.Dictionary
local Set = llama.Set

local createSignal = Signals.createSignal
local createComputed = Signals.createComputed
local createProxy = SignalsExperimental.createProxy
local FFlagExpChatUseChatConfigStore = SharedFlags.FFlagExpChatUseChatConfigStore
local FFlagEnableInExpChatRewrite = require(ExpChat.Flags.FFlagEnableInExpChatRewrite)
local FFlagEnableInExpChatSummaryOnLua = require(ExpChat.Flags.FFlagEnableInExpChatSummaryOnLua)
local FIntExpChatRandomCharChangeLowerBound = require(ExpChat.Flags.FIntExpChatRandomCharChangeLowerBound)
local FIntExpChatRandomCharChangeUpperBound = require(ExpChat.Flags.FIntExpChatRandomCharChangeUpperBound)
local getFFlagExpChatTelemetryEventTrigger = require(ExpChat.Flags.getFFlagExpChatTelemetryEventTrigger)

local FFlagExpChatClearHiddenMessagesPostAgeCheck = require(ExpChat.Flags.FFlagExpChatClearHiddenMessagesPostAgeCheck)
local FFlagExpChatEnableV2ChatWindow = require(ExpChat.Flags.FFlagExpChatEnableV2ChatWindow)
local GetFFlagTextChatEnableUniverseChatTabs = ExpChatShared.Flags.GetFFlagTextChatEnableUniverseChatTabs
local FFlagExpChatDisableUniverseBubbleChat = ExpChatShared.Flags.FFlagExpChatDisableUniverseBubbleChat
local isGlobalBubbleChatEnabled = require(ExpChat.isGlobalBubbleChatEnabled)
local FFlagExpChatGlobalTabDefault = require(ExpChat.Flags.FFlagExpChatGlobalTabDefault)
local GetFFlagExpChatSyntheticSystemMessageRichText = ExpChatShared.Flags.GetFFlagExpChatSyntheticSystemMessageRichText

local FFlagExpChatMessagesStoreKeepInByMessageId = require(ExpChat.Flags.FFlagExpChatMessagesStoreKeepInByMessageId)
local FFlagExpChatPresetChatEnabled = ExpChatShared.Flags.FFlagExpChatPresetChatEnabled
local getFFlagExpChatProtectedChatInternalAPIs = SharedFlags.getFFlagExpChatProtectedChatInternalAPIs
local FFlagExpChatDictation = SharedFlags.FFlagExpChatDictation
local FFlagExpChatMessagesStoreBatch = require(ExpChat.Flags.FFlagExpChatMessagesStoreBatch)
local FFlagExpChatMessagesStoreUseProxy = require(ExpChat.Flags.FFlagExpChatMessagesStoreUseProxy)
local FFlagExpChatMessagesStoreMemoryCleanup = require(ExpChat.Flags.FFlagExpChatMessagesStoreMemoryCleanup)

local FFlagExpChatEvictFloodcheckedFromWindowOrder = require(ExpChat.Flags.FFlagExpChatEvictFloodcheckedFromWindowOrder)
local FFlagExpChatFixLocalUserVerifiedBadge = require(ExpChat.Flags.FFlagExpChatFixLocalUserVerifiedBadge)
local isBorderlessBubbleChatEnabled = require(ExpChat.isBorderlessBubbleChatEnabled)

local ExpChatPresetChatEmojiEffectExperimentation = require(ExpChatParent.SocialExperiments).ExpChatPresetChatEmojiEffectExperimentation
local logPresetChatEmojiEffectExposure = require(ExpChat.PresetChat.logPresetChatEmojiEffectExposure)
local FFlagExpChatRenderHistoricalMessages = require(ExpChat.Flags.FFlagExpChatRenderHistoricalMessages)
local FFlagExpChatMessageHistoryExperiment = SharedFlags.FFlagExpChatMessageHistoryExperiment
local ExpChatMessageHistoryExperimentation = require(ExpChatParent.SocialExperiments).ExpChatMessageHistoryExperimentation

function getChatTranslationEnabled(): boolean
    return TextChatService.ChatTranslationEnabled
end

local function createMessagesStore(arg1)
    local tbl1 = {
        canLocalUserChat = false,
        isBubbleChatEnabled = false,
        mutedUserIds = {},
        messageLimit = 50,
        windowMessagesInOrder = {},
        windowMessagesInOrderByTabId = {},
        byMessageId = {},
        mockUserIdToPartOrModel = {},
        partOrModelToMockUserId = {},
        messagesBySenderId = {},
        messageComponentRingBuffer = {},
        nextMessageComponentPointer = 1
    }

    local var1, var2 = createSignal(tbl1.byMessageId)
    local proxy = if FFlagExpChatMessagesStoreUseProxy then createProxy({}) else nil
    local var3, var4 = createSignal(tbl1.messagesBySenderId)
    local proxy2 = if FFlagExpChatMessagesStoreUseProxy then createProxy({}) else nil
    local getWindowMessagesInOrder, var6 = createSignal(tbl1.windowMessagesInOrder)

    local getWindowMessagesInOrderByTabId, var8 = createSignal(tbl1.windowMessagesInOrderByTabId)
    local var9, var10 = createSignal(tbl1.mutedUserIds)

    local getMutedUserIds = if arg1 == nil then var9 else createComputed(function(arg2)
        local var11 = var9(arg2)
        local var12 = arg1(arg2)
        local var13 = table.clone(var11)
        for value in var12 do
            var13[value] = true
        end
        return var13
    end)

    local getCanLocalUserChat, setCanLocalUserChat = createSignal(tbl1.canLocalUserChat)
    local getIsBubbleChatEnabled, _ = createSignal(tbl1.isBubbleChatEnabled)
    local getMockUserIdToPartOrModel, var16 = createSignal(tbl1.mockUserIdToPartOrModel)
    local getPartOrModelToMockUserId, var18 = createSignal(tbl1.partOrModelToMockUserId)

    local getChannelTabsConfigurationEnabled, setChannelTabsConfigurationEnabled = createSignal(false)

    local getMessageComponentRingBuffer, var22 = createSignal(tbl1.messageComponentRingBuffer)

    local getNextMessageComponentPointer, var24 = createSignal(tbl1.nextMessageComponentPointer)

    local tbl2 = ({})

    local num1 = 0
    local num2 = 0

    local tbl3 = ({})

    local getActiveChannelFilter, setActiveChannelFilter = createSignal(nil)

    local updateNextMessageComponent = nil
    local repopulateMessageComponents = nil
    local bool1 = false
    local bool2 = false

    local tbl4 = ({})

    local function readByMessageId() -- Luacid: Inlined by compiler; 21 call sites recovered
        if FFlagExpChatMessagesStoreUseProxy then
            return proxy
        end
        return var1(false)
    end

    local function readByMessageIdReactive(arg2) -- Luacid: Inlined by compiler; 5 call sites recovered
        if FFlagExpChatMessagesStoreUseProxy then
            return proxy(arg2)
        end
        return var1(arg2)
    end

    local function writeByMessageId(str1: string, tbl5) -- Luacid: Inlined by compiler; 18 call sites recovered
        if FFlagExpChatMessagesStoreUseProxy then
            proxy[str1] = tbl5
            return
        end

        if tbl5 ~= nil then
            var2(function(arg2)
                return Dictionary.join(arg2, { [str1] = tbl5 })
            end)
        else
            var2(function(arg2)
                return Dictionary.removeKey(arg2, str1)
            end)
        end
    end

    local function updateByMessageId(str1: string, func1: (...any) -> (...any)) -- Luacid: unused: defined but never referenced
        if FFlagExpChatMessagesStoreUseProxy then
            local var27 = proxy[str1]
            if var27 then
                local var28 = func1(var27)
                if var28 then
                    proxy[str1] = var28
                end
            end

            return
        end

        var2(function(arg2)
            if not (arg2 and arg2[str1]) then
                return arg2 or {}
            end
            local var27 = func1(arg2[str1])
            if var27 then
                return Dictionary.join(arg2, { [str1] = var27 })
            end
            return arg2
        end)
    end

    local function forEachByMessageId(func1: (...any) -> (...any))
        if FFlagExpChatMessagesStoreUseProxy then
            for value in proxy do
                local var27 = proxy[value]
                if not var27 then
                    continue
                end

                local var28 = func1(value, var27)
                if var28 then
                    proxy[value] = var28
                end
            end

            return
        end

        var2(function(arg2)
            if not arg2 then
                return {}
            end
            local result = ({})
            for value, value2 in arg2 do
                result[value] = func1(value, value2) or value2
            end
            return result
        end)
    end

    local function readMessagesBySenderIdReactive(arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
        if FFlagExpChatMessagesStoreUseProxy then
            return proxy2(arg2)
        end
        return var3(arg2)
    end

    local function writeMessagesBySenderId(str1: string, arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
        if FFlagExpChatMessagesStoreUseProxy then
            proxy2[str1] = arg2
            return
        end

        if arg2 ~= nil then
            var4(function(arg3)
                return Dictionary.join(arg3, { [str1] = arg2 })
            end)
        else
            var4(function(arg3)
                return Dictionary.removeKey(arg3, str1)
            end)
        end
    end

    local function updateMessagesBySenderId(userId: string, func1: (...any) -> (...any)) -- Luacid: Inlined by compiler; 24 call sites recovered
        if FFlagExpChatMessagesStoreUseProxy then
            proxy2[userId] = func1(proxy2[userId])
            return
        end
        var4(function(arg2)
            local var27 = func1(arg2[userId])
            if var27 == nil then
                return Dictionary.removeKey(arg2, userId)
            end
            return Dictionary.join(arg2, { [userId] = var27 })
        end)
    end

    local function resolveChannelNameForMapOrder(tbl5, channelNameOverride: string?)
        if GetFFlagTextChatEnableUniverseChatTabs() then
            return channelNameOverride
                or (if tbl5.textChannel then if tbl5.textChannel.Name == "RBXSystem" or not getChannelTabsConfigurationEnabled(false) then "RBXGeneral" else tbl5.textChannel.Name else nil)
        end

        if tbl5.textChannel then
            if tbl5.textChannel.Name == "RBXSystem" then
                return "RBXGeneral"
            end

            return tbl5.textChannel.Name
        end

        return nil
    end

    local function maybeBatch(callback: (...any) -> (...any)) -- Luacid: Inlined by compiler; 13 call sites recovered
        if FFlagExpChatMessagesStoreBatch then
            SignalsExperimental.batch(callback)
            return
        end
        callback()
    end

    local function batchWrites(callback: (...any) -> (...any))
        if bool1 then
            maybeBatch(callback)
            return
        end

        bool1 = true
        bool2 = false
        maybeBatch(callback)
        bool1 = false

        if bool2 then
            bool2 = false
            repopulateMessageComponents()
        end
    end

    local function isHistoricalWindowMessage(str1: string): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
        local var27 = readByMessageId()
        local var28 = var27 and var27[str1]
        return not (var28 == nil) and var28.isHistorical == true
    end

    local function countHistoricalPrefix(tbl5, func1: (...any) -> (...any)): number
        local num3 = 0
        for _, value in ipairs(tbl5) do
            local var27 = func1(value)
            if not (var27 and var27.isHistorical) then
                break
            end

            num3 += 1
        end
        return num3
    end

    local getHistoricalWindowMessageCount = if FFlagExpChatRenderHistoricalMessages then createComputed(function(arg2): number
        local var27 = readByMessageIdReactive(arg2)

        return (countHistoricalPrefix(getWindowMessagesInOrder(arg2), function(arg3)
            return var27[arg3]
        end))
    end) else nil

    local function insertWindowMessageIdInOrder(tbl5, messageId: string, isHistorical: boolean?)
        if not (FFlagExpChatRenderHistoricalMessages and isHistorical) then
            return List.append(tbl5, messageId)
        end

        local var27 = readByMessageId()

        local num3 = countHistoricalPrefix(tbl5, function(arg2)
            return var27[arg2]
        end)
        if num3 == #tbl5 then
            return List.append(tbl5, messageId)
        end
        return List.insert(tbl5, num3 + 1, messageId)
    end

    local function capHistoricalPrefix(tbl5, tbl6)
        if not tbl6.isHistorical then
            return tbl5
        end

        local historyArm = ExpChatMessageHistoryExperimentation.getHistoryArm(getCanLocalUserChat(false))
        local var27 = readByMessageId()

        local function resolve(messageId: string) -- Luacid: Inlined by compiler; 1 call site recovered
            return if messageId == tbl6.messageId then tbl6 else var27 and var27[messageId]
        end

        local num3 = countHistoricalPrefix(tbl5, resolve)
        local var28 = if historyArm then historyArm.maxCount else 0
        local var29 = if historyArm then historyArm.maxAgeSeconds else 0
        local num4 = math.max(1, num3 - var28 + 1)
        if var29 > 0 then
            local var30 = workspace:GetServerTimeNow() - var29
            for i = num4, num3 do
                local var31 = resolve(tbl5[i])
                if var31 and var30 <= var31.timestamp.UnixTimestamp then
                    break
                end

                num4 = i + 1
            end
        end
        if num4 == 1 then
            return tbl5
        elseif #tbl5 < num4 then
            return {}
        end

        return List.slice(tbl5, num4)
    end

    local function shouldDropHistoricalAtLimit(tbl5) -- Luacid: Inlined by compiler; 6 call sites recovered
        local var27 = getWindowMessagesInOrder(false)
        local isVisibleInChatWindow

        if tbl5.isHistorical == true then
            isVisibleInChatWindow = tbl5.isVisibleInChatWindow

            if isVisibleInChatWindow then
                if #var27 >= tbl1.messageLimit then
                    isVisibleInChatWindow = not isHistoricalWindowMessage(var27[1])
                else
                    isVisibleInChatWindow = false
                end
            end
        else
            isVisibleInChatWindow = false
        end

        return isVisibleInChatWindow
    end

    local function syncPoolForInsert(messageId: string, bool3: boolean) -- Luacid: Inlined by compiler; 6 call sites recovered
        if not (bool3 or bool2) then
            updateNextMessageComponent(messageId)
        elseif bool1 then
            bool2 = true
        else
            repopulateMessageComponents()
        end
    end

    local function keepHistoricalFlag(tbl5)
        if isHistoricalWindowMessage(tbl5.messageId) then
            return Dictionary.join(tbl5, { isHistorical = true })
        end
        return tbl5
    end

    local function addMessage(tbl5) -- Luacid: Inlined by compiler; 5 call sites recovered
        maybeBatch(function()
            local var27 = readByMessageId()

            if isBorderlessBubbleChatEnabled() then
                local var28 = var27 and var27[tbl5.messageId]

                tbl5.bubbleChatReceivedAtMillis = var28 and var28.bubbleChatReceivedAtMillis or getServerTimeNowMillis()
            end
            if var27 and var27[tbl5.messageId] then
                if FFlagExpChatEvictFloodcheckedFromWindowOrder
                    and (tbl5.status == Enum.TextChatMessageStatus.Floodchecked or tbl5.status == Enum.TextChatMessageStatus.MessageTooLong)
                then
                    var6(function(arg2)
                        return List.filter(arg2, function(messageId): boolean
                            return messageId ~= tbl5.messageId
                        end)
                    end)

                    local var28 = resolveChannelNameForMapOrder(tbl5, tbl5.channelNameOverride)
                    if var28 then
                        var8(function(arg2)
                            local var29 = arg2[var28]
                            if not var29 then
                                return arg2
                            end
                            local var30 = List.filter(var29, function(messageId): boolean
                                return messageId ~= tbl5.messageId
                            end)
                            return Dictionary.join(arg2, { [var28] = var30 })
                        end)
                    end

                    writeByMessageId(tbl5.messageId, nil)

                    if tbl5.userId then
                        updateMessagesBySenderId(tbl5.userId, function(arg2)
                            if not arg2 then
                                return nil
                            end

                            local var29 = if FFlagExpChatMessagesStoreMemoryCleanup then List.filter(arg2, function(messageId): boolean
                                return messageId ~= tbl5.messageId
                            end) else List.filter(arg2, function(arg3): boolean
                                return arg3.messageId ~= tbl5.messageId
                            end)

                            return if #var29 == 0 then nil else var29
                        end)

                        return
                    end

                    return
                end

                if FFlagExpChatRenderHistoricalMessages then
                    writeByMessageId(tbl5.messageId, keepHistoricalFlag(tbl5))
                else
                    writeByMessageId(tbl5.messageId, tbl5)
                end

                if not FFlagExpChatMessagesStoreMemoryCleanup and tbl5.userId then
                    updateMessagesBySenderId(tbl5.userId, function(arg2)
                        if not arg2 then
                            return nil
                        end
                        local var28 = nil
                        for i, value in ipairs(arg2) do
                            if value.messageId == tbl5.messageId then
                                var28 = i
                                break
                            end
                        end

                        if var28 then
                            return List.set(arg2, var28, tbl5)
                        end

                        return arg2
                    end)
                end

                return
            end

            if FFlagExpChatRenderHistoricalMessages and shouldDropHistoricalAtLimit(tbl5) then
                return
            end

            local userId = tbl5.userId
            local partOrModel = tbl5.partOrModel

            if not userId and partOrModel then
                userId = getPartOrModelToMockUserId(false)[partOrModel]

                if not userId then
                    userId = HttpService:GenerateGUID(false)

                    var16(function(arg2)
                        return Dictionary.join(arg2, { [userId] = partOrModel })
                    end)

                    var18(function(arg2)
                        return Dictionary.join(arg2, { [partOrModel] = userId })
                    end)
                end
            end

            local userId2 = tbl5.userId
            local var28 = if userId ~= userId2 then Dictionary.join(tbl5, { userId = userId }) else tbl5
            local var29 = nil
            if GetFFlagTextChatEnableUniverseChatTabs() and var28.channelNameOverride then
                var29 = var28.channelNameOverride
            elseif var28.textChannel then
                var29 = if var28.textChannel.Name == "RBXSystem"
                    or GetFFlagTextChatEnableUniverseChatTabs() and not getChannelTabsConfigurationEnabled(false) then "RBXGeneral" else var28.textChannel.Name
            end

            if var28.isVisibleInChatWindow then
                local var30 = getWindowMessagesInOrder(false)
                local var31 = not var29 and {} or getWindowMessagesInOrderByTabId(false)[var29] or {}

                if #var30 >= tbl1.messageLimit then
                    local var32 = var30[1]
                    local var33 = var27 and var27[var32]

                    if var33 then
                        if not FFlagExpChatMessagesStoreKeepInByMessageId then
                            writeByMessageId(var32, nil)
                        end

                        if var33.userId then
                            updateMessagesBySenderId(var33.userId, function(arg2)
                                if not arg2 then
                                    return nil
                                end

                                local var34 = if FFlagExpChatMessagesStoreMemoryCleanup then List.filter(arg2, function(arg3): boolean
                                    return arg3 ~= var32
                                end) else List.filter(arg2, function(arg3): boolean
                                    return arg3.messageId ~= var32
                                end)

                                if #var34 ~= 0 then
                                    return var34
                                end

                                local var35 = getMockUserIdToPartOrModel(false)
                                if var35[var33.userId] then
                                    local var36 = var35[var33.userId]

                                    var18(function(arg3)
                                        return Dictionary.removeKey(arg3, var36)
                                    end)

                                    var16(function(arg3)
                                        return Dictionary.removeKey(arg3, var33.userId)
                                    end)
                                end

                                return nil
                            end)
                        end

                        var6(function(arg2)
                            return List.removeIndex(arg2, 1)
                        end)

                        if FFlagExpChatMessagesStoreMemoryCleanup then
                            tbl4[var32] = nil
                        end
                    end
                end

                if var29 and #var31 >= tbl1.messageLimit then
                    local var32 = var31[1]
                    if var32 then
                        var8(function(arg2)
                            local var33 = arg2[var29] or {}
                            local var34 = List.removeIndex(var33, 1)
                            return Dictionary.join(arg2, { [var29] = var34 })
                        end)

                        if var27 and var27[var32] then
                            writeByMessageId(var32, nil)
                        end

                        if FFlagExpChatMessagesStoreMemoryCleanup then
                            tbl4[var32] = nil
                        end
                    end
                end
            end

            writeByMessageId(var28.messageId, var28)

            if var28.userId then
                updateMessagesBySenderId(var28.userId, function(arg2)
                    local var30 = arg2 or {}

                    local bool3 = false
                    if FFlagExpChatMessagesStoreMemoryCleanup then
                        for _, value in ipairs(var30) do
                            if value == var28.messageId then
                                bool3 = true
                                break
                            end
                        end
                    else
                        for _, value in ipairs(var30) do
                            if value.messageId == var28.messageId then
                                bool3 = true
                                break
                            end
                        end
                    end

                    if bool3 then
                        return var30
                    end

                    local var31 = if FFlagExpChatMessagesStoreMemoryCleanup then var28.messageId else var28
                    return List.append(var30, var31)
                end)
            end

            local bool3 = false
            if not var28.isVisibleInChatWindow then
                return
            end

            var6(function(arg2)
                local var30 = insertWindowMessageIdInOrder(arg2, var28.messageId, var28.isHistorical)
                bool3 = bool3 or var30[#var30] ~= var28.messageId
                if not FFlagExpChatMessageHistoryExperiment then
                    return var30
                end

                local var31 = capHistoricalPrefix(var30, var28)
                bool3 = bool3 or #var31 < #var30
                return var31
            end)

            if var29 then
                var8(function(arg2)
                    local var30 = arg2[var29] or {}
                    local var31 = insertWindowMessageIdInOrder(var30, var28.messageId, var28.isHistorical)

                    bool3 = bool3 or var31[#var31] ~= var28.messageId
                    if FFlagExpChatMessageHistoryExperiment then
                        var31 = capHistoricalPrefix(var31, var28)
                    end
                    return Dictionary.join(arg2, { [var29] = var31 })
                end)
            end

            if not FFlagExpChatEnableV2ChatWindow then
                return
            end

            local var30 = getActiveChannelFilter(false)
            if var30 == nil or var29 == var30 then
                syncPoolForInsert(var28.messageId, bool3)
            end
        end)
    end

    local tbl5 = ({})

    local function getMessage(str1: string)
        if FFlagExpChatMessagesStoreUseProxy then
            return function(arg2)
                return readByMessageIdReactive(arg2)[str1]
            end
        end

        if not tbl4[str1] then
            tbl4[str1] = createComputed(function(arg2)
                local var27 = var1(arg2)
                return if var27 and var27[str1] then var27[str1] else nil
            end)
        end
        return tbl4[str1]
    end

    local function getUserMessageCache(str1: string)
        local str2 = tostring(str1)
        if not tbl5[str2] then
            tbl5[str2] = {}

            if not FFlagExpChatMessagesStoreMemoryCleanup then
                tbl5[str2].messages = createComputed(function(arg2)
                    return readMessagesBySenderIdReactive(arg2)[str2] or {}
                end)
            end

            if FFlagExpChatMessagesStoreMemoryCleanup then
                tbl5[str2].bubbleMessages = createComputed(function(arg2)
                    local var27 = readMessagesBySenderIdReactive(arg2)[str2] or {}
                    local var28 = readByMessageIdReactive(arg2)
                    local var29 = getMutedUserIds(arg2)
                    local result = {}
                    for _, value in ipairs(var27) do
                        local var30 = var28[value]
                        if not var30 then
                            continue
                        end

                        local var31 = if var30.userId then Set.has(var29, var30.userId) or false else false

                        if var30.isVisibleInBubbleChat and not var31 then
                            table.insert(result, var30)
                        end
                    end

                    return result
                end)
            else
                tbl5[str2].bubbleMessages = createComputed(function(arg2)
                    local var27 = tbl5[str2].messages(arg2)
                    local var28 = getMutedUserIds(arg2)
                    local result = {}
                    for _, value in ipairs(var27) do
                        local var29 = if value.userId then Set.has(var28, value.userId) or false else false

                        if value.isVisibleInBubbleChat and not var29 then
                            table.insert(result, value)
                        end
                    end
                    return result
                end)
            end

            if not FFlagExpChatMessagesStoreMemoryCleanup then
                tbl5[str2].lastMessage = createComputed(function(arg2)
                    local var27 = tbl5[str2].messages(arg2)
                    return if #var27 > 0 then var27[#var27] else nil
                end)
            end
        end
        return tbl5[str2]
    end

    local function getUserMessages(str1: string)
        return getUserMessageCache(str1).messages
    end

    local function getUserBubbleMessages(str1: string)
        return getUserMessageCache(str1).bubbleMessages
    end

    local function getUserLastMessage(str1: string)
        return getUserMessageCache(str1).lastMessage
    end

    local function createMessagesArraySignal() -- Luacid: Inlined by compiler; 1 call site recovered
        return createComputed(function(arg2)
            local var27 = readByMessageIdReactive(arg2)

            if not var27 then
                return {}
            end
            local result = {}
            for _, value in var27 do
                table.insert(result, value)
            end
            return result
        end)
    end

    local function addSystemMessage(str1: string, channelNameOverride: string, metadata: string?, func1: ((...any) -> (...any))?, bool3: boolean?, textChannel)
        local var27 = sanitizeForRichText(str1)
        if GetFFlagExpChatSyntheticSystemMessageRichText() then
            local var28 = generateRichSystemMessageTextFormat

            if not FFlagExpChatDictation then
                bool3 = nil
            end

            var27 = var28(var27, bool3, func1)
        end

        local tbl6 = {
            userId = nil,
            prefixText = "",
            text = var27,
            translation = nil,
            useTranslation = false,
            messageId = HttpService:GenerateGUID(false),
            timestamp = DateTime.fromUnixTimestampMillis(workspace:GetServerTimeNow() * 1000),
            status = Enum.TextChatMessageStatus.Success,
            isVisibleInChatWindow = true,
            isVisibleInBubbleChat = false,
            shouldOverrideBubbleChatSettings = false,
            textChannel = textChannel,
            bubbleChatMessageProperties = nil,
            chatWindowMessageProperties = nil,
            textChatMessageInstance = nil,
            partOrModel = nil,
            channelNameOverride = 0,
            metadata = 0
        }

        if textChannel ~= nil then
            channelNameOverride = nil
        end

        tbl6.channelNameOverride = channelNameOverride
        tbl6.metadata = metadata
        addMessage(tbl6)
    end

    local function formatPrefixForUniverseChatTabs(str1: string, str2: string?, arg2): string
        if not GetFFlagTextChatEnableUniverseChatTabs() or not str2 or #str1 == 0 then
            return str1
        end

        local var27 = if arg2.TextSource then computeNameColor(arg2.TextSource.Username) else computeNameColor(if Players.LocalPlayer then Players.LocalPlayer.Name else "")
        return `<font color="#{var27:ToHex()}">{str1}</font>`
    end

    local function handleIncomingOrOutgoingMessage(textChatMessageInstance, bool3: boolean, str1: string?, isUniverseChat: boolean?, isHistorical: boolean?)
        local var27, var28

        if FFlagEnableInExpChatRewrite then
            var27, var28 = getTextAndTranslation(textChatMessageInstance)
        else
            if getFFlagExpChatProtectedChatInternalAPIs() then
                var27 = textChatMessageInstance.TextInternal
            else
                var27 = textChatMessageInstance.Text
            end

            if getFFlagExpChatProtectedChatInternalAPIs() then
                var28 = textChatMessageInstance.TranslationInternal
            else
                var28 = textChatMessageInstance.Translation
            end
        end
        if isWhiteSpaceOnly(var27)
            and textChatMessageInstance.Status ~= Enum.TextChatMessageStatus.Floodchecked
            and textChatMessageInstance.Status ~= Enum.TextChatMessageStatus.MessageTooLong
        then
            return
        end

        local var29 = if textChatMessageInstance.TextSource then tostring(textChatMessageInstance.TextSource.UserId) elseif FFlagExpChatFixLocalUserVerifiedBadge and bool3 and Players.LocalPlayer then tostring(Players.LocalPlayer.UserId) else nil

        if not readByMessageId() then
            return
        end

        local var30 = getCanLocalUserChat(false)
        local bool4 = var29 == nil
            or (if var30 or FFlagExpChatPresetChatEnabled and (textChatMessageInstance.PresetId or "") ~= "" then textChatMessageInstance.Status == Enum.TextChatMessageStatus.Success
                or textChatMessageInstance.Status == Enum.TextChatMessageStatus.Sending else false)
        local var31 = if var29 and getMutedUserIds(false) then Set.has(getMutedUserIds(false), var29) else false
        local bool5 = bool4 and not var31

        local bool6 = false
        local isBubbleChatEnabled

        if FFlagExpChatUseChatConfigStore then
            isBubbleChatEnabled = GetChatConfigurationStore(false).getIsBubbleChatEnabled(false)
        else
            local store = ExpChatShared.context and ExpChatShared.context.store
            if store then
                isBubbleChatEnabled = store:getState().Messages.isBubbleChatEnabled
            else
                isBubbleChatEnabled = getIsBubbleChatEnabled(false)
            end
        end

        if isBubbleChatEnabled
            and bool5
            and (not FFlagEnableInExpChatSummaryOnLua or var29 ~= nil)
            and (textChatMessageInstance.Status == Enum.TextChatMessageStatus.Success
                or textChatMessageInstance.Status == Enum.TextChatMessageStatus.Sending)
        then
            bool6 = true
        end

        if FFlagExpChatDisableUniverseBubbleChat
            and GetFFlagTextChatEnableUniverseChatTabs()
            and isUniverseChat == true
            and not (FFlagExpChatGlobalTabDefault and isGlobalBubbleChatEnabled())
        then
            bool6 = false
        end

        if textChatMessageInstance.Status ~= Enum.TextChatMessageStatus.Success
            and textChatMessageInstance.Status ~= Enum.TextChatMessageStatus.Sending
        then
            bool6 = false
            bool5 = false
        end

        if isHistorical then
            bool6 = false
        end

        if not isUniverseChat
            and str1 == nil
            and not shouldRenderTextChannelInDefaultWindow(textChatMessageInstance.TextChannel, getTextChannelDisplayMode())
        then
            bool5 = false
        end

        local tbl6 = {
            userId = var29,
            prefixText = formatPrefixForUniverseChatTabs(
                if getFFlagExpChatProtectedChatInternalAPIs() then textChatMessageInstance.PrefixTextInternal else textChatMessageInstance.PrefixText,
                str1,
                textChatMessageInstance
            ),
            text = var27,
            translation = var28,
            useTranslation = getChatTranslationEnabled() and var28 ~= nil,
            messageId = textChatMessageInstance.MessageId,
            status = textChatMessageInstance.Status,
            timestamp = textChatMessageInstance.Timestamp,
            shouldOverrideBubbleChatSettings = false,
            isVisibleInBubbleChat = bool6,
            isVisibleInChatWindow = bool5,
            textChannel = textChatMessageInstance.TextChannel,
            bubbleChatMessageProperties = textChatMessageInstance.BubbleChatMessageProperties,
            chatWindowMessageProperties = textChatMessageInstance.ChatWindowMessageProperties,
            textChatMessageInstance = if getFFlagExpChatTelemetryEventTrigger() then textChatMessageInstance else nil,
            partOrModel = if textChatMessageInstance.TextSource then textChatMessageInstance.TextSource.Parent or nil else nil,
            wasRewritten = if FFlagEnableInExpChatRewrite then textChatMessageInstance.WasRewritten else nil,
            originalText = if FFlagEnableInExpChatRewrite then textChatMessageInstance.OriginalText else nil,
            isHistorical = isHistorical,
            channelNameOverride = if GetFFlagTextChatEnableUniverseChatTabs() then str1 or nil else nil,
            chatActionType = if FFlagEnableInExpChatSummaryOnLua then textChatMessageInstance.ChatActionType else nil,
            isUniverseChat = isUniverseChat,
            presetId = if FFlagExpChatPresetChatEnabled then textChatMessageInstance.PresetId else nil,
            presetChatVersion = if FFlagExpChatPresetChatEnabled then textChatMessageInstance.PresetChatVersion else nil
        }
        local var32 = readByMessageId()
        local var33 = var32 and var32[tbl6.messageId] ~= nil

        if isHistorical and var33 then
            return
        end

        if FFlagExpChatMessageHistoryExperiment and isHistorical then
            ExpChatMessageHistoryExperimentation.logExposure(getCanLocalUserChat(false))
        end

        if tbl6.isVisibleInChatWindow or tbl6.isVisibleInBubbleChat or var33 then
            addMessage(tbl6)
        end

        if ExpChatPresetChatEmojiEffectExperimentation.isExperimentEnabled then
            logPresetChatEmojiEffectExposure(tbl6)
        end
    end

    local function handleIncomingBubbleChatMessage(tbl6)
        local tbl7 = {
            userId = tbl6.bubbleChatMessageUserId,
            prefixText = "",
            text = tbl6.message,
            translation = tbl6.translation,
            useTranslation = getChatTranslationEnabled(),
            textChannel = nil,
            messageId = tbl6.bubbleChatMessageId,
            status = Enum.TextChatMessageStatus.Success,
            timestamp = tbl6.timestamp,
            partOrModel = tbl6.partOrModel,
            shouldOverrideBubbleChatSettings = true,
            isVisibleInBubbleChat = true,
            isVisibleInChatWindow = false,
            bubbleChatMessageProperties = tbl6.bubbleChatMessageProperties,
            chatWindowMessageProperties = nil
        }
        addMessage(tbl7)

        if ExpChatPresetChatEmojiEffectExperimentation.isExperimentEnabled then
            logPresetChatEmojiEffectExposure(tbl7)
        end
    end

    local function handleHiddenMessageReceived(textChatMessageInstance)
        local num3 = string.len(
            if getFFlagExpChatProtectedChatInternalAPIs() then textChatMessageInstance.TextInternal else textChatMessageInstance.Text
        )

        local num4 = math.max(FIntExpChatRandomCharChangeLowerBound, -(num3 - 1))
        local num5 = math.random(num4, FIntExpChatRandomCharChangeUpperBound)
        local text = string.rep(Config.DOT_TEXT, num3 + num5)

        local tbl6 = {
            userId = nil,
            prefixText = Config.LOCK_EMOJI .. " :",
            text = text,
            textChannel = textChatMessageInstance.TextChannel,
            messageId = textChatMessageInstance.MessageId,
            status = textChatMessageInstance.Status,
            timestamp = textChatMessageInstance.Timestamp,
            isVisibleInBubbleChat = false,
            isVisibleInChatWindow = true,
            textChatMessageInstance = 0,
            isHiddenMessage = true
        }

        if not getFFlagExpChatTelemetryEventTrigger() then
            textChatMessageInstance = nil
        end

        tbl6.textChatMessageInstance = textChatMessageInstance
        addMessage(tbl6)
    end

    local function handlePlayerRemoved(str1: string)
        local str2 = tostring(str1)

        maybeBatch(function() -- name: doHandlePlayerRemoved
            writeMessagesBySenderId(str2, nil)

            if FFlagExpChatMessagesStoreMemoryCleanup then
                tbl5[str2] = nil
            end

            var10(function(arg2)
                if not arg2 then
                    return {}
                end

                local bool3 = not Set.has(arg2, str2)
                local var27 = if FFlagExpChatMessagesStoreUseProxy then proxy2 else var3(false)

                if #(var27[str2] or {}) == 0 and bool3 then
                    return arg2
                end

                local var28 = getMockUserIdToPartOrModel(false)
                if var28[str2] then
                    local var29 = var28[str2]

                    var18(function(arg3)
                        return Dictionary.removeKey(arg3, var29)
                    end)

                    var16(function(arg3)
                        return Dictionary.removeKey(arg3, str2)
                    end)
                end

                return Set.subtract(arg2, str2)
            end)
        end)
    end

    local function muteUser(str1: string)
        var10(function(arg2)
            if not arg2 then
                return {}
            end
            return (Set.add(arg2, str1))
        end)
    end

    local function unmuteUser(str1: string)
        var10(function(arg2)
            if not arg2 then
                return {}
            end
            return (Set.subtract(arg2, str1))
        end)
    end

    local function clearWindowMessages()
        maybeBatch(function() -- name: doClearWindowMessages
            forEachByMessageId(function(_, arg2)
                return Dictionary.join(arg2, { isVisibleInChatWindow = false })
            end)

            var6(function(_)
                return {}
            end)

            var8(function(_)
                return {}
            end)

            if not FFlagExpChatEnableV2ChatWindow then
                return
            end

            var24(1)
            num1 = 0
            num2 = 0
            local var27 = getMessageComponentRingBuffer(false)
            for _, value in ipairs(var27) do
                local var28 = tbl2[value]
                if var28 then
                    var28.setter(nil)
                end
            end
        end)
    end

    local function handleHiddenMessagesCleared()
        if not FFlagExpChatClearHiddenMessagesPostAgeCheck then
            return
        end

        forEachByMessageId(function(_, arg2)
            if arg2 and arg2.isHiddenMessage then
                return Dictionary.join(arg2, { isVisibleInChatWindow = false })
            end
            return nil
        end)

        local function isNotHidden(str1: string)
            local var27 = readByMessageId()[str1]

            return var27 and not var27.isHiddenMessage
        end

        var6(function(arg2)
            return List.filter(arg2, isNotHidden)
        end)

        var8(function(arg2)
            return Dictionary.map(arg2, function(arg3)
                return List.filter(arg3, isNotHidden)
            end)
        end)
    end

    local function rebuildMessageWithTranslation(tbl6, useTranslation: boolean)
        return {
            prefixText = tbl6.prefixText,
            text = tbl6.text,
            translation = tbl6.translation,
            useTranslation = useTranslation,
            messageId = tbl6.messageId,
            status = tbl6.status,
            timestamp = tbl6.timestamp,
            bubbleChatReceivedAtMillis = if isBorderlessBubbleChatEnabled() then tbl6.bubbleChatReceivedAtMillis else nil,
            isVisibleInBubbleChat = tbl6.isVisibleInBubbleChat,
            isVisibleInChatWindow = tbl6.isVisibleInChatWindow,
            partOrModel = tbl6.partOrModel,
            shouldOverrideBubbleChatSettings = tbl6.shouldOverrideBubbleChatSettings,
            bubbleChatMessageProperties = tbl6.bubbleChatMessageProperties,
            chatWindowMessageProperties = tbl6.chatWindowMessageProperties,
            textChatMessageInstance = if getFFlagExpChatTelemetryEventTrigger() then tbl6.textChatMessageInstance else nil,
            userId = tbl6.userId,
            textChannel = tbl6.textChannel,
            wasRewritten = if FFlagEnableInExpChatRewrite then tbl6.wasRewritten else nil,
            originalText = if FFlagEnableInExpChatRewrite then tbl6.originalText else nil,
            chatActionType = if FFlagEnableInExpChatSummaryOnLua then tbl6.chatActionType else nil,
            presetId = if FFlagExpChatPresetChatEnabled then tbl6.presetId else nil,
            presetChatVersion = if FFlagExpChatPresetChatEnabled then tbl6.presetChatVersion else nil,
            isHistorical = if FFlagExpChatRenderHistoricalMessages then tbl6.isHistorical else nil
        }
    end

    local function toggleGlobalTranslation(useTranslation: boolean)
        maybeBatch(function() -- name: doToggleGlobalTranslation
            forEachByMessageId(function(_, arg2)
                return (rebuildMessageWithTranslation(arg2, useTranslation))
            end)
        end)
    end

    local function toggleMessageTranslation(useTranslation: boolean, str1: string)
        local function func1(arg2) -- Luacid: Inlined by compiler; 1 call site recovered
            return (rebuildMessageWithTranslation(arg2, useTranslation))
        end

        if FFlagExpChatMessagesStoreUseProxy then
            local var27 = proxy[str1]
            if var27 then
                local tbl6 = func1(var27)

                if tbl6 then
                    proxy[str1] = tbl6
                end
            end

            return
        end

        var2(function(arg2)
            if not (arg2 and arg2[str1]) then
                return arg2 or {}
            end
            local tbl6 = func1(arg2[str1])
            if tbl6 then
                return Dictionary.join(arg2, { [str1] = tbl6 })
            end
            return arg2
        end)
    end

    local function handleLegacyBubbleCreated(tbl6)
        local timestamp = tbl6.timestamp
        local dateTime = if timestamp then DateTime.fromUnixTimestampMillis(timestamp) else DateTime.now()
        addMessage({
            userId = tbl6.userId,
            prefixText = "",
            text = tbl6.text,
            messageId = tbl6.id,
            status = Enum.TextChatMessageStatus.Success,
            timestamp = dateTime,
            partOrModel = tbl6.adornee,
            shouldOverrideBubbleChatSettings = true,
            isVisibleInBubbleChat = true,
            isVisibleInChatWindow = false,
            translation = nil,
            useTranslation = false,
            textChannel = nil,
            bubbleChatMessageProperties = nil,
            chatWindowMessageProperties = nil
        })
    end

    local function handleLegacyBubbleTextUpdated(str1: string, text: string)
        local function func1(arg2) -- Luacid: Inlined by compiler; 1 call site recovered
            return Dictionary.join(arg2, { text = text })
        end

        if FFlagExpChatMessagesStoreUseProxy then
            local var27 = proxy[str1]
            if var27 then
                local var28 = func1(var27)

                if var28 then
                    proxy[str1] = var28
                end
            end

            return
        end

        var2(function(arg2)
            if not (arg2 and arg2[str1]) then
                return arg2 or {}
            end
            local var27 = func1(arg2[str1])
            if var27 then
                return Dictionary.join(arg2, { [str1] = var27 })
            end
            return arg2
        end)
    end

    local function registerMessageComponent(str1: string)
        if not tbl2[str1] then
            local getter, setter = createSignal(nil)
            tbl2[str1] = { getter = getter, setter = setter }

            local var5, var7 = createSignal(0)
            tbl3[str1] = { getter = var5, setter = var7 }

            var22(function(arg2)
                return List.append(arg2, str1)
            end)
        end

        return tbl2[str1].getter
    end

    local function unregisterMessageComponent(str1: string)
        local var27 = getMessageComponentRingBuffer(false)
        local var28 = nil
        for i, value in ipairs(var27) do
            if value == str1 then
                var28 = i
                break
            end
        end

        if tbl2[str1] then
            tbl2[str1] = nil
        end

        if tbl3[str1] then
            tbl3[str1] = nil
        end

        if not var28 then
            return
        end

        maybeBatch(function() -- name: doUnregister
            var22(function(arg2)
                return List.filter(arg2, function(arg3): boolean
                    return arg3 ~= str1
                end)
            end)

            local var29 = getMessageComponentRingBuffer(false)
            local var30 = getNextMessageComponentPointer(false)

            if #var29 == 0 then
                var24(1)
            elseif var28 < var30 then
                var24(var30 - 1)
            elseif #var29 < var30 then
                var24(1)
            end
        end)
    end

    local function getMessageComponentSignal(str1: string)
        local var27 = tbl2[str1]
        return if var27 then var27.getter else nil
    end

    local function getLayoutOrderSignal(str1: string)
        local var27 = tbl3[str1]
        return if var27 then var27.getter else nil
    end

    updateNextMessageComponent = function(str1: string)
        local var27 = getMessageComponentRingBuffer(false)
        if #var27 == 0 then
            return
        end

        local var28 = getNextMessageComponentPointer(false)
        local var29 = var27[var28]

        if not var29 then
            var24(1)
            return
        end

        local var30 = tbl2[var29]
        if var30 then
            var30.setter(str1)
        end

        local num3 = if FFlagEnableInExpChatRewrite then 10 else 1
        local var31 = tbl3[var29]

        if FFlagExpChatRenderHistoricalMessages and isHistoricalWindowMessage(str1) then
            num2 += num3
            if var31 then
                var31.setter(num2 + -1000000)
            end
        else
            num1 += num3
            if var31 then
                var31.setter(num1)
            end
        end

        local var32 = var28 % #var27 + 1
        var24(var32)
    end

    repopulateMessageComponents = function()
        maybeBatch(function() -- name: doRepopulate
            local var27 = getActiveChannelFilter(false)
            local var28 = if var27 then getWindowMessagesInOrderByTabId(false)[var27] or {} else getWindowMessagesInOrder(false)
            var24(1)
            num1 = 0
            num2 = 0

            for _, value in ipairs(var28) do
                updateNextMessageComponent(value)
            end

            local var29 = getMessageComponentRingBuffer(false)
            if not (#var28 < #var29) then
                return
            end

            for i = getNextMessageComponentPointer(false), #var29 do
                local var30 = var29[i]
                local var31 = tbl2[var30]
                if var31 then
                    var31.setter(nil)
                end
            end
        end)
    end

    local tbl6 = {
        getByMessageId = if FFlagExpChatMessagesStoreUseProxy then proxy else var1,
        getMessages = if FFlagExpChatMessagesStoreMemoryCleanup then nil else createMessagesArraySignal(),
        getMessagesBySenderId = if FFlagExpChatMessagesStoreUseProxy then proxy2 else var3,
        getWindowMessagesInOrder = getWindowMessagesInOrder,
        getWindowMessagesInOrderByTabId = getWindowMessagesInOrderByTabId,
        getHistoricalWindowMessageCount = getHistoricalWindowMessageCount,
        getMutedUserIds = getMutedUserIds,
        getCanLocalUserChat = getCanLocalUserChat,
        getIsBubbleChatEnabled = getIsBubbleChatEnabled,
        getMockUserIdToPartOrModel = getMockUserIdToPartOrModel,
        getPartOrModelToMockUserId = getPartOrModelToMockUserId,
        getMessage = getMessage
    }

    if FFlagExpChatMessagesStoreMemoryCleanup then
        getUserMessages = nil
    end

    tbl6.getUserMessages = getUserMessages
    tbl6.getUserBubbleMessages = getUserBubbleMessages
    if FFlagExpChatMessagesStoreMemoryCleanup then
        getUserLastMessage = nil
    end

    tbl6.getUserLastMessage = getUserLastMessage

    tbl6.registerMessageComponent = registerMessageComponent
    tbl6.unregisterMessageComponent = unregisterMessageComponent
    tbl6.repopulateMessageComponents = repopulateMessageComponents
    tbl6.getMessageComponentSignal = getMessageComponentSignal
    tbl6.getLayoutOrderSignal = getLayoutOrderSignal
    tbl6.updateNextMessageComponent = updateNextMessageComponent
    tbl6.getMessageComponentRingBuffer = getMessageComponentRingBuffer
    tbl6.getNextMessageComponentPointer = getNextMessageComponentPointer
    tbl6.setActiveChannelFilter = setActiveChannelFilter
    tbl6.getActiveChannelFilter = getActiveChannelFilter

    tbl6.setCanLocalUserChat = setCanLocalUserChat

    tbl6.muteUser = muteUser
    tbl6.unmuteUser = unmuteUser
    tbl6.handlePlayerRemoved = handlePlayerRemoved
    tbl6.clearWindowMessages = clearWindowMessages
    tbl6.toggleGlobalTranslation = toggleGlobalTranslation
    tbl6.toggleMessageTranslation = toggleMessageTranslation

    tbl6.handleIncomingOrOutgoingMessage = handleIncomingOrOutgoingMessage
    tbl6.batchWrites = batchWrites
    tbl6.handleIncomingBubbleChatMessage = handleIncomingBubbleChatMessage
    tbl6.handleLegacyBubbleCreated = handleLegacyBubbleCreated
    tbl6.handleLegacyBubbleTextUpdated = handleLegacyBubbleTextUpdated
    tbl6.handleHiddenMessageReceived = handleHiddenMessageReceived
    tbl6.handleHiddenMessagesCleared = handleHiddenMessagesCleared
    tbl6.addSystemMessage = addSystemMessage
    tbl6.getChannelTabsConfigurationEnabled = getChannelTabsConfigurationEnabled
    tbl6.setChannelTabsConfigurationEnabled = setChannelTabsConfigurationEnabled
    return tbl6
end

return createMessagesStore
