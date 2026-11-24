-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local ExpChatShared = require(ExpChatParent.ExpChatShared)
local shouldRenderTextChannelInDefaultWindow = ExpChatShared.shouldRenderTextChannelInDefaultWindow
local getTextChannelDisplayMode = ExpChatShared.getTextChannelDisplayMode
local Rodux = require(ExpChatParent.Rodux)
local llama = require(ExpChatParent.llama)
local List = llama.List
local Dictionary = llama.Dictionary
local Set = llama.Set
local None = llama.None

local isWhiteSpaceOnly = require(ExpChat.isWhiteSpaceOnly)
local sanitizeForRichText = require(ExpChat.sanitizeForRichText)
local generateRichSystemMessageTextFormat = require(ExpChat.generateRichSystemMessageTextFormat)
local Config = require(ExpChat.Config)
local _TextChatMessageChatActionType = require(ExpChat.TextChatMessageChatActionType)

local Actions = ExpChat.Actions
local IncomingMessageReceived = require(Actions.IncomingMessageReceived)
local UniverseChatSystemMessageAdded = require(Actions.UniverseChatSystemMessageAdded)
local IncomingBubbleChatMessageReceived = require(Actions.IncomingBubbleChatMessageReceived)
local OutgoingMessageSent = require(Actions.OutgoingMessageSent)
local UserMuted = ExpChatShared.Actions.UserMuted
local UserUnmuted = ExpChatShared.Actions.UserUnmuted
local PlayerRemoved = ExpChatShared.Actions.PlayerRemoved
local ChatPrivacySettingsReceived = require(Actions.ChatPrivacySettingsReceived)
local ChatPrivacySettingsFetchFailed = require(Actions.ChatPrivacySettingsFetchFailed)
local ConfigurationObjectsLoaded = require(Actions.ConfigurationObjectsLoaded)
local BubbleChatSettingsChanged = require(Actions.BubbleChatSettingsChanged)
local ChatWindowMessagesCleared = ExpChatShared.Actions.ChatWindowMessagesCleared
local ChatTranslationGlobalToggled = require(Actions.ChatTranslationGlobalToggled)
local ChatTranslationMessageToggled = require(ExpChat.Actions.ChatTranslationMessageToggled)
local LegacyBubbleCreated = require(ExpChat.Actions.LegacyBubbleCreated)
local LegacyBubbleTextUpdated = require(ExpChat.Actions.LegacyBubbleTextUpdated)
local HiddenMessageReceived = require(ExpChat.Actions.HiddenMessageReceived)
local HiddenMessagesCleared = require(ExpChat.Actions.HiddenMessagesCleared)
local getFFlagExpChatTelemetryEventTrigger = require(ExpChat.Flags.getFFlagExpChatTelemetryEventTrigger)
local FFlagExpChatEnableFOMOUpsell = require(ExpChat.Flags.FFlagExpChatEnableFOMOUpsell)

local FFlagExpChatClearHiddenMessagesPostAgeCheck = require(ExpChat.Flags.FFlagExpChatClearHiddenMessagesPostAgeCheck)
local FIntExpChatRandomCharChangeLowerBound = require(ExpChat.Flags.FIntExpChatRandomCharChangeLowerBound)
local FIntExpChatRandomCharChangeUpperBound = require(ExpChat.Flags.FIntExpChatRandomCharChangeUpperBound)
local FFlagEnableInExpChatRewrite = require(ExpChat.Flags.FFlagEnableInExpChatRewrite)
local FFlagEnableInExpChatSummaryOnLua = require(ExpChat.Flags.FFlagEnableInExpChatSummaryOnLua)
local FFlagExpChatFixLocalUserVerifiedBadge = require(ExpChat.Flags.FFlagExpChatFixLocalUserVerifiedBadge)
local FFlagExpChatPresetChatEnabled = ExpChatShared.Flags.FFlagExpChatPresetChatEnabled

