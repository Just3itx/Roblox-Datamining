-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local AnalyticsMetricChart = require(MomentsParent.AnalyticsMetricChart)
local FocusNavigationUtils = require(MomentsParent.FocusNavigationUtils)
local Foundation = require(MomentsParent.Foundation)
local InputHandlers = require(MomentsParent.InputHandlers)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local React = require(MomentsParent.React)
local _ReactFocusNavigation = require(MomentsParent.ReactFocusNavigation)
local FFlagMomentsUseSharedReactions = require(Moments.Flags.FFlagMomentsUseSharedReactions)

local HeaderBar = Foundation.HeaderBar
local Icon = Foundation.Icon
local ScrollView = Foundation.ScrollView
local Skeleton = Foundation.Skeleton
local FoundationText = Foundation.Text
local View = Foundation.View
local IconName = Foundation.Enums.IconName
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance
local useTokens = Foundation.Hooks.useTokens

local FocusRoot = FocusNavigationUtils.FocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum

local MomentMediaTile = MomentsCommon.Media.MomentMediaTile
local Reaction = if FFlagMomentsUseSharedReactions then require(MomentsParent.Reactions.Reaction) else MomentsCommon.Components.Reaction
local ReactionAssets = MomentsCommon.Components.ReactionAssets
local ReactionSize = MomentsCommon.Enums.ReactionSize
local FormFactor = MomentsCommon.Enums.FormFactor
local useDeviceInsets = MomentsCommon.Hooks.useDeviceInsets
local useFormFactor = MomentsCommon.Hooks.useFormFactor

local Constants = require(Moments.Constants)
local _usePostInsightsPageViewModel = require(script.Parent.usePostInsightsPageViewModel)

local vector2 = Vector2.new(83, 124)

local vector2_2 = Vector2.new(94, 140)

local uDim2 = UDim2.fromOffset(64, 24)

local eventMap = {
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.Escape] = FocusNavigationEventNameEnum.NavigateBack
}
local frameProps = table.freeze({ ZIndex = Constants.DisplayOrder.Modals })

local function noop() end

local function Thumbnail(tbl2)
    local var2 = useTokens()
    return React.createElement(View, {
        LayoutOrder = tbl2.LayoutOrder,
        cornerRadius = UDim.new(0, var2.Radius.Small),
        Size = UDim2.fromOffset(tbl2.size.X, tbl2.size.Y),
        tag = "radius-small clip bg-surface-300",
        testId = "post-insights-thumbnail"
    }, {
        Media = if tbl2.mediaItem == nil then nil else React.createElement(MomentMediaTile, { mediaItem = tbl2.mediaItem, isActive = false })
    })
end

local function InteractionCounts(tbl2)
    local var2 = useTokens()
    local tbl3 = ({})
    for layoutOrder, interactionCount in tbl2.interactionCounts do
        local key = interactionCount.key
        local createElement = React.createElement
        local var3 = View
        local tbl4 = {
            LayoutOrder = layoutOrder,
            Size = if tbl2.isWide then nil else UDim2.fromOffset(52, 0),
            tag = {
                ["col align-x-center gap-xsmall padding-y-small"] = true,
                ["auto-xy"] = tbl2.isWide,
                ["auto-y"] = not tbl2.isWide
            }
        }
        local tbl5 = {
            Icon = React.createElement(
                Icon,
                {
                    LayoutOrder = 1,
                    name = interactionCount.icon,
                    size = var2.Size.Size_600,
                    style = var2.Color.Content.Emphasis
                }
            ),
            Count = React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = interactionCount.countText,
                tag = "auto-xy text-label-small content-emphasis",
                testId = `post-insights-count-{interactionCount.key}`
            })
        }
        tbl3[key] = createElement(var3, tbl4, tbl5)
    end

    return React.createElement(View, {
        LayoutOrder = tbl2.LayoutOrder,
        tag = {
            row = true,
            ["gap-xxlarge auto-xy"] = tbl2.isWide,
            ["align-x-center gap-small size-full-0 auto-y"] = not tbl2.isWide
        }
    }, tbl3)
end

