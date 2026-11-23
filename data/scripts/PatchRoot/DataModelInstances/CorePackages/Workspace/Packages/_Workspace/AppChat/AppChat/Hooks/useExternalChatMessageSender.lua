-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:40:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local Http = require(AppChatParent.Http)
local _LuauPolyfill = require(AppChatParent.LuauPolyfill)
local Promise = require(AppChatParent.Promise)
local React = require(AppChatParent.React)
local RetrievalStatus = Http.Enum.RetrievalStatus
local StatusCodes = Http.StatusCodes
local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector
local NavigateIntoChat = require(AppChat.Actions.NavigateIntoChat)
local NavigateIntoChat2 = require(AppChat.Conversations.Thunks.NavigateIntoChat)
local ReceivedConversation = require(AppChat.Conversations.Actions.ReceivedConversation)
local SendTextMessage = require(AppChat.Conversations.Thunks.SendTextMessage)
local createConversation = require(AppChat.Conversations.Thunks.createConversation)
local createConversationFromFriendPlaceholder = require(AppChat.Conversations.createConversationFromFriendPlaceholder)
local EnumScreens = require(AppChat.EnumScreens)
local GetChatModerationStatusDataHydration = require(AppChat.Stores.GetChatModerationStatusDataHydration)
local _GetConversationStore = require(AppChat.Stores.GetConversationStore)
local getConversationSendEligibilityStatus = require(AppChat.Utils.getConversationSendEligibilityStatus)
local getUserSendEligibilityStatus = require(AppChat.Utils.getUserSendEligibilityStatus)
local navigateWithOsaGate = require(AppChat.Utils.navigateWithOsaGate)
local useAppPolicy = require(AppChat.Hooks.useAppPolicy)
local useIsChatEnabled = require(AppChat.Hooks.useIsChatEnabled)
local useIsChatUserMessagesEnabled = require(AppChat.Hooks.useIsChatUserMessagesEnabled)
local useChatSettingsRetrievalStatus = require(AppChat.Hooks.useChatSettingsRetrievalStatus)
local useIsGroupChatEnabled = require(AppChat.Hooks.useIsGroupChatEnabled)
local isNavigationAvailable = require(AppChatParent.RobloxAppNavigation).isNavigationAvailable

local function makeSendResult(status: string, conversationId: string?) -- Luacid: Inlined by compiler; 10 call sites recovered
    return { conversationId = conversationId, status = status }
end