local SharedFlags = require(ExpChatParent.SharedFlags)
local getFFlagExpChatProtectedChatInternalAPIs = SharedFlags.getFFlagExpChatProtectedChatInternalAPIs
local FFlagExpChatUseChatConfigStore = SharedFlags.FFlagExpChatUseChatConfigStore
local FFlagExpChatDictation = SharedFlags.FFlagExpChatDictation
local GetChatConfigurationStore = require(ExpChat.Stores.GetChatConfigurationStore)
local computeNameColor = require(ExpChatParent.ChatUIPrimitives).Utils.computeNameColor
local getFFlagExpChatExcludeFOMORenders = require(ExpChat.Flags.getFFlagExpChatExcludeFOMORenders)
local GetFFlagTextChatEnableUniverseChatTabs = ExpChatShared.Flags.GetFFlagTextChatEnableUniverseChatTabs
local FFlagExpChatDisableUniverseBubbleChat = ExpChatShared.Flags.FFlagExpChatDisableUniverseBubbleChat
local isGlobalBubbleChatEnabled = require(ExpChat.isGlobalBubbleChatEnabled)
local FFlagExpChatGlobalTabDefault = require(ExpChat.Flags.FFlagExpChatGlobalTabDefault)
local GetFFlagExpChatSyntheticSystemMessageRichText = ExpChatShared.Flags.GetFFlagExpChatSyntheticSystemMessageRichText
local getTextAndTranslation = require(ExpChat.getTextAndTranslation)

local ChannelTabsConfigurationEnabled = require(Actions.ChannelTabsConfigurationEnabled)

local TextChatService = game:GetService("TextChatService")

function getChatTranslationEnabled()
    local success, result = pcall(function(): boolean
        return TextChatService.ChatTranslationEnabled
    end)

    return success and result
end

local function resolveChannelNameForMapOrder(tbl1, tbl2, str1: string?)
    if GetFFlagTextChatEnableUniverseChatTabs() then
        return str1
            or (if tbl2.textChannel then if tbl2.textChannel.Name == "RBXSystem" or not tbl1.channelTabsConfigurationEnabled then "RBXGeneral" else tbl2.textChannel.Name else None)
    end

    if tbl2.textChannel then
        if tbl2.textChannel.Name == "RBXSystem" then
            return "RBXGeneral"
        end

        return tbl2.textChannel.Name
    end

    return None
end

