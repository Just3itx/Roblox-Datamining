-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:30:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local Roact = require(scriptParentParentParentParentParent.Roact)
local t = require(scriptParentParentParentParentParent.t)

local Images = require(scriptParentParentParent.ImageSet.Images)

local ScrollButton = require(scriptParent.ScrollButton)

local isCallable = require(scriptParentParentParentParent.Utility.isCallable)

local BidirectionalFlatList = require(scriptParentParentParentParentParent.VirtualizedList).BidirectionalFlatList

local Promise = require(scriptParentParentParentParentParent.Promise)
local LuauPolyfill = require(scriptParentParentParentParentParent.LuauPolyfill)

local iconsActionsCycleLeft = Images["icons/actions/cycleLeft"]
local iconsActionsCycleRight = Images["icons/actions/cycleRight"]

local var1 = Roact.PureComponent:extend("HorizontalCarousel")

var1.validateProps = t.strictInterface({
    itemList = t.array(t.any),
    renderItem = t.callback,
    identifier = t.optional(t.callback),
    itemSize = t.optional(t.Vector2),
    itemPadding = t.optional(t.number),
    carouselMargin = t.optional(t.number),
    layoutOrder = t.optional(t.integer),
    loadNext = t.optional(t.callback),
    loadPrevious = t.optional(t.callback),
    animateScrolling = t.optional(t.boolean),
    maxNumOfItemsVisible = t.optional(t.integer),
    onContentSizeChange = t.optional(t.callback),
    viewabilityConfigCallbackPairs = t.optional(
        t.array(
            t.strictInterface({
                viewabilityConfig = t.strictInterface({
                    minimumViewTime = t.optional(t.number),
                    viewAreaCoveragePercentThreshold = t.optional(t.number),
                    itemVisiblePercentThreshold = t.optional(t.number),
                    waitForInteraction = t.optional(t.boolean)
                }),
                onViewableItemsChanged = isCallable
            })
        )
    )
})
var1.defaultProps = {
    itemSize = Vector2.new(1, 1),
    itemPadding = 12,
    maxNumOfItemsVisible = 0
}

local function updateScrollState(num1: number?, maxNumOfItemsVisible: number, numOfItems: number?, _: number?)
    if num1 == nil then
        return {}
    end

    if numOfItems == nil or numOfItems == 0 then
        return { showLeftButton = false, showRightButton = false }
    end

    local bool1 = true
    local bool2 = true

    if num1 <= 1 then
        num1 = 1
        bool1 = false
    elseif numOfItems < num1 then
        num1 = numOfItems
        bool2 = false
    end

    if numOfItems < num1 + maxNumOfItemsVisible then
        bool2 = false
    end

    return {
        index = num1,
        showLeftButton = bool1,
        showRightButton = bool2,
        numOfItems = numOfItems
    }
end

local function func1(func2: (...any) -> (...any)) -- Luacid: Inlined by compiler; 2 call sites recovered
    if func2 then
        return Promise.is(func2) and func2 or Promise.promisify(func2)
    end

    return nil
end

function var1.getDerivedStateFromProps(tbl1, tbl2)
    local itemListLen = #tbl1.itemList
    if tbl2.numOfItems ~= itemListLen then
        return (updateScrollState(tbl2.index, tbl2.maxNumOfItemsVisible, itemListLen))
    end
    return nil
end

function var1.init(arg1)
    arg1.frameRef = Roact.createRef()
    arg1.listRef = Roact.createRef()

    local tbl1 = { anchorIndex = 1 }

    arg1:setState({
        index = 1,
        hovering = false,
        showLeftButton = false,
        showRightButton = false,
        maxNumOfItemsVisible = arg1.props.maxNumOfItemsVisible,
        numOfItems = 0
    })

    function arg1.onMouseEnter(_, arg2)
        if arg2.UserInputType ~= Enum.UserInputType.MouseMovement then
            return
        end

        arg1:setState(function(arg3)
            local anchorIndex = tbl1.anchorIndex
            return LuauPolyfill.Object.assign(
                updateScrollState(anchorIndex, arg3.maxNumOfItemsVisible, arg3.numOfItems),
                { hovering = true }
            )
        end)
    end

    function arg1.onMouseLeave(_, arg2)
        if arg2.UserInputType == Enum.UserInputType.MouseMovement then
            arg1:setState({ hovering = false })
        end
    end

    function arg1.onResize(arg2)
        local absoluteSizeX = arg2.AbsoluteSize.X
        arg1:setState(function(_, arg3)
            return {
                maxNumOfItemsVisible = math.floor(absoluteSizeX / (arg3.itemSize.X + arg3.itemPadding))
            }
        end)
    end
    function arg1.onScrollUpdate(arg2)
        local var2 = arg1.props.itemSize.X + arg1.props.itemPadding
        tbl1 = {
            anchorIndex = math.floor((arg2.CanvasPosition.X > 0 and arg2.CanvasPosition.X or 0) / var2) + 1,
            animationActive = false
        }
    end

    function arg1.scrollLeft()
        if tbl1.animationActive then
            return
        end
        arg1:setState(function(arg2, arg3)
            local var2 = tbl1.anchorIndex - arg2.maxNumOfItemsVisible
            if arg1.listRef then
                arg1.listRef.current:scrollToIndex(
                    {
                        animated = true,
                        index = var2 > 1 and var2 or 1,
                        viewOffset = arg3.itemSize.X + arg3.itemPadding
                    }
                )
            end

            return (updateScrollState(var2, arg2.maxNumOfItemsVisible, arg2.numOfItems))
        end)
    end

    function arg1.scrollRight()
        if tbl1.animationActive then
            return
        end
        arg1:setState(function(arg2, arg3)
            local index = tbl1.anchorIndex + arg2.maxNumOfItemsVisible
            if arg1.listRef then
                arg1.listRef.current:scrollToIndex({ animated = true, index = index, viewOffset = arg3.itemSize.X + arg3.itemPadding })
            end

            return (updateScrollState(index, arg2.maxNumOfItemsVisible, arg2.numOfItems))
        end)
    end

    function arg1.proxyKeyExtractor(arg2, arg3)
        local props = arg1.props
        if props.identifier then
            return (props.identifier(arg2, arg3))
        end

        return nil
    end

    function arg1.proxyRenderItem(arg2)
        return arg1.props.renderItem(arg2.item)
    end

    function arg1.getItemLayout(arg2, index)
        local props = arg1.props
        local vector2 = props.itemSize.X + (props.itemPadding or 0)
        local offset = vector2 * (index - 1) + (props.carouselMargin or 0)
        if index == #arg2 then
            vector2 = props.itemSize.X
        end
        return { length = vector2, offset = offset, index = index }
    end
