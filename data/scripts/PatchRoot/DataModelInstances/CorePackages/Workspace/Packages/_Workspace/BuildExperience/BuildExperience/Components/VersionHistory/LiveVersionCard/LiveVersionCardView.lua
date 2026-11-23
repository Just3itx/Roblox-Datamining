-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local Button = Foundation.Button
local Icon = Foundation.Icon
local Skeleton = Foundation.Skeleton
local FoundationText = Foundation.Text
local View = Foundation.View

local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local InputSize = Foundation.Enums.InputSize
local Radius = Foundation.Enums.Radius
local useTokens = Foundation.Hooks.useTokens

local function MetricItem(tbl1)
    local var1 = useTokens()

    local createElement = React.createElement
    local var2 = View
    local tbl2 = {
        LayoutOrder = tbl1.layoutOrder,
        tag = "row align-y-center gap-xxsmall auto-xy",
        testId = tbl1.testId
    }
    local tbl3 = {
        Icon = React.createElement(
            Icon,
            {
                LayoutOrder = 1,
                name = tbl1.iconName,
                size = IconSize.XSmall,
                tag = "content-action-standard"
            }
        ),
        Value = 0
    }
    local element

    if tbl1.value ~= nil then
        element = React.createElement(
            FoundationText,
            {
                LayoutOrder = 2,
                Text = tbl1.value,
                tag = "auto-xy text-caption-medium content-action-standard"
            }
        )
    elseif tbl1.isLoading then
        element = React.createElement(Skeleton, {
            LayoutOrder = 2,
            Size = UDim2.fromOffset(var1.Size.Size_200, var1.Size.Size_300),
            radius = Radius.Small,
            testId = `{tbl1.testId}-skeleton`
        })
    else
        element = nil
    end

    tbl3.Value = element
    return createElement(var2, tbl2, tbl3)
end

local function LiveVersionCardView(tbl1)
    local testId = tbl1.testId or "LiveVersionCardView"
    local var1 = tbl1.totalUpVotes ~= nil or tbl1.totalVisits ~= nil or tbl1.isTotalUpVotesLoading or tbl1.isTotalVisitsLoading

    local createElement = React.createElement
    local var2 = View
    local tbl2 = {
        LayoutOrder = tbl1.layoutOrder,
        tag = "col gap-large size-full-0 auto-y padding-x-large padding-bottom-large padding-top-medium radius-large clip bg-shift-200",
        testId = testId
    }
    local tbl3 = { Content = 0, Actions = 0 }
    local createElement2 = React.createElement
    local var3 = View
    local tbl4 = {
        LayoutOrder = 1,
        tag = "col gap-xxsmall size-full-0 auto-y",
        testId = `{testId}-content`
    }
    local tbl5 = { Eyebrow = 0, Description = 0 }
    local createElement3 = React.createElement
    local var4 = View
    local tbl6 = {
        LayoutOrder = 1,
        tag = "row align-x-left align-y-top gap-small size-full-0 auto-y",
        testId = `{testId}-eyebrow`
    }
    local tbl7 = {
        VersionAndTitle = React.createElement(
            View,
            { LayoutOrder = 1, tag = "col align-x-left align-y-top fill gap-xxsmall auto-y" },
            {
                Version = React.createElement(FoundationText, {
                    LayoutOrder = 1,
                    Text = tbl1.versionLabel,
                    tag = "size-full-0 auto-y text-caption-medium text-align-x-left content-muted",
                    testId = `{testId}-version`
                }),
                Title = React.createElement(FoundationText, {
                    LayoutOrder = 2,
                    Text = tbl1.title,
                    tag = "size-full-0 auto-y text-title-medium text-wrap text-align-x-left content-emphasis",
                    testId = `{testId}-title`
                })
            }
        ),
        Metrics = 0
    }
    local element

    if var1 then
        element = React.createElement(View, {
            LayoutOrder = 2,
            tag = "row align-y-center gap-small auto-xy padding-x-small padding-y-xsmall radius-small bg-action-standard",
            testId = `{testId}-metrics`
        }, {
            TotalVisits = if tbl1.totalVisits == nil and not tbl1.isTotalVisitsLoading then nil else React.createElement(
                MetricItem,
                {
                    layoutOrder = 1,
                    iconName = IconName.Eye,
                    value = tbl1.totalVisits,
                    isLoading = tbl1.isTotalVisitsLoading,
                    testId = `{testId}-total-visits`
                }
            ),
            TotalUpVotes = if tbl1.totalUpVotes == nil and not tbl1.isTotalUpVotesLoading then nil else React.createElement(
                MetricItem,
                {
                    layoutOrder = 2,
                    iconName = IconName.ThumbUp,
                    value = tbl1.totalUpVotes,
                    isLoading = tbl1.isTotalUpVotesLoading,
                    testId = `{testId}-total-up-votes`
                }
            )
        })
    else
        element = nil
    end

    tbl7.Metrics = element
    tbl5.Eyebrow = createElement3(var4, tbl6, tbl7)

    tbl5.Description = React.createElement(FoundationText, {
        LayoutOrder = 2,
        Text = tbl1.description,
        tag = "size-full-0 auto-y text-body-small text-wrap text-align-x-left content-emphasis",
        testId = `{testId}-description`
    })
    tbl3.Content = createElement2(var3, tbl4, tbl5)

    tbl3.Actions = React.createElement(
        View,
        {
            LayoutOrder = 2,
            tag = "row size-full-0 auto-y",
            testId = `{testId}-actions`
        },
        {
            Play = React.createElement(Button, {
                text = tbl1.playText,
                icon = IconName.PlaySmall,
                size = InputSize.Small,
                variant = ButtonVariant.SoftEmphasis,
                fillBehavior = FillBehavior.Fill,
                isDisabled = tbl1.isPlayDisabled,
                onActivated = tbl1.onPlayActivated,
                testId = `{testId}-play`
            })
        }
    )
    return createElement(var2, tbl2, tbl3)
end

return LiveVersionCardView