local function mapByMessageIdInOrderHelper(tbl1, tbl2, str1: string?)
    if isWhiteSpaceOnly(tbl2.text)
        and tbl2.status ~= Enum.TextChatMessageStatus.Floodchecked
        and tbl2.status ~= Enum.TextChatMessageStatus.MessageTooLong
    then
        return tbl1
    end

    local partOrModel = tbl2.partOrModel
    local userId = tbl2.userId
    local messageId = tbl2.messageId

    local var1 = resolveChannelNameForMapOrder(tbl1, tbl2, str1)

    local windowMessagesInOrder = tbl1.windowMessagesInOrder
    local var2 = tbl1.windowMessagesInOrderByTabId[var1] or {}
    local byMessageId = tbl1.byMessageId
    local bubbleMessagesInOrderBySenderId = tbl1.bubbleMessagesInOrderBySenderId
    local mockUserIdToPartOrModel = tbl1.mockUserIdToPartOrModel
    local partOrModelToMockUserId = tbl1.partOrModelToMockUserId
    local messagesBySenderId = tbl1.messagesBySenderId

    if not userId and partOrModel then
        userId = partOrModelToMockUserId[partOrModel]

        if not userId then
            userId = HttpService:GenerateGUID(false)
            mockUserIdToPartOrModel = Dictionary.join(mockUserIdToPartOrModel, { [userId] = partOrModel })

            partOrModelToMockUserId = Dictionary.join(partOrModelToMockUserId, { [partOrModel] = userId })
        end
    end

    local wasRewritten, originalText

    if FFlagEnableInExpChatRewrite then
        wasRewritten = tbl2.wasRewritten
        originalText = tbl2.originalText
    else
        wasRewritten = nil
        originalText = nil
    end

    if byMessageId[messageId] then
        local tbl3 = {
            userId = userId,
            prefixText = tbl2.prefixText,
            text = tbl2.text,
            translation = tbl2.translation,
            useTranslation = tbl2.useTranslation,
            textChannel = tbl2.textChannel,
            messageId = messageId,
            status = tbl2.status,
            timestamp = tbl2.timestamp,
            isVisibleInBubbleChat = tbl2.isVisibleInBubbleChat,
            isVisibleInChatWindow = tbl2.isVisibleInChatWindow,
            shouldOverrideBubbleChatSettings = tbl2.shouldOverrideBubbleChatSettings,
            bubbleChatMessageProperties = tbl2.bubbleChatMessageProperties,
            chatWindowMessageProperties = tbl2.chatWindowMessageProperties,
            metadata = if FFlagExpChatDictation then tbl2.metadata else nil,
            textChatMessageInstance = if getFFlagExpChatTelemetryEventTrigger() then tbl2.textChatMessageInstance else nil,
            wasRewritten = wasRewritten,
            originalText = originalText,
            chatActionType = if FFlagEnableInExpChatSummaryOnLua then tbl2.chatActionType else nil,
            isUniverseChat = tbl2.isUniverseChat,
            presetId = if FFlagExpChatPresetChatEnabled then tbl2.presetId else nil,
            presetChatVersion = if FFlagExpChatPresetChatEnabled then tbl2.presetChatVersion else nil
        }

        local var3 = Dictionary.join(byMessageId, { [messageId] = tbl3 })

        if userId and messagesBySenderId[userId] then
            local where = List.findWhere(messagesBySenderId[userId], function(arg1, _): boolean
                return arg1.messageId == messageId
            end)

            if where and where > 0 then
                messagesBySenderId = Dictionary.join(messagesBySenderId, { [userId] = List.set(messagesBySenderId[userId], where, tbl3) })
            end
        end

        if tbl2.status == Enum.TextChatMessageStatus.Floodchecked or tbl2.status == Enum.TextChatMessageStatus.MessageTooLong then
            windowMessagesInOrder = List.removeIndex(windowMessagesInOrder, List.count(windowMessagesInOrder))

            var2 = List.removeIndex(var2, List.count(var2))
            var3 = Dictionary.removeKey(var3, tbl2.messageId)
            if userId then
                local where = List.findWhere(messagesBySenderId[userId], function(arg1, _): boolean
                    return arg1.messageId == messageId
                end)

                if where and where > 0 then
                    messagesBySenderId = Dictionary.join(messagesBySenderId, { [userId] = List.removeIndex(messagesBySenderId[userId], where) })
                end
            end
        end

        return Dictionary.join(tbl1, {
            windowMessagesInOrder = windowMessagesInOrder,
            windowMessagesInOrderByTabId = Dictionary.join(tbl1.windowMessagesInOrderByTabId, { [var1] = var2 }),
            byMessageId = var3,
            messagesBySenderId = messagesBySenderId
        })
    end

    if #windowMessagesInOrder == tbl1.messageLimit and tbl2.isVisibleInChatWindow then
        local var3 = windowMessagesInOrder[1]
        local userId2 = if byMessageId[var3] then byMessageId[var3].userId else nil
        windowMessagesInOrder = List.removeIndex(windowMessagesInOrder, 1)

        if userId2 then
            if messagesBySenderId ~= nil and messagesBySenderId[userId2] then
                local where = List.findWhere(messagesBySenderId[userId2], function(arg1, _): boolean
                    return arg1.messageId == var3
                end)
                if where and where > 0 then
                    messagesBySenderId = Dictionary.join(messagesBySenderId, { [userId2] = List.removeIndex(messagesBySenderId[userId2], where) })
                end

                if Dictionary.count(messagesBySenderId[userId2]) == 0 then
                    messagesBySenderId = Dictionary.removeKey(messagesBySenderId, userId2)
                    if mockUserIdToPartOrModel[userId2] then
                        local var4 = mockUserIdToPartOrModel[userId2]
                        if partOrModelToMockUserId[var4] then
                            partOrModelToMockUserId = Dictionary.removeKey(partOrModelToMockUserId, var4)
                        end
                        mockUserIdToPartOrModel = Dictionary.removeKey(mockUserIdToPartOrModel, userId2)
                    end
                end
            elseif bubbleMessagesInOrderBySenderId ~= nil and bubbleMessagesInOrderBySenderId[userId2] then
                local var4 = Dictionary.join(
                    bubbleMessagesInOrderBySenderId,
                    {
                        [userId2] = List.removeValue(bubbleMessagesInOrderBySenderId[userId2], var3)
                    }
                )
                if Dictionary.count(var4[userId2]) == 0 then
                    Dictionary.removeKey(var4, userId2)
                    if mockUserIdToPartOrModel[userId2] then
                        local var5 = mockUserIdToPartOrModel[userId2]
                        if partOrModelToMockUserId[var5] then
                            partOrModelToMockUserId = Dictionary.removeKey(partOrModelToMockUserId, var5)
                        end
                        mockUserIdToPartOrModel = Dictionary.removeKey(mockUserIdToPartOrModel, userId2)
                    end
                end
            end
        end

        if #var2 == tbl1.messageLimit then
            var3 = var2[1]
            var2 = List.removeIndex(var2, 1)
            byMessageId = Dictionary.removeKey(byMessageId, var3)
        end
    end

    if tbl2.isVisibleInChatWindow then
        windowMessagesInOrder = List.append(windowMessagesInOrder, messageId)
        var2 = List.append(var2, messageId)
    end

    local join = Dictionary.join
    local tbl3 = {
        windowMessagesInOrder = windowMessagesInOrder,
        windowMessagesInOrderByTabId = Dictionary.join(tbl1.windowMessagesInOrderByTabId, { [var1] = var2 }),
        byMessageId = Dictionary.join(byMessageId, {
            [messageId] = {
                userId = userId,
                prefixText = tbl2.prefixText,
                text = tbl2.text,
                translation = tbl2.translation,
                useTranslation = tbl2.useTranslation,
                messageId = messageId,
                status = tbl2.status,
                timestamp = tbl2.timestamp,
                isVisibleInBubbleChat = tbl2.isVisibleInBubbleChat,
                isVisibleInChatWindow = tbl2.isVisibleInChatWindow,
                partOrModel = partOrModel,
                shouldOverrideBubbleChatSettings = tbl2.shouldOverrideBubbleChatSettings,
                bubbleChatMessageProperties = tbl2.bubbleChatMessageProperties,
                chatWindowMessageProperties = tbl2.chatWindowMessageProperties,
                textChannel = tbl2.textChannel,
                metadata = if FFlagExpChatDictation then tbl2.metadata else nil,
                textChatMessageInstance = if getFFlagExpChatTelemetryEventTrigger() then tbl2.textChatMessageInstance else nil,
                isHiddenMessage = if FFlagExpChatEnableFOMOUpsell or getFFlagExpChatExcludeFOMORenders() then tbl2.isHiddenMessage else nil,
                wasRewritten = wasRewritten,
                originalText = originalText,
                chatActionType = if FFlagEnableInExpChatSummaryOnLua then tbl2.chatActionType else nil,
                isUniverseChat = tbl2.isUniverseChat,
                presetId = if FFlagExpChatPresetChatEnabled then tbl2.presetId else nil,
                presetChatVersion = if FFlagExpChatPresetChatEnabled then tbl2.presetChatVersion else nil
            }
        }),
        mockUserIdToPartOrModel = mockUserIdToPartOrModel,
        partOrModelToMockUserId = partOrModelToMockUserId,
        messagesBySenderId = 0
    }
    local var3

    if userId then
        local join2 = Dictionary.join
        local tbl4 = {}
        local append = List.append
        local var4 = messagesBySenderId[userId] or {}
        local tbl5 = {
            userId = userId,
            prefixText = tbl2.prefixText,
            text = tbl2.text,
            translation = tbl2.translation,
            useTranslation = tbl2.useTranslation,
            messageId = messageId,
            status = tbl2.status,
            timestamp = tbl2.timestamp,
            isVisibleInBubbleChat = tbl2.isVisibleInBubbleChat,
            isVisibleInChatWindow = tbl2.isVisibleInChatWindow,
            partOrModel = partOrModel,
            shouldOverrideBubbleChatSettings = tbl2.shouldOverrideBubbleChatSettings,
            bubbleChatMessageProperties = tbl2.bubbleChatMessageProperties,
            chatWindowMessageProperties = tbl2.chatWindowMessageProperties,
            textChannel = tbl2.textChannel,
            textChatMessageInstance = if getFFlagExpChatTelemetryEventTrigger() then tbl2.textChatMessageInstance else nil,
            wasRewritten = wasRewritten,
            originalText = originalText,
            chatActionType = if FFlagEnableInExpChatSummaryOnLua then tbl2.chatActionType else nil,
            isUniverseChat = tbl2.isUniverseChat,
            presetId = if FFlagExpChatPresetChatEnabled then tbl2.presetId else nil,
            presetChatVersion = if FFlagExpChatPresetChatEnabled then tbl2.presetChatVersion else nil
        }
        tbl4[userId] = append(var4, tbl5)
        var3 = join2(messagesBySenderId, tbl4)
    else
        var3 = nil
    end

    tbl3.messagesBySenderId = var3
    return join(tbl1, tbl3)
