-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:31:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local CoreScriptsRoactCommonParent = script:FindFirstAncestor("CoreScriptsRoactCommon").Parent

local AppCommonLib = require(CoreScriptsRoactCommonParent.AppCommonLib)
local CollectionViews = require(CoreScriptsRoactCommonParent.CollectionViews)
local Cryo = require(CoreScriptsRoactCommonParent.Cryo)
local DiscoveryAnalytics = require(CoreScriptsRoactCommonParent.DiscoveryAnalytics)
local Foundation = require(CoreScriptsRoactCommonParent.Foundation)
local GameCollections = require(CoreScriptsRoactCommonParent.GameCollections)
local Impressions = require(CoreScriptsRoactCommonParent.Impressions)
local Localization = require(CoreScriptsRoactCommonParent.Localization)
local React = require(CoreScriptsRoactCommonParent.React)
local RoactServiceTags = require(CoreScriptsRoactCommonParent.RoactServiceTags)
local RobloxAppHooks = require(CoreScriptsRoactCommonParent.RobloxAppHooks)
local ViewportUtils = require(CoreScriptsRoactCommonParent.ViewportUtils)
local SharedFlags = require(CoreScriptsRoactCommonParent.SharedFlags)

local Constants = require(script.Parent.Constants)
local TraversalExperienceCard = require(script.Parent.TraversalExperienceCard)
local TraversalTelemetry = require(script.Parent.TraversalTelemetry)

local maxCardsPerRow = game:DefineFastInt("MaxTraversalHistoryCardsPerRow709", 6)
local FFlagTraversalHistoryDiscoveryTelemetry = SharedFlags.FFlagTraversalHistoryDiscoveryTelemetry
local FFlagTraversalExpPagePaddingFixes = require(script.Parent.Flags).FFlagTraversalExpPagePaddingFixes
local bool1 = game:DefineFastFlag("TraversalUseDiscoveryCollectionViews", false)
local bool2 = game:DefineFastFlag("TraversalUseXSmallCollectionItems", false)
local FFlagIntegrateTraversalHistoryInSideSheet = SharedFlags.FFlagIntegrateTraversalHistoryInSideSheet

local Signal = AppCommonLib.Signal
local CollectionLayoutCalculators = CollectionViews.CollectionLayoutCalculators
local CollectionItemSize = CollectionViews.CollectionViewTypes.CollectionItemSize
local gamePlayIntent = DiscoveryAnalytics.Events.gamePlayIntent
local IconButton = Foundation.IconButton
local IconName = Foundation.Enums.IconName
local FoundationText = Foundation.Text
local View = Foundation.View
local ScrollView = Foundation.ScrollView
local useTokens = Foundation.Hooks.useTokens
local SendGameImpressions = GameCollections.SendGameImpressions
local ImpressionsTrackerWithoutNavigation = Impressions.ImpressionsTrackerWithoutNavigation
local useViewportBounds = ViewportUtils.useViewportBounds
local useLocalization = Localization.Hooks.useLocalization
local AppEventIngestService = RoactServiceTags.AppEventIngestService
local RoactAnalytics = RoactServiceTags.RoactAnalytics
local useRoactService = RobloxAppHooks.useRoactService

local function getCardsPerRowAndCardWidth(tbl1)
    local availableWidth = tbl1.availableWidth
    local maxCardsPerRow = tbl1.maxCardsPerRow
    local minCardWidth = tbl1.minCardWidth
    local cardGap = tbl1.cardGap or 0

    local num2 = math.floor((availableWidth + cardGap) / (minCardWidth + cardGap))

    local num3 = math.floor((availableWidth - cardGap * (num2 - 1)) / num2)
    local num4 = math.floor((availableWidth - cardGap * (maxCardsPerRow - 1)) / maxCardsPerRow)
    if num2 < 1 then
        return 1, minCardWidth
    elseif num3 < num4 then
        return maxCardsPerRow, num4
    end
    return num2, num3
end

