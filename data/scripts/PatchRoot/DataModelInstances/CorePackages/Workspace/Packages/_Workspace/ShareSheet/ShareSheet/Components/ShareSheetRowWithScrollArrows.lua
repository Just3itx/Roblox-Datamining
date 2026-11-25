-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:41:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheetParent = script:FindFirstAncestor("ShareSheet").Parent

local React = require(ShareSheetParent.React)
local Foundation = require(ShareSheetParent.Foundation)

local Icon = Foundation.Icon
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local IconVariant = Foundation.Enums.IconVariant
local ScrollView = Foundation.ScrollView
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance
local Visibility = Foundation.Enums.Visibility
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

local function ShareSheetRowWithScrollArrows(tbl1)
    local var1 = useTokens()
    local scrollingFrameRef = React.useRef(nil)
    local var3, var4 = React.useState(false)
    local var5, var6 = React.useState(false)
    local var7, var8 = React.useState(false)

    local var9 = React.useCallback(function(arg1)
        local num1 = math.max(0, arg1.AbsoluteCanvasSize.X - arg1.AbsoluteWindowSize.X)
        local canvasPositionX = arg1.CanvasPosition.X
        var6(canvasPositionX > 1)
        var8(canvasPositionX < num1 - 1)
    end, {})

    local var10 = React.useCallback(function(num1: number)
        local current = scrollingFrameRef.current
        if current == nil then
            return
        end

        local num2 = math.max(0, current.AbsoluteCanvasSize.X - current.AbsoluteWindowSize.X)
        local x = math.clamp(current.CanvasPosition.X + num1 * current.AbsoluteWindowSize.X, 0, num2)

        current.CanvasPosition = Vector2.new(x, current.CanvasPosition.Y)
        var9(current)
    end, { var9 })

    local createElement = React.createElement
    local var11 = View
    local tbl2 = {
        tag = "size-full-0 auto-y",
        LayoutOrder = tbl1.LayoutOrder,
        testId = "share-sheet-row"
    }
    local tbl3 = {
        ScrollView = React.createElement(ScrollView, {
            tag = "size-full-0 auto-y",
            testId = "share-sheet-row-scroll-view",
            padding = {
                left = UDim.new(0, var1.Padding.XLarge),
                right = UDim.new(0, var1.Padding.XLarge)
            },
            scrollingFrameRef = scrollingFrameRef,
            onCanvasPositionChanged = var9,
            onAbsoluteCanvasSizeChanged = var9,
            onAbsoluteWindowSizeChanged = var9,
            scroll = {
                AutomaticSize = Enum.AutomaticSize.Y,
                AutomaticCanvasSize = Enum.AutomaticSize.X,
                CanvasSize = UDim2.fromScale(0, 0),
                ScrollingDirection = Enum.ScrollingDirection.X,
                scrollBarVisibility = Visibility.None
            },
            layout = {
                FillDirection = Enum.FillDirection.Horizontal,
                VerticalAlignment = Enum.VerticalAlignment.Top,
                Padding = UDim.new(0, var1.Padding.Medium)
            }
        }, tbl1.children),
        ScrollControls = 0
    }
    local createElement2 = React.createElement
    local tbl4 = {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 10
    }

    tbl4[React.Event.MouseEnter] = function()
        var4(true)
    end
    tbl4[React.Event.MouseLeave] = function()
        var4(false)
    end
    tbl4[React.Tag] = "data-testid=share-sheet-row-scroll-controls"

    tbl3.ScrollControls = createElement2("Frame", tbl4, {
        Left = React.createElement(View, {
            Position = UDim2.new(0, var1.Padding.Medium, 0.5, 0),
            Visible = var3 and var5,
            ZIndex = 11,
            backgroundStyle = var1.DarkMode.OverMedia.OverMedia_100,
            onActivated = function()
                var10(-1)
            end,
            stateLayer = {
                affordance = StateLayerAffordance.Background
            },
            tag = "anchor-center-left size-1000 radius-circle",
            testId = "share-sheet-row-scroll-left"
        }, {
            Icon = React.createElement(Icon, {
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5),
                name = IconName.ChevronLargeLeft,
                size = IconSize.Large,
                style = var1.Color.Extended.White.White_100,
                testId = "share-sheet-row-scroll-left--icon",
                variant = IconVariant.Regular
            })
        }),
        Right = React.createElement(View, {
            Position = UDim2.new(1, -var1.Padding.Medium, 0.5, 0),
            Visible = var3 and var7,
            ZIndex = 11,
            backgroundStyle = var1.DarkMode.OverMedia.OverMedia_100,
            onActivated = function()
                var10(1)
            end,
            stateLayer = {
                affordance = StateLayerAffordance.Background
            },
            tag = "anchor-center-right size-1000 radius-circle",
            testId = "share-sheet-row-scroll-right"
        }, {
            Icon = React.createElement(Icon, {
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5),
                name = IconName.ChevronLargeRight,
                size = IconSize.Large,
                style = var1.Color.Extended.White.White_100,
                testId = "share-sheet-row-scroll-right--icon",
                variant = IconVariant.Regular
            })
        })
    })

    return createElement(var11, tbl2, tbl3)
end

return ShareSheetRowWithScrollArrows