end

local function mapByMessageIdInOrder(tbl1, arg1)
    local textChatMessage = arg1.textChatMessage
    local var1, var2

    if FFlagEnableInExpChatRewrite then
        var1, var2 = getTextAndTranslation(textChatMessage)
    else
        if getFFlagExpChatProtectedChatInternalAPIs() then
            var1 = textChatMessage.TextInternal
        else
            var1 = textChatMessage.Text
        end

        if getFFlagExpChatProtectedChatInternalAPIs() then
            var2 = textChatMessage.TranslationInternal
        else
            var2 = textChatMessage.Translation
        end
    end

    local var3 = if textChatMessage.TextSource then tostring(textChatMessage.TextSource.UserId) elseif FFlagExpChatFixLocalUserVerifiedBadge and arg1.type == OutgoingMessageSent.name and Players.LocalPlayer then tostring(Players.LocalPlayer.UserId) else nil
    local bool1 = var3 == nil
        or (if tbl1.canLocalUserChat or FFlagExpChatPresetChatEnabled and (textChatMessage.PresetId or "") ~= "" then textChatMessage.Status == Enum.TextChatMessageStatus.Success
            or textChatMessage.Status == Enum.TextChatMessageStatus.Sending else false)
    local var4 = if var3 then Set.has(tbl1._mutedUserIds, var3) else false
    local bool2 = bool1 and not var4

    local bool3 = false
    local var5 = if FFlagExpChatUseChatConfigStore then GetChatConfigurationStore(false).getIsBubbleChatEnabled(false) else tbl1.isBubbleChatEnabled

    if var5
        and bool2
        and (not FFlagEnableInExpChatSummaryOnLua or var3 ~= nil)
        and (textChatMessage.Status == Enum.TextChatMessageStatus.Success
            or textChatMessage.Status == Enum.TextChatMessageStatus.Sending)
    then
        bool3 = true
    end

    if FFlagExpChatDisableUniverseBubbleChat
        and GetFFlagTextChatEnableUniverseChatTabs()
        and arg1.isUniverseChat == true
        and not (FFlagExpChatGlobalTabDefault and isGlobalBubbleChatEnabled())
    then
        bool3 = false
    end

    if not arg1.isUniverseChat
        and arg1.channelNameOverride == nil
        and not shouldRenderTextChannelInDefaultWindow(textChatMessage.TextChannel, getTextChannelDisplayMode())
    then
        bool2 = false
    end

    local var6 = if getFFlagExpChatProtectedChatInternalAPIs() then textChatMessage.PrefixTextInternal else textChatMessage.PrefixText

    if GetFFlagTextChatEnableUniverseChatTabs() and arg1.channelNameOverride and #var6 > 0 then
        local var7 = if textChatMessage.TextSource then computeNameColor(textChatMessage.TextSource.Username) else computeNameColor(Players.LocalPlayer.Name)
        var6 = `<font color="#{var7:ToHex()}">{var6}</font>`
    end

    local tbl2 = {
        userId = var3,
        prefixText = var6,
        text = var1,
        translation = var2,
        useTranslation = getChatTranslationEnabled(),
        textChannel = textChatMessage.TextChannel,
        messageId = textChatMessage.MessageId,
        status = textChatMessage.Status,
        timestamp = textChatMessage.Timestamp,
        isVisibleInBubbleChat = bool3,
        isVisibleInChatWindow = bool2,
        bubbleChatMessageProperties = textChatMessage.BubbleChatMessageProperties,
        chatWindowMessageProperties = textChatMessage.ChatWindowMessageProperties,
        textChatMessageInstance = if getFFlagExpChatTelemetryEventTrigger() then textChatMessage else nil,
        wasRewritten = if FFlagEnableInExpChatRewrite then textChatMessage.WasRewritten else nil,
        originalText = if FFlagEnableInExpChatRewrite then textChatMessage.OriginalText else nil,
        chatActionType = if FFlagEnableInExpChatSummaryOnLua then textChatMessage.ChatActionType else nil,
        isUniverseChat = arg1.isUniverseChat,
        presetId = if FFlagExpChatPresetChatEnabled then textChatMessage.PresetId else nil,
        presetChatVersion = if FFlagExpChatPresetChatEnabled then textChatMessage.PresetChatVersion else nil
    }

    return mapByMessageIdInOrderHelper(
        tbl1,
        tbl2,
        if GetFFlagTextChatEnableUniverseChatTabs() then arg1.channelNameOverride else nil
    )
