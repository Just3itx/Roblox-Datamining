-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Graphing = script:FindFirstAncestor("Graphing")
local GraphingParent = Graphing.Parent
local Dash = require(GraphingParent.Dash)
local React = require(GraphingParent.React)

local CanvasContext = require(Graphing.CanvasContext)
local InputDetector = require(Graphing.Components.InputDetector)
local Panel = require(Graphing.Components.Panel)
local Types = require(Graphing.Types)

local function onDrag(arg1, vector2: Vector2, vector2_2: Vector2)
    if not arg1.SetRect then
        return
    end

    local var1 = arg1.MinSize or Vector2.zero

    local minX = arg1.Rect.Min.X
    local minY = arg1.Rect.Min.Y
    local maxX = arg1.Rect.Max.X
    local maxY = arg1.Rect.Max.Y

    if vector2_2.X == 0 then
        minX = math.min(vector2.X, maxX - var1.X)
    end
    if vector2_2.X == 1 then
        maxX = math.max(vector2.X, minX + var1.X)
    end
    if vector2_2.Y == 0 then
        minY = math.min(vector2.Y, maxY - var1.Y)
    end
    if vector2_2.Y == 1 then
        maxY = math.max(vector2.Y, minY + var1.Y)
    end

    assert(arg1.SetRect ~= nil, "props.SetRect is nil")

    arg1.SetRect(Rect.new(minX, minY, maxX, maxY))
end