local function Summary(tbl2)
    local viewProps = tbl2.viewProps
    if not tbl2.isWide then
        return React.createElement(
            View,
            {
                LayoutOrder = tbl2.LayoutOrder,
                tag = "col align-x-center gap-xlarge size-full-0 auto-y"
            },
            {
                Thumbnail = React.createElement(Thumbnail, { LayoutOrder = 1, mediaItem = viewProps.mediaItem, size = vector2 }),
                Counts = React.createElement(
                    InteractionCounts,
                    {
                        LayoutOrder = 2,
                        interactionCounts = viewProps.interactionCounts,
                        isWide = false
                    }
                )
            }
        )
    end
    local createElement = React.createElement
    local var2 = View
    local tbl3 = {
        LayoutOrder = tbl2.LayoutOrder,
        tag = "row align-y-center gap-xxlarge size-full-0 auto-y"
    }
    local tbl4 = {
        Thumbnail = React.createElement(Thumbnail, { LayoutOrder = 1, mediaItem = viewProps.mediaItem, size = vector2_2 }),
        Details = 0
    }
    local createElement2 = React.createElement
    local var3 = View
    local tbl5 = { LayoutOrder = 2, tag = "col align-x-left fill gap-medium auto-y" }

    local tbl6 = { Text = 0, Counts = 0 }
    local element

    if viewProps.caption == nil and viewProps.postedOnText == nil then
        element = nil
    else
        element = React.createElement(
            View,
            {
                LayoutOrder = 1,
                tag = "col align-x-left gap-xsmall size-full-0 auto-y",
                testId = "post-insights-summary-text"
            },
            {
                Caption = if viewProps.caption == nil then nil else React.createElement(FoundationText, {
                    LayoutOrder = 1,
                    Text = viewProps.caption,
                    tag = "size-full-0 auto-y text-heading-small text-align-x-left text-truncate-end content-emphasis",
                    testId = "post-insights-caption"
                }),
                PostedOn = if viewProps.postedOnText == nil then nil else React.createElement(FoundationText, {
                    LayoutOrder = 2,
                    Text = viewProps.postedOnText,
                    tag = "size-full-0 auto-y text-body-medium text-align-x-left content-default",
                    testId = "post-insights-posted-on"
                })
            }
        )
    end

    tbl6.Text = element

    tbl6.Counts = React.createElement(
        InteractionCounts,
        {
            LayoutOrder = 2,
            interactionCounts = viewProps.interactionCounts,
            isWide = true
        }
    )
    tbl4.Details = createElement2(var3, tbl5, tbl6)
    return createElement(var2, tbl3, tbl4)
end

local function SectionHeading(tbl2)
    return React.createElement(
        FoundationText,
        {
            LayoutOrder = tbl2.LayoutOrder,
            Text = tbl2.text,
            tag = "auto-xy text-heading-small content-emphasis"
        }
    )
end

local function Metric(tbl2)
    return React.createElement(View, {
        LayoutOrder = tbl2.LayoutOrder,
        tag = tbl2.tag
    }, {
        Label = React.createElement(FoundationText, {
            LayoutOrder = 1,
            Text = tbl2.label,
            tag = "auto-xy text-body-medium content-default",
            testId = `{tbl2.testId}-label`
        }),
        Value = if tbl2.isLoading then React.createElement(Skeleton, { LayoutOrder = 2, Size = uDim2, testId = `{tbl2.testId}-skeleton` }) else React.createElement(
            FoundationText,
            {
                LayoutOrder = 2,
                Text = tbl2.valueText,
                tag = "auto-xy text-heading-small content-emphasis",
                testId = tbl2.testId
            }
        )
    })
end

local function ViewsChartSkeleton(tbl2)
    return React.createElement(View, {
        LayoutOrder = tbl2.LayoutOrder,
        tag = "col gap-small size-full-0 auto-y",
        testId = "post-insights-views-chart-skeleton"
    }, {
        Title = React.createElement(Skeleton, { LayoutOrder = 1, Size = UDim2.new(0.4, 0, 0, 22) }),
        Value = React.createElement(Skeleton, { LayoutOrder = 2, Size = UDim2.new(0.25, 0, 0, 32) }),
        Plot = React.createElement(
            Skeleton,
            {
                LayoutOrder = 3,
                Size = UDim2.new(1, 0, 0, AnalyticsMetricChart.chartLayout.PLOT_HEIGHT)
            }
        )
    })
