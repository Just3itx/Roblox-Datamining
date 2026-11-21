-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:20:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameFilters = script:FindFirstAncestor("GameFilters")

local GameFiltersParent = GameFilters.Parent
local Cryo = require(GameFiltersParent.Cryo)
local _DiscoveryTypes = require(GameFiltersParent.DiscoveryTypes)
local React = require(GameFiltersParent.React)
local ScreenSizeImpressionsTracker = require(GameFiltersParent.Impressions).ScreenSizeImpressionsTracker
local FrameBoundsImpressionsTracker = require(GameFiltersParent.Impressions).FrameBoundsImpressionsTracker
local VariableItemWidthCarousel = require(GameFiltersParent.VariableItemWidthCarousel).VariableItemWidthCarousel

local useCollectionImpressionsSignal = require(GameFiltersParent.CollectionViews).useCollectionImpressionsSignal
local Foundation = require(GameFiltersParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local FilterPill = require(GameFilters.Components.FilterPill)
local FFlagLuaAppUseFrameBoundsImpressions = require(GameFiltersParent.SharedFlags).FFlagLuaAppUseFrameBoundsImpressions

local _FilterCallbackTypes = require(GameFilters.FilterCallbackTypes)

return function(tbl1)
    local var1 = useTokens()

    local var2, var3 = React.useState({})

    local var4 = React.useRef(nil)

    local impressionsTag = "FilterPillCarousel_" .. tbl1.sortIndex

    local scrollViewPositionChangedSignal, onCanvasPositionChanged = useCollectionImpressionsSignal(tbl1.scrollViewPositionChangedSignal)

    local sendImpressions = tbl1.sendImpressions

    local var8 = React.useCallback(function()
        local bodyMedium = var1.Typography.BodyMedium
        local muted = var1.Color.Content.Muted

        return React.createElement("TextLabel", {
            BackgroundTransparency = 1,
            Text = tbl1.title,
            Size = UDim2.new(0, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.XY,
            FontFace = normalizeFontFace(bodyMedium.Font),
            TextSize = bodyMedium.FontSize,
            TextTransparency = muted.Transparency,
            TextColor3 = muted.Color3,
            TextWrapped = false,
            TextTruncate = Enum.TextTruncate.SplitWord,
            TextXAlignment = Enum.TextXAlignment.Left,
            LayoutOrder = 1
        })
    end, { tbl1.title, var1 })

    local title = if not tbl1.title or tbl1.title == "" then "" else var8

    local renderItem = React.useCallback(function(filter, index: number)
        return React.createElement(FilterPill, {
            analyticsInfo = tbl1.analyticsInfo,
            filter = filter,
            impressionsTag = impressionsTag,
            index = index,
            onFilterApplied = tbl1.onFilterApplied,
            onAbsoluteSizeChanged = function(arg1)
                if arg1 then
                    var3(Cryo.Dictionary.join(var2, { [index] = arg1.AbsoluteSize.X }))
                end
            end,
            pageContext = tbl1.pageContext,
            sendFilterClick = tbl1.sendFilterClick
        })
    end, {
        tbl1.analyticsInfo,
        impressionsTag,
        tbl1.onFilterApplied,
        var2,
        tbl1.pageContext,
        tbl1.sendFilterClick
    })

    local calculateItemWidth = React.useCallback(function(num1: number)
        return var2[num1] or 0
    end, { var2 })

    return React.createElement(React.Fragment, nil, {
        FilterCarousel = React.createElement(VariableItemWidthCarousel, {
            title = title,
            items = tbl1.filters,
            renderItem = renderItem,
            onCanvasPositionChanged = onCanvasPositionChanged,
            calculateItemWidth = calculateItemWidth,
            itemHeight = var1.Size.Size_800,
            headerContentPadding = var1.Padding.XSmall,
            itemPadding = var1.Padding.XSmall,
            sideMargin = tbl1.sideMargin,
            LayoutOrder = tbl1.sortIndex,
            scrollButtonEnabled = true,
            scrollingFrameRef = var4,
            ref = tbl1.containerRef
        }),
        ImpressionsTracker = React.createElement(
            if FFlagLuaAppUseFrameBoundsImpressions then FrameBoundsImpressionsTracker else ScreenSizeImpressionsTracker,
            {
                impressionsTag = impressionsTag,
                pageContext = tbl1.pageContext,
                parentRef = var4,
                scrollViewPositionChangedSignal = scrollViewPositionChangedSignal,
                sendImpressions = sendImpressions,
                dataUpdatedTimestamp = tbl1.dataUpdatedTimestamp
            }
        )
    })
end
