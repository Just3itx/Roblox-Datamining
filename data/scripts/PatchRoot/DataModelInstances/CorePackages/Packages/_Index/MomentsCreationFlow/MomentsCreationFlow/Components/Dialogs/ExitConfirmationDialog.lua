-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:20:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationFlow = script:FindFirstAncestor("MomentsCreationFlow")
local MomentsCreationFlowParent = MomentsCreationFlow.Parent

local React = require(MomentsCreationFlowParent.React)

local Foundation = require(MomentsCreationFlowParent.Foundation)
local Dialog = Foundation.Dialog

local CreationFlowContext = require(MomentsCreationFlow.Context.CreationFlowContext)
local CreationFlowLocalization = require(MomentsCreationFlow.Enums.CreationFlowLocalization)

return function(tbl1)
    local var1 = React.useContext(CreationFlowContext)

    return React.createElement(
        Dialog.Root,
        {
            disablePortal = false,
            size = Foundation.Enums.DialogSize.Medium,
            hasBackdrop = true
        },
        {
            DialogTitle = React.createElement(
                Dialog.Title,
                {
                    text = var1.getLocalization(CreationFlowLocalization.LeaveMomentCreationTitle),
                    LayoutOrder = 1
                }
            ),
            DialogContent = React.createElement(Dialog.Content, { LayoutOrder = 2 }, {
                DialogText = React.createElement(Dialog.Text, { Text = var1.getLocalization(CreationFlowLocalization.LeaveMomentCreationBody) })
            }),
            DialogActions = React.createElement(Dialog.Actions, {
                LayoutOrder = 3,
                actions = {
                    {
                        text = var1.getLocalization(CreationFlowLocalization.GeneralCtaLeave),
                        variant = Foundation.Enums.ButtonVariant.Emphasis,
                        onActivated = tbl1.onConfirm
                    },
                    {
                        text = var1.getLocalization(CreationFlowLocalization.GeneralCtaCancel),
                        variant = Foundation.Enums.ButtonVariant.Standard,
                        onActivated = tbl1.onCancel
                    }
                }
            })
        }
    )
end
