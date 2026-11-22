-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:51:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local Foundation = require(MomentsCreationParent.Foundation)
local React = require(MomentsCreationParent.React)

local IconButton = Foundation.IconButton
local FoundationText = Foundation.Text
local View = Foundation.View
local ButtonVariant = Foundation.Enums.ButtonVariant
local IconName = Foundation.Enums.IconName
local IconVariant = Foundation.Enums.IconVariant
local InputSize = Foundation.Enums.InputSize

local TextFeedbackReasonDialog = require(MomentsCreation.Components.Dialogs.TextFeedbackReasonDialog)

local GetFFlagMomentsGeneratedTextDisclosureWrap = require(MomentsCreation.Flags.GetFFlagMomentsGeneratedTextDisclosureWrap)

local function GeneratedTextFeedbackView(tbl1)
    if not tbl1.visible then
        return nil
    end

    local tag = if GetFFlagMomentsGeneratedTextDisclosureWrap then "size-full-0 auto-y text-body-small text-wrap text-align-x-center text-align-y-top content-neutral" else "size-full-0 auto-y text-body-small text-align-x-center text-align-y-top content-neutral"

    return React.createElement(React.Fragment, nil, {
        Feedback = React.createElement(
            View,
            {
                LayoutOrder = tbl1.layoutOrder,
                tag = "col align-x-center gap-small size-full-0 auto-y"
            },
            {
                Disclosure = React.createElement(FoundationText, { LayoutOrder = 1, tag = tag, Text = tbl1.disclosureText }),
                Icons = React.createElement(View, {
                    LayoutOrder = 2,
                    tag = "row align-x-center align-y-center gap-small auto-xy"
                }, {
                    ThumbsUp = React.createElement(IconButton, {
                        LayoutOrder = 1,
                        icon = tbl1.selectedAction == "thumbs_up" and {
                            name = IconName.ThumbUp,
                            variant = IconVariant.Filled
                        } or IconName.ThumbUp,
                        onActivated = tbl1.onThumbsUp,
                        size = InputSize.Small,
                        variant = ButtonVariant.Utility,
                        testId = "generated-text-feedback-thumbs-up"
                    }),
                    ThumbsDown = React.createElement(IconButton, {
                        LayoutOrder = 2,
                        icon = tbl1.selectedAction == "thumbs_down" and {
                            name = IconName.ThumbDown,
                            variant = IconVariant.Filled
                        }
                            or IconName.ThumbDown,
                        onActivated = tbl1.onThumbsDown,
                        size = InputSize.Small,
                        variant = ButtonVariant.Utility,
                        testId = "generated-text-feedback-thumbs-down"
                    })
                })
            }
        ),
        ReasonDialog = if tbl1.showReasonDialog then React.createElement(
            TextFeedbackReasonDialog,
            {
                onNotHelpful = tbl1.onNotHelpful,
                onPolicyViolation = tbl1.onPolicyViolation,
                onDismiss = tbl1.onDismissDialog
            }
        ) else nil
    })
end

return GeneratedTextFeedbackView
