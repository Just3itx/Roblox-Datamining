-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:50:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheet = script:FindFirstAncestor("ShareSheet")
local ShareSheetParent = ShareSheet.Parent

local Array = require(ShareSheetParent.LuauPolyfill).Array
local React = require(ShareSheetParent.React)
local SignalsReact = require(ShareSheetParent.SignalsReact)

local GetUniversalShareSheetStore = require(ShareSheet.Stores.GetUniversalShareSheetStore)
local GetExternalChatMessageSenderStore = require(ShareSheetParent.AppChat.GetExternalChatMessageSenderStore)
local useLocalization = require(ShareSheetParent.Localization).Hooks.useLocalization
local getAppFeaturePolicies = require(ShareSheetParent.UniversalAppPolicy).getAppFeaturePolicies
local _Recipient = require(ShareSheet.Recipients.Recipient)
local RecipientSource = require(ShareSheet.Recipients.RecipientSource)
local useRecipientList = require(ShareSheet.Recipients.useRecipientList)
local getSelectableRecipients = require(ShareSheet.Recipients.getSelectableRecipients)
local useRecipientSearch = require(ShareSheet.Recipients.useRecipientSearch)
local usePeoplePickerSearch = require(script.Parent.PeoplePicker.usePeoplePickerSearch)
local ShareSheetTelemetry = require(ShareSheet.telemetry.ShareSheetTelemetry)
local _ShareSheetView = require(script.Parent.ShareSheetView)
local usePeoplePickerViewModel = require(script.Parent.PeoplePicker.usePeoplePickerViewModel)
local useShareSheetRecipientModel = require(script.Parent.useShareSheetRecipientModel)
local useShareSheetSelection = require(script.Parent.useShareSheetSelection)
local useShareSheetSend = require(script.Parent.useShareSheetSend)

local function useShareSheetViewModel(tbl1)
    local universalShareSheetStore = GetUniversalShareSheetStore()
    local isPeoplePickerDisplayed = SignalsReact.useSignalState(universalShareSheetStore.getIsPeoplePickerDisplayed)
    local chatShare = SignalsReact.useSignalState(GetExternalChatMessageSenderStore().getSender)

    local listResult, var4 = useRecipientList(tbl1.recipientSource or RecipientSource.DefaultRecipientSource, chatShare ~= nil)

    local search = usePeoplePickerSearch()
    local var6 = useRecipientSearch(var4, search.debouncedQuery)

    local pickedRecipients, var8 = React.useState({})
    local recipients = React.useMemo(function()
        return getSelectableRecipients(listResult.recipients, pickedRecipients)
    end, { listResult.recipients, pickedRecipients })
    local var10 = useShareSheetSelection()
    local selectedConversationIds = var10.selectedConversationIds
    local var11 = useShareSheetSend({
        chatShare = chatShare,
        context = tbl1.context,
        recipients = recipients,
        recipientSource = tbl1.recipientSource,
        formatSuccessSnackbarText = tbl1.formatSuccessSnackbarText,
        onCloseWithReason = tbl1.onCloseWithReason,
        onSendActivated = var10.onSendActivated,
        onShareSendResultSnackbar = tbl1.onShareSendResultSnackbar,
        selectedConversationIds = selectedConversationIds,
        telemetryId = tbl1.telemetryId,
        url = tbl1.url
    })
    local var12 = useShareSheetRecipientModel({
        listResult = listResult,
        chatShare = chatShare,
        isOpen = tbl1.isOpen == true,
        isPeoplePickerDisplayed = isPeoplePickerDisplayed,
        isSending = var11.isSending,
        searchResult = var6.result,
        pickedRecipients = pickedRecipients,
        selectedConversationIds = selectedConversationIds
    })
    local var13 = useLocalization({
        messagePlaceholder = "Feature.UniversalShareSheet.InputPlaceholder.ShareMessage",
        send = "CommonUI.Features.Action.Send",
        share = "Feature.SocialShare.Action.Share"
    })

    local onComposerFocused = React.useCallback(function()
        ShareSheetTelemetry.logInteraction({
            context = tbl1.context,
            recipientSource = tbl1.recipientSource,
            telemetryId = tbl1.telemetryId or "",
            interactionType = ShareSheetTelemetry.InteractionType.CustomMessageComposerFocused
        })
    end, { tbl1.context, tbl1.recipientSource, tbl1.telemetryId })
    local onConversationActivated = React.useCallback(function(requestedConversationId: string)
        if var11.isSending then
            return
        end
        local interactionType = if selectedConversationIds[requestedConversationId] then "conversationDeselected" else "conversationSelected"

        ShareSheetTelemetry.logInteraction({
            context = tbl1.context,
            telemetryId = tbl1.telemetryId or "",
            interactionType = interactionType,
            recipientSource = tbl1.recipientSource,
            requestedConversationId = requestedConversationId
        })
        local function hasId(arg1): boolean
            return arg1.id == requestedConversationId
        end
        local var15 = Array.find(var12.peoplePickerRecipients.recipients, hasId) or Array.find(var12.socialRowRecipients.recipients, hasId)
        if var15 then
            var8(function(tbl2)
                if Array.find(tbl2, hasId) then
                    return tbl2
                end

                return (Array.concat(tbl2, { var15 }))
            end)
        end
        var10.onConversationActivated(requestedConversationId)
    end, {
        tbl1.context,
        tbl1.recipientSource,
        tbl1.telemetryId,
        selectedConversationIds,
        var10.onConversationActivated,
        var11.isSending,
        var12.socialRowRecipients,
        var12.peoplePickerRecipients
    })

    local onMoreActivated = React.useCallback(function()
        universalShareSheetStore.setIsPeoplePickerDisplayed(true)
    end, { universalShareSheetStore })
    local onBack = React.useCallback(function()
        universalShareSheetStore.setIsPeoplePickerDisplayed(false)
    end, { universalShareSheetStore })
    local peoplePickerRecipients = var12.peoplePickerRecipients
    local var18 = usePeoplePickerViewModel({
        filterQuery = var6.filterQuery,
        recipients = peoplePickerRecipients.recipients,
        isEligibilityLoading = peoplePickerRecipients.isLoading,
        isPeoplePickerDisplayed = isPeoplePickerDisplayed,
        loadMore = var6.pageList.loadMore,
        listResult = var12.peoplePickerListResult,
        search = search,
        onBack = onBack,
        onConversationActivated = onConversationActivated,
        selectedConversationIds = selectedConversationIds
    })

    return {
        canShareLink = getAppFeaturePolicies().getEligibleForExternalContentSharing(),
        socialRowRecipients = var12.socialRowRecipients,
        context = tbl1.context,
        isOpen = tbl1.isOpen == true,
        isPeoplePickerDisplayed = isPeoplePickerDisplayed,
        isSending = var11.isSending,
        isSocialRowLoading = var12.isSocialRowLoading,
        messagePlaceholder = tbl1.messagePlaceholder or var13.messagePlaceholder,
        onComposerFocused = onComposerFocused,
        onCloseWithReason = tbl1.onCloseWithReason,
        onConversationActivated = onConversationActivated,
        onMoreActivated = onMoreActivated,
        onSendActivated = var11.onSendActivated,
        peoplePicker = var18.viewModel,
        recipientSource = tbl1.recipientSource,
        selectedConversationIds = selectedConversationIds,
        sendLabel = var13.send,
        shareLabel = var13.share,
        telemetryId = tbl1.telemetryId,
        shouldShowSocialRow = var12.shouldShowSocialRow,
        url = tbl1.url
    }
end

return useShareSheetViewModel
