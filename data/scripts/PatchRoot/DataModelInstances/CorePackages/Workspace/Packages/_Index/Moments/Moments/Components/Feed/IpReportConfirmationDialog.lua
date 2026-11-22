-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Foundation = require(MomentsParent.Foundation)
local Localization = require(MomentsParent.Localization)
local React = require(MomentsParent.React)

local Dialog = Foundation.Dialog
local FoundationText = Foundation.Text
local View = Foundation.View

local useLocalization = Localization.Hooks.useLocalization

local tbl1 = {
    ipReportCodeLabel = "Feature.ReportAbuse.Label.YourReportCode",
    ipReportSubmittedBody = "Feature.ReportAbuse.Description.IpInfringementReportModal",
    ipReportSubmittedClose = "Feature.ReportAbuse.Action.Close",
    ipReportSubmittedTitle = "Feature.ReportAbuse.Title.SelectInSceneIpReport"
}

local function IpReportConfirmationDialog(tbl2)
    local var1 = useLocalization(tbl1)

    return React.createElement(
        Dialog.Root,
        {
            disablePortal = false,
            hasBackdrop = true,
            onClose = tbl2.onClose,
            size = Foundation.Enums.DialogSize.Medium
        },
        {
            DialogTitle = React.createElement(Dialog.Title, { text = var1.ipReportSubmittedTitle, LayoutOrder = 1 }),
            DialogContent = React.createElement(Dialog.Content, { LayoutOrder = 2 }, {
                ReportCodeContent = React.createElement(View, {
                    tag = "col align-x-center gap-small size-full-0 auto-y"
                }, {
                    ReportCodeLabel = React.createElement(FoundationText, {
                        Text = var1.ipReportCodeLabel,
                        tag = "auto-xy text-title-medium text-align-x-center content-default",
                        LayoutOrder = 1
                    }),
                    ReportCode = React.createElement(
                        FoundationText,
                        {
                            Text = tbl2.reportCode,
                            tag = "auto-xy text-heading-medium text-align-x-center content-emphasis",
                            LayoutOrder = 2
                        }
                    ),
                    ReportSubmittedBody = React.createElement(FoundationText, {
                        Text = var1.ipReportSubmittedBody,
                        tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-center content-default",
                        RichText = true,
                        LayoutOrder = 3
                    })
                })
            }),
            DialogActions = React.createElement(Dialog.Actions, {
                LayoutOrder = 3,
                actions = {{
                    text = var1.ipReportSubmittedClose,
                    variant = Foundation.Enums.ButtonVariant.Emphasis,
                    onActivated = tbl2.onClose
                }}
            })
        }
    )
end

return IpReportConfirmationDialog
