-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:31:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Graphing = script:FindFirstAncestor("Graphing")
local GraphingParent = Graphing.Parent
local React = require(GraphingParent.React)

local StyleUtil = require(Graphing.Util.StyleUtil)
local Types = require(Graphing.Types)
local useViewportBinding = require(Graphing.Util.useViewportBinding)
local useViewportBinding2 = useViewportBinding.useViewportBinding
local useViewportVisibility = useViewportBinding.useViewportVisibility

function GridLine(tbl1)
    assert(
        tbl1.Orientation == Types.ORIENTATION_VERTICAL or tbl1.Orientation == Types.ORIENTATION_HORIZONTAL,
        `Invalid orientation {tbl1.Orientation}`
    )

    local backgroundColor3 = tbl1.Color3 or StyleUtil.GRID_LINE_COLOR3
    local backgroundTransparency = tbl1.Transparency or StyleUtil.GRID_LINE_TRANSPARENCY
    local var3 = tbl1.Thickness or StyleUtil.GRID_LINE_THICKNESS

    local var4 = useViewportBinding2(function(arg1)
        local var4 = if tbl1.Orientation == Types.ORIENTATION_VERTICAL then arg1.plotToViewX(tbl1.Position) else arg1.plotToViewY(tbl1.Position)
        local var5, var6

        if tbl1.OppositeAxisBounds then
            if tbl1.Orientation == Types.ORIENTATION_VERTICAL then
                var5 = arg1.plotToViewY(tbl1.OppositeAxisBounds.Min)
                var6 = arg1.plotToViewY(tbl1.OppositeAxisBounds.Max)
            else
                var5 = arg1.plotToViewX(tbl1.OppositeAxisBounds.Min)
                var6 = arg1.plotToViewX(tbl1.OppositeAxisBounds.Max)
            end
        else
            var5 = 0
            var6 = 1
        end

        local scale, var7

        if tbl1.Orientation == Types.ORIENTATION_VERTICAL then
            scale = UDim2.fromScale(var4, (var5 + var6) / 2)
            var7 = UDim2.new(0, var3, var6 - var5, 0)
        else
            scale = UDim2.fromScale((var5 + var6) / 2, var4)
            var7 = UDim2.new(var6 - var5, 0, 0, var3)
        end

        return { position = scale, size = var7 }
    end, {
        tbl1.Orientation,
        tbl1.Position,
        tbl1.OppositeAxisBounds,
        var3
    })
    if not useViewportVisibility(function(arg1)
        if tbl1.OppositeAxisBounds then
            if tbl1.Orientation == Types.ORIENTATION_VERTICAL then
                return (arg1.isRectInViewport(Rect.new(tbl1.Position, tbl1.OppositeAxisBounds.Min, tbl1.Position, tbl1.OppositeAxisBounds.Max)))
            end
            return (arg1.isRectInViewport(Rect.new(tbl1.OppositeAxisBounds.Min, tbl1.Position, tbl1.OppositeAxisBounds.Max, tbl1.Position)))
        elseif tbl1.Orientation == Types.ORIENTATION_VERTICAL then
            return (arg1.isPointInViewportX(tbl1.Position))
        else
            return (arg1.isPointInViewportY(tbl1.Position))
        end
    end, { tbl1.Orientation, tbl1.Position, tbl1.OppositeAxisBounds }) then
        return nil
    end

    return React.createElement("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = var4:map(function(arg1)
            return arg1.position
        end),
        Size = var4:map(function(arg1)
            return arg1.size
        end),
        BorderSizePixel = 0,
        BackgroundColor3 = backgroundColor3,
        BackgroundTransparency = backgroundTransparency,
        ZIndex = tbl1.ZIndex
    }, tbl1.children)
end

return GridLine
