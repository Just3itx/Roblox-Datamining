-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local Foundation = require(MomentsCreationParent.Foundation)
local Localization = require(MomentsCreationParent.Localization)
local React = require(MomentsCreationParent.React)

local Dialog = Foundation.Dialog
local FoundationText = Foundation.Text
local useLocalization = Localization.Hooks.useLocalization

local useCreationFlowStrings = require(MomentsCreation.Hooks.useCreationFlowStrings)

local tbl1 = {
    title = "Feature.Moments.Title.GenerateTextFeedbackReason",
    notHelpful = "Feature.Moments.Action.GenerateTextFeedbackNotHelpful",
    policy = "Feature.Moments.Action.GenerateTextFeedbackPolicy"
}

local function TextFeedbackReasonDialog(tbl2)
    local var1 = useCreationFlowStrings()
    local var2 = useLocalization(tbl1)

    return React.createElement(
        Dialog.Root,
        {
            size = Foundation.Enums.DialogSize.Small,
            hasBackdrop = true,
            disablePortal = false
        },
        {
            DialogTitle = React.createElement(FoundationText, {
                LayoutOrder = 1,
                tag = "size-full-0 auto-y text-heading-small text-wrap text-align-x-center content-emphasis",
                Text = var2.title
            }),
            DialogActions = React.createElement(Dialog.Actions, {
                LayoutOrder = 2,
                orientation = Foundation.Enums.Orientation.Vertical,
                actions = {
                    {
                        text = var2.notHelpful,
                        variant = Foundation.Enums.ButtonVariant.Standard,
                        onActivated = tbl2.onNotHelpful
                    },
                    {
                        text = var2.policy,
                        variant = Foundation.Enums.ButtonVariant.Standard,
                        onActivated = tbl2.onPolicyViolation
                    },
                    {
                        text = var1.GeneralCtaCancel,
                        variant = Foundation.Enums.ButtonVariant.Standard,
                        onActivated = tbl2.onDismiss
                    }
                }
            })
        }
    )
end

return TextFeedbackReasonDialog
