-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheetParent = script:FindFirstAncestor("ShareSheet").Parent

local Foundation = require(ShareSheetParent.Foundation)
local React = require(ShareSheetParent.React)

local Button = Foundation.Button
local TextInput = Foundation.TextInput
local View = Foundation.View
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize

local function ShareSendRow(tbl1)
    local text, onChanged = React.useState("")
    local onActivated = React.useCallback(function()
        tbl1.onActivated(text)
    end, { text, tbl1.onActivated })

    return React.createElement(View, {
        tag = "col gap-medium size-full-0 auto-y",
        testId = "share-send-row"
    }, {
        MessageInput = React.createElement(TextInput, {
            isDisabled = tbl1.isLoading,
            label = "",
            LayoutOrder = 1,
            onChanged = onChanged,
            onFocusGained = tbl1.onFocusGained,
            placeholder = tbl1.messagePlaceholder,
            size = InputSize.Medium,
            testId = "share-message-input",
            text = text,
            width = UDim.new(1, 0)
        }),
        SendButton = React.createElement(Button, {
            text = tbl1.label,
            variant = ButtonVariant.Emphasis,
            isLoading = tbl1.isLoading,
            LayoutOrder = 2,
            size = InputSize.Medium,
            onActivated = onActivated,
            testId = "share-send-button",
            width = UDim.new(1, 0)
        })
    })
end

return ShareSendRow
