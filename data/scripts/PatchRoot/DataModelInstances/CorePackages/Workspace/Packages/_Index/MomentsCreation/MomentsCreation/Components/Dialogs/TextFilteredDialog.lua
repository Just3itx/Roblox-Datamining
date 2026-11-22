-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local Foundation = require(MomentsCreationParent.Foundation)
local React = require(MomentsCreationParent.React)

local Dialog = Foundation.Dialog

local useCreationFlowStrings = require(MomentsCreation.Hooks.useCreationFlowStrings)

return function(tbl1)
    local var1 = useCreationFlowStrings()

    return React.createElement(Dialog.Root, {
        size = Foundation.Enums.DialogSize.Medium,
        hasBackdrop = true
    }, {
        DialogTitle = React.createElement(Dialog.Title, { text = var1.StayFriendlyModeration, LayoutOrder = 1 }),
        DialogContent = React.createElement(
            Dialog.Content,
            { LayoutOrder = 2 },
            {
                DialogText = React.createElement(Dialog.Text, { Text = var1.CommunityStandardsText })
            }
        ),
        DialogActions = React.createElement(Dialog.Actions, {
            LayoutOrder = 3,
            actions = {{
                text = var1.GeneralCtaOk,
                variant = Foundation.Enums.ButtonVariant.Emphasis,
                onActivated = tbl1.onConfirm
            }}
        })
    })
end