end

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[ChannelTabsConfigurationEnabled.name] = function(tbl2, arg1)
    if not GetFFlagTextChatEnableUniverseChatTabs() then
        return tbl2
    end
    return Dictionary.join(tbl2, { channelTabsConfigurationEnabled = arg1.enabled })
end

tbl1[IncomingMessageReceived.name] = mapByMessageIdInOrder

tbl1[IncomingBubbleChatMessageReceived.name] = function(tbl2, arg1) -- name: mapByMessageIdInOrderBubbleChat
    local bubbleChatMessageTable = arg1.bubbleChatMessageTable

    local tbl3 = {
        userId = bubbleChatMessageTable.bubbleChatMessageUserId,
        prefixText = "",
        text = bubbleChatMessageTable.message,
        translation = bubbleChatMessageTable.translation,
        useTranslation = getChatTranslationEnabled(),
        messageId = bubbleChatMessageTable.bubbleChatMessageId,
        status = Enum.TextChatMessageStatus.Success,
        timestamp = bubbleChatMessageTable.timestamp,
        partOrModel = bubbleChatMessageTable.partOrModel,
        shouldOverrideBubbleChatSettings = true,
        isVisibleInBubbleChat = true,
        isVisibleInChatWindow = false,
        bubbleChatMessageProperties = bubbleChatMessageTable.bubbleChatMessageProperties
    }

    return mapByMessageIdInOrderHelper(tbl2, tbl3)
