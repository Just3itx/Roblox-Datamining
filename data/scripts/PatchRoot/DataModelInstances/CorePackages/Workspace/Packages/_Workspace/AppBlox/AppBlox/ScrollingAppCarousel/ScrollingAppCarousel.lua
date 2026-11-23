-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:31:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent
local Roact = require(AppBloxParent.Roact)
local UIBlox = require(AppBloxParent.UIBlox)
local Otter = require(AppBloxParent.Otter)
local Cryo = require(AppBloxParent.Cryo)
local t = require(AppBloxParent.t)
local ArgCheck = require(AppBloxParent.ArgCheck)

local AppCarousel = require(script.Parent.AppCarousel)
local ScrollButton = require(script.Parent.ScrollButton)
local Images = UIBlox.App.ImageSet.Images

local bool1 = game:DefineFastFlag("AXFixScrollingCarouselShowRightButton", false)

local iconsActionsCycleLeft = Images["icons/actions/cycleLeft"]
local iconsActionsCycleRight = Images["icons/actions/cycleRight"]

local tbl1 = {
    frequency = 2,
    dampingRatio = 0.9,
    restingPositionLimit = 0.5,
    restingVelocityLimit = 0.1
}

local var1 = Roact.PureComponent:extend("ScrollingAppCarousel")

var1.defaultProps = { carouselMargin = 0 }

var1.validateProps = t.strictInterface({
    items = t.table,
    index = t.numberMin(1),
    itemCount = t.number,
    itemWidth = t.numberMin(1),
    itemPadding = t.number,
    carouselMargin = t.number,
    carouselHeight = t.number,
    canvasWidth = t.number,
    styleProps = t.optional(t.table),
    isScrollingDisabled = t.optional(t.boolean),
    onChangeCanvasPosition = t.callback,
    onRefCallback = t.optional(t.callback),
    shouldExpandToFitContentHeight = t.optional(t.boolean)
})

function var1.getScrollState(arg1, arg2, arg3)
    local var2 = arg1 + arg2
    return {
        maxNumOfItemsVisible = math.floor((arg3 + arg2) / var2)
    }
end

function var1.handleMouseEvent(arg1, arg2, hoveringCarousel)
    if arg2.UserInputType == Enum.UserInputType.MouseMovement then
        arg1:setState({ hoveringCarousel = hoveringCarousel })
    end
end

function var1.handleScroll(arg1, arg2)
    if arg1.state.animationActive then
        return
    end

    local index = arg1.props.index
    local maxNumOfItemsVisible = arg1.state.maxNumOfItemsVisible
    arg1:scrollToIndex(index, index + (arg2 and maxNumOfItemsVisible or -maxNumOfItemsVisible))
end

function var1.handleResize(arg1, arg2)
    if not arg1._isMounted then
        return
    end

    local carouselMargin = arg1.props.carouselMargin
    local carouselWidth = arg2.AbsoluteSize.X - 2 * carouselMargin
    arg1:setState(
        Cryo.Dictionary.join(
            {
                absoluteWidth = arg2.AbsoluteSize.X,
                carouselWidth = carouselWidth
            },
            arg1.getScrollState(arg1.props.itemWidth, arg1.props.itemPadding, carouselWidth)
        )
    )
end

function var1.scrollToIndex(arg1, arg2, arg3)
    ArgCheck.assert(not arg1.props.isScrollingDisabled, "scrolling should be disabled")

    local itemCount = arg1.props.itemCount
    local var2 = arg1.props.itemWidth + arg1.props.itemPadding
    arg3 = math.min(arg3, itemCount - arg1.state.maxNumOfItemsVisible + 1)
    arg3 = math.max(arg3, 1)

    local var3 = (arg2 - 1) * var2
    local var4 = (arg3 - 1) * var2

    arg1:destroyMotor()
    arg1:createMotor(var3)
    if UserGameSettings.ReducedMotion then
        arg1.carouselMotor:setGoal(Otter.instant(var4))
        return
    end
    arg1.carouselMotor:setGoal(Otter.spring(var4, tbl1))
end

function var1.createMotor(arg1, arg2)
    arg1.carouselMotor = Otter.createSingleMotor(arg2)
    arg1.carouselMotor:onStep(function(x: number?)
        arg1:setState({ animationActive = true, canvasPosition = Vector2.new(x, 0) })
    end)

    arg1.carouselMotor:onComplete(function()
        arg1:destroyMotor()
        arg1:setState({ animationActive = false })
    end)
end

function var1.destroyMotor(arg1)
    if arg1.carouselMotor then
        arg1.carouselMotor:destroy()
        arg1.carouselMotor = nil
    end
end

function var1.init(arg1)
    arg1:setState({
        carouselWidth = 0,
        hoveringCarousel = false,
        animationActive = false,
        canvasPosition = Vector2.new(0, 0),
        maxNumOfItemsVisible = 0,
        absoluteWidth = 0
    })

    arg1.carouselMotor = nil

    function arg1.onMouseEnter(_, arg2)
        if arg1._isMounted then
            arg1:handleMouseEvent(arg2, true)
        end
    end

    function arg1.onMouseLeave(_, arg2)
        if arg1._isMounted then
            arg1:handleMouseEvent(arg2, false)
        end
    end

    arg1.frameRef = Roact.createRef()

    function arg1.onResize(arg2)
        if not arg1._isMounted then
            return
        end

        arg1:handleResize(arg2)
        if arg1.props.onResize then
            arg1.props.onResize(arg2)
        end
    end

    function arg1.scrollLeft()
        if arg1._isMounted then
            arg1:handleScroll(false)
        end
    end

    function arg1.scrollRight()
        if arg1._isMounted then
            arg1:handleScroll(true)
        end
    end
