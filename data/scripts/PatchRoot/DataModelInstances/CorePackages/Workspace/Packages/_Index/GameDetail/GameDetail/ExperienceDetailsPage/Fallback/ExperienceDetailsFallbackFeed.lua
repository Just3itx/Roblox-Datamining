-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:51:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetailParent = script:FindFirstAncestor("GameDetail").Parent

local React = require(GameDetailParent.React)
local Foundation = require(GameDetailParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text
local Icon = Foundation.Icon
local Skeleton = Foundation.Skeleton
local Button = Foundation.Button
local Radius = Foundation.Enums.Radius
local ButtonVariant = Foundation.Enums.ButtonVariant
local useTokens = Foundation.Hooks.useTokens
local useLocalization = require(GameDetailParent.Localization).Hooks.useLocalization
local DataHydration = require(GameDetailParent.DataHydration)
local SignalsReact = require(GameDetailParent.SignalsReact)
local CompositionTags = require(GameDetailParent.AppComposition).CompositionTags

local ExperienceDetailsFallbackAttributionRow = require(script.Parent.ExperienceDetailsFallbackAttributionRow)
local useGameInfo = require(script.Parent.Parent.useGameInfo)

local FFlagLuaAppSduiEdpFallbackAttributionFromCache = require(GameDetailParent.SharedFlags).FFlagLuaAppSduiEdpFallbackAttributionFromCache

local function ExperienceDetailsFeedSkeleton(tbl1)
    local universeId = tbl1.universeId
    local var1 = useTokens()
    local isSmallScreen = tbl1.isSmallScreen
    local var2 = if FFlagLuaAppSduiEdpFallbackAttributionFromCache then useGameInfo(universeId) else nil
    return React.createElement(View, {
        tag = {
            ["col size-full auto-y"] = true,
            ["gap-xlarge"] = isSmallScreen,
            ["gap-xxlarge"] = not isSmallScreen,
            ["padding-x-xlarge"] = isSmallScreen,
            ["align-x-left"] = not isSmallScreen,
            [CompositionTags.ContentRegion.Body] = true
        },
        testId = "--edp-fallback-feed-skeleton"
    }, {
        AttributionRow = React.createElement(ExperienceDetailsFallbackAttributionRow, {
            universeId = universeId,
            isLoading = true,
            gameName = var2 and var2.name,
            isSmallScreen = isSmallScreen,
            launchSource = tbl1.launchSource,
            referralSource = tbl1.referralSource,
            experienceJoinData = tbl1.experienceJoinData,
            placeIdOverride = tbl1.placeIdOverride
        }),
        MediaGallerySkeleton = React.createElement(
            View,
            {
                tag = "size-full-0",
                LayoutOrder = if isSmallScreen then 2 else 3,
                aspectRatio = {
                    AspectRatio = 16 / 9,
                    AspectType = Enum.AspectType.ScaleWithParentSize,
                    DominantAxis = Enum.DominantAxis.Width
                }
            },
            {
                Skeleton = React.createElement(Skeleton, { Size = UDim2.fromScale(1, 1), radius = Radius.Medium })
            }
        ),
        ActionModuleSkeleton = React.createElement(
            View,
            {
                tag = "row gap-small size-full-0 auto-y",
                LayoutOrder = if isSmallScreen then 3 else 2
            },
            {
                Chip1 = React.createElement(
                    Skeleton,
                    {
                        Size = UDim2.fromOffset(var1.Size.Size_2800, var1.Size.Size_800),
                        radius = Radius.Large,
                        LayoutOrder = 1
                    }
                ),
                Chip2 = React.createElement(
                    Skeleton,
                    {
                        Size = UDim2.fromOffset(var1.Size.Size_2800, var1.Size.Size_800),
                        radius = Radius.Large,
                        LayoutOrder = 2
                    }
                ),
                Chip3 = React.createElement(
                    Skeleton,
                    {
                        Size = UDim2.fromOffset(var1.Size.Size_2800, var1.Size.Size_800),
                        radius = Radius.Large,
                        LayoutOrder = 3
                    }
                ),
                Chip4 = React.createElement(
                    Skeleton,
                    {
                        Size = UDim2.fromOffset(var1.Size.Size_2800, var1.Size.Size_800),
                        radius = Radius.Large,
                        LayoutOrder = 4
                    }
                ),
                Chip5 = React.createElement(
                    Skeleton,
                    {
                        Size = UDim2.fromOffset(var1.Size.Size_2800, var1.Size.Size_800),
                        radius = Radius.Large,
                        LayoutOrder = 5
                    }
                )
            }
        ),
        DescriptionSkeleton = React.createElement(View, {
            tag = "col gap-medium size-full-0 auto-y",
            LayoutOrder = 4
        }, {
            HeaderSkeleton = React.createElement(Skeleton, {
                Size = UDim2.fromOffset(
                    var1.Size.Size_2800 * 2,
                    var1.Typography.HeadingSmall.LineHeight * var1.Typography.HeadingSmall.FontSize
                ),
                radius = Radius.Small,
                LayoutOrder = 1
            }),
            TextSkeleton = React.createElement(Skeleton, {
                Size = UDim2.new(1, 0, 0, var1.Typography.BodyLarge.LineHeight * var1.Typography.BodyLarge.FontSize * 3),
                radius = Radius.Small,
                LayoutOrder = 2
            })
        })
    })
end

return {
    Skeleton = React.memo(ExperienceDetailsFeedSkeleton),
    Error = React.memo(function(tbl1) -- name: ExperienceDetailsFeedError
        local universeId = tbl1.universeId
        local isSmallScreen = tbl1.isSmallScreen
        local var1 = useTokens()

        local var2 = useGameInfo(universeId)
        local var3 = SignalsReact.useSignalState(DataHydration.Game.getAgeRecommendationStore(false).getAgeRecommendation(universeId).data)

        local var4 = useLocalization({
            somethingWentWrongMessage = "Feature.Toast.NetworkingError.SomethingIsWrong",
            experienceUnavailableMessage = "Feature.GamePage.QuickLaunch.LaunchError.TemporarilyUnavailable",
            retryButtonText = "InGame.CommonUI.Button.Retry"
        })

        if var2 == nil then
            return React.createElement(ExperienceDetailsFeedSkeleton, {
                universeId = universeId,
                isSmallScreen = isSmallScreen,
                launchSource = tbl1.launchSource,
                referralSource = tbl1.referralSource,
                experienceJoinData = tbl1.experienceJoinData,
                placeIdOverride = tbl1.placeIdOverride
            })
        end

        local creator = var2.creator
        local name = var2.name
        local name2 = creator and creator.name
        local hasVerifiedBadge = if creator then creator.hasVerifiedBadge == true else false
        local displayNameWithHeaderShort = var3 and var3.displayNameWithHeaderShort
        if var2.isUnavailable == true then
            return React.createElement(
                View,
                {
                    tag = "col align-x-center align-y-center size-full-0 auto-y",
                    testId = "--edp-fallback-feed-unavailable"
                },
                {
                    ErrorIcon = React.createElement(
                        Icon,
                        {
                            size = var1.Size.Size_2500,
                            name = Foundation.Enums.IconName.TriangleExclamation,
                            LayoutOrder = 1
                        }
                    ),
                    ErrorText = React.createElement(FoundationText, {
                        tag = "auto-xy padding-top-medium text-body-large text-align-x-center content-default",
                        Text = var4.experienceUnavailableMessage,
                        LayoutOrder = 2
                    })
                }
            )
        end

        return React.createElement(View, {
            tag = {
                ["col size-full auto-y"] = true,
                ["gap-xlarge"] = isSmallScreen,
                ["gap-xxlarge"] = not isSmallScreen,
                ["padding-x-xlarge"] = isSmallScreen,
                ["align-x-left"] = not isSmallScreen,
                [CompositionTags.ContentRegion.Body] = true
            },
            testId = "--edp-fallback-feed-error"
        }, {
            AttributionRow = React.createElement(ExperienceDetailsFallbackAttributionRow, {
                universeId = universeId,
                gameName = name,
                creatorName = name2,
                hasVerifiedBadge = hasVerifiedBadge,
                ageRecDisplayName = displayNameWithHeaderShort,
                isSmallScreen = isSmallScreen,
                launchSource = tbl1.launchSource,
                referralSource = tbl1.referralSource,
                experienceJoinData = tbl1.experienceJoinData,
                placeIdOverride = tbl1.placeIdOverride
            }),
            ErrorBlock = React.createElement(View, {
                tag = "col align-x-center size-full-0 auto-y padding-top-xxlarge",
                LayoutOrder = 2,
                testId = "--edp-fallback-error-state"
            }, {
                ErrorIcon = React.createElement(
                    Icon,
                    {
                        size = var1.Size.Size_2500,
                        name = Foundation.Enums.IconName.TriangleExclamation,
                        LayoutOrder = 1
                    }
                ),
                ErrorText = React.createElement(FoundationText, {
                    tag = "auto-xy padding-bottom-medium text-body-large text-align-x-center content-default",
                    Text = var4.somethingWentWrongMessage,
                    LayoutOrder = 2
                }),
                RetryButton = React.createElement(Button, {
                    text = var4.retryButtonText,
                    onActivated = tbl1.refresh,
                    variant = ButtonVariant.Standard,
                    LayoutOrder = 3,
                    testId = "--edp-fallback-error-state-retry"
                })
            })
        })
    end)
}
