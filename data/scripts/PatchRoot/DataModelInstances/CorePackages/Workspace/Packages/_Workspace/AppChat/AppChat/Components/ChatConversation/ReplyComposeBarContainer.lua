-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:40:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local Cryo = require(AppChatParent.Cryo)
local ReplyComposeBar = require(script.Parent.ReplyComposeBar)
local populateUserWithState = require(AppChat.Users.populateUserWithState)
local UserProfiles = require(AppChatParent.UserProfiles)

local useSignalState = require(AppChatParent.SignalsReact).useSignalState
local GetReplyingToStore = require(AppChat.Stores.GetReplyingToStore)
local GetConversationMessageStore = require(AppChat.Stores.GetConversationMessageStore)

local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector
local useLocalUserId = require(AppChatParent.RobloxAppHooks).useLocalUserId
local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization
local useTelemetry = require(AppChat.Telemetry.useTelemetry)

local ChatConversationTelemetryEvents = require(script.Parent.ChatConversationTelemetryEvents)
local ChatConversationTelemetryLayer = require(AppChat.Telemetry.Layers.ChatConversationTelemetryLayer)

local FFlagAppChatSignalsReplyStore = require(AppChat.Flags.FFlagAppChatSignalsReplyStore)
local FFlagAppChatUseUserProfileHydration = require(AppChat.Flags.FFlagAppChatUseUserProfileHydration)
local useProfileName = require(AppChat.Hooks.useProfileName)

local tbl1 = {
    LayoutOrder = 3,
    message = nil,
    close = function() end,
    inputBoxRef = nil,
    unknownUserKey = "Feature.Chat.Label.UnknownUser",
    replyingToYourselfKey = "Feature.Chat.Label.ReplyingToYourself",
    replyingToOthersKey = "Feature.Chat.Label.ReplyingToOthers"
}

function getTargetMessageInfo(message)
    if not message then
        return {}
    end
    return {
        targetMessageSenderId = message.senderTargetId,
        targetMessageId = message.id,
        targetMessageSentAt = if message.sent then message.sent.dateTime else nil,
        targetMessageLength = message.content and #message.content or nil
    }
end

local function getTargetMessageInfoFromSignals(targetMessageSenderId: string?, targetMessageId: string?, str1: string?) -- Luacid: Inlined by compiler; 2 call sites recovered
    return {
        targetMessageSenderId = targetMessageSenderId,
        targetMessageId = targetMessageId,
        targetMessageLength = str1 and #str1 or nil
    }
end