end

tbl1[OutgoingMessageSent.name] = mapByMessageIdInOrder
tbl1[UserMuted.name] = function(tbl2, arg1)
    return Dictionary.join(tbl2, { _mutedUserIds = Set.add(tbl2._mutedUserIds, arg1.userId) })
end

tbl1[UserUnmuted.name] = function(tbl2, arg1)
    return Dictionary.join(tbl2, { _mutedUserIds = Set.subtract(tbl2._mutedUserIds, arg1.userId) })
end

tbl1[PlayerRemoved.name] = function(tbl2, arg1)
    local var1 = Dictionary.filter(tbl2.bubbleMessagesInOrderBySenderId, function(_, userId): boolean
        return userId ~= arg1.userId
    end)

    local messagesBySenderId = Dictionary.filter(tbl2.messagesBySenderId, function(_, userId): boolean
        return userId ~= arg1.userId
    end)
    local bool1 = not Set.has(tbl2._mutedUserIds, arg1.userId)

    if #var1 == 0 and #messagesBySenderId == 0 and bool1 then
        return tbl2
    end
    return Dictionary.join(
        tbl2,
        {
            messagesBySenderId = messagesBySenderId,
            _mutedUserIds = Set.subtract(tbl2._mutedUserIds, arg1.userId)
        }
    )
end

tbl1[ChatPrivacySettingsReceived.name] = function(tbl2, arg1)
    return Dictionary.join(tbl2, { canLocalUserChat = arg1.canUserChat })
end

tbl1[ChatPrivacySettingsFetchFailed.name] = function(tbl2, _)
    return Dictionary.join(tbl2, { canLocalUserChat = false })
end

tbl1[ConfigurationObjectsLoaded.name] = function(arg1, arg2)
    return Dictionary.join(
        arg1,
        {
            isBubbleChatEnabled = if arg2.bubbleChatSettings.Enabled then arg2.bubbleChatSettings.Enabled else false
        }
    )
end

tbl1[BubbleChatSettingsChanged.name] = function(arg1, arg2)
    if arg2.property ~= "Enabled" then
        return arg1
    end

    local byMessageId = Dictionary.map(arg1.byMessageId, function(arg3)
        if arg3.shouldOverrideBubbleChatSettings then
            return arg3
        end
        return Dictionary.join(arg3, { isVisibleInBubbleChat = arg2.value and arg3.isVisibleInChatWindow })
    end)

    return Dictionary.join(arg1, { byMessageId = byMessageId, isBubbleChatEnabled = arg2.value })
end

tbl1[ChatWindowMessagesCleared.name] = function(tbl2, _)
    local byMessageId = Dictionary.map(tbl2.byMessageId, function(arg1)
        return Dictionary.join(arg1, { isVisibleInChatWindow = false })
    end)

    return Dictionary.join(tbl2, { windowMessagesInOrder = {}, windowMessagesInOrderByTabId = {}, byMessageId = byMessageId })
end