end

local function OverviewSection(tbl2)
    local var2 = table.clone(tbl2.viewsChart)
    var2.layoutOrder = 2
    local tbl3 = {
        Heading = React.createElement(SectionHeading, { LayoutOrder = 1, text = tbl2.heading }),
        ViewsChart = 0
    }
    local element

    if tbl2.isViewsChartLoading then
        element = React.createElement(ViewsChartSkeleton, { LayoutOrder = 2 })
    elseif tbl2.isViewsChartVisible then
        element = React.createElement(View, {
            LayoutOrder = 2,
            tag = "col gap-large size-full-0 auto-y"
        }, {
            TotalViews = React.createElement(Metric, {
                LayoutOrder = 1,
                label = tbl2.totalViewsLabel,
                valueText = tbl2.totalViewsText,
                isLoading = tbl2.isTotalViewsLoading,
                tag = "col gap-xxsmall auto-xy",
                testId = "post-insights-total-views"
            }),
            Chart = React.createElement(AnalyticsMetricChart.MetricChart, var2)
        })
    else
        element = nil
    end

    tbl3.ViewsChart = element

    local num1 = #tbl2.overviewMetrics / 2

    for i = 1, math.ceil(num1) do
        local tbl4 = ({})
        for layoutOrder = 1, 2 do
            local overviewMetric = tbl2.overviewMetrics[(i - 1) * 2 + layoutOrder]
            if overviewMetric == nil then
                continue
            end

            local key = overviewMetric.key
            tbl4[key] = React.createElement(Metric, {
                LayoutOrder = layoutOrder,
                label = overviewMetric.label,
                valueText = overviewMetric.valueText,
                isLoading = overviewMetric.isLoading,
                tag = "col fill gap-xxsmall auto-y padding-y-small",
                testId = `post-insights-metric-{overviewMetric.key}`
            })
        end

        local str1 = `Row{i}`
        tbl3[str1] = React.createElement(View, { LayoutOrder = i + 2, tag = "row gap-medium size-full-0 auto-y" }, tbl4)
    end

    return React.createElement(
        View,
        {
            LayoutOrder = tbl2.LayoutOrder,
            tag = "col gap-medium size-full-0 auto-y padding-y-xsmall"
        },
        tbl3
    )
end

local function EngagementSection(tbl2)
    local var2 = useTokens()
    local size600 = if FFlagMomentsUseSharedReactions then var2.Size.Size_600 else assert(ReactionAssets.getSizePixels(ReactionSize.Small), "expected a pixel size for Small reactions")
    local tbl3 = ({})
    for layoutOrder, reactionCount in tbl2.viewProps.reactionCounts do
        local reactionType = reactionCount.reactionType
        local createElement = React.createElement
        local var3 = View
        local tbl4 = {
            LayoutOrder = layoutOrder,
            sizeConstraint = {
                MinSize = Vector2.new(size600, 0)
            },
            tag = "col align-x-center gap-xxsmall auto-xy",
            testId = `post-insights-reaction-item-{reactionCount.reactionType}`
        }
        local tbl5 = {
            Reaction = React.createElement(Reaction, { LayoutOrder = 1, reactionType = reactionCount.reactionType, size = ReactionSize.Small }),
            Count = React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = reactionCount.countText,
                tag = "auto-xy text-caption-medium content-emphasis",
                testId = `post-insights-reaction-{reactionCount.reactionType}`
            })
        }
        tbl3[reactionType] = createElement(var3, tbl4, tbl5)
    end

    return React.createElement(
        View,
        {
            LayoutOrder = tbl2.LayoutOrder,
            tag = "col gap-large size-full-0 auto-y padding-y-xsmall"
        },
        {
            Heading = React.createElement(SectionHeading, { LayoutOrder = 1, text = tbl2.viewProps.engagementHeading }),
            Card = React.createElement(
                View,
                {
                    LayoutOrder = 2,
                    tag = "col gap-large size-full-0 auto-y padding-y-xsmall",
                    testId = "post-insights-engagement-card"
                },
                {
                    Total = React.createElement(Metric, {
                        LayoutOrder = 1,
                        label = tbl2.viewProps.totalReactionsLabel,
                        valueText = tbl2.viewProps.totalReactionsText,
                        tag = "col gap-xxsmall auto-xy",
                        testId = "post-insights-total-reactions"
                    }),
                    Reactions = React.createElement(View, {
                        LayoutOrder = 2,
                        sizeConstraint = {
                            MaxSize = Vector2.new(353, math.huge)
                        },
                        tag = "row flex-x-between size-full-0 auto-y"
                    }, tbl3)
                }
            )
        }
    )
