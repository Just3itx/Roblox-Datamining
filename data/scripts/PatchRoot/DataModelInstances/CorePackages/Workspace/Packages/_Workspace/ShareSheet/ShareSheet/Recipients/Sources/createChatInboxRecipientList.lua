-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:51:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheet = script:FindFirstAncestor("ShareSheet")
local ShareSheetParent = ShareSheet.Parent

local GetConversationListStore = require(ShareSheetParent.AppChat.GetConversationListStore)
local Signals = require(ShareSheetParent.Signals)
local fetchConversationListPageToSignals = require(ShareSheetParent.AppChat.fetchConversationListPageToSignals)
local ListRecipientsStatus = require(ShareSheet.Recipients.ListRecipientsStatus)
local Recipient = require(ShareSheet.Recipients.Recipient)
local _Types = require(ShareSheet.Types)

local function createChatInboxRecipientList()
    local conversationListStore = GetConversationListStore(false)

    local tbl1 = {}

    local computed = Signals.createComputed(function(arg1)
        local conversations = conversationListStore.getConversations(arg1)
        local var1 = table.create(#conversations)
        local tbl2 = ({})
        for k, conversation in conversations do
            local var2 = tbl1[conversation] or Recipient.fromConversation(conversation)
            tbl2[conversation] = var2
            var1[k] = var2
        end
        tbl1 = tbl2
        return var1
    end)

    local getResult = Signals.createComputed(function(arg1)
        local recipients = computed(arg1)
        local listStatus = conversationListStore.getListStatus(arg1)
        local isFetchingNextPage = listStatus.isFetchingConversations == true
        return {
            recipients = recipients,
            status = if listStatus.error ~= nil then ListRecipientsStatus.Failed elseif #recipients == 0 and (isFetchingNextPage or listStatus.hasFetchedInitialPage ~= true) then ListRecipientsStatus.Loading else ListRecipientsStatus.Ready,
            nextPageToken = if listStatus.oldestConversationIsFetched == true then nil else listStatus.nextCursor,
            isFetchingNextPage = isFetchingNextPage
        }
    end)

    return {
        getResult = getResult,
        refresh = function()
            fetchConversationListPageToSignals()
        end,
        loadMore = function(cursor: string)
            if getResult(false).nextPageToken == cursor then
                fetchConversationListPageToSignals({ cursor = cursor })
            end
        end
    }
end

return createChatInboxRecipientList
