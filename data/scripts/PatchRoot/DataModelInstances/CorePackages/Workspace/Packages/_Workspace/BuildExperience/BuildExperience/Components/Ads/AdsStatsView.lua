-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:01:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local _CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)

local _StatsCard = require(BuildExperience.Components.Analytics.StatsCard.StatsCard)
local StatsCardContainer = require(BuildExperience.Components.Analytics.StatsCardContainer)
local PastCampaignsList = require(script.Parent.PastCampaignsList)
local _PastCampaignRow = require(script.Parent.PastCampaignRow)
local CreateAdCampaignSheetContainer = require(script.Parent.CreateAdCampaignSheet.CreateAdCampaignSheetContainer)
local FFlagBuildAdsManagerUniverseUrl = require(BuildExperience.Flags.FFlagBuildAdsManagerUniverseUrl)

local Icon = Foundation.Icon
local FoundationText = Foundation.Text
local View = Foundation.View
local Skeleton = Foundation.Skeleton

local IconName = Foundation.Enums.IconName
local Radius = Foundation.Enums.Radius
local useTokens = Foundation.Hooks.useTokens

local function renderActiveCampaign(tbl1, layoutOrder: number, testId: string)
    local str1 = `{testId}-active-{layoutOrder}`
    return React.createElement(
        View,
        { LayoutOrder = layoutOrder, tag = "col gap-medium size-full-0 auto-y", testId = str1 },
        {
            DateRange = React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = tbl1.dateText,
                tag = "size-full-0 auto-y text-title-medium text-align-x-left content-emphasis",
                testId = `{str1}-date-range`
            }),
            Cards = React.createElement(
                StatsCardContainer,
                {
                    layoutOrder = 2,
                    cards = tbl1.summaryCards,
                    testId = `{str1}-cards`
                }
            )
        }
    )
end

local function renderSkeletonTileRow(layoutOrder: number, yOffset: number)
    local tbl1 = ({})
    for i = 1, 2 do
        local str1 = `Cell{i}`
        local createElement = React.createElement
        local var1 = View

        local tbl2 = {
            Card = React.createElement(Skeleton, { Size = UDim2.new(1, 0, 0, yOffset), radius = Radius.Large })
        }
        tbl1[str1] = createElement(var1, { LayoutOrder = i, tag = "fill auto-y" }, tbl2)
    end

    return React.createElement(View, { LayoutOrder = layoutOrder, tag = "row gap-medium size-full-0 auto-y" }, tbl1)
end

local function LoadingSkeleton(tbl1)
    local var1 = useTokens()
    local size400 = var1.Size.Size_400
    local size1600 = var1.Size.Size_1600
    local size2000 = var1.Size.Size_2000

    return React.createElement(
        View,
        {
            LayoutOrder = tbl1.layoutOrder,
            tag = "col gap-xlarge size-full-0 auto-y padding-top-xlarge",
            testId = tbl1.testId
        },
        {
            ActiveBlock = React.createElement(View, {
                LayoutOrder = 1,
                tag = "col gap-medium size-full-0 auto-y"
            }, {
                DateRange = React.createElement(Skeleton, { LayoutOrder = 1, Size = UDim2.new(0.4, 0, 0, size400), radius = Radius.Small }),
                Grid = React.createElement(
                    View,
                    { LayoutOrder = 2, tag = "col gap-medium size-full-0 auto-y" },
                    {
                        Row1 = renderSkeletonTileRow(1, size1600),
                        Row2 = renderSkeletonTileRow(2, size1600)
                    }
                )
            }),
            PastSection = React.createElement(View, {
                LayoutOrder = 2,
                tag = "col gap-small size-full-0 auto-y"
            }, {
                Heading = React.createElement(Skeleton, { LayoutOrder = 1, Size = UDim2.new(0.35, 0, 0, size400), radius = Radius.Small }),
                Rows = React.createElement(View, {
                    LayoutOrder = 2,
                    tag = "col gap-small size-full-0 auto-y"
                }, {
                    Row1 = React.createElement(Skeleton, { LayoutOrder = 1, Size = UDim2.new(1, 0, 0, size2000), radius = Radius.Large }),
                    Row2 = React.createElement(Skeleton, { LayoutOrder = 2, Size = UDim2.new(1, 0, 0, size2000), radius = Radius.Large })
                })
            })
        }
    )
end

