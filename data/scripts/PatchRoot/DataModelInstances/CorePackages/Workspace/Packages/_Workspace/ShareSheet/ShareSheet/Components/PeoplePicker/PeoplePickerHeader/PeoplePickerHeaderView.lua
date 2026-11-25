-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheetParent = script:FindFirstAncestor("ShareSheet").Parent

local Foundation = require(ShareSheetParent.Foundation)
local React = require(ShareSheetParent.React)

local IconButton = Foundation.IconButton
local SearchInput = Foundation.SearchInput
local View = Foundation.View
local ButtonVariant = Foundation.Enums.ButtonVariant
local IconName = Foundation.Enums.IconName
local InputSize = Foundation.Enums.InputSize
local SearchInputShape = Foundation.Enums.SearchInputShape

local function PeoplePickerHeaderView(tbl1)
    return React.createElement(View, {
        tag = "row align-y-center gap-xsmall size-full-0 auto-y padding-y-small padding-right-small",
        testId = "PeoplePickerHeaderView"
    }, {
        Back = React.createElement(View, { tag = "auto-xy", LayoutOrder = 1 }, {
            Button = React.createElement(IconButton, {
                icon = IconName.ChevronLargeLeft,
                onActivated = tbl1.goBack,
                size = InputSize.Medium,
                variant = ButtonVariant.Utility,
                testId = "PeoplePickerHeaderView--back"
            })
        }),
        Field = React.createElement(View, { tag = "fill auto-y", LayoutOrder = 2 }, {
            Input = React.createElement(SearchInput, {
                onChanged = tbl1.onQueryChanged,
                placeholder = tbl1.searchPlaceholder,
                shape = SearchInputShape.Pill,
                size = InputSize.Medium,
                text = tbl1.query,
                width = UDim.new(1, 0)
            })
        })
    })
end

return PeoplePickerHeaderView
