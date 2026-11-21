-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:51:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfileParent = script:FindFirstAncestor("EditProfile").Parent
local React = require(EditProfileParent.React)
local Foundation = require(EditProfileParent.Foundation)
local Dialog = Foundation.Dialog
local ButtonVariant = Foundation.Enums.ButtonVariant
local useLocalization = require(EditProfileParent.Localization).Hooks.useLocalization

return function(tbl1)
    local var1 = useLocalization({ title = tbl1.titleKey, saveButtonText = tbl1.saveKey })

    return React.createElement(Dialog.Root, {
        onClose = tbl1.onClose
    }, {
        Title = React.createElement(Dialog.Title, { text = var1.title, LayoutOrder = 1 }),
        Content = React.createElement(Dialog.Content, { LayoutOrder = 2 }, tbl1.component),
        Actions = React.createElement(Dialog.Actions, {
            LayoutOrder = 3,
            actions = {{
                text = var1.saveButtonText,
                variant = ButtonVariant.Emphasis,
                isLoading = tbl1.isLoading,
                isDisabled = tbl1.isDisabled,
                onActivated = tbl1.onSave
            }}
        })
    })
end
