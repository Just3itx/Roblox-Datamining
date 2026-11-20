-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:40:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Graphing = script:FindFirstAncestor("Graphing")
local GraphingParent = Graphing.Parent
local React = require(GraphingParent.React)

local CanvasContext = require(Graphing.CanvasContext)
local ScrollbarButton = require(Graphing.Components.ScrollbarButton)
local StyleUtil = require(Graphing.Util.StyleUtil)
local Types = require(Graphing.Types)
local useViewportBinding = require(Graphing.Util.useViewportBinding).useViewportBinding

local function getDim(arg1, axisX) -- Luacid: Inlined by compiler; 12 call sites recovered
    return if axisX == Types.AXIS_X then arg1.X else arg1.Y
end

local function makeUDim2(uDim: UDim, uDim2: UDim, axisX) -- Luacid: Inlined by compiler; 8 call sites recovered
    if axisX == Types.AXIS_X then
        return UDim2.new(uDim, uDim2)
    end

    return UDim2.new(uDim2, uDim)
end

function Scrollbar(tbl1)
    local var1 = tbl1.Distance or StyleUtil.SCROLLBAR_DISTANCE
    local uDim = tbl1.Size or StyleUtil.SCROLLBAR_SIZE
    local offset = tbl1.ScrollButtonSize or StyleUtil.SCROLLBAR_SCROLL_BUTTON_SIZE
    local offset2 = tbl1.ZoomButtonSize or StyleUtil.SCROLLBAR_ZOOM_BUTTON_SIZE

    local var2 = React.useContext(CanvasContext)

    local var3 = useViewportBinding(function(arg1)
        local var3 = if tbl1.Axis == Types.AXIS_X then arg1.plotToGraphX else arg1.plotToGraphY
        local viewportRect = arg1.getViewportRect()
        local scale = var3((getDim(viewportRect.Min, tbl1.Axis)))
        local var4 = var3((getDim(viewportRect.Max, tbl1.Axis)))
        return {
            position = makeUDim2(UDim.new(scale, 0), UDim.new(0, 0), tbl1.Axis),
            size = makeUDim2(UDim.new(var4 - scale), UDim.new(1, 0), tbl1.Axis)
        }
    end, { tbl1.Axis })

    local var4 = React.useCallback(function(num1: number)
        if not tbl1.OnViewChanged then
            return
        end

        local var4 = if tbl1.Axis == Types.AXIS_X then var2.plotToGraphX else var2.plotToGraphY
        local var5 = if tbl1.Axis == Types.AXIS_X then var2.graphToPlotX else var2.graphToPlotY
        local viewportRect = var2.getViewportRect()
        local var6 = var4((getDim(viewportRect.Min, tbl1.Axis)))
        local var7 = var4((getDim(viewportRect.Max, tbl1.Axis)))

        local var8 = if tbl1.ExpandedBounds then var4(tbl1.ExpandedBounds.Min) else 0
        local var9 = if tbl1.ExpandedBounds then var4(tbl1.ExpandedBounds.Max) else 1

        local var10 = var6 + num1
        local var11 = var7 + num1

        local num2 = 0
        local num3 = math.min(var10, var11)
        local num4 = math.max(var10, var11)
        if num3 < var8 then
            num2 = var8 - num3
        elseif var9 < num4 then
            num2 = var9 - num4
        end
        local var12 = var10 + num2
        local var13 = var11 + num2

        local var14 = var5(var12)
        local var15 = var5(var13)

        tbl1.OnViewChanged(var14, var15)
    end, { tbl1.OnViewChanged, tbl1.Axis, tbl1.ExpandedBounds })

    local onMoved = React.useCallback(function(vector2: Vector2)
        local var5 = (if tbl1.Axis == Types.AXIS_X then var2.plotToGraphX else var2.plotToGraphY)(
            (getDim(var2.getViewportRect().Min, tbl1.Axis))
        )
        local var6 = var2.plotToView(vector2)
        var4(getDim(var6, tbl1.Axis) - var5)
    end, { var4, tbl1.Axis })

    local var5 = React.useCallback(function(vector2: Vector2)
        if not tbl1.OnViewChanged then
            return
        end
        local var6 = var2.plotToView(vector2)
        local var7 = var2.graphToPlot(var6)

        local dim = getDim(var2.getGraphRect().Min, tbl1.Axis)
        local dim2 = getDim(var2.getViewportRect().Max, tbl1.Axis)

        local num1 = math.max(math.min(getDim(var7, tbl1.Axis), dim2 - tbl1.MinZoom), dim)

        tbl1.OnViewChanged(num1, dim2)
    end, { tbl1.OnViewChanged, tbl1.Axis, tbl1.MinZoom })

    local var6 = React.useCallback(function(vector2: Vector2)
        if not tbl1.OnViewChanged then
            return
        end
        local var7 = var2.plotToView(vector2)
        local var8 = var2.graphToPlot(var7)

        local dim = getDim(var2.getGraphRect().Max, tbl1.Axis)
        local dim2 = getDim(var2.getViewportRect().Min, tbl1.Axis)

        local num1 = math.min(math.max(getDim(var8, tbl1.Axis), dim2 + tbl1.MinZoom), dim)

        tbl1.OnViewChanged(dim2, num1)
    end, { tbl1.OnViewChanged, tbl1.Axis, tbl1.MinZoom })

    local onClick = React.useCallback(function()
        var4(-0.04)
    end, { var4 })

    local var7 = React.useCallback(function()
        var4(0.04)
    end, { var4 })

    local uDim2 = makeUDim2(UDim.new(0, -offset - offset2), UDim.new(1, 0) + var1, tbl1.Axis)
    local uDim2_2 = makeUDim2(UDim.new(1, 0), uDim, tbl1.Axis)
    local uDim2_3 = makeUDim2(UDim.new(0, (offset + offset2) * 2), UDim.new(0, 0), tbl1.Axis)
    local uDim2_4 = makeUDim2(UDim.new(0, offset), UDim.new(1, 0), tbl1.Axis)
    local uDim2_5 = makeUDim2(UDim.new(0, offset2), UDim.new(1, 0), tbl1.Axis)
    local rotation = if tbl1.Axis == Types.AXIS_X then 0 else 90

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Position = uDim2,
        Size = uDim2_2 + uDim2_3,
        BorderSizePixel = tbl1.OutlineThickness or StyleUtil.SCROLLBAR_OUTLINE_THICKNESS,
        BorderColor3 = tbl1.OutlineColor3 or StyleUtil.SCROLLBAR_OUTLINE_COLOR3,
        BackgroundColor3 = tbl1.Color3 or StyleUtil.SCROLLBAR_COLOR3,
        ZIndex = tbl1.ZIndex,
        [React.Tag] = "ScrollbarFrame"
    }
    local tbl3 = {
        MinScrollButton = React.createElement(ScrollbarButton, {
            Position = UDim2.fromScale(0, 0),
            Rotation = rotation,
            Size = uDim2_4,
            Image = StyleUtil.SCROLLBAR_LEFT_SCROLL_BUTTON_IMAGE,
            OnClick = onClick
        }),
        MaxScrollButton = React.createElement(ScrollbarButton, {
            AnchorPoint = if tbl1.Axis == Types.AXIS_X then Vector2.new(1, 0) else Vector2.new(0, 1),
            Position = makeUDim2(UDim.new(1, 0), UDim.new(0, 0), tbl1.Axis),
            Rotation = rotation,
            Size = uDim2_4,
            Image = StyleUtil.SCROLLBAR_RIGHT_SCROLL_BUTTON_IMAGE,
            OnClick = var7
        }),
        Inner = 0
    }
    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl4 = {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1, 1) - uDim2_3,
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    }

    local tbl5 = { Body = 0 }
    local createElement3 = React.createElement
    local str3 = "Frame"

    local tbl6 = {
        Position = var3:map(function(arg1)
            return arg1.position
        end),
        Size = var3:map(function(arg1)
            return arg1.size
        end),
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    }

    local tbl7 = {
        MainButton = React.createElement(ScrollbarButton, {
            AnchorPoint = if tbl1.Axis == Types.AXIS_X then Vector2.new(0, 0) else Vector2.new(0, 1),
            Position = if tbl1.Axis == Types.AXIS_X then UDim2.fromScale(0, 0) else UDim2.fromScale(0, 1),
            Size = UDim2.fromScale(1, 1),
            OnMoved = onMoved
        }),
        LeftButton = React.createElement(ScrollbarButton, {
            AnchorPoint = if tbl1.Axis == Types.AXIS_X then Vector2.new(1, 0) else Vector2.new(0, 0),
            Position = if tbl1.Axis == Types.AXIS_X then UDim2.fromScale(0, 0) else UDim2.fromScale(0, 1),
            Rotation = rotation,
            Size = uDim2_5,
            Image = StyleUtil.SCROLLBAR_LEFT_ZOOM_BUTTON_IMAGE,
            OnMoved = var5
        }),
        RightButton = React.createElement(ScrollbarButton, {
            AnchorPoint = if tbl1.Axis == Types.AXIS_X then Vector2.new(0, 0) else Vector2.new(0, 1),
            Position = if tbl1.Axis == Types.AXIS_X then UDim2.fromScale(1, 0) else UDim2.fromScale(0, 0),
            Rotation = rotation,
            Size = uDim2_5,
            Image = StyleUtil.SCROLLBAR_RIGHT_ZOOM_BUTTON_IMAGE,
            OnMoved = var6
        })
    }
    tbl5.Body = createElement3(str3, tbl6, tbl7)
    tbl3.Inner = createElement2(str2, tbl4, tbl5)
    return createElement(str1, tbl2, tbl3)
end

return Scrollbar
