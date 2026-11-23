-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:10:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local PrivateInviteUserRow = require(script.Parent.PrivateInviteUserRow)

local Dialog = Foundation.Dialog
local View = Foundation.View

local ButtonVariant = Foundation.Enums.ButtonVariant
local DialogSize = Foundation.Enums.DialogSize

local function PrivateInviteAddRejectedDialog(tbl1)
    local var1 = useLocalization({
        action = LocalizationStrings.PRIVATE_INVITES_ADD_ERROR_ACTION,
        title = LocalizationStrings.PRIVATE_INVITES_ADD_REJECTED_TITLE,
        unknownUser = LocalizationStrings.PRIVATE_INVITES_UNKNOWN_USER
    })

    local tbl2 = ({})
    for layoutOrder, userId in tbl1.rejectedUserIds do
        local str1 = `user-{userId}`
        tbl2[str1] = React.createElement(
            PrivateInviteUserRow,
            {
                userId = userId,
                layoutOrder = layoutOrder,
                unknownText = var1.unknownUser
            }
        )
    end
    return React.createElement(
        Dialog.Root,
        {
            onClose = tbl1.onDismiss,
            size = DialogSize.Small,
            testId = "build-private-invite-add-rejected-dialog"
        },
        {
            Title = React.createElement(Dialog.Title, { LayoutOrder = 1, text = var1.title }),
            Content = React.createElement(
                Dialog.Content,
                { LayoutOrder = 2 },
                {
                    Users = React.createElement(View, { tag = "col gap-xsmall size-full-0 auto-y" }, tbl2)
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

return PrivateInviteAddRejectedDialog
