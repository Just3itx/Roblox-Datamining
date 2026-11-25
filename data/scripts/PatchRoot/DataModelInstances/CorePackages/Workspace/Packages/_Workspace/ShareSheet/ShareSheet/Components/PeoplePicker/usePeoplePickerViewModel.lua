-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheet = script:FindFirstAncestor("ShareSheet")
local ShareSheetParent = ShareSheet.Parent

local React = require(ShareSheetParent.React)

local _PeoplePickerHeaderContainer = require(script.Parent.PeoplePickerHeader.PeoplePickerHeaderContainer)
local _PeoplePickerListContainer = require(script.Parent.PeoplePickerList.PeoplePickerListContainer)
local usePeoplePickerPagination = require(script.Parent.usePeoplePickerPagination)
local _usePeoplePickerSearch = require(script.Parent.usePeoplePickerSearch)
local _Recipient = require(ShareSheet.Recipients.Recipient)
local _Types = require(ShareSheet.Types)

local function usePeoplePickerViewModel(tbl1)
    local search = tbl1.search
    local var1 = usePeoplePickerPagination({
        conversationCount = #tbl1.recipients,
        isEligibilityLoading = tbl1.isEligibilityLoading,
        isPeoplePickerDisplayed = tbl1.isPeoplePickerDisplayed,
        loadMore = tbl1.loadMore,
        listResult = tbl1.listResult
    })

    return {
        viewModel = {
            headerProps = {
                goBack = React.useCallback(function()
                    search.reset()
                    tbl1.onBack()
                end, { tbl1.onBack, search.reset }),
                query = search.query,
                setQuery = search.setQuery
            },
            listProps = {
                recipients = tbl1.recipients,
                filterQuery = tbl1.filterQuery,
                scrollResetQuery = search.debouncedQuery,
                isLoading = var1.isLoading,
                onConversationActivated = tbl1.onConversationActivated,
                paginationProps = var1.paginationProps,
                selectedConversationIds = tbl1.selectedConversationIds,
                LayoutOrder = 1
            }
        }
    }
end

return usePeoplePickerViewModel
