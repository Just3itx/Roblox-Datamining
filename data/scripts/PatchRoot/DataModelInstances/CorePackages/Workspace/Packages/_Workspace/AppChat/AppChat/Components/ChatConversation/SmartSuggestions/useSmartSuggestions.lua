-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:50:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local Cryo = require(AppChatParent.Cryo)
local OrderedMap = require(AppChatParent.AppCommonLib).OrderedMap
local useCanAccessParty = require(AppChatParent.Squads.useCanAccessParty)

local RoactRodux = require(AppChatParent.RoactUtils).Hooks.RoactRodux
local useSelector = RoactRodux.useSelector
local useStore = RoactRodux.useStore

local Constants = require(AppChat.Components.EventReceivers.Constants)
local _PlatformChatConversationTypes = require(AppChat.Components.EventReceivers.PlatformChatConversationTypes)

local useRealtimePlatformChatConversation = require(AppChat.Components.EventReceivers.useRealtimePlatformChatConversation)
local getDeepValue = require(AppChat.Utils.getDeepValue)
local MessageModel = require(AppChat.Models.MessageModel)
local Types = require(script.Parent.Types)
local SmartSuggestionActionHandler = require(script.Parent.SmartSuggestionActionHandler)
local fetchSmartSuggestions = require(script.Parent.fetchSmartSuggestions)
local useStartPartySuggestion = require(script.Parent.useStartPartySuggestion)

local createSmartSuggestionActionHandler = SmartSuggestionActionHandler.createSmartSuggestionActionHandler
local SuggestionType = Types.SuggestionType

local function getConversationMessages(arg1, str1: string?) -- Luacid: Inlined by compiler; 4 call sites recovered
    if str1 == nil then
        return nil
    end

    local deepValue = getDeepValue(arg1, `ChatAppReducer.Conversations.{str1}`)
    return if deepValue == nil or deepValue.messages == nil then nil else deepValue.messages
end

local function getLatestUserMessageId(arg1, str1: string?)
    local conversationMessages = getConversationMessages(arg1, str1)

    if conversationMessages == nil or conversationMessages.keys == nil or conversationMessages.values == nil then
        return nil
    end

    for i = OrderedMap.Length(conversationMessages), 1, -1 do
        local byIndex = OrderedMap.GetByIndex(conversationMessages, i)
        if byIndex and byIndex.senderType == MessageModel.SenderTypes.User then
            return byIndex.id
        end
    end

    return nil
end

local function isMessageCommitted(state, str1: string, messageId: string): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    local conversationMessages = getConversationMessages(state, str1)
    return not (conversationMessages == nil or conversationMessages.values == nil)
        and OrderedMap.Get(conversationMessages, messageId) ~= nil
end

local function useSmartSuggestions<T>(str1: string, sendMessage: (...any) -> (...any), sendGameLinkChatMessage: (...any) -> (...any))
    local var1 = useCanAccessParty()
    local var2 = useStartPartySuggestion(str1, var1)
    local canStartParty = var2.canStartParty
    local startParty = var2.startParty
    local var3 = useStore()
    local var4 = React.useCallback(function(arg1)
        return (getLatestUserMessageId(arg1, str1))
    end, { str1 })
    local previousNewestUserMessageId = useSelector(var4)
    local var6 = React.useMemo(function()
        return createSmartSuggestionActionHandler(
            {
                sendMessage = sendMessage,
                sendGameLinkChatMessage = sendGameLinkChatMessage,
                startParty = startParty
            }
        )
    end, { sendMessage, sendGameLinkChatMessage, startParty })

    local var7, var8 = React.useState({})
    local areSuggestionsDismissed, var10 = React.useState(false)
    local suggestions = React.useMemo(function()
        return Cryo.List.filter(var7, function(arg1)
            return arg1.type ~= SuggestionType.StartParty or canStartParty
        end)
    end, { var7, canStartParty })

    local var12 = React.useRef({
        requestId = 0,
        pendingRealtimeNotification = nil,
        previousNewestUserMessageId = previousNewestUserMessageId,
        newestMessageConversationId = str1
    })

    local var13 = React.useCallback(function()
        if str1 == nil then
            return
        end
        local current = var12.current
        current.requestId += 1
        local requestId = var12.current.requestId
        fetchSmartSuggestions(str1):andThen(function(tbl1)
            if var12.current.requestId ~= requestId then
                return
            end
            var8(tbl1)
            var10(false)
        end):catch(function() end)
    end, { str1 })

    React.useEffect(function()
        var8({})
        var10(false)
        var13()
        return function()
            local current = var12.current
            current.requestId += 1
            var12.current.pendingRealtimeNotification = nil
        end
    end, { str1, var13 })

    local var14 = React.useCallback(function(arg1)
        if arg1.Type ~= Constants.PlatformChatConversation.Types.ConversationSuggestionsGenerated
            or str1 == nil
            or arg1.ConversationId ~= str1
        then
            return
        end

        local state = var3:getState()
        local latestUserMessageId = getLatestUserMessageId(state, str1)
        if arg1.MessageId ~= latestUserMessageId then
            if isMessageCommitted(state, str1, arg1.MessageId) then
                return
            end
            var12.current.pendingRealtimeNotification = {
                conversationId = str1,
                messageId = arg1.MessageId
            }
        elseif var12.current.newestMessageConversationId ~= str1 or var12.current.previousNewestUserMessageId ~= arg1.MessageId then
            var12.current.pendingRealtimeNotification = {
                conversationId = str1,
                messageId = arg1.MessageId
            }
        else
            var13()
        end
    end, { str1, var3, var13 })

    useRealtimePlatformChatConversation(var14, { var14 })

    React.useEffect(function()
        local previousNewestUserMessageId2 = var12.current.previousNewestUserMessageId
        local newestMessageConversationId = var12.current.newestMessageConversationId
        var12.current.previousNewestUserMessageId = previousNewestUserMessageId
        var12.current.newestMessageConversationId = str1

        if previousNewestUserMessageId2 == previousNewestUserMessageId or newestMessageConversationId ~= str1 then
            return
        end

        local current = var12.current
        current.requestId += 1
        var8({})
        var10(false)

        local pendingRealtimeNotification = var12.current.pendingRealtimeNotification
        if pendingRealtimeNotification == nil or pendingRealtimeNotification.conversationId ~= str1 then
            return
        end

        if pendingRealtimeNotification.messageId == previousNewestUserMessageId then
            var12.current.pendingRealtimeNotification = nil
            var13()
        elseif isMessageCommitted(var3:getState(), str1, pendingRealtimeNotification.messageId) then
            var12.current.pendingRealtimeNotification = nil
        end
    end, {
        previousNewestUserMessageId,
        str1,
        var3,
        var13
    })
    return {
        suggestions = suggestions,
        areSuggestionsDismissed = areSuggestionsDismissed,
        onActivated = React.useCallback(function(arg1)
            var10(true)

            local var15 = var6(arg1, str1)
            if typeof(var15) == "table" and typeof(var15.catch) == "function" then
                var15:catch(function()
                    var10(false)
                end)
            end
        end, { var6, str1 })
    }
end

return useSmartSuggestions
