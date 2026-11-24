-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GroupsParent = script:FindFirstAncestor("Groups").Parent

local React = require(GroupsParent.React)
local Foundation = require(GroupsParent.Foundation)
local SettingsFieldBase = require(script.Parent.Parent.SettingsFieldBase)

local Dialog = Foundation.Dialog

local function SettingsTextInputFieldView(tbl1)
    local buttons = {
        {
            text = tbl1.cancelText,
            variant = Foundation.Enums.ButtonVariant.Standard,
            onActivated = tbl1.onCancel,
            testId = `{tbl1.testId}--cancel`
        },
        {
            text = tbl1.saveText,
            variant = Foundation.Enums.ButtonVariant.Emphasis,
            isDisabled = not tbl1.canSave,
            onActivated = tbl1.onSave,
            testId = `{tbl1.testId}--save`
        }
    }

    local createElement = React.createElement
    local fragment = React.Fragment
    local var1 = nil
    local tbl3 = {
        Field = React.createElement(SettingsFieldBase, {
            title = tbl1.title,
            description = tbl1.value,
            onClick = tbl1.onOpen,
            LayoutOrder = tbl1.LayoutOrder,
            testId = tbl1.testId
        }),
        Editor = 0
    }
    local var2

    if tbl1.isEditing then
        local createElement2 = React.createElement
        local root = Dialog.Root
        local tbl4 = {
            ref = tbl1.dialogRef,
            onClose = if tbl1.hideCloseButton then nil else tbl1.onCancel,
            hasBackdrop = true,
            disablePortal = false,
            testId = `{tbl1.testId}--editor`
        }
        local tbl5 = {
            Title = React.createElement(Dialog.Title, { text = tbl1.title, LayoutOrder = 1 }),
            Content = 0,
            Actions = 0
        }
        local createElement3 = React.createElement
        local content = Dialog.Content
        local tbl6 = { Body = 0 }
        local createElement4 = React.createElement
        local view = Foundation.View

        local tbl7 = {
            Description = React.createElement(Foundation.Text, {
                Text = tbl1.description,
                tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-muted",
                LayoutOrder = 1
            }),
            Input = 0
        }

        local createElement5 = React.createElement
        local view2 = Foundation.View

        local tbl8 = {
            TextInput = React.createElement(Foundation.TextInput, {
                inputRef = tbl1.inputRef,
                label = "",
                text = tbl1.draft,
                onChanged = tbl1.onDraftChanged,
                onReturnPressed = tbl1.onSave,
                hasError = tbl1.hasError,
                width = UDim.new(1, 0),
                LayoutOrder = 1,
                testId = `{tbl1.testId}--input`
            }),
            RemainingCharacters = React.createElement(Foundation.Text, {
                Text = tostring(tbl1.remainingCharacters),
                tag = "size-full-0 auto-y text-caption-small text-align-x-right content-muted",
                LayoutOrder = 2
            })
        }
        tbl7.Input = createElement5(view2, { tag = "col gap-xsmall size-full-0 auto-y", LayoutOrder = 2 }, tbl8)
        tbl6.Body = createElement4(view, { tag = "col gap-medium size-full-0 auto-y" }, tbl7)
        tbl5.Content = createElement3(content, { LayoutOrder = 2 }, tbl6)

        tbl5.Actions = React.createElement(
            Foundation.ButtonGroup,
            {
                LayoutOrder = 3,
                fillBehavior = Foundation.Enums.FillBehavior.Fill,
                buttons = buttons
            }
        )
        var2 = createElement2(root, tbl4, tbl5)
    else
        var2 = nil
    end

    tbl3.Editor = var2
    return createElement(fragment, var1, tbl3)
end

return SettingsTextInputFieldView
