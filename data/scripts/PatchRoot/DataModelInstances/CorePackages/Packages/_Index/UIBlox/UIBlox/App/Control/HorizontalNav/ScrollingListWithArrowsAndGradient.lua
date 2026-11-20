-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:31:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParentParent = scriptParentParent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local React = require(scriptParentParentParentParentParent.React)

local IntroScroll = require(scriptParentParent.HorizontalNav.IntroScroll)
local GradientFrame = require(scriptParentParent.HorizontalNav.GradientFrame)
local ArrowFrame = require(scriptParentParent.HorizontalNav.ArrowFrame)
local Utils = require(scriptParentParent.HorizontalNav.Utils)
local useIsMouseAndKeyboard = require(scriptParentParentParentParent.Utility.useIsMouseAndKeyboard)

local function ScrollingListWithArrowsAndGradient(tbl1)
    local listHeight = tbl1.listHeight
    local childWidgetIndex = tbl1.childWidgetIndex
    local useIntroScroll = tbl1.useIntroScroll
    local canvasWidth = tbl1.canvasWidth or 0

    local var1 = useIsMouseAndKeyboard()
    local frameRef = React.useRef(nil)

    local isVisibleLeft, var4 = React.useBinding(false)
    local isVisibleRight, var6 = React.useBinding(false)

    local canvasPosition, updateCanvasPosition = React.useBinding(Vector2.new(0, 0))

    local var9 = React.useCallback(function(arg1)
        local value = frameRef:getValue()
        if not value then
            return
        end

        local var9, leftVisible, rightVisible = Utils.shouldShowGradientsForScrollingFrame(arg1)

        value.Visible = var9 and (not tbl1.hideGradient or var1)

        local left = value:FindFirstChild("Left")
        local right = value:FindFirstChild("Right")

        if left and right then
            left.Visible = leftVisible
            right.Visible = rightVisible
        end

        var4(leftVisible)
        var6(rightVisible)
    end, { frameRef, var4, var6 })

    local var10 = React.useCallback(function(arg1)
        var9(arg1)

        updateCanvasPosition(arg1.CanvasPosition)
    end, { var9, updateCanvasPosition })

    React.useEffect(function()
        local value = tbl1.scrollingFrameRef:getValue()
        if value then
            var9(value)
        end
    end)

    local createElement = React.createElement
    local fragment = React.Fragment
    local tbl2 = {}
    local tbl3 = {
        ScrollingList = React.createElement("ScrollingFrame", {
            ClipsDescendants = tbl1.clipsDescendants,
            Size = UDim2.new(1, 0, 1, 0),
            CanvasSize = UDim2.new(0, canvasWidth, 1, 0),
            CanvasPosition = canvasPosition,
            ScrollBarThickness = 0,
            BackgroundTransparency = 1,
            ElasticBehavior = Enum.ElasticBehavior.Always,
            ScrollingDirection = Enum.ScrollingDirection.X,
            ZIndex = 2,
            [React.Change.AbsoluteSize] = var9,
            [React.Change.CanvasSize] = var9,
            [React.Change.CanvasPosition] = var10,
            ref = tbl1.scrollingFrameRef
        }, tbl1.getScollingListContent()),
        GradientFrame = React.createElement(GradientFrame, { height = listHeight, frameRef = frameRef, ZIndex = 3 }),
        ArrowFrame = var1
            and React.createElement(ArrowFrame, {
                isVisibleLeft = isVisibleLeft,
                isVisibleRight = isVisibleRight,
                defaultUseProps = {
                    scrollingFrameRef = tbl1.scrollingFrameRef,
                    buttonRefs = tbl1.buttonRefs,
                    buttonWidth = tbl1.buttonWidth,
                    padOutsideEdges = tbl1.padOutsideEdges,
                    numButtons = tbl1.numButtons,
                    buttonPadding = tbl1.buttonPadding,
                    updateCanvasPosition = updateCanvasPosition
                },
                ZIndex = 4
            }),
        IntroScroll = if useIntroScroll then React.createElement(IntroScroll, {
            childWidgetIndex = childWidgetIndex,
            scrollingFrameRef = tbl1.scrollingFrameRef,
            updateCanvasPosition = updateCanvasPosition
        })
            or nil else nil
    }
    return createElement(fragment, tbl2, tbl3)
end

return ScrollingListWithArrowsAndGradient
