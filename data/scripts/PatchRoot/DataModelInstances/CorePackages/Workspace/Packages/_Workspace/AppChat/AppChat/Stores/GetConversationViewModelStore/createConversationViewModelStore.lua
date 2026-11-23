-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:11:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")

local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Signals = require(AppChatParent.Signals)
local DomLocators = require(AppChat.Utils.DomLocators)
local getConversationTitle = require(AppChat.Conversations.getConversationTitle)
local useIsUserPending = require(AppChat.Hooks.useIsUserPending)
local shouldShowOSAForConversation = require(AppChat.Utils.shouldShowOSAForConversation)
local shouldShowU13ChatOptInForConversation = require(AppChat.Utils.shouldShowU13ChatOptInForConversation)
local _createConversationStore = require(AppChat.Stores.GetConversationStore.createConversationStore)

local _createConversationMessageStore = require(AppChat.Stores.GetConversationMessageStore.createConversationMessageStore)

local _createConversationMessageListStore = require(AppChat.Stores.GetConversationMessageListStore.createConversationMessageListStore)
local getUnixTimestampMillis = require(AppChat.Utils.getUnixTimestampMillis)
local Enums = require(AppChat.MessageData.Enums)
local _Types = require(AppChat.MessageData.Types)
local Localization = require(AppChatParent.RobloxAppLocales).Localization

local FFlagAppChatDerivedConversationLatestActivity = require(AppChat.Flags.FFlagAppChatDerivedConversationLatestActivity)

local MessageType = Enums.MessageType
local MessageVisibility = Enums.MessageVisibility

local function getFirstCardAltText(cards) -- Luacid: Inlined by compiler; 1 call site recovered
    if type(cards) ~= "table" or type(cards[1]) ~= "table" then
        return nil
    end
    return if type(cards[1].alt_text) == "string" then cards[1].alt_text else nil
end

local function getContentFirstLine(str1: string?): string -- Luacid: Inlined by compiler; 2 call sites recovered
    if type(str1) ~= "string" then
        return ""
    end
    local tbl1 = str1:split("\n")
    return tbl1 and tbl1[1] or ""
end

local function getHiddenMessageText() -- Luacid: Inlined by compiler; 1 call site recovered
    return Localization.new(LocalizationService.RobloxLocaleId):Format("Feature.Chat.Label.MessageNotAvailable")
end

local function getUnixTime(lastUpdated) -- Luacid: Inlined by compiler; 1 call site recovered
    if lastUpdated == nil then
        return nil
    elseif typeof(lastUpdated) == "DateTime" then
        return lastUpdated.UnixTimestamp
    elseif type(lastUpdated) == "table" and lastUpdated.GetUnixTimestamp ~= nil then
        return lastUpdated:GetUnixTimestamp()
    end
    return nil
end