end

local function PostInsightsPageView(viewProps)
    local var2 = useDeviceInsets()
    local isWide = useFormFactor() == FormFactor.Wide

    local onBack = viewProps.onBack
    local eventHandlers = React.useMemo(function()
        return {
            [FocusNavigationEventNameEnum.NavigateBack] = {
                handler = InputHandlers.onRelease(function(arg1)
                    onBack()
                    arg1:cancel()
                end)
            }
        }
    end, { onBack })

    return React.createElement(FocusRoot, {
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.CentralOverlay,
        isAutoFocusRoot = true,
        eventMap = eventMap,
        eventHandlers = eventHandlers,
        frameProps = frameProps
    }, {
        InputSink = React.createElement(
            View,
            {
                onActivated = noop,
                stateLayer = {
                    affordance = StateLayerAffordance.None
                },
                tag = "size-full",
                ZIndex = 1
            }
        ),
        Page = React.createElement(View, {
            tag = "col size-full bg-surface-0",
            testId = "post-insights-page",
            ZIndex = 2
        }, {
            Header = React.createElement(View, {
                LayoutOrder = 1,
                padding = {
                    top = UDim.new(0, var2.top),
                    left = UDim.new(0, var2.left),
                    right = UDim.new(0, var2.right)
                },
                tag = "size-full-0 auto-y"
            }, {
                HeaderBar = React.createElement(HeaderBar.Root, {
                    hasBackground = false,
                    testId = "post-insights-header"
                }, {
                    Leading = React.createElement(HeaderBar.Leading, nil, {
                        Actions = React.createElement(
                            HeaderBar.Actions,
                            {
                                actions = {{
                                    id = "back",
                                    icon = IconName.ChevronLargeLeft,
                                    onActivated = viewProps.onBack
                                }}
                            }
                        ),
                        Title = React.createElement(
                            FoundationText,
                            {
                                LayoutOrder = 1,
                                Text = viewProps.title,
                                tag = "auto-xy text-heading-medium text-truncate-end content-emphasis"
                            }
                        )
                    })
                })
            }),
            Body = React.createElement(ScrollView, {
                LayoutOrder = 2,
                scroll = {
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    CanvasSize = UDim2.new(),
                    ScrollingDirection = Enum.ScrollingDirection.Y
                },
                tag = "fill size-full-0"
            }, {
                Centering = React.createElement(View, {
                    padding = {
                        bottom = UDim.new(0, var2.bottom),
                        left = UDim.new(0, var2.left),
                        right = UDim.new(0, var2.right)
                    },
                    tag = "col align-x-center size-full-0 auto-y"
                }, {
                    Content = React.createElement(
                        View,
                        {
                            sizeConstraint = {
                                MaxSize = Vector2.new(608, math.huge)
                            },
                            tag = "col gap-xlarge size-full-0 auto-y padding-xlarge"
                        },
                        {
                            Summary = React.createElement(Summary, { LayoutOrder = 1, viewProps = viewProps, isWide = isWide }),
                            Overview = React.createElement(OverviewSection, {
                                LayoutOrder = 2,
                                heading = viewProps.overviewHeading,
                                totalViewsLabel = viewProps.totalViewsLabel,
                                totalViewsText = viewProps.totalViewsText,
                                isTotalViewsLoading = viewProps.isTotalViewsLoading,
                                viewsChart = viewProps.viewsChart,
                                isViewsChartLoading = viewProps.isViewsChartLoading,
                                isViewsChartVisible = viewProps.isViewsChartVisible,
                                overviewMetrics = viewProps.overviewMetrics
                            }),
                            Engagement = React.createElement(EngagementSection, { LayoutOrder = 3, viewProps = viewProps })
                        }
                    )
                })
            })
        })
    })
end

return PostInsightsPageView
