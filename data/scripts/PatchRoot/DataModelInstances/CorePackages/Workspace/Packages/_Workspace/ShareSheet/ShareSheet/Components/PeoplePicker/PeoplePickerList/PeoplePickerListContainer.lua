-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheet = script:FindFirstAncestor("ShareSheet")
local ShareSheetParent = ShareSheet.Parent

local Foundation = require(ShareSheetParent.Foundation)
local React = require(ShareSheetParent.React)

local PeoplePickerEmptyState = require(script.Parent.PeoplePickerEmptyState)
local PeoplePickerVirtualizedList = require(script.Parent.PeoplePickerVirtualizedList)
local usePeoplePickerListViewModel = require(script.Parent.usePeoplePickerListViewModel)
local _usePeoplePickerPagination = require(ShareSheet.Components.PeoplePicker.usePeoplePickerPagination)

local View = Foundation.View

local function PeoplePickerListContainer(arg1)
    local var1 = usePeoplePickerListViewModel(arg1)

    return React.createElement(
        View,
        {
            LayoutOrder = arg1.LayoutOrder,
            Size = UDim2.fromScale(1, 1),
            testId = "share-sheet-people-picker-list"
        },
        {
            List = React.createElement(PeoplePickerVirtualizedList, {
                scrollResetQuery = arg1.scrollResetQuery,
                items = var1.items,
                onConversationActivated = arg1.onConversationActivated,
                paginationProps = arg1.paginationProps,
                skeletonCount = var1.skeletonCount
            }),
            EmptyState = if var1.shouldShowEmptyState then React.createElement(PeoplePickerEmptyState, { testId = "share-sheet-people-picker-empty-state" }) else nil
        }
    )
end

return PeoplePickerListContainer