tbl1[ChatTranslationGlobalToggled.name] = function(tbl2, arg1) -- name: globalToggleTranslations
    local useTranslation = arg1.useTranslation
    local byMessageId = tbl2.byMessageId
    local tbl3 = ({})

    for k, _ in pairs(byMessageId) do
        local var1 = byMessageId[k]

        if var1 == nil then
            continue
        end

        local tbl4 = {
            prefixText = var1.prefixText,
            text = var1.text,
            translation = var1.translation,
            useTranslation = useTranslation,
            messageId = var1.messageId,
            status = var1.status,
            timestamp = var1.timestamp,
            isVisibleInBubbleChat = var1.isVisibleInBubbleChat,
            isVisibleInChatWindow = var1.isVisibleInChatWindow,
            partOrModel = var1.partOrModel,
            shouldOverrideBubbleChatSettings = var1.shouldOverrideBubbleChatSettings,
            bubbleChatMessageProperties = var1.bubbleChatMessageProperties,
            chatWindowMessageProperties = var1.chatWindowMessageProperties,
            userId = var1.userId,
            textChannel = var1.textChannel,
            textChatMessageInstance = if getFFlagExpChatTelemetryEventTrigger() then var1.textChatMessageInstance else nil,
            wasRewritten = if FFlagEnableInExpChatRewrite then var1.wasRewritten else nil,
            originalText = if FFlagEnableInExpChatRewrite then var1.originalText else nil,
            chatActionType = if FFlagEnableInExpChatSummaryOnLua then var1.chatActionType else nil,
            presetId = if FFlagExpChatPresetChatEnabled then var1.presetId else nil,
            presetChatVersion = if FFlagExpChatPresetChatEnabled then var1.presetChatVersion else nil
        }
        tbl3[k] = tbl4
    end

    return Dictionary.join(tbl2, { byMessageId = Dictionary.join(byMessageId, tbl3) })
end

tbl1[ChatTranslationMessageToggled.name] = function(tbl2, arg1) -- name: individualToggleTranslation
    local useTranslation = arg1.useTranslation
    local messageId = arg1.messageId
    local byMessageId = tbl2.byMessageId

    local var1 = byMessageId[messageId]

    if var1 == nil then
        return nil
    end

    local join = Dictionary.join
    local tbl3 = {
        byMessageId = Dictionary.join(byMessageId, {
            [messageId] = {
                prefixText = var1.prefixText,
                text = var1.text,
                translation = var1.translation,
                useTranslation = useTranslation,
                messageId = var1.messageId,
                status = var1.status,
                timestamp = var1.timestamp,
                isVisibleInBubbleChat = var1.isVisibleInBubbleChat,
                isVisibleInChatWindow = var1.isVisibleInChatWindow,
                partOrModel = var1.partOrModel,
                shouldOverrideBubbleChatSettings = var1.shouldOverrideBubbleChatSettings,
                bubbleChatMessageProperties = var1.bubbleChatMessageProperties,
                chatWindowMessageProperties = var1.chatWindowMessageProperties,
                userId = var1.userId,
                textChannel = var1.textChannel,
                textChatMessageInstance = if getFFlagExpChatTelemetryEventTrigger() then var1.textChatMessageInstance else nil,
                wasRewritten = if FFlagEnableInExpChatRewrite then var1.wasRewritten else nil,
                originalText = if FFlagEnableInExpChatRewrite then var1.originalText else nil,
                chatActionType = if FFlagEnableInExpChatSummaryOnLua then var1.chatActionType else nil,
                presetId = if FFlagExpChatPresetChatEnabled then var1.presetId else nil,
                presetChatVersion = if FFlagExpChatPresetChatEnabled then var1.presetChatVersion else nil
            }
        })
    }
    return join(tbl2, tbl3)
end

tbl1[LegacyBubbleCreated.name] = function(tbl2, arg1) -- name: mapByMessageIdInOrderLegacyBubbleChat
    local messageData = arg1.messageData
    local dateTime = if messageData.timestamp then DateTime.fromUnixTimestampMillis(messageData.timestamp) else DateTime.now()
    local tbl3 = {
        userId = messageData.userId,
        prefixText = "",
        text = messageData.text,
        messageId = messageData.id,
        status = Enum.TextChatMessageStatus.Success,
        timestamp = dateTime,
        partOrModel = messageData.adornee,
        shouldOverrideBubbleChatSettings = true,
        isVisibleInBubbleChat = true,
        isVisibleInChatWindow = false
    }

    return mapByMessageIdInOrderHelper(tbl2, tbl3)
end

tbl1[LegacyBubbleTextUpdated.name] = function(tbl2, arg1)
    local byMessageId = tbl2.byMessageId
    local messagesBySenderId = tbl2.messagesBySenderId
    local messageId = arg1.messageId
    local newText = arg1.newText
    if byMessageId[messageId] then
        local var1 = byMessageId[messageId]
        var1.text = newText
        byMessageId = Dictionary.join(byMessageId, { [messageId] = var1 })

        local userId = var1.userId
        if userId and messagesBySenderId[userId] then
            local where = List.findWhere(messagesBySenderId[userId], function(arg2, _): boolean
                return arg2.messageId == messageId
            end)
            if where and where > 0 then
                messagesBySenderId = Dictionary.join(messagesBySenderId, { [userId] = List.set(messagesBySenderId[userId], where, var1) })
            end
        end
    end

    return Dictionary.join(tbl2, { byMessageId = byMessageId, messagesBySenderId = messagesBySenderId })