function ResizablePanel(arg1)
    local var1 = React.useContext(CanvasContext)

    local bool1 = var1.getXAxisScaling().Direction == Types.DIRECTION_REVERSED
    local bool2 = var1.getYAxisScaling().Direction == Types.DIRECTION_REVERSED

    local onDragMoved = React.useCallback(function(vector2: Vector2)
        if not arg1.SetRect then
            return
        end

        assert(arg1.SetRect, "props.SetRect was nil")

        arg1.SetRect(Rect.new(vector2.X, vector2.Y, vector2.X + arg1.Rect.Width, vector2.Y + arg1.Rect.Height))
    end, { arg1.Rect, arg1.SetRect })

    local var2 = React.useCallback(function(vector2: Vector2)
        onDrag(arg1, vector2, Vector2.new(if bool1 then 1 else 0, 0.5))
    end, {
        arg1.Rect,
        arg1.SetRect,
        arg1.MinSize,
        bool1
    })
    local var3 = React.useCallback(function(vector2: Vector2)
        onDrag(arg1, vector2, Vector2.new(if bool1 then 0 else 1, 0.5))
    end, {
        arg1.Rect,
        arg1.SetRect,
        arg1.MinSize,
        bool1
    })
    local var4 = React.useCallback(function(vector2: Vector2)
        onDrag(arg1, vector2, Vector2.new(0.5, if bool2 then 0 else 1))
    end, {
        arg1.Rect,
        arg1.SetRect,
        arg1.MinSize,
        bool2
    })
    local var5 = React.useCallback(function(vector2: Vector2)
        onDrag(arg1, vector2, Vector2.new(0.5, if bool2 then 1 else 0))
    end, {
        arg1.Rect,
        arg1.SetRect,
        arg1.MinSize,
        bool2
    })
    local var6 = React.useCallback(function(vector2: Vector2)
        onDrag(arg1, vector2, Vector2.new(if bool1 then 1 else 0, if bool2 then 0 else 1))
    end, {
        arg1.Rect,
        arg1.SetRect,
        arg1.MinSize,
        bool1,
        bool2
    })
    local var7 = React.useCallback(function(vector2: Vector2)
        onDrag(arg1, vector2, Vector2.new(if bool1 then 0 else 1, if bool2 then 0 else 1))
    end, {
        arg1.Rect,
        arg1.SetRect,
        arg1.MinSize,
        bool1,
        bool2
    })
    local var8 = React.useCallback(function(vector2: Vector2)
        onDrag(arg1, vector2, Vector2.new(if bool1 then 1 else 0, if bool2 then 1 else 0))
    end, {
        arg1.Rect,
        arg1.SetRect,
        arg1.MinSize,
        bool1,
        bool2
    })
    local var9 = React.useCallback(function(vector2: Vector2)
        onDrag(arg1, vector2, Vector2.new(if bool1 then 0 else 1, if bool2 then 1 else 0))
    end, {
        arg1.Rect,
        arg1.SetRect,
        arg1.MinSize,
        bool1,
        bool2
    })
    return React.createElement(
        Panel,
        Dash.join(arg1, {
            Rect = arg1.Rect,
            children = Dash.join(arg1.children, {
                CenterInput = arg1.DragEnabled
                    and React.createElement(
                        InputDetector,
                        {
                            AnchorPoint = Vector2.new(0, 0),
                            XSnap = arg1.XSnap,
                            YSnap = arg1.YSnap,
                            OnDragMoved = onDragMoved,
                            ZIndex = 0
                        }
                    ),
                Left = arg1.EdgeLeftEnabled
                    and React.createElement("Frame", {
                        Position = UDim2.fromScale(0, 0),
                        Size = UDim2.fromScale(0, 1),
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        ZIndex = 1
                    }, {
                        Input = React.createElement(InputDetector, { Inflate = 5, XSnap = arg1.XSnap, YSnap = arg1.YSnap, OnDragMoved = var2 })
                    }),
                Right = arg1.EdgeRightEnabled
                    and React.createElement("Frame", {
                        Position = UDim2.fromScale(1, 0),
                        Size = UDim2.fromScale(0, 1),
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        ZIndex = 1
                    }, {
                        Input = React.createElement(InputDetector, { Inflate = 5, XSnap = arg1.XSnap, YSnap = arg1.YSnap, OnDragMoved = var3 })
                    }),
                Top = arg1.EdgeTopEnabled
                    and React.createElement("Frame", {
                        Position = UDim2.fromScale(0, 0),
                        Size = UDim2.fromScale(1, 0),
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        ZIndex = 1
                    }, {
                        Input = React.createElement(InputDetector, { Inflate = 5, XSnap = arg1.XSnap, YSnap = arg1.YSnap, OnDragMoved = var4 })
                    }),
                Bottom = arg1.EdgeBottomEnabled
                    and React.createElement("Frame", {
                        Position = UDim2.fromScale(0, 1),
                        Size = UDim2.fromScale(1, 0),
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        ZIndex = 1
                    }, {
                        Input = React.createElement(InputDetector, { Inflate = 5, XSnap = arg1.XSnap, YSnap = arg1.YSnap, OnDragMoved = var5 })
                    }),
                TopLeft = arg1.CornerTopLeftEnabled
                    and React.createElement("Frame", {
                        Position = UDim2.fromScale(0, 0),
                        Size = UDim2.fromScale(0, 0),
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        ZIndex = 2
                    }, {
                        Input = React.createElement(InputDetector, { Inflate = 5, XSnap = arg1.XSnap, YSnap = arg1.YSnap, OnDragMoved = var6 })
                    }),
                TopRight = arg1.CornerTopRightEnabled
                    and React.createElement("Frame", {
                        Position = UDim2.fromScale(1, 0),
                        Size = UDim2.fromScale(0, 0),
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        ZIndex = 2
                    }, {
                        Input = React.createElement(InputDetector, { Inflate = 5, XSnap = arg1.XSnap, YSnap = arg1.YSnap, OnDragMoved = var7 })
                    }),
                BottomLeft = arg1.CornerBottomLeftEnabled
                    and React.createElement("Frame", {
                        Position = UDim2.fromScale(0, 1),
                        Size = UDim2.fromScale(0, 0),
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        ZIndex = 2
                    }, {
                        Input = React.createElement(InputDetector, { Inflate = 5, XSnap = arg1.XSnap, YSnap = arg1.YSnap, OnDragMoved = var8 })
                    }),
                BottomRight = arg1.CornerBottomRightEnabled
                    and React.createElement("Frame", {
                        Position = UDim2.fromScale(1, 1),
                        Size = UDim2.fromScale(0, 0),
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        ZIndex = 2
                    }, {
                        Input = React.createElement(InputDetector, { Inflate = 5, XSnap = arg1.XSnap, YSnap = arg1.YSnap, OnDragMoved = var9 })
                    })
            })
        })
    )
end

return ResizablePanel
