-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:11:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCommonParent = script:FindFirstAncestor("SocialCommon").Parent

local Foundation = require(SocialCommonParent.Foundation)
local React = require(SocialCommonParent.React)

local SearchField = require(script.Parent.SearchField)

local function SearchRow(tbl1)
    local onExit = tbl1.onExit
    local exitVariant = tbl1.exitVariant or "Cancel"
    local exitTestId = tbl1.exitTestId or "SearchRow"
    local height = tbl1.height
    local paddingHorizontal = tbl1.paddingHorizontal

    return React.createElement(Foundation.View, {
        tag = {
            ["row align-y-center gap-small"] = true,
            ["size-full"] = height == nil
        },
        Size = if height then UDim2.new(1, 0, 0, height) else nil,
        LayoutOrder = tbl1.LayoutOrder,
        padding = paddingHorizontal and {
            left = UDim.new(0, paddingHorizontal),
            right = UDim.new(0, paddingHorizontal)
        } or nil
    }, {
        back = if onExit and exitVariant == "Chevron" then React.createElement(Foundation.IconButton, {
            icon = Foundation.Enums.IconName.ChevronLargeLeft,
            size = Foundation.Enums.InputSize.Medium,
            LayoutOrder = 1,
            testId = `{exitTestId}Back`,
            onActivated = onExit
        }) else nil,
        field = React.createElement(Foundation.View, { tag = "grow auto-y", LayoutOrder = 2 }, {
            input = React.createElement(SearchField, {
                text = tbl1.text,
                placeholder = tbl1.placeholder,
                shouldAutoFocus = tbl1.shouldAutoFocus,
                onChanged = tbl1.onChanged,
                onExit = onExit,
                onFocusGained = tbl1.onFocusGained,
                testId = tbl1.testId
            })
        }),
        cancel = if onExit and exitVariant == "Cancel" then React.createElement(Foundation.Button, {
            text = tbl1.cancelText or "",
            variant = Foundation.Enums.ButtonVariant.Utility,
            size = Foundation.Enums.InputSize.Medium,
            LayoutOrder = 3,
            testId = `{exitTestId}Cancel`,
            onActivated = onExit
        }) else nil
    })
end

return SearchRow