end

tbl1[HiddenMessageReceived.name] = function(tbl2, arg1) -- name: mapByMessageIdInOrderHiddenMessage
    local userMessageIntent = arg1.userMessageIntent

    local num1 = string.len(
        if getFFlagExpChatProtectedChatInternalAPIs() then userMessageIntent.TextInternal else userMessageIntent.Text
    )

    local num2 = math.max(FIntExpChatRandomCharChangeLowerBound, -(num1 - 1))
    local num3 = math.random(num2, FIntExpChatRandomCharChangeUpperBound)
    local text = string.rep(Config.DOT_TEXT, num1 + num3)

    local tbl3 = {
        userId = nil,
        prefixText = Config.LOCK_EMOJI .. " :",
        text = text,
        textChannel = userMessageIntent.TextChannel,
        messageId = userMessageIntent.MessageId,
        status = userMessageIntent.Status,
        timestamp = userMessageIntent.Timestamp,
        isVisibleInBubbleChat = false,
        isVisibleInChatWindow = true,
        textChatMessageInstance = 0,
        isHiddenMessage = true
    }

    if not getFFlagExpChatTelemetryEventTrigger() then
        userMessageIntent = nil
    end

    tbl3.textChatMessageInstance = userMessageIntent

    return mapByMessageIdInOrderHelper(tbl2, tbl3)
end

tbl1[UniverseChatSystemMessageAdded.name] = function(tbl2, arg1) -- name: mapUniverseChatSystemMessage
    local messageId = HttpService:GenerateGUID(false)
    local var1 = sanitizeForRichText(arg1.text)
    if GetFFlagExpChatSyntheticSystemMessageRichText() then
        var1 = generateRichSystemMessageTextFormat(var1, if FFlagExpChatDictation then arg1.isError else nil, arg1.postProcessMessage)
    end

    local tbl3 = {
        userId = nil,
        prefixText = "",
        text = var1,
        translation = nil,
        useTranslation = false,
        messageId = messageId,
        timestamp = DateTime.fromUnixTimestampMillis(workspace:GetServerTimeNow() * 1000),
        status = Enum.TextChatMessageStatus.Success,
        isVisibleInChatWindow = true,
        isVisibleInBubbleChat = false,
        textChannel = nil,
        bubbleChatMessageProperties = nil,
        chatWindowMessageProperties = nil,
        textChatMessageInstance = nil,
        partOrModel = nil,
        metadata = arg1.metadata
    }

    return mapByMessageIdInOrderHelper(
        tbl2,
        tbl3,
        if GetFFlagTextChatEnableUniverseChatTabs() then arg1.channelNameOverride else nil
    )
end

tbl1[HiddenMessagesCleared.name] = function(tbl2, _)
    if not FFlagExpChatClearHiddenMessagesPostAgeCheck then
        return tbl2
    end

    local byMessageId = Dictionary.map(tbl2.byMessageId, function(arg1)
        if arg1.isHiddenMessage then
            return Dictionary.join(arg1, { isVisibleInChatWindow = false })
        end

        return arg1
    end)

    local windowMessagesInOrder = List.filter(tbl2.windowMessagesInOrder, function(arg1)
        local var2 = byMessageId[arg1]
        return var2 and not var2.isHiddenMessage
    end)

    local windowMessagesInOrderByTabId = Dictionary.map(tbl2.windowMessagesInOrderByTabId, function(arg1)
        return List.filter(arg1, function(arg2)
            local var3 = byMessageId[arg2]
            return var3 and not var3.isHiddenMessage
        end)
    end)

    return Dictionary.join(tbl2, {
        windowMessagesInOrder = windowMessagesInOrder,
        windowMessagesInOrderByTabId = windowMessagesInOrderByTabId,
        byMessageId = byMessageId
    })
end

return createReducer({
    canLocalUserChat = false,
    isBubbleChatEnabled = false,
    _mutedUserIds = {},
    channelTabsConfigurationEnabled = false,
    messageLimit = 50,
    windowMessagesInOrder = {},
    windowMessagesInOrderByTabId = {},
    byMessageId = {},
    bubbleMessagesInOrderBySenderId = {},
    mockUserIdToPartOrModel = {},
    partOrModelToMockUserId = {},
    messagesBySenderId = {}
}, tbl1)
