-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:51:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local variableItemWidthCarousel = script:FindFirstAncestor("VariableItemWidthCarousel")
local variableItemWidthCarouselParent = variableItemWidthCarousel.Parent

local CollectionViews = require(variableItemWidthCarouselParent.CollectionViews)
local React = require(variableItemWidthCarouselParent.React)

local CarouselScrollButtons = CollectionViews.CarouselScrollButtons
local CollectionHeader = CollectionViews.CollectionHeader
local useDesignTokens = require(variableItemWidthCarouselParent.Style).useDesignTokens
local useTokens = require(variableItemWidthCarouselParent.Foundation).Hooks.useTokens
local Responsive = require(variableItemWidthCarouselParent.Responsive)
local useLastInput = Responsive.useLastInput
local usePreferredInput = Responsive.usePreferredInput
local useIsSpatial = Responsive.useIsSpatial
local useVariableItemWidthScrollHandlers = require(variableItemWidthCarousel.useVariableItemWidthScrollHandlers)
local FFlagSduiOptionSelectorHeaderComponent = require(variableItemWidthCarouselParent.SharedFlags).FFlagSduiOptionSelectorHeaderComponent
local FFlagSduiComponentsUseFoundationTokens = require(variableItemWidthCarouselParent.SharedFlags).FFlagSduiComponentsUseFoundationTokens

local function areScrollButtonsEnabled(pointer: string, directional: string, bool1: boolean, bool2: boolean) -- Luacid: Inlined by compiler; 1 call site recovered
    if not bool1 then
        return false
    end

    if pointer == Responsive.Input.Pointer then
        bool2 = directional ~= Responsive.Input.Directional or bool2
    end

    return bool2
end

function VariableItemWidthCarousel(tbl1, ref)
    local var1 = if FFlagSduiComponentsUseFoundationTokens then useTokens() else useDesignTokens()
    local var2 = useLastInput()
    local var3 = usePreferredInput()
    local var4 = useIsSpatial()

    local items = tbl1.items
    local renderItem = tbl1.renderItem
    local itemPadding = tbl1.itemPadding
    local itemHeight = tbl1.itemHeight
    local sideMargin = tbl1.sideMargin or 0
    local calculateItemWidth = tbl1.calculateItemWidth
    local scrollingFrameRef = tbl1.scrollingFrameRef
    local var5 = tbl1.title and tbl1.title ~= ""
    local var6 = var5 or tbl1.subtitle ~= nil or tbl1.tooltipInfoText ~= nil
    local var7 = tbl1.scrollButtonsEnabled and areScrollButtonsEnabled(var2, var3, true, var4)

    local var8 = React.useMemo(function()
        local result = ({})
        for i, item in ipairs(items) do
            result[i] = renderItem(item, i)
        end
        return result
    end, { items, renderItem })

    local handleScrollLeft, handleScrollRight, leftScrollingEnabled, rightScrollingEnabled, var13 = useVariableItemWidthScrollHandlers(items, itemPadding, calculateItemWidth, scrollingFrameRef, tbl1.scrollSpeed)

    local var14 = React.useCallback(function(arg1)
        var13()
        if tbl1.onCanvasPositionChanged and arg1 then
            tbl1.onCanvasPositionChanged(arg1.CanvasPosition)
        end
    end, { var13, tbl1.onCanvasPositionChanged })

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        Position = tbl1.Position,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = tbl1.LayoutOrder,
        ref = ref
    }
    local tbl3 = {
        UIPadding = React.createElement("UIPadding", { PaddingLeft = UDim.new(0, sideMargin), PaddingRight = UDim.new(0, sideMargin) }),
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(
                0,
                if not var6 and (not FFlagSduiOptionSelectorHeaderComponent or tbl1.headerComponent == nil) then 0 else tbl1.headerContentPadding or var1.Size.Size_400
            )
        }),
        Header = 0,
        ContentFrame = 0
    }
    local var15

    if FFlagSduiOptionSelectorHeaderComponent and tbl1.headerComponent then
        var15 = tbl1.headerComponent
    elseif var6 then
        var15 = React.createElement(CollectionHeader, {
            LayoutOrder = 1,
            title = tbl1.title,
            subtitle = tbl1.subtitle,
            tooltipInfoText = tbl1.tooltipInfoText,
            onActivateInfoIcon = tbl1.onActivateInfoIcon,
            tooltipSupportsVR = tbl1.tooltipSupportsVR,
            tooltipSupportsTenFootUi = tbl1.tooltipSupportsTenFootUi,
            hideButton = #items < 1 or tbl1.hideHeaderButton or not var5,
            onActivate = tbl1.onActivateHeader,
            buttonText = tbl1.headerButtonText
        })
    else
        var15 = nil
    end

    tbl3.Header = var15

    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl4 = {
        BackgroundTransparency = 1,
        LayoutOrder = 2,
        Size = UDim2.new(1, 0, 0, itemHeight)
    }
    local tbl5 = {
        DynamicScrollingFrame = React.createElement("ScrollingFrame", {
            AutomaticCanvasSize = Enum.AutomaticSize.X,
            BackgroundTransparency = 1,
            CanvasSize = UDim2.new(0, 0, 0, itemHeight),
            ClipsDescendants = false,
            ElasticBehavior = Enum.ElasticBehavior.Always,
            ScrollBarThickness = 0,
            ScrollingDirection = Enum.ScrollingDirection.X,
            Selectable = false,
            Size = UDim2.new(1, 0, 0, itemHeight),
            ZIndex = 1,
            ref = scrollingFrameRef,
            [React.Change.AbsoluteSize] = var13,
            [React.Change.CanvasPosition] = var14
        }, { React.createElement(React.Fragment, nil, { React.createElement("UIListLayout", {
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalAlignment = Enum.HorizontalAlignment.Left,
                    Padding = UDim.new(0, itemPadding),
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    VerticalAlignment = Enum.VerticalAlignment.Center
                }), React.createElement(React.Fragment, nil, var8) }) }),
        ScrollButtons = 0
    }
    local element

    if var7 then
        element = React.createElement(CarouselScrollButtons, {
            AnchorPoint = Vector2.new(0.5, 0),
            Position = UDim2.new(0.5, 0, 0, 0),
            Size = UDim2.new(1, 2 * sideMargin, 0, itemHeight),
            ZIndex = 2,
            buttonOffsetFromEdge = var1.Size.Size_200,
            handleScrollLeft = handleScrollLeft,
            handleScrollRight = handleScrollRight,
            leftScrollingEnabled = leftScrollingEnabled,
            rightScrollingEnabled = rightScrollingEnabled
        })
    else
        element = nil
    end

    tbl5.ScrollButtons = element
    tbl3.ContentFrame = createElement2(str2, tbl4, tbl5)
    return createElement(str1, tbl2, tbl3)
end

return React.forwardRef(VariableItemWidthCarousel)
