-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GiftingParent = script:FindFirstAncestor("Gifting").Parent

local React = require(GiftingParent.React)
local Foundation = require(GiftingParent.Foundation)

local GiftSheetLayoutView = require(script.Parent.Parent.GiftSheetLayout.GiftSheetLayoutView)
local GiftStateView = require(script.Parent.Parent.GiftState.GiftStateView)
local RecipientRowView = require(script.Parent.RecipientRowView)

local InputSize = Foundation.Enums.InputSize
local SearchInputShape = Foundation.Enums.SearchInputShape

local snapPoints = { 0.93 }

return React.memo(function(tbl2) -- name: RecipientPickerView
    local var1 = React.useMemo(function()
        local result = ({})
        for layoutOrder, row in tbl2.rows do
            local str1 = `Recipient_{row.userId}`
            local createElement = React.createElement
            local var1 = RecipientRowView
            local tbl3 = {
                userId = row.userId,
                displayName = row.displayName,
                username = row.username,
                isAvailable = row.isAvailable,
                unavailableLabel = tbl2.unavailableLabel,
                avatarBackgroundStyle = tbl2.avatarBackgroundStyle,
                onActivated = 0,
                LayoutOrder = 0
            }

            function tbl3.onActivated()
                tbl2.onRecipientSelected(row.userId)
            end
            tbl3.LayoutOrder = layoutOrder
            result[str1] = createElement(var1, tbl3)
        end

        return result
    end, {
        tbl2.rows,
        tbl2.avatarBackgroundStyle,
        tbl2.onRecipientSelected,
        tbl2.unavailableLabel
    })
    local createElement = React.createElement
    local view = Foundation.View
    local tbl3 = { tag = "col gap-medium size-full-0 auto-y" }

    local tbl4 = {
        Search = if tbl2.isSearchVisible then React.createElement(Foundation.SearchInput, {
            text = tbl2.searchText,
            placeholder = tbl2.searchPlaceholder,
            onChanged = tbl2.onSearchChanged,
            size = InputSize.Medium,
            shape = SearchInputShape.Pill,
            width = UDim.new(1, 0),
            testId = "recipient-picker-search",
            LayoutOrder = 1
        }) else nil,
        SectionTitle = if tbl2.state then nil else React.createElement(Foundation.Text, {
            tag = "size-full-0 auto-y text-title-medium text-align-x-left content-emphasis",
            Text = tbl2.sectionTitle,
            testId = "recipient-picker-section-title",
            LayoutOrder = 2
        }),
        Body = React.createElement(Foundation.View, {
            tag = "col size-full-0 auto-y",
            LayoutOrder = 3
        }, {
            State = if tbl2.state then React.createElement(GiftStateView, tbl2.state) else nil,
            RecipientList = if tbl2.state then nil else React.createElement(Foundation.View, { tag = "col size-full-0 auto-y", LayoutOrder = 1 }, var1)
        })
    }
    local content = createElement(view, tbl3, tbl4)

    return React.createElement(GiftSheetLayoutView, {
        isOpen = tbl2.isOpen,
        titleText = tbl2.titleText,
        content = content,
        snapPoints = snapPoints,
        centerSheetHeight = 1,
        onClose = tbl2.onClose
    })
end)
