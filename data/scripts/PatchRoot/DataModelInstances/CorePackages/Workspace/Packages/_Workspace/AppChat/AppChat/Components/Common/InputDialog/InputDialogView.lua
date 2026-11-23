-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:11:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local React = require(AppChatParent.React)
local Foundation = require(AppChatParent.Foundation)

local Dialog = Foundation.Dialog
local FoundationText = Foundation.Text
local TextInput = Foundation.TextInput
local ButtonVariant = Foundation.Enums.ButtonVariant
local DialogSize = Foundation.Enums.DialogSize

local function InputDialogView(tbl1)
    local createElement = React.createElement
    local root = Dialog.Root
    local tbl2 = {
        ref = tbl1.dialogRef,
        disablePortal = false,
        hasBackdrop = true,
        size = DialogSize.Small,
        testId = "InputDialogView"
    }
    local tbl3 = {
        Title = React.createElement(Dialog.Title, { LayoutOrder = 1, text = tbl1.titleText or "" }),
        Content = React.createElement(Dialog.Content, { LayoutOrder = 2 }, {
            Input = React.createElement(TextInput, {
                LayoutOrder = 1,
                label = "",
                text = tbl1.text,
                placeholder = tbl1.placeholderText,
                hint = tbl1.counterText,
                hasError = tbl1.isOverLimit,
                onChanged = tbl1.onTextChanged,
                width = UDim.new(1, 0),
                testId = "InputDialogView--input"
            }),
            Warning = if tbl1.warningText then React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = tbl1.warningText,
                tag = "size-full-0 auto-y text-body-small text-wrap text-align-x-left content-alert",
                testId = "InputDialogView--warning"
            }) else nil
        }),
        Actions = React.createElement(Dialog.Actions, {
            LayoutOrder = 3,
            actions = {
                {
                    text = tbl1.cancelText,
                    variant = ButtonVariant.Standard,
                    onActivated = tbl1.onCancel,
                    isDisabled = tbl1.isLoading
                },
                {
                    text = tbl1.confirmText,
                    variant = ButtonVariant.Emphasis,
                    onActivated = tbl1.onConfirm,
                    isDisabled = tbl1.isOverLimit,
                    isLoading = tbl1.isLoading
                }
            }
        })
    }
    return createElement(root, tbl2, tbl3)
end

return InputDialogView
