-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:31:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Graphing = script:FindFirstAncestor("Graphing")
local GraphingParent = Graphing.Parent
local React = require(GraphingParent.React)

local _Types = require(Graphing.Types)
local CanvasContext = require(Graphing.CanvasContext)
local MathUtil = require(Graphing.Util.MathUtil)

function InputDetector(tbl1)
    local var1 = React.useContext(CanvasContext)

    local inflate = tbl1.Inflate or 0

    local var2, var3 = React.useState(false)
    local _, var4 = React.useState(false)
    local var5, var6 = React.useState(false)
    local var7, var8 = React.useState(false)
    local var9, var10 = React.useState(Vector2.zero)

    local var11 = React.useCallback(function(vector2: Vector2): Vector2
        local vector2X = vector2.X
        local vector2Y = vector2.Y
        if tbl1.XSnap then
            vector2X = MathUtil.roundToNearest(vector2X, tbl1.XSnap)
        end
        if tbl1.YSnap then
            vector2Y = MathUtil.roundToNearest(vector2Y, tbl1.YSnap)
        end
        return Vector2.new(vector2X, vector2Y)
    end, { tbl1.XSnap, tbl1.YSnap })

    local var12 = React.useCallback(function(_, arg1)
        local var12 = var11(var1.mouseToPlot(arg1.Position))

        if arg1.UserInputType == Enum.UserInputType.MouseMovement then
            var3(true)

            if tbl1.OnHoverStart then
                tbl1.OnHoverStart(var1.mouseToPlot(arg1.Position), arg1)
            end
        elseif arg1.UserInputType == Enum.UserInputType.MouseButton1 or arg1.UserInputType == Enum.UserInputType.Touch then
            var6(false)

            if tbl1.OnPress then
                tbl1.OnPress(var12, arg1)
            end
        elseif arg1.UserInputType == Enum.UserInputType.MouseButton2 then
            var8(false)

            if tbl1.OnRightPress then
                tbl1.OnRightPress(var12, arg1)
            end
        end
    end, {
        var3,
        var6,
        var8,
        var1,
        tbl1.OnHoverStart,
        tbl1.OnPress,
        tbl1.OnRightPress,
        var11
    })

    local var13 = React.useCallback(function(_, arg1)
        if tbl1.OnHoverMoved and var2 and arg1.UserInputType == Enum.UserInputType.MouseMovement then
            tbl1.OnHoverMoved(var11(var1.mouseToPlot(arg1.Position)), arg1)
        elseif tbl1.OnScroll and arg1.UserInputType == Enum.UserInputType.MouseWheel then
            tbl1.OnScroll(arg1.Position.Z, arg1)
        end
    end, {
        var2,
        var1,
        tbl1.OnHoverMoved,
        tbl1.OnScroll,
        var11
    })
    local var14 = React.useCallback(function(_, arg1)
        local var14 = var11(var1.mouseToPlot(arg1.Position))

        if arg1.UserInputType == Enum.UserInputType.MouseMovement then
            var3(false)

            if tbl1.OnHoverEnded then
                tbl1.OnHoverEnded(var14, arg1)
            end

            return
        end

        if arg1.UserInputType == Enum.UserInputType.MouseButton1 or arg1.UserInputType == Enum.UserInputType.Touch then
            if tbl1.OnRelease then
                tbl1.OnRelease(var14, arg1)
            end
            if tbl1.OnClick and var2 and not var5 then
                tbl1.OnClick(var14, arg1)
            end
        elseif arg1.UserInputType == Enum.UserInputType.MouseButton2 then
            if tbl1.OnRightRelease then
                tbl1.OnRightRelease(var14, arg1)
            end
            if tbl1.OnRightClick and var2 and not var7 then
                tbl1.OnRightClick(var14, arg1)
            end
        end
    end, {
        var3,
        var2,
        var5,
        var7,
        var1,
        tbl1.OnHoverEnded,
        tbl1.OnClick,
        tbl1.OnRightClick,
        tbl1.OnRelease,
        tbl1.OnRightRelease,
        var11
    })

    local var15 = React.useCallback(function(arg1, vector2: Vector2)
        var4(true)

        local zero = Vector2.zero
        local parent = if arg1.Parent then arg1.Parent.Parent else nil

        if parent and parent:IsA("GuiObject") then
            local anchorPoint = tbl1.AnchorPoint or parent.AnchorPoint
            zero = parent.AbsolutePosition + parent.AbsoluteSize * anchorPoint
        end

        local var15 = var1.absToView(vector2) - var1.absToView(zero)
        if tbl1.TreatMouseAsAnchor then
            var15 = Vector2.zero
        end
        var10(var15)

        if tbl1.OnDragStart then
            local var16 = var1.absToView(vector2) - var15
            local var17 = Vector2.new(math.clamp(var16.X, 0, 1), math.clamp(var16.Y, 0, 1))
            tbl1.OnDragStart(var11(var1.viewToPlot(var17)), vector2)
        end
    end, {
        var1,
        var10,
        var4,
        tbl1.OnDragStart,
        tbl1.AnchorPoint,
        tbl1.TreatMouseAsAnchor,
        var11
    })

    local var16 = React.useCallback(function(_, vector2: Vector2)
        var6(true)
        var8(true)

        if tbl1.OnDragMoved then
            local var16 = var1.absToView(vector2) - var9
            local var17 = Vector2.new(math.clamp(var16.X, 0, 1), math.clamp(var16.Y, 0, 1))
            tbl1.OnDragMoved(var11(var1.viewToPlot(var17)), vector2)
        end
    end, {
        var1,
        var6,
        var8,
        var9,
        tbl1.OnDragMoved,
        var11
    })
    local var17 = React.useCallback(function(_, vector2: Vector2)
        var4(false)

        if tbl1.OnDragEnded then
            local var17 = var1.absToView(vector2) - var9
            local var18 = Vector2.new(math.clamp(var17.X, 0, 1), math.clamp(var17.Y, 0, 1))
            tbl1.OnDragEnded(var11(var1.viewToPlot(var18)), vector2)
        end
    end, {
        var1,
        var4,
        tbl1.OnDragEnded,
        var9,
        var11
    })
    local createElement = React.createElement
    local tbl2 = {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.new(1, inflate * 2, 1, inflate * 2),
        BackgroundTransparency = if tbl1.DebugColor3 == nil then 1 else 0,
        BackgroundColor3 = tbl1.DebugColor3,
        BorderSizePixel = 0,
        ZIndex = tbl1.ZIndex,
        [React.Event.InputBegan] = var12,
        [React.Event.InputChanged] = var13,
        [React.Event.InputEnded] = var14
    }
    local tbl3 = {
        DragDetector = React.createElement("UIDragDetector", {
            DragStyle = Enum.UIDragDetectorDragStyle.Scriptable,
            ReferenceUIInstance = var1.getViewport(),
            [React.Event.DragStart] = var15,
            [React.Event.DragContinue] = var16,
            [React.Event.DragEnd] = var17
        })
    }
    return createElement("Frame", tbl2, tbl3)
end

return InputDetector
