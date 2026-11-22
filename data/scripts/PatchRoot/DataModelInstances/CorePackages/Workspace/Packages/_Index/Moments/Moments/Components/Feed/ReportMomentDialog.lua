-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:30:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Foundation = require(MomentsParent.Foundation)
local Localization = require(MomentsParent.Localization)
local React = require(MomentsParent.React)

local Dialog = Foundation.Dialog
local RadioGroup = Foundation.RadioGroup
local FoundationText = Foundation.Text
local View = Foundation.View

local useLocalization = Localization.Hooks.useLocalization

local tbl1 = {
    report = "Feature.Moments.Action.Report",
    cancel = "Feature.Moments.Action.Cancel",
    continue = "Feature.Moments.Action.Continue",
    reportDialogTitle = "Feature.Moments.Title.ReportPost",
    reportReasonBreaksRules = "Feature.Moments.Label.ReportReason.BreaksRules",
    reportReasonIntellectualProperty = "Feature.Moments.Label.ReportReason.IntellectualProperty",
    ipReportCodeLabel = "Feature.ReportAbuse.Label.YourReportCode",
    ipReportSubmittedBody = "Feature.ReportAbuse.Description.IpInfringementReportModal",
    ipReportSubmittedClose = "Feature.ReportAbuse.Action.Close",
    ipReportSubmittedTitle = "Feature.ReportAbuse.Title.SelectInSceneIpReport"
}

local function ReportMomentDialog(tbl2)
    local var1 = useLocalization(tbl1)
    local var2, var3 = React.useState(false)
    local isDisabled, var5 = React.useState(false)
    local value, onValueChanged = React.useState("Safety")
    local var8, var9 = React.useState("------")

    React.useEffect(function()
        if tbl2.isOpen then
            onValueChanged("Safety")
            var3(false)
            var5(false)
            var9("------")
        end
    end, { tbl2.isOpen })

    local onActivated = React.useCallback(function()
        if isDisabled then
            return
        end

        local var10 = value
        local bool1 = var10 == "IntellectualProperty"
        var5(true)

        if not bool1 then
            var5(false)
            tbl2.onClose()
        end

        task.spawn(function()
            local var11 = tbl2.onSubmitReport(var10, bool1)
            if bool1 then
                var9(var11 and var11 ~= "" and var11 or "------")

                var3(true)
                var5(false)
            end
        end)
    end, {
        isDisabled,
        value,
        tbl2.onClose,
        tbl2.onSubmitReport
    })
    local var11 = React.useCallback(function()
        if isDisabled then
            return
        end

        tbl2.onClose()
    end, { isDisabled, tbl2.onClose })

    local var12 = React.useCallback(function()
        var3(false)
        tbl2.onClose()
    end, { tbl2.onClose })

    if var2 then
        return React.createElement(
            Dialog.Root,
            {
                disablePortal = false,
                hasBackdrop = true,
                onClose = var12,
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
                                Text = var8,
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
                        onActivated = var12
                    }}
                })
            }
        )
    end

    if not tbl2.isOpen then
        return nil
    end

    local createElement = React.createElement
    local root = Dialog.Root
    local tbl3 = {
        disablePortal = false,
        hasBackdrop = true,
        onClose = var11,
        size = Foundation.Enums.DialogSize.Medium
    }
    local tbl4 = {
        DialogTitle = React.createElement(Dialog.Title, { text = var1.reportDialogTitle, LayoutOrder = 1 }),
        DialogContent = React.createElement(Dialog.Content, { LayoutOrder = 2 }, {
            ReportReasons = React.createElement(RadioGroup.Root, {
                value = value,
                onValueChanged = onValueChanged
            }, {
                BreaksRules = React.createElement(RadioGroup.Item, { value = "Safety", label = var1.reportReasonBreaksRules }),
                IntellectualProperty = React.createElement(RadioGroup.Item, { value = "IntellectualProperty", label = var1.reportReasonIntellectualProperty })
            })
        }),
        DialogActions = 0
    }

    local createElement2 = React.createElement
    local actions = Dialog.Actions
    local tbl5 = {
        LayoutOrder = 3,
        actions = {
            {
                text = if value == "IntellectualProperty" then var1.continue else var1.report,
                variant = Foundation.Enums.ButtonVariant.Emphasis,
                onActivated = onActivated,
                isDisabled = isDisabled
            },
            {
                text = var1.cancel,
                variant = Foundation.Enums.ButtonVariant.Standard,
                onActivated = var11,
                isDisabled = isDisabled
            }
        }
    }
    tbl4.DialogActions = createElement2(actions, tbl5)
    return createElement(root, tbl3, tbl4)
end

return ReportMomentDialog