local function getLatestUnixSeconds(conversation, arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local unixTimestampMillis = getUnixTimestampMillis(conversation.lastUpdated)
    local unixTimestampMillis2 = if arg1 == nil then nil else getUnixTimestampMillis(arg1.created_at)

    if unixTimestampMillis2 == nil or unixTimestampMillis ~= nil and not (unixTimestampMillis < unixTimestampMillis2) then
        unixTimestampMillis2 = unixTimestampMillis
    end

    return if unixTimestampMillis2 == nil then nil else unixTimestampMillis2 / 1000
end

local function isNewerPreviewThanServer(conversation, arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local unixTimestampMillis = getUnixTimestampMillis(conversation.lastUpdated)
    local unixTimestampMillis2 = getUnixTimestampMillis(arg1.created_at)
    return not (unixTimestampMillis2 == nil) and (unixTimestampMillis == nil or unixTimestampMillis <= unixTimestampMillis2)
end

local function getSubtitle(conversation, arg1)
    if arg1 == nil then
        return getContentFirstLine(conversation.previewContent)
    end

    local var1 = if arg1.visibility == MessageVisibility.Hidden then getHiddenMessageText() else arg1.preview_content or arg1.content_to_display or arg1.content

    if var1 == nil and arg1.type == MessageType.System then
        var1 = getFirstCardAltText(arg1.cards)
    end

    return getContentFirstLine(var1)
end

local function getTitle(conversation) -- Luacid: Inlined by compiler; 4 call sites recovered
    return getConversationTitle(conversation) or ""
end

local function getLocatorTitle(conversation) -- Luacid: Inlined by compiler; 1 call site recovered
    return conversation.title or getTitle(conversation)
end

local function getCachedGetter(tbl1, str1: string, str2: string, func1: (...any) -> (...any)) -- Luacid: unused: defined but never referenced
    local tbl2 = tbl1[str1]
    if tbl2 then
        local var1 = tbl2[str2]
        if var1 ~= nil then
            return var1
        end
    else
        tbl2 = {}
        tbl1[str1] = tbl2
    end

    local computed = Signals.createComputed(func1)
    tbl2[str2] = computed
    return computed
end

local function createConversationViewModelStore(arg1, arg2, arg3)
    local tbl1 = {}

    local function getNewestPreviewableMessageGetter(str1: string) -- Luacid: unused: defined but never referenced
        local tbl2 = tbl1

        local function func1(arg4)
            for _, value in arg3.getOrderedIds(str1, arg4) do
                local message = arg2.getMessage(value, arg4)
                if message ~= nil and message.is_previewable == true then
                    return message
                end
            end
            return nil
        end

        local tbl3 = tbl2[str1]
        if tbl3 then
            local newestPreviewableMessage = tbl3.newestPreviewableMessage
            if newestPreviewableMessage ~= nil then
                return newestPreviewableMessage
            end
        else
            tbl3 = {}
            tbl2[str1] = tbl3
        end

        local newestPreviewableMessage = Signals.createComputed(func1)
        tbl3.newestPreviewableMessage = newestPreviewableMessage
        return newestPreviewableMessage
    end

    return {
        getTitle = function(str1: string) -- name: getTitleGetter
            local tbl2 = tbl1

            local function func1(arg4)
                local conversation = arg1.getConversation(str1, arg4)
                if conversation ~= nil then
                    return (getTitle(conversation))
                end

                return nil
            end

            local tbl3 = tbl2[str1]
            if tbl3 then
                local title = tbl3.title
                if title ~= nil then
                    return title
                end
            else
                tbl3 = {}
                tbl2[str1] = tbl3
            end

            local title = Signals.createComputed(func1)
            tbl3.title = title
            return title
        end,
        getSubtitle = function(str1: string) -- name: getSubtitleGetter
            local tbl2 = tbl1

            local function func1(arg4)
                local conversation = arg1.getConversation(str1, arg4)
                if conversation == nil then
                    return ""
                end

                if FFlagAppChatDerivedConversationLatestActivity then
                    local str2 = str1
                    local tbl3 = tbl1

                    local function func2(arg5)
                        for _, value in arg3.getOrderedIds(str2, arg5) do
                            local message = arg2.getMessage(value, arg5)
                            if message ~= nil and message.is_previewable == true then
                                return message
                            end
                        end
                        return nil
                    end

                    local tbl4 = tbl3[str2]
                    local var1

                    if tbl4 then
                        var1 = tbl4.newestPreviewableMessage

                        if var1 == nil then
                            var1 = Signals.createComputed(func2)
                            tbl4.newestPreviewableMessage = var1
                        end
                    else
                        tbl4 = {}
                        tbl3[str2] = tbl4

                        var1 = Signals.createComputed(func2)
                        tbl4.newestPreviewableMessage = var1
                    end

                    local var2 = var1(arg4)

                    if var2 ~= nil and isNewerPreviewThanServer(conversation, var2) then
                        return (getSubtitle(conversation, var2))
                    end
                end

                local message = if conversation.previewMessageId == nil then nil else arg2.getMessage(conversation.previewMessageId, arg4)
                return (getSubtitle(conversation, message))
            end

            local tbl3 = tbl2[str1]
            if tbl3 then
                local subtitle = tbl3.subtitle
                if subtitle ~= nil then
                    return subtitle
                end
            else
                tbl3 = {}
                tbl2[str1] = tbl3
            end

            local subtitle = Signals.createComputed(func1)
            tbl3.subtitle = subtitle
            return subtitle
        end,
        getIsSubtitlePending = function(str1: string)
            local tbl2 = tbl1

            local function func1(arg4)
                local conversation = arg1.getConversation(str1, arg4)
                if conversation ~= nil then
                    return (useIsUserPending(conversation))
                end

                return false
            end

            local tbl3 = tbl2[str1]
            if tbl3 then
                local isSubtitlePending = tbl3.isSubtitlePending
                if isSubtitlePending ~= nil then
                    return isSubtitlePending
                end
            else
                tbl3 = {}
                tbl2[str1] = tbl3
            end

            local isSubtitlePending = Signals.createComputed(func1)
            tbl3.isSubtitlePending = isSubtitlePending
            return isSubtitlePending
        end,
        getHasUnreadMessages = function(str1: string)
            local tbl2 = tbl1

            local function func1(arg4): boolean
                local conversation = arg1.getConversation(str1, arg4)
                return not (conversation == nil) and conversation.hasUnreadMessages == true
            end

            local tbl3 = tbl2[str1]
            if tbl3 then
                local hasUnreadMessages = tbl3.hasUnreadMessages
                if hasUnreadMessages ~= nil then
                    return hasUnreadMessages
                end
            else
                tbl3 = {}
                tbl2[str1] = tbl3
            end

            local hasUnreadMessages = Signals.createComputed(func1)
            tbl3.hasUnreadMessages = hasUnreadMessages
            return hasUnreadMessages
        end,
        getHasGroupUp = function(str1: string)
            local tbl2 = tbl1

            local function func1(arg4): boolean
                local conversation = arg1.getConversation(str1, arg4)
                return not (conversation == nil) and conversation.hasGroupUp == true
            end

            local tbl3 = tbl2[str1]
            if tbl3 then
                local hasGroupUp = tbl3.hasGroupUp
                if hasGroupUp ~= nil then
                    return hasGroupUp
                end
            else
                tbl3 = {}
                tbl2[str1] = tbl3
            end

            local hasGroupUp = Signals.createComputed(func1)
            tbl3.hasGroupUp = hasGroupUp
            return hasGroupUp
        end,
        getShouldShowOSA = function(str1: string)
            local tbl2 = tbl1

            local function func1(arg4): boolean
                local conversation = arg1.getConversation(str1, arg4)
                return not (conversation == nil) and shouldShowOSAForConversation(conversation) == true
            end

            local tbl3 = tbl2[str1]
            if tbl3 then
                local shouldShowOsa = tbl3.shouldShowOSA
                if shouldShowOsa ~= nil then
                    return shouldShowOsa
                end
            else
                tbl3 = {}
                tbl2[str1] = tbl3
            end

            local shouldShowOsa = Signals.createComputed(func1)
            tbl3.shouldShowOSA = shouldShowOsa
            return shouldShowOsa
        end,
        getShouldShowU13ChatOptIn = function(str1: string)
            local tbl2 = tbl1

            local function func1(arg4): boolean
                local conversation = arg1.getConversation(str1, arg4)
                return not (conversation == nil) and shouldShowU13ChatOptInForConversation(conversation) == true
            end

            local tbl3 = tbl2[str1]
            if tbl3 then
                local shouldShowU13ChatOptIn = tbl3.shouldShowU13ChatOptIn
                if shouldShowU13ChatOptIn ~= nil then
                    return shouldShowU13ChatOptIn
                end
            else
                tbl3 = {}
                tbl2[str1] = tbl3
            end

            local shouldShowU13ChatOptIn = Signals.createComputed(func1)
            tbl3.shouldShowU13ChatOptIn = shouldShowU13ChatOptIn
            return shouldShowU13ChatOptIn
        end,
        getConversationType = function(str1: string)
            local tbl2 = tbl1

            local function func1(arg4)
                local conversation = arg1.getConversation(str1, arg4)
                return if conversation == nil then nil else conversation.conversationType
            end

            local tbl3 = tbl2[str1]
            if tbl3 then
                local conversationType = tbl3.conversationType
                if conversationType ~= nil then
                    return conversationType
                end
            else
                tbl3 = {}
                tbl2[str1] = tbl3
            end

            local conversationType = Signals.createComputed(func1)
            tbl3.conversationType = conversationType
            return conversationType
        end,
        getUnixTime = function(str1: string) -- name: getUnixTimeGetter
            local tbl2 = tbl1

            local function func1(arg4)
                local conversation = arg1.getConversation(str1, arg4)
                if not FFlagAppChatDerivedConversationLatestActivity then
                    if conversation ~= nil then
                        return (getUnixTime(conversation.lastUpdated))
                    end

                    return nil
                end

                if conversation == nil then
                    return nil
                end

                local str2 = str1
                local tbl3 = tbl1

                local function func2(arg5)
                    for _, value in arg3.getOrderedIds(str2, arg5) do
                        local message = arg2.getMessage(value, arg5)
                        if message ~= nil and message.is_previewable == true then
                            return message
                        end
                    end
                    return nil
                end

                local tbl4 = tbl3[str2]
                local var1

                if tbl4 then
                    var1 = tbl4.newestPreviewableMessage

                    if var1 == nil then
                        var1 = Signals.createComputed(func2)
                        tbl4.newestPreviewableMessage = var1
                    end
                else
                    tbl4 = {}
                    tbl3[str2] = tbl4

                    var1 = Signals.createComputed(func2)
                    tbl4.newestPreviewableMessage = var1
                end

                return getLatestUnixSeconds(conversation, (var1(arg4)))
            end

            local tbl3 = tbl2[str1]
            if tbl3 then
                local unixTime = tbl3.unixTime
                if unixTime ~= nil then
                    return unixTime
                end
            else
                tbl3 = {}
                tbl2[str1] = tbl3
            end

            local unixTime = Signals.createComputed(func1)
            tbl3.unixTime = unixTime
            return unixTime
        end,
        getTestId = function(str1: string)
            local tbl2 = tbl1

            local function func1(arg4)
                local conversation = arg1.getConversation(str1, arg4)
                if conversation == nil then
                    return nil
                end
                return DomLocators.chatLandingConversationEntry((getLocatorTitle(conversation)))
            end

            local tbl3 = tbl2[str1]
            if tbl3 then
                local testId = tbl3.testId
                if testId ~= nil then
                    return testId
                end
            else
                tbl3 = {}
                tbl2[str1] = tbl3
            end

            local testId = Signals.createComputed(func1)
            tbl3.testId = testId
            return testId
        end,
        getLocatorTitle = function(str1: string) -- name: getLocatorTitleGetter
            local tbl2 = tbl1

            local function func1(arg4)
                local conversation = arg1.getConversation(str1, arg4)
                local title

                if conversation == nil then
                    title = nil
                else
                    title = conversation.title

                    if not title then
                        return (getTitle(conversation))
                    end
                end

                return title
            end

            local tbl3 = tbl2[str1]
            if tbl3 then
                local locatorTitle = tbl3.locatorTitle
                if locatorTitle ~= nil then
                    return locatorTitle
                end
            else
                tbl3 = {}
                tbl2[str1] = tbl3
            end

            local locatorTitle = Signals.createComputed(func1)
            tbl3.locatorTitle = locatorTitle
            return locatorTitle
        end
    }
end
return createConversationViewModelStore