local function isSuccessfulResponse(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1 then
        if arg1.responseCode == StatusCodes.OK then
            arg1 = arg1.responseBody and arg1.responseBody.messages and arg1.responseBody.messages[1]
        else
            arg1 = false
        end
    end

    local status = arg1 and arg1.status

    return not (arg1 == nil) and (status == nil or status == "" or status == AppChatNetworking.Constants.ResponseStatus.SUCCESS)
end

local function useExternalChatMessageSender(bool1: boolean)
    local dispatch = useDispatch()
    local timeoutStore = GetChatModerationStatusDataHydration()
    local var2 = useAppPolicy(function(arg1)
        return arg1.getCanUsePlatformChat()
    end)
    local var3 = useAppPolicy(function(arg1)
        return arg1.getCanSeeChatTerminology()
    end)
    local var4 = useChatSettingsRetrievalStatus()
    local var5 = useSelector(function(arg1): number
        return tonumber(arg1.LocalUserId) or 0
    end)
    local var6 = useSelector(function(arg1): boolean
        return arg1.Navigation ~= nil
    end)
    local var7 = useIsChatEnabled()
    local var8 = useIsChatUserMessagesEnabled()
    local isGroupChatEnabled = useIsGroupChatEnabled()

    local isLoading = var4 ~= RetrievalStatus.Done
    local isAvailable = not isLoading and var2 and var3 and var7 and var8

    local var11 = React.useCallback(function(conversation, allowConversationStatusLoading: boolean)
        return getConversationSendEligibilityStatus({
            allowConversationStatusLoading = allowConversationStatusLoading,
            conversation = conversation,
            currentTimestamp = DateTime.now().UnixTimestamp,
            isAvailable = isAvailable,
            isGroupChatEnabled = isGroupChatEnabled,
            scope = false,
            timeoutStore = timeoutStore
        })
    end, { isAvailable, isGroupChatEnabled, timeoutStore })

    local canSendToConversation = React.useCallback(function(arg1): boolean
        return var11(arg1, false) == "eligible"
    end, { var11 })

    local canSendToUser = React.useCallback(function(_: string): boolean
        return getUserSendEligibilityStatus(
            {
                currentTimestamp = DateTime.now().UnixTimestamp,
                isAvailable = isAvailable,
                scope = false
            }
        ) == "eligible"
    end, { isAvailable })

    local var14 = React.useCallback(function(arg1, bool3: boolean, str1: string)
        return arg1:andThen(function(arg2)
            local id = arg2 and arg2.id
            if arg2 == nil or id == nil or id == "" or arg2.source == "friends" or var11(arg2, bool3) ~= "eligible" then
                return makeSendResult("failure", nil)
            end

            if bool3 then
                dispatch(ReceivedConversation(arg2))
            end

            return Promise.new(function(callback)
                local function sendMessage()
                    dispatch(SendTextMessage(id, str1, nil)):andThen(function(arg3)
                        local var14 = callback
                        local tbl1 = if isSuccessfulResponse(arg3) then makeSendResult("success", id) else makeSendResult("failure", nil)
                        var14(tbl1)
                    end, function()
                        local sendResult = makeSendResult("failure", nil)
                        callback(sendResult)
                    end)
                end

                navigateWithOsaGate({
                    conversationId = id,
                    dispatch = dispatch,
                    onAccepted = function()
                        sendMessage()
                    end,
                    onDeclined = function()
                        local sendResult = makeSendResult("declined", nil)
                        callback(sendResult)
                    end,
                    onError = function()
                        local sendResult = makeSendResult("failure", nil)
                        callback(sendResult)
                    end
                })
            end)
        end):catch(function()
            return makeSendResult("failure", nil)
        end)
    end, { dispatch, var11 })

    local sendToConversation = React.useCallback(function(arg1, str1: string)
        if not canSendToConversation(arg1) then
            local sendResult = makeSendResult("failure", nil)
            return Promise.resolve(sendResult)
        end

        local bool3 = arg1.source == "friends"
        local conversationFromFriendPlaceholder

        if bool3 then
            conversationFromFriendPlaceholder = createConversationFromFriendPlaceholder(arg1, var5)
            if conversationFromFriendPlaceholder == nil then
                local sendResult = makeSendResult("failure", nil)
                return Promise.resolve(sendResult)
            end
        else
            conversationFromFriendPlaceholder = Promise.resolve(arg1)
        end

        return var14(conversationFromFriendPlaceholder, bool3, str1)
    end, { canSendToConversation, var5, var14 })

    local sendToUser = React.useCallback(function(str1: string, str2: string)
        if canSendToUser(str1) then
            return var14(dispatch(createConversation("one_to_one", { str1 })), true, str2)
        end

        local sendResult = makeSendResult("failure", nil)
        return Promise.resolve(sendResult)
    end, { canSendToUser, dispatch, var14 })
    local var17 = React.useCallback(function(conversationId: string?)
        dispatch(NavigateIntoChat2({ conversationId = conversationId }, true))
        if conversationId ~= nil then
            return
        end

        dispatch(NavigateIntoChat({ screen = EnumScreens.ChatLanding, params = {} }))
    end, { dispatch })
    local var18 = not bool1 and (isNavigationAvailable() or var6)

    return React.useMemo(function()
        return {
            isAvailable = isAvailable,
            isGroupChatEnabled = isGroupChatEnabled,
            isLoading = isLoading,
            canSendToConversation = canSendToConversation,
            canSendToUser = canSendToUser,
            navigateToChat = if var18 then var17 else nil,
            sendToConversation = sendToConversation,
            sendToUser = sendToUser
        }
    end, {
        isAvailable,
        isGroupChatEnabled,
        isLoading,
        canSendToConversation,
        canSendToUser,
        var17,
        var18,
        sendToConversation,
        sendToUser
    })
end

return useExternalChatMessageSender