end

function var1.render(arg1)
    local props = arg1.props
    local state = arg1.state

    local itemList = props.itemList
    local itemSize = props.itemSize
    local itemPadding = props.itemPadding

    local carouselMargin = props.carouselMargin
    local layoutOrder = props.layoutOrder

    local loadNext = props.loadNext
    local loadPrevious = props.loadPrevious
    local scrollLeftButton = if state.hovering and state.showLeftButton then Roact.createElement(ScrollButton, { icon = iconsActionsCycleLeft, callback = arg1.scrollLeft }) else nil
    local scrollRightButton = if state.hovering and state.showRightButton then Roact.createElement(ScrollButton, { icon = iconsActionsCycleRight, callback = arg1.scrollRight }) else nil
    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl1 = {
        Size = UDim2.new(1, 0, 0, itemSize.Y),
        LayoutOrder = layoutOrder,
        BackgroundTransparency = 1,
        [Roact.Ref] = arg1.frameRef,
        [Roact.Event.InputBegan] = arg1.onMouseEnter,
        [Roact.Event.InputEnded] = arg1.onMouseLeave,
        [Roact.Change.AbsoluteSize] = arg1.onResize
    }
    local tbl2 = {
        LeftMargin = Roact.createElement("Frame", {
            Position = UDim2.fromScale(0, 0),
            AnchorPoint = Vector2.new(0, 0),
            Size = UDim2.new(0, carouselMargin, 1, 0),
            BackgroundTransparency = 1,
            ZIndex = 2
        }, { ScrollLeftButton = scrollLeftButton }),
        ScrollerCarousel = 0,
        RightMargin = 0
    }
    local var2

    if state.maxNumOfItemsVisible > 0 then
        local createElement2 = Roact.createElement
        local var3 = BidirectionalFlatList

        local tbl3 = {
            [Roact.Ref] = arg1.listRef,
            data = itemList,
            renderItem = arg1.proxyRenderItem,
            keyExtractor = arg1.proxyKeyExtractor,
            horizontal = true,
            initialScrollIndex = 1,
            initialNumToRender = 10,
            windowSize = 5,
            onScroll = arg1.onScrollUpdate,
            onStartReachedThreshold = 1,
            onStartReached = func1(loadPrevious),
            onEndReachedThreshold = 1,
            onEndReached = func1(loadNext),
            overrideAutomaticCanvasSize = true,
            getItemLayout = arg1.getItemLayout,
            viewabilityConfigCallbackPairs = props.viewabilityConfigCallbackPairs,
            ItemSeparatorComponent = itemPadding and function()
                return Roact.createFragment({ ItemPadding = Roact.createElement("UIPadding", { PaddingRight = UDim.new(0, itemPadding) }) })
            end or nil,
            showDefaultLoadingIndicators = false,
            ListHeaderComponent = carouselMargin and function()
                return Roact.createFragment({
                    LeftCarouselMargin = Roact.createElement("Frame", {
                        Position = UDim2.fromScale(0, 0),
                        AnchorPoint = Vector2.new(0, 0),
                        BackgroundTransparency = 1,
                        Size = UDim2.new(0, carouselMargin, 1, 0)
                    })
                })
            end or nil,
            ListFooterComponent = carouselMargin and function()
                return Roact.createFragment({
                    RightCarouselMargin = Roact.createElement("Frame", {
                        Position = UDim2.fromScale(0, 0),
                        AnchorPoint = Vector2.new(0, 0),
                        BackgroundTransparency = 1,
                        Size = UDim2.new(0, carouselMargin, 1, 0)
                    })
                })
            end or nil,
            contentContainerStyle = {
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(0, 1),
                ClipsDescendants = false
            },
            style = { BackgroundTransparency = 1, ScrollBarThickness = 0 },
            onContentSizeChange = props.onContentSizeChange
        }

        var2 = createElement2(var3, tbl3) or nil
    else
        var2 = nil
    end

    tbl2.ScrollerCarousel = var2

    tbl2.RightMargin = Roact.createElement("Frame", {
        Position = UDim2.fromScale(1, 0),
        AnchorPoint = Vector2.new(1, 0),
        Size = UDim2.new(0, carouselMargin, 1, 0),
        BackgroundTransparency = 1,
        ZIndex = 2
    }, { ScrollRightButton = scrollRightButton })
    return createElement(str1, tbl1, tbl2)
end

return var1