end

function var1.getDerivedStateFromProps(arg1, arg2)
    local carouselWidth = math.max(0, arg2.absoluteWidth - 2 * arg1.carouselMargin)
    return Cryo.Dictionary.join(
        { carouselWidth = carouselWidth },
        var1.getScrollState(arg1.itemWidth, arg1.itemPadding, carouselWidth)
    )
end

function var1.didMount(arg1)
    arg1._isMounted = true
    arg1:handleResize((arg1.frameRef:getValue()))
end

function var1.didUpdate(arg1, arg2, arg3)
    local bool2 = arg1.props.itemCount < arg2.itemCount
    local bool3 = arg1.props.itemWidth ~= arg2.itemWidth
    local bool4 = arg1.props.itemPadding ~= arg2.itemPadding
    local bool5 = arg1.state.maxNumOfItemsVisible ~= arg3.maxNumOfItemsVisible
    if not arg1.props.isScrollingDisabled and (bool2 or bool3 or bool4 or bool5) then
        arg1:scrollToIndex(arg1.props.index, arg2.index)
    end
end

function var1.willUnmount(arg1)
    arg1._isMounted = false
    arg1:destroyMotor()
end

function var1.render(arg1)
    local carouselMargin = arg1.props.carouselMargin
    local carouselHeight = arg1.props.carouselHeight

    local element = nil
    local element2 = nil

    if arg1.state.hoveringCarousel then
        local isScrollingDisabled = arg1.props.isScrollingDisabled
        local bool2 = arg1.props.index > 1 and not isScrollingDisabled
        local bool3 = if bool1 then arg1.props.index + arg1.state.maxNumOfItemsVisible < arg1.props.itemCount and not isScrollingDisabled else arg1.props.index + arg1.state.maxNumOfItemsVisible < arg1.props.itemCount

        if bool2 then
            element = Roact.createElement(ScrollButton, { icon = iconsActionsCycleLeft, callback = arg1.scrollLeft })
        end

        if bool3 then
            element2 = Roact.createElement(ScrollButton, { icon = iconsActionsCycleRight, callback = arg1.scrollRight })
        end
    end

    local uDim2 = if arg1.props.styleProps and arg1.props.styleProps.leftPosition then UDim2.new(0, arg1.props.styleProps.leftPosition, 0, 0) else UDim2.fromScale(0, 0)
    local uDim2_2 = if arg1.props.styleProps and arg1.props.styleProps.rightPosition then UDim2.new(1, arg1.props.styleProps.rightPosition, 0, 0) else UDim2.fromScale(1, 0)
    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.new(1, carouselMargin, 0, carouselHeight),
        AutomaticSize = if arg1.props.shouldExpandToFitContentHeight then Enum.AutomaticSize.Y else nil,
        Position = UDim2.fromOffset(-carouselMargin, 0),
        BackgroundTransparency = 1,
        [Roact.Event.InputBegan] = arg1.onMouseEnter,
        [Roact.Event.InputEnded] = arg1.onMouseLeave,
        [Roact.Change.AbsoluteSize] = arg1.onResize,
        [Roact.Ref] = arg1.frameRef
    }
    local tbl3 = {
        LeftMargin = Roact.createElement("Frame", {
            Position = uDim2,
            AnchorPoint = Vector2.new(0, 0),
            Size = UDim2.new(0, carouselMargin, 1, 0),
            BackgroundTransparency = 1,
            ZIndex = 2
        }, { ScrollLeftButton = element }),
        Carousel = Roact.createElement("Frame", {
            Size = UDim2.new(1, -2 * carouselMargin, 1, 0),
            AutomaticSize = if arg1.props.shouldExpandToFitContentHeight then Enum.AutomaticSize.Y else nil,
            Position = UDim2.fromOffset(carouselMargin, 0),
            BackgroundTransparency = 1
        }, {
            InnerCarouselContent = Roact.createElement(AppCarousel, {
                carouselHeight = carouselHeight,
                canvasWidth = arg1.props.canvasWidth,
                items = arg1.props.items,
                onChangeCanvasPosition = arg1.props.onChangeCanvasPosition,
                onRefCallback = arg1.props.onRefCallback,
                canvasPosition = arg1.state.canvasPosition,
                scrollingAnimationActive = if arg1.props.isScrollingDisabled then true else arg1.state.animationActive,
                shouldExpandToFitContentHeight = arg1.props.shouldExpandToFitContentHeight
            })
        }),
        RightMargin = Roact.createElement("Frame", {
            Position = uDim2_2,
            AnchorPoint = Vector2.new(1, 0),
            Size = UDim2.new(0, carouselMargin, 1, 0),
            BackgroundTransparency = 1,
            ZIndex = 2
        }, { ScrollRightButton = element2 })
    }
    return createElement(str1, tbl2, tbl3)
end

return var1
