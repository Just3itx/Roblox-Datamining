-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:41:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheet = script:FindFirstAncestor("ShareSheet")
local ShareSheetParent = ShareSheet.Parent

local React = require(ShareSheetParent.React)

local _GetExternalChatMessageSenderStore = require(ShareSheetParent.AppChat.GetExternalChatMessageSenderStore)
local ListRecipientsStatus = require(ShareSheet.Recipients.ListRecipientsStatus)
local Recipient = require(ShareSheet.Recipients.Recipient)
local getSelectableRecipients = require(ShareSheet.Recipients.getSelectableRecipients)
local ShareSheetConstants = require(ShareSheet.ShareSheetConstants)
local _Types = require(ShareSheet.Types)

local function getCompactRecipients<T>(recipients, tbl1, selectedConversationIds, func1: (...any) -> (...any)): {T}
    local compactRecipients = {}
    local tbl2 = {}
    local recipientsLen = #recipients
    local fIntShareSheetMaxConversations = ShareSheetConstants.FIntShareSheetMaxConversations

    for i = 1, math.min(recipientsLen, fIntShareSheetMaxConversations) do
        local recipient = recipients[i]
        table.insert(compactRecipients, recipient)
        tbl2[recipient.id] = true
    end

    for _, value in tbl1 do
        if selectedConversationIds[value.id] and not tbl2[value.id] and func1(value) then
            table.insert(compactRecipients, value)
            tbl2[value.id] = true
        end
    end

    return compactRecipients
end

local function useShareSheetRecipientModel(tbl1)
    local bool1 = tbl1.chatShare ~= nil
    local listResult = tbl1.listResult

    local var1 = React.useRef(listResult)
    if tbl1.isSending then
        listResult = var1.current
    else
        var1.current = listResult
    end
    local bool2 = #listResult.recipients > 0
    local bool3 = listResult.status == ListRecipientsStatus.Failed
    local bool4 = listResult.status == ListRecipientsStatus.Loading
    local isAvailable = not (tbl1.chatShare == nil) and tbl1.chatShare.isAvailable
    local isActive = tbl1.isOpen and isAvailable and bool2
    local isGroupChatEnabled = if tbl1.chatShare then tbl1.chatShare.isGroupChatEnabled else false
    local recipients = listResult.recipients
    local var3 = Recipient.useEligibleRecipients({
        recipients = recipients,
        isActive = isActive,
        isGroupChatEnabled = isGroupChatEnabled,
        maxCount = ShareSheetConstants.FIntShareSheetMaxConversations
    })
    local searchResult = tbl1.searchResult
    local selectableRecipients = getSelectableRecipients(recipients, tbl1.pickedRecipients)
    local useEligibleRecipients = Recipient.useEligibleRecipients
    local tbl2 = { recipients = 0, isActive = 0, isGroupChatEnabled = 0, maxCount = 0 }
    if searchResult then
        recipients = searchResult.recipients
    end

    tbl2.recipients = recipients
    tbl2.isActive = isActive and tbl1.isPeoplePickerDisplayed
    tbl2.isGroupChatEnabled = isGroupChatEnabled
    tbl2.maxCount = ShareSheetConstants.FIntShareSheetPeoplePickerMaxConversations
    local var4 = useEligibleRecipients(tbl2)

    local socialRowRecipients = {
        recipients = getCompactRecipients(var3.recipients, selectableRecipients, tbl1.selectedConversationIds, function(arg1)
            return not (tbl1.chatShare == nil) and Recipient.canSend(tbl1.chatShare, arg1)
        end),
        isLoading = var3.isLoading
    }

    local peoplePickerRecipients = {
        recipients = if var4.isLoading and not var3.isLoading and searchResult == nil then var3.recipients else var4.recipients,
        isLoading = if searchResult then searchResult.status == ListRecipientsStatus.Loading
            or searchResult.status == ListRecipientsStatus.Ready and var4.isLoading else not bool3 and var4.isLoading
    }

    local bool5 = bool1 and bool4

    return {
        socialRowRecipients = socialRowRecipients,
        isSocialRowLoading = isAvailable and bool5,
        peoplePickerRecipients = peoplePickerRecipients,
        peoplePickerListResult = tbl1.searchResult or listResult,
        shouldShowSocialRow = isAvailable and (bool2 or bool5)
    }
end

return useShareSheetRecipientModel
