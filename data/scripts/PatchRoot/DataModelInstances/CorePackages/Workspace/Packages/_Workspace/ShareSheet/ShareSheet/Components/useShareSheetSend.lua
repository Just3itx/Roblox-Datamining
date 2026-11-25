-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:50:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheet = script:FindFirstAncestor("ShareSheet")
local ShareSheetParent = ShareSheet.Parent

local React = require(ShareSheetParent.React)

local _GetExternalChatMessageSenderStore = require(ShareSheetParent.AppChat.GetExternalChatMessageSenderStore)
local _InExperienceLocales = require(ShareSheetParent.InExperienceLocales)
local LocalizationRoactContext = require(ShareSheetParent.Localization).LocalizationRoactContext
local Recipient = require(ShareSheet.Recipients.Recipient)
local _RecipientSource = require(ShareSheet.Recipients.RecipientSource)
local ShareSheetTelemetry = require(ShareSheet.telemetry.ShareSheetTelemetry)

local function formatLocalizedSnackbarTitle(arg1, bool1: boolean, num1: number, tbl1, formatSuccessSnackbarText: ((...any) -> (...any))?)
    if not bool1 then
        return arg1:Format(
            if num1 == 1 then "Feature.UniversalShareSheet.Response.NotSharedMessage" else "Feature.UniversalShareSheet.Response.NotSharedMultipleMessages"
        )
    elseif formatSuccessSnackbarText == nil then
        return arg1:Format(
            if num1 == 1 then "Feature.UniversalShareSheet.Response.SharedMessage" else "Feature.UniversalShareSheet.Response.SharedMultipleMessages"
        )
    else
        local customMessage = formatSuccessSnackbarText(tbl1)
        local n = #tbl1 - 1
        if n <= 0 then
            return customMessage
        end

        return (arg1:Format(
            if n == 1 then "Feature.UniversalShareSheet.Response.SharedCustomMessage" else "Feature.UniversalShareSheet.SharedCustomMultipleMessages",
            { CUSTOM_MESSAGE = customMessage, N = n }
        ))
    end
end

local function useShareSheetSend(tbl1)
    local isSending, var2 = React.useState(false)
    local var3 = React.useRef(false)
    local var4 = React.useContext(LocalizationRoactContext)

    return {
        isSending = isSending,
        onSendActivated = React.useCallback(function(str1: string)
            if var3.current then
                return
            end

            local hasCustomMessage = string.find(str1, "%S") ~= nil
            if hasCustomMessage then
                ShareSheetTelemetry.logInteraction({
                    context = tbl1.context,
                    recipientSource = tbl1.recipientSource,
                    telemetryId = tbl1.telemetryId or "",
                    interactionType = ShareSheetTelemetry.InteractionType.CustomMessageSubmitted
                })
            end

            local tbl2 = {}
            if tbl1.chatShare ~= nil then
                for _, recipient in tbl1.recipients do
                    if tbl1.selectedConversationIds[recipient.id] and Recipient.canSend(tbl1.chatShare, recipient) then
                        table.insert(tbl2, recipient)
                    end
                end
            end
            local num1 = #tbl2
            local chatShare = tbl1.chatShare
            if chatShare == nil or num1 == 0 then
                tbl1.onSendActivated()
                return
            end

            var3.current = true
            var2(true)

            local bool2 = false
            local bool3 = false
            local bool4 = false
            local tbl3 = {}
            local var5 = if str1 == "" then tbl1.url else `{tbl1.url} {str1}`

            local function finishSending()
                var3.current = false
                var2(false)

                if not (bool3 or bool4) then
                    return
                end

                if tbl1.onShareSendResultSnackbar then
                    local navigateToChat = chatShare.navigateToChat
                    local conversationId = if num1 == 1 and #tbl3 == 1 then tbl3[1].conversationId else nil

                    tbl1.onShareSendResultSnackbar({
                        action = bool4 and navigateToChat and {
                            onActivated = function()
                                ShareSheetTelemetry.logInteraction({
                                    context = tbl1.context,
                                    recipientSource = tbl1.recipientSource,
                                    telemetryId = tbl1.telemetryId or "",
                                    interactionType = ShareSheetTelemetry.InteractionType.ViewMessage,
                                    requestedConversationId = if num1 == 1 then tbl2[1].id else nil,
                                    resolvedConversationId = conversationId,
                                    viewDestination = if conversationId then ShareSheetTelemetry.ViewDestination.Conversation else ShareSheetTelemetry.ViewDestination.ChatLanding
                                })

                                navigateToChat(conversationId)
                            end,
                            text = var4:Format("CommonUI.Messages.Action.View")
                        } or nil,
                        title = formatLocalizedSnackbarTitle(var4, bool4, num1, tbl3, tbl1.formatSuccessSnackbarText)
                    })
                end

                if bool4 then
                    tbl1.onSendActivated()
                    tbl1.onCloseWithReason(ShareSheetTelemetry.CloseReason.SendSuccess)
                end
            end

            local function send(num2: number)
                local var6 = tbl2[num2]
                local var7 = ShareSheetTelemetry.startMessageSendResult({
                    context = tbl1.context,
                    recipientSource = tbl1.recipientSource,
                    telemetryId = tbl1.telemetryId or "",
                    requestedConversationId = var6.id,
                    hasCustomMessage = hasCustomMessage
                })
                return Recipient.send(chatShare, var6, var5):catch(function()
                    return { status = "failure" }
                end):andThen(function(arg1)
                    var7(arg1)
                    if arg1.status == "success" and arg1.conversationId then
                        bool4 = true
                        table.insert(tbl3, { conversationId = arg1.conversationId, displayName = Recipient.getName(var6, false) })
                    elseif arg1.status == "failure" then
                        bool3 = true
                    elseif arg1.status == "declined" then
                        bool2 = true
                    end
                end)
            end

            local var6 = send(1)
            for i = 2, num1 do
                var6 = var6:andThen(function()
                    if not bool2 then
                        return send(i)
                    end
                end)
            end
            var6:andThen(finishSending)
        end, {
            tbl1.chatShare,
            tbl1.context,
            tbl1.formatSuccessSnackbarText,
            tbl1.onCloseWithReason,
            tbl1.onSendActivated,
            tbl1.onShareSendResultSnackbar,
            tbl1.recipients,
            tbl1.recipientSource,
            tbl1.selectedConversationIds,
            tbl1.telemetryId,
            tbl1.url,
            var4
        })
    }
end
return useShareSheetSend
