-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:10:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local Dialog = Foundation.Dialog

local ButtonVariant = Foundation.Enums.ButtonVariant
local DialogSize = Foundation.Enums.DialogSize

local function PrivateInviteAddErrorDialog(tbl1)
    local var1 = useLocalization({
        action = LocalizationStrings.PRIVATE_INVITES_ADD_ERROR_ACTION,
        body = LocalizationStrings.PRIVATE_INVITES_ADD_ERROR,
        title = LocalizationStrings.PRIVATE_INVITES_ADD_ERROR_TITLE
    })

    return React.createElement(
        Dialog.Root,
        {
            onClose = tbl1.onDismiss,
            size = DialogSize.Small,
            testId = "build-private-invite-add-error-dialog"
        },
        {
            Title = React.createElement(Dialog.Title, { LayoutOrder = 1, text = var1.title }),
            Content = React.createElement(
                Dialog.Content,
                { LayoutOrder = 2 },
                {
                    Body = React.createElement(Dialog.Text, { Text = var1.body })
                }
            ),
            Actions = React.createElement(Dialog.Actions, {
                LayoutOrder = 3,
                actions = {{
                    text = var1.action,
                    variant = ButtonVariant.Emphasis,
                    onActivated = tbl1.onDismiss
                }}
            })
        }
    )
end

return PrivateInviteAddErrorDialog