function ReplyComposeBarContainer(tbl2)
    local var1 = Cryo.Dictionary.union(tbl1, tbl2)
    local var2 = useLocalUserId()
    local var3 = useTelemetry(ChatConversationTelemetryLayer.Context)

    if not FFlagAppChatSignalsReplyStore then
        React.useEffect(function()
            var3.emit(ChatConversationTelemetryEvents.ConversationInputBarReplyComposeRendered, getTargetMessageInfo(var1.message))

            return function() end
        end, {})

        local var4 = useSelector(function(arg1)
            local user = if arg1 and arg1.Users and var1.message.senderTargetId then arg1.Users[var1.message.senderTargetId] else nil
            return if user then {
                targetUser = populateUserWithState(arg1, user)
            } else {}
        end)

        local var5 = nil
        local var6 = nil
        if FFlagAppChatUseUserProfileHydration then
            var6 = useProfileName(var1.message.senderTargetId)
        else
            var5 = UserProfiles.Hooks.useUserProfilesFetch(
                {
                    userIds = { var1.message.senderTargetId },
                    query = UserProfiles.Queries.userProfilesCombinedNameAndUsernameByUserIds
                }
            )
        end

        local var7

        if var4.targetUser and var4.targetUser.displayName and var4.targetUser.displayName ~= "" then
            var7 = var4.targetUser.displayName
        elseif FFlagAppChatUseUserProfileHydration then
            var7 = var6.combinedName or var1.unknownUserKey
        elseif var5.data and var5.data.userProfiles and var5.data.userProfiles[1] and var5.data.userProfiles[1].names then
            var7 = UserProfiles.Selectors.getCombinedNameFromId(var5.data, var1.message.senderTargetId)
        else
            var7 = var1.unknownUserKey
        end

        local displayName = useLocalization(var7 == var1.unknownUserKey and { replyingToUserName = var7 } or {}).replyingToUserName or var7

        local bool1 = var2 == var1.message.senderTargetId
        local var8 = not bool1 and {
            var1.replyingToOthersKey,
            DISPLAY_NAME = displayName
        } or var1.replyingToYourselfKey

        local replyingToUserText = useLocalization({ replyingToUserText = var8 }).replyingToUserText
        local senderTargetId = if bool1 or not var4.targetUser then nil else var1.message.senderTargetId

        local onCloseActivated = React.useCallback(function()
            var3.emit(
                ChatConversationTelemetryEvents.ConversationInputBarReplyComposeCancelBtnActivated,
                getTargetMessageInfo(var1.message)
            )
            var1.close()
        end, { var1.close, var3, var1.message })

        return React.createElement(ReplyComposeBar, {
            LayoutOrder = var1.LayoutOrder,
            replyingToUserText = replyingToUserText,
            replyingToUserContent = var1.message.content,
            replyingToUserId = senderTargetId,
            onCloseActivated = onCloseActivated
        })
    end

    local replyingToStore = GetReplyingToStore(false)
    local conversationMessageStore = GetConversationMessageStore(false)

    local targetMessageId = useSignalState(replyingToStore.getMessageId)
    local var4 = React.useMemo(function()
        if targetMessageId == nil then
            return nil
        end

        return conversationMessageStore.messages(false)[targetMessageId]
    end, { targetMessageId, conversationMessageStore })

    local var5 = if var4 and var4.sender_user_id then tostring(var4.sender_user_id) else nil
    local content = if var4 then var4.content else nil

    React.useEffect(function()
        var3.emit(
            ChatConversationTelemetryEvents.ConversationInputBarReplyComposeRendered,
            (getTargetMessageInfoFromSignals(var5, targetMessageId, content))
        )
        return function() end
    end, {})

    local var6 = useSelector(function(arg1)
        local user = if arg1 and arg1.Users and var5 then arg1.Users[var5] else nil
        return if user then {
            targetUser = populateUserWithState(arg1, user)
        } else {}
    end)

    local var7 = nil
    local var8 = nil
    if FFlagAppChatUseUserProfileHydration then
        var8 = useProfileName(var5)
    else
        var7 = UserProfiles.Hooks.useUserProfilesFetch(
            {
                userIds = var5 and { var5 } or {},
                query = UserProfiles.Queries.userProfilesCombinedNameAndUsernameByUserIds
            }
        )
    end

    local var9

    if var6.targetUser and var6.targetUser.displayName and var6.targetUser.displayName ~= "" then
        var9 = var6.targetUser.displayName
    elseif FFlagAppChatUseUserProfileHydration then
        var9 = var8.combinedName or var1.unknownUserKey
    elseif var7.data and var7.data.userProfiles and var7.data.userProfiles[1] and var7.data.userProfiles[1].names then
        var9 = UserProfiles.Selectors.getCombinedNameFromId(var7.data, var5)
    else
        var9 = var1.unknownUserKey
    end

    local displayName = useLocalization(var9 == var1.unknownUserKey and { replyingToUserName = var9 } or {}).replyingToUserName or var9

    local bool1 = var2 == var5
    local var10 = not bool1 and {
        var1.replyingToOthersKey,
        DISPLAY_NAME = displayName
    } or var1.replyingToYourselfKey

    local replyingToUserText = useLocalization({ replyingToUserText = var10 }).replyingToUserText
    local replyingToUserId = if bool1 then nil elseif var6.targetUser then var5 else nil

    local onCloseActivated = React.useCallback(function()
        var3.emit(
            ChatConversationTelemetryEvents.ConversationInputBarReplyComposeCancelBtnActivated,
            (getTargetMessageInfoFromSignals(var5, targetMessageId, content))
        )
        var1.close()
    end, {
        var1.close,
        var3,
        var5,
        targetMessageId,
        content
    })
    return React.createElement(ReplyComposeBar, {
        LayoutOrder = var1.LayoutOrder,
        replyingToUserText = replyingToUserText,
        replyingToUserContent = content,
        replyingToUserId = replyingToUserId,
        onCloseActivated = onCloseActivated
    })
end

return React.memo(ReplyComposeBarContainer)
