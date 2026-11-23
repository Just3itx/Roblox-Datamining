-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:20:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)
local Foundation = require(BuildExperienceParent.Foundation)

local Button = Foundation.Button
local IconButton = Foundation.IconButton
local FoundationText = Foundation.Text
local View = Foundation.View
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize
local FillBehavior = Foundation.Enums.FillBehavior
local IconName = Foundation.Enums.IconName
local FFlagBuildAnalyticsGoals = require(BuildExperience.Flags.FFlagBuildAnalyticsGoals)
local Sheet = Foundation.Sheet
local _AnalyticsMetric = require(BuildExperience.Analytics.AnalyticsMetric)
local _AnalyticsWindow = require(BuildExperience.Analytics.AnalyticsWindow)
local _CreatorAnalytics = require(BuildExperienceParent.DataHydration.CreatorAnalytics)
local MetricChartContainer = require(BuildExperience.Components.Analytics.Chart.MetricChartContainer)

local function MetricDetailSheetView(tbl1)
    local testId = tbl1.testId or "MetricDetailSheetView"
    local navigation = if FFlagBuildAnalyticsGoals then tbl1.navigation else nil
    local element

    if FFlagBuildAnalyticsGoals and tbl1.improvementText ~= nil and tbl1.improvementText ~= "" then
        element = React.createElement(
            View,
            {
                LayoutOrder = 3,
                tag = "col gap-small size-full-0 auto-y",
                testId = `{testId}.HowToImprove`
            },
            {
                Title = React.createElement(FoundationText, {
                    LayoutOrder = 1,
                    Text = tbl1.improvementTitleText,
                    tag = "size-full-0 auto-y text-heading-small text-wrap text-align-x-left content-emphasis",
                    testId = `{testId}.HowToImproveTitle`
                }),
                Tips = React.createElement(FoundationText, {
                    LayoutOrder = 2,
                    Text = tbl1.improvementText,
                    tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-muted",
                    testId = `{testId}.ImprovementText`
                })
            }
        )
    else
        element = nil
    end

    local tbl2 = {
        [if navigation == nil then "Chart" else `Chart{navigation.index}`] = React.createElement(MetricChartContainer, {
            universeId = tbl1.universeId,
            metric = tbl1.metric,
            window = tbl1.window,
            latestAvailableTime = tbl1.latestAvailableTime,
            metadataStatus = tbl1.metadataStatus,
            hideIcon = true,
            summary = tbl1.summaryText
        })
    }

    local createElement = React.createElement
    local root = Sheet.Root
    local tbl3 = {
        ref = tbl1.focusRootRef,
        isOpen = true,
        onClose = tbl1.onClose,
        testId = testId
    }
    local tbl4 = {
        Header = React.createElement(Sheet.Header, {
            hasCloseAffordance = tbl1.showCloseButton ~= false
        }, {
            Title = React.createElement(FoundationText, {
                Text = tbl1.titleText,
                tag = "shrink auto-xy text-heading-small text-wrap text-align-x-left content-emphasis",
                testId = `{testId}.Title`
            })
        }),
        Content = 0,
        Actions = 0
    }

    local createElement2 = React.createElement
    local content = Sheet.Content
    local var1 = nil
    local tbl5 = { Body = 0 }
    local createElement3 = React.createElement
    local var2 = View
    local tbl6 = { tag = "col gap-large size-full-0 auto-y padding-top-medium" }

    local tbl7 = { Navigation = 0, ChartCard = 0, Description = 0, HowToImprove = 0 }
    local element2

    if navigation == nil or not (navigation.count > 1) then
        element2 = nil
    else
        element2 = React.createElement(
            View,
            {
                LayoutOrder = 0,
                tag = "row align-x-right gap-small size-full-0 auto-y",
                testId = `{testId}.Navigation`
            },
            {
                Previous = React.createElement(IconButton, {
                    LayoutOrder = 1,
                    icon = IconName.ChevronLargeLeft,
                    size = InputSize.Small,
                    onActivated = navigation.onPrevious,
                    isDisabled = navigation.index == 1,
                    testId = `{testId}.Previous`
                }),
                Next = React.createElement(IconButton, {
                    LayoutOrder = 2,
                    icon = IconName.ChevronLargeRight,
                    size = InputSize.Small,
                    onActivated = navigation.onNext,
                    isDisabled = navigation.index == navigation.count,
                    testId = `{testId}.Next`
                })
            }
        )
    end

    tbl7.Navigation = element2

    tbl7.ChartCard = React.createElement(View, {
        LayoutOrder = 1,
        tag = "col size-full-0 auto-y padding-large stroke-standard stroke-default radius-large",
        testId = `{testId}.ChartCard`
    }, tbl2)

    tbl7.Description = React.createElement(FoundationText, {
        LayoutOrder = 2,
        Text = tbl1.descriptionText,
        tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-muted",
        testId = `{testId}.Description`
    })
    tbl7.HowToImprove = element
    tbl5.Body = createElement3(var2, tbl6, tbl7)
    tbl4.Content = createElement2(content, var1, tbl5)

    tbl4.Actions = React.createElement(Sheet.Actions, nil, {
        Analyze = React.createElement(Button, {
            LayoutOrder = 1,
            text = tbl1.analyzeText,
            size = InputSize.Medium,
            variant = ButtonVariant.Emphasis,
            fillBehavior = FillBehavior.Fill,
            width = UDim.new(1, 0),
            isDisabled = tbl1.isAnalyzeDisabled,
            onActivated = tbl1.onAnalyze,
            testId = `{testId}.Analyze`
        }),
        ViewInOverview = React.createElement(Button, {
            LayoutOrder = 2,
            text = tbl1.viewInOverviewText,
            icon = IconName.ArrowUpRightFromSquare,
            size = InputSize.Medium,
            variant = ButtonVariant.Standard,
            fillBehavior = FillBehavior.Fill,
            width = UDim.new(1, 0),
            onActivated = tbl1.onViewInOverview,
            testId = `{testId}.ViewInOverview`
        })
    })
    return createElement(root, tbl3, tbl4)
end

return MetricDetailSheetView