local function EmptyState(tbl1)
    local var1 = useTokens()
    local size1400 = var1.Size.Size_1400

    return React.createElement(
        View,
        {
            LayoutOrder = 1,
            tag = "col align-x-center gap-small size-full-0 auto-y",
            testId = `{tbl1.testId}-empty`
        },
        {
            Illustration = React.createElement(Icon, {
                LayoutOrder = 1,
                name = IconName.ChartScatterPlot,
                size = size1400,
                style = var1.Color.Content.Emphasis,
                testId = `{tbl1.testId}-empty-illustration`
            }),
            Headings = React.createElement(View, {
                LayoutOrder = 2,
                tag = "col align-x-center gap-xxsmall size-full-0 auto-y"
            }, {
                Title = React.createElement(FoundationText, {
                    LayoutOrder = 1,
                    Text = tbl1.title,
                    tag = "size-full-0 auto-y text-heading-small text-wrap text-align-x-center content-emphasis"
                }),
                Subtitle = React.createElement(FoundationText, {
                    LayoutOrder = 2,
                    Text = tbl1.subtitle,
                    tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-center content-default"
                })
            })
        }
    )
end

local function AdsStatsView(tbl1)
    local testId = tbl1.testId or "AdsStatsView"

    local tbl2 = {
        PromotionSheet = React.createElement(CreateAdCampaignSheetContainer, {
            universeId = if FFlagBuildAdsManagerUniverseUrl then tbl1.universeId else nil,
            isOpen = tbl1.isPromotionSheetOpen,
            onClose = tbl1.onClosePromotionSheet,
            onCreate = tbl1.onCreateCampaign,
            waitForCreateResult = true,
            isCreatePending = tbl1.isPromotionCreatePending,
            hasCreateError = tbl1.hasPromotionCreateError,
            createErrorKind = tbl1.promotionCreateErrorKind,
            useLocalRunDates = true,
            campaignDurationDays = tbl1.adCampaignDurationDays,
            estimatedPriceRobux = tbl1.adCampaignEstimatedPriceRobux,
            campaignOffers = tbl1.adCampaignOffers,
            runStartTimeMs = tbl1.adCampaignRunStartTimeMs,
            runEndTimeMs = tbl1.adCampaignRunEndTimeMs
        })
    }
    if tbl1.isFailed then
        tbl2.Error = React.createElement(FoundationText, {
            LayoutOrder = 1,
            Text = tbl1.errorText,
            tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-default",
            testId = `{testId}-error`
        })
    elseif tbl1.isLoading then
        tbl2.Loading = React.createElement(LoadingSkeleton, { layoutOrder = 1, testId = `{testId}-loading` })
    elseif not tbl1.hasCampaigns then
        tbl2.EmptyState = React.createElement(EmptyState, { title = tbl1.emptyTitle, subtitle = tbl1.emptySubtitle, testId = testId })
    else
        if #tbl1.activeCampaigns > 0 then
            local tbl3 = {}
            for k, activeCampaign in tbl1.activeCampaigns do
                tbl3[activeCampaign.id] = renderActiveCampaign(activeCampaign, k, testId)
            end
            tbl2.ActiveCampaigns = React.createElement(
                View,
                {
                    LayoutOrder = 1,
                    tag = "col gap-large size-full-0 auto-y",
                    testId = `{testId}-active-campaigns`
                },
                tbl3
            )
        end
        if #tbl1.pastCampaigns > 0 then
            tbl2.PastCampaigns = React.createElement(
                View,
                {
                    LayoutOrder = 2,
                    tag = "col gap-small size-full-0 auto-y",
                    testId = `{testId}-past-campaigns`
                },
                {
                    Heading = React.createElement(FoundationText, {
                        LayoutOrder = 1,
                        Text = tbl1.pastCampaignsTitle,
                        tag = "size-full-0 auto-y text-title-medium text-align-x-left content-emphasis"
                    }),
                    List = React.createElement(PastCampaignsList, { layoutOrder = 2, rows = tbl1.pastCampaigns })
                }
            )
        end
    end

    local bool1 = not (tbl1.isFailed or tbl1.isLoading or tbl1.hasCampaigns)
    return React.createElement(View, {
        LayoutOrder = tbl1.layoutOrder,
        tag = {
            ["col align-y-center size-full"] = bool1,
            ["col gap-xlarge size-full-0 auto-y padding-top-xlarge"] = not bool1
        },
        testId = testId
    }, tbl2)
end

return AdsStatsView