return React.memo(React.forwardRef(function(tbl1, ref) -- name: HistoryPage
    local var1 = useRoactService(AppEventIngestService)
    local var2 = useRoactService(RoactAnalytics)
    local var3 = useTokens()
    local var4 = useLocalization({
        historyTitle = "CoreScripts.TopBar.Traversal.History",
        historyDescription = "CoreScripts.InGameMenu.Traversal.HistoryDescription"
    })
    local cardGap = if FFlagTraversalExpPagePaddingFixes then var3.Gap.Large else var3.Gap.Small
    local xLarge = var3.Padding.XLarge
    local availableWidth, var6 = React.useState(0)
    local numColumns, var7

    if bool1 then
        local var8 = if bool2 and GuiService.ViewportDisplaySize == Enum.DisplaySize.Small then CollectionItemSize.XSmall else CollectionItemSize.Small
        numColumns = CollectionLayoutCalculators.calculateNumColumns(availableWidth, 0, cardGap, var8, var3)
        var7 = CollectionViews.calculateItemWidth(numColumns, cardGap, 0, availableWidth, 0)
    else
        local var8
        numColumns, var8 = getCardsPerRowAndCardWidth({
            availableWidth = availableWidth,
            maxCardsPerRow = maxCardsPerRow,
            minCardWidth = var3.Size.Size_2500,
            cardGap = cardGap
        })
        var7 = var8
    end

    local num2 = math.max(numColumns, 1)
    local num3 = math.floor(#tbl1.historyItems / num2)
    local var8 = React.useRef(nil)
    local var9 = React.useRef({})
    local var10 = React.useCallback(function(arg1, arg2)
        var9.current[arg1] = arg2
    end, {})
    local var11 = React.useRef(nil)
    local scrollViewPositionChangedSignal = React.useMemo(function()
        return Signal.new()
    end, {})

    local var13 = Cryo.List.map(tbl1.historyItems, function(arg1, arg2)
        return React.createElement(TraversalExperienceCard, {
            key = arg2,
            name = arg1.name,
            image = arg1.image,
            impressionIndex = arg2,
            impressionTag = Constants.CardImpressionTag,
            rating = arg1.rating,
            onActivated = function()
                if not tbl1.onCardItemActivated then
                    return
                end
                TraversalTelemetry.sendHistoryPageExperienceTileClick({
                    integration_id = "history_landing_game_tile",
                    event_type = "click",
                    destination_universe_id = tostring(arg1.universeId),
                    recency_pos = arg2
                })

                if FFlagTraversalHistoryDiscoveryTelemetry then
                    gamePlayIntent(
                        var1,
                        DiscoveryAnalytics.Constants.Context.InExpHistoryTile,
                        {
                            placeId = tostring(arg1.placeId),
                            universeId = tostring(arg1.universeId),
                            sortEntryIndex = tostring(arg2)
                        }
                    )
                end
                tbl1.onCardItemActivated(arg1.universeId)
            end,
            width = var7,
            ref = function(arg3)
                var10(arg2, arg3)
            end
        })
    end)

    local var14 = React.useRef(false)
    React.useEffect(function()
        if var14.current or not var8.current or not var11.current or not tbl1.onLoadMoreHistory then
            return
        end

        local var15 = var8.current * num3
        if var15 + var8.current <= var11.current.AbsoluteSize.Y then
            var14.current = true
            local num4 = math.max(math.floor((var11.current.AbsoluteSize.Y - var15) / var8.current), 1) * num2
            tbl1.onLoadMoreHistory(num4)
        end
    end, { tbl1.onLoadMoreHistory, num2, num3 })

    local viewPortBounds = useViewportBounds()
    local sendImpressions = React.useCallback(function(arg1)
        if not FFlagTraversalHistoryDiscoveryTelemetry then
            return
        end

        local tbl2 = {}
        for uiIndex, historyItem in tbl1.historyItems do
            if not historyItem then
                continue
            end

            table.insert(
                tbl2,
                {
                    placeId = tostring(historyItem.placeId),
                    universeId = tostring(historyItem.universeId),
                    uiIndex = uiIndex
                }
            )
        end

        SendGameImpressions.sendFromTraversalHistoryPage(var1, var2, arg1, tbl2, num2, num3)
    end, {
        tbl1.historyItems,
        var2,
        num2,
        var1,
        num3
    })

    local onActivated = React.useCallback(function()
        TraversalTelemetry.sendHistoryPageBackButtonClick(
            { integration_id = "history_landing_back_button", event_type = "click" }
        )

        tbl1.onHistoryClose()
    end, { tbl1.onHistoryClose })

    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        local var18 = arg1.AbsoluteSize.X - 2 * xLarge
        var6(var18)
        if var9.current[1] then
            var8.current = var9.current[1].AbsoluteSize.Y
        end
    end, { xLarge })

    local onCanvasPositionChanged = React.useCallback(function(arg1)
        scrollViewPositionChangedSignal:fire()
        if not (tbl1.onLoadMoreHistory and var8.current) then
            return
        end
        local canvasPositionY = arg1.CanvasPosition.Y
        local absoluteWindowSizeY = arg1.AbsoluteWindowSize.Y
        local absoluteCanvasSizeY = arg1.AbsoluteCanvasSize.Y
        local current = var8.current
        if absoluteCanvasSizeY <= canvasPositionY + absoluteWindowSizeY + current then
            tbl1.onLoadMoreHistory(num2)
        end
    end, { tbl1.onLoadMoreHistory, num2, scrollViewPositionChangedSignal })

    local var20 = FFlagTraversalExpPagePaddingFixes and {
        left = UDim.new(0, xLarge),
        right = UDim.new(0, xLarge)
    }
        or UDim.new(0, xLarge)
    local padding = FFlagIntegrateTraversalHistoryInSideSheet
        and {
            left = UDim.new(0, xLarge),
            right = UDim.new(0, xLarge),
            top = UDim.new(0, var3.Padding.Small)
        }
        or var20

    return React.createElement(View, {
        tag = "col auto-xy size-full-0",
        selectionGroup = {
            SelectionBehaviorUp = Enum.SelectionBehavior.Stop,
            SelectionBehaviorDown = Enum.SelectionBehavior.Stop,
            SelectionBehaviorLeft = Enum.SelectionBehavior.Stop,
            SelectionBehaviorRight = Enum.SelectionBehavior.Stop
        }
    }, {
        TopContainer = if FFlagIntegrateTraversalHistoryInSideSheet then nil elseif FFlagTraversalExpPagePaddingFixes then React.createElement(
            View,
            { tag = "size-full-0 auto-y padding-x-small padding-bottom-large" },
            {
                ChevronButton = React.createElement(IconButton, { icon = IconName.ChevronLargeLeft, onActivated = onActivated, ref = ref })
            }
        ) else React.createElement(IconButton, { icon = IconName.ChevronLargeLeft, onActivated = onActivated, ref = ref }),
        Header = React.createElement(View, {
            tag = "col auto-y size-full-0 " .. (if FFlagTraversalExpPagePaddingFixes then "" else "padding-left-medium padding-top-small padding-bottom-large"),
            padding = FFlagTraversalExpPagePaddingFixes and {
                left = UDim.new(0, xLarge),
                bottom = UDim.new(0, var3.Padding.XLarge)
            } or nil,
            LayoutOrder = 1
        }, {
            Title = not FFlagIntegrateTraversalHistoryInSideSheet
                and React.createElement(
                    FoundationText,
                    {
                        Text = var4.historyTitle,
                        tag = "auto-xy text-heading-small text-truncate-split"
                    }
                ),
            Description = React.createElement(
                FoundationText,
                {
                    Text = var4.historyDescription,
                    tag = "auto-xy text-body-large text-truncate-split"
                }
            )
        }),
        ScrollContent = React.createElement(ScrollView, {
            tag = "size-full shrink",
            padding = padding,
            layout = {
                FillDirection = Enum.FillDirection.Horizontal,
                Padding = UDim.new(0, cardGap),
                Wraps = true
            },
            scroll = {
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                CanvasSize = UDim2.new(0, 0, 0, 0),
                ScrollingDirection = Enum.ScrollingDirection.Y
            },
            LayoutOrder = 2,
            onAbsoluteSizeChanged = onAbsoluteSizeChanged,
            onCanvasPositionChanged = onCanvasPositionChanged,
            scrollingFrameRef = var11,
            selection = { Selectable = false },
            selectionGroup = false
        }, var13),
        TraversalHistoryCardImpressionTracker = FFlagTraversalHistoryDiscoveryTelemetry
            and React.createElement(ImpressionsTrackerWithoutNavigation, {
                parentRef = var11,
                impressionsTag = Constants.CardImpressionTag,
                scrollViewPositionChangedSignal = scrollViewPositionChangedSignal,
                sendImpressions = sendImpressions,
                viewPortBounds = viewPortBounds
            })
    })
end))
