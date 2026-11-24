-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local Dash = require(GenericAbuseReportingParent.Dash)
local DsaIllegalContentReporting = require(GenericAbuseReportingParent.DsaIllegalContentReporting)
local Foundation = require(GenericAbuseReportingParent.Foundation)
local Localization = require(GenericAbuseReportingParent.Localization)
local React = require(GenericAbuseReportingParent.React)

local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local GenericReportLink = DsaIllegalContentReporting.GenericReportLink
local IconButton = Foundation.IconButton
local IconName = Foundation.Enums.IconName
local InputLabel = Foundation.InputLabel
local InputSize = Foundation.Enums.InputSize
local isShowGenericIllegalContentReportingLink = DsaIllegalContentReporting.isShowGenericIllegalContentReportingLink
local OptionSelectorGroup = Foundation.OptionSelectorGroup
local Sheet = Foundation.Sheet
local FoundationText = Foundation.Text
local TextArea = Foundation.TextArea
local useLocalization = Localization.Hooks.useLocalization
local useTokens = Foundation.Hooks.useTokens
local View = Foundation.View

local SideModalDropdownButton = require(GenericAbuseReporting.Common.SideModalDropdownButton)

return React.memo(function(tbl1) -- name: DualDropdownReportV2
    local var1 = useTokens()
    local isOpen, var3 = React.useState(true)
    local var4, var5 = React.useState("None")
    local var6, var7 = React.useState(if tbl1.preselected then tbl1.preselected.problem or nil else nil)
    local var8, var9 = React.useState(if tbl1.preselected then tbl1.preselected.surface or nil else nil)
    local text, var11 = React.useState("")

    local var12, var13 = React.useState("None")

    local var14 = useLocalization({
        problemHeading = "Feature.ReportAbuse.Label.WhatWasWrong",
        surfaceHeading = "Feature.ReportAbuse.Label.WhereDidItHappen",
        selectOnePrompt = "Feature.ReportAbuse.Label.PleaseSelectOne",
        commentHeading = "Feature.ReportAbuse.Label.TellUsWhatHappenedNoOptional",
        textAreaPlaceholder = "Feature.SettingsHub.Label.ReportComment",
        submitButton = "Feature.ReportAbuse.Label.Report",
        continueButton = "Feature.ReportAbuse.Action.Continue",
        titleIpInfringement = "Feature.ReportAbuse.Title.SelectInSceneContinueYourReport"
    })

    local onChanged = React.useCallback(function(arg1)
        var11(arg1)
    end, {})

    local onActivated = React.useCallback(function()
        var5("Problem")
    end, {})

    local var2 = React.useCallback(function()
        var5("Surface")
    end, {})

    local var18 = React.useCallback(function()
        var3(false)
        task.wait(0.3)
        tbl1.onClose()
    end, { tbl1.onClose })

    local var19 = React.useCallback(function()
        var5("None")
    end, {})

    local onValueChanged = React.useCallback(function(str1: string)
        if var4 == "Problem" then
            local var20 = Dash.find(tbl1.problems, function(tbl2): boolean
                return tbl2.value == str1
            end)
            var7(var20)
        else
            local var20 = Dash.find(tbl1.surfaces, function(tbl2): boolean
                return tbl2.value == str1
            end)
            var9(var20)
        end
        var19()
    end, {
        var4,
        tbl1.problems,
        tbl1.surfaces,
        var19
    })
    local var21 = var6 and var6.value == "ip infringement"

    local var10 = React.useCallback(function()
        local var22 = if var6 == nil then "" else var6.value
        local var23 = if var8 == nil then "" else var8.value

        if var22 == "" and var23 == "" then
            var13("Both")
            return
        end
        if var22 == "" then
            var13("Problem")
            return
        end
        if var23 == "" and not var21 then
            var13("Surface")
        else
            var13("None")
            var18()
            tbl1.onSubmit(var22, var23, text)
        end
    end, {
        var6,
        var8,
        text,
        var18,
        tbl1.onSubmit,
        var21
    })
    local createElement = React.createElement
    local fragment = React.Fragment
    local var23 = nil
    local tbl2 = { MainSheet = 0, OptionSheet = 0 }
    local createElement2 = React.createElement
    local root = Sheet.Root
    local tbl3 = { isOpen = isOpen, onClose = var18 }
    local tbl4 = { Header = 0, Content = 0, Actions = 0 }
    local createElement3 = React.createElement
    local header = Sheet.Header
    local tbl5 = { hasCloseAffordance = false }

    local createElement4 = React.createElement
    local var24 = View
    local tbl6 = { tag = "size-full-0 auto-y row gap-medium align-y-center" }

    local tbl7 = {
        Icon = React.createElement(
            IconButton,
            {
                variant = ButtonVariant.Utility,
                icon = IconName.X,
                onActivated = var18,
                LayoutOrder = 1
            }
        ),
        Title = React.createElement(FoundationText, {
            Text = if var21 then var14.titleIpInfringement else tbl1.title,
            RichText = true,
            tag = "auto-xy text-wrap text-heading-small text-align-x-left",
            LayoutOrder = 2
        })
    }
    tbl4.Header = createElement3(header, tbl5, createElement4(var24, tbl6, tbl7))

    local createElement5 = React.createElement
    local content = Sheet.Content
    local var25 = nil
    local tbl8 = {
        ProblemFrame = React.createElement(View, {
            tag = "size-full-0 auto-y col gap-small",
            LayoutOrder = 1
        }, {
            ProblemHeading = React.createElement(InputLabel, { Text = var14.problemHeading, size = InputSize.Small, LayoutOrder = 1 }),
            ProblemDropdownButton = React.createElement(SideModalDropdownButton, {
                text = var6 and var6.label or var14.chooseOne,
                onActivated = onActivated,
                isDropdownError = var12 == "Problem" or var12 == "Both",
                layoutOrder = 2
            }),
            ProblemSubtext = React.createElement(FoundationText, {
                Text = if var12 ~= "Problem" and var12 ~= "Both" then "" else var14.selectOnePrompt or "",
                RichText = true,
                textStyle = var1.Color.System.Alert,
                tag = "auto-xy text-wrap text-align-x-left text-body-small",
                LayoutOrder = 3
            })
        }),
        ProblemSurface = 0,
        TextArea = 0
    }
    local element

    if var21 then
        element = nil
    else
        element = React.createElement(View, {
            tag = "size-full-0 auto-y col gap-small",
            LayoutOrder = 2
        }, {
            SurfaceHeading = React.createElement(InputLabel, { Text = var14.surfaceHeading, size = InputSize.Small, LayoutOrder = 1 }),
            SurfaceDropdownButton = React.createElement(SideModalDropdownButton, {
                text = var8 and var8.label or var14.chooseOne,
                onActivated = var2,
                isDropdownError = var12 == "Surface" or var12 == "Both",
                layoutOrder = 2
            }),
            SurfaceSubtext = React.createElement(FoundationText, {
                Text = if var12 ~= "Surface" and var12 ~= "Both" then "" else var14.selectOnePrompt or "",
                RichText = true,
                textStyle = var1.Color.System.Alert,
                tag = "auto-xy text-wrap text-align-x-left text-body-small",
                LayoutOrder = 3
            })
        })
    end

    tbl8.ProblemSurface = element

    tbl8.TextArea = if var21 then nil else React.createElement(TextArea, {
        label = var14.commentHeading,
        text = text,
        placeholder = var14.textAreaPlaceholder,
        isRequired = false,
        onChanged = onChanged,
        width = UDim.new(1, 0),
        LayoutOrder = 3
    })
    tbl4.Content = createElement5(content, var25, tbl8)

    local createElement6 = React.createElement
    local actions = Sheet.Actions
    local var26 = nil
    local tbl9 = { ActionsFrame = 0 }
    local createElement7 = React.createElement
    local var27 = View
    local tbl10 = { tag = "size-full-0 auto-xy col gap-small" }

    local tbl11 = {
        SubmitButton = React.createElement(Button, {
            text = if var21 then var14.continueButton else var14.submitButton,
            onActivated = var10,
            variant = ButtonVariant.Emphasis,
            width = UDim.new(1, 0),
            LayoutOrder = 0
        }),
        GenericReportLink = if isShowGenericIllegalContentReportingLink() then React.createElement(GenericReportLink, {}) else nil
    }
    tbl9.ActionsFrame = createElement7(var27, tbl10, tbl11)
    tbl4.Actions = createElement6(actions, var26, tbl9)
    tbl2.MainSheet = createElement2(root, tbl3, tbl4)

    local createElement8 = React.createElement
    local root2 = Sheet.Root
    local tbl12 = {
        isOpen = var4 ~= "None",
        onClose = var19
    }
    local tbl13 = {
        Header = React.createElement(
            Sheet.Header,
            { hasCloseAffordance = false },
            React.createElement(View, { tag = "auto-xy row gap-medium align-y-center" }, {
                Icon = React.createElement(
                    IconButton,
                    {
                        variant = ButtonVariant.Utility,
                        icon = IconName.ChevronLargeLeft,
                        onActivated = var19,
                        LayoutOrder = 1
                    }
                ),
                Title = React.createElement(FoundationText, {
                    Text = var4 == "Problem" and var14.problemHeading or var14.surfaceHeading,
                    RichText = true,
                    tag = "auto-xy text-align-x-left text-wrap text-heading-small text-align-x-left",
                    LayoutOrder = 2
                })
            })
        ),
        Content = 0
    }

    local createElement9 = React.createElement
    local content2 = Sheet.Content
    local var28 = nil
    local tbl14 = {
        Padding = React.createElement(View, { tag = "padding-top-xxsmall", LayoutOrder = 1 }),
        OptionsList = 0
    }

    local createElement10 = React.createElement
    local root3 = OptionSelectorGroup.Root
    local tbl15 = {
        value = if var4 == "Problem" and var6 ~= nil then var6.value elseif var4 ~= "Surface" then "" elseif var8 == nil then "" else var8.value,
        onValueChanged = onValueChanged,
        LayoutOrder = 2
    }

    tbl14.OptionsList = createElement10(root3, tbl15, Dash.map(tbl1[if var4 == "Problem" then "problems" else "surfaces"], function(tbl16)
        return React.createElement(
            OptionSelectorGroup.Item,
            {
                key = tbl16.value,
                value = tbl16.value,
                label = tbl16.label,
                description = tbl16.description,
                size = InputSize.Small
            }
        )
    end))

    tbl13.Content = createElement9(content2, var28, tbl14)
    tbl2.OptionSheet = createElement8(root2, tbl12, tbl13)
    return createElement(fragment, var23, tbl2)
end)
