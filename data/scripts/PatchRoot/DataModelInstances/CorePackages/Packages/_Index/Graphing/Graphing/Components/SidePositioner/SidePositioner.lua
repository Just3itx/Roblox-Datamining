-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:41:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Graphing = script:FindFirstAncestor("Graphing")
local GraphingParent = Graphing.Parent
local React = require(GraphingParent.React)

local Types = require(Graphing.Types)
local useViewportBinding = require(Graphing.Util.useViewportBinding)
local useViewportBinding2 = useViewportBinding.useViewportBinding
local useViewportVisibility = useViewportBinding.useViewportVisibility

local function isX(side): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return side == Types.SIDE_TOP or side == Types.SIDE_BOTTOM
end

function SidePositioner(tbl1)
    local var1 = useViewportBinding2(function(arg1): UDim2
        local xScale = 0
        local yScale = 0

        if isX(tbl1.Side) then
            xScale = arg1.plotToViewX(tbl1.Position)
            if tbl1.Side == Types.SIDE_BOTTOM then
                yScale = 1
            end
        else
            yScale = arg1.plotToViewY(tbl1.Position)
            if tbl1.Side == Types.SIDE_RIGHT then
                xScale = 1
            end
        end

        return UDim2.fromScale(xScale, yScale)
    end, { tbl1.Side, tbl1.Position })

    if not useViewportVisibility(function(arg1)
        if isX(tbl1.Side) then
            return (arg1.isPointInViewportX(tbl1.Position))
        end

        return (arg1.isPointInViewportY(tbl1.Position))
    end, { tbl1.Side, tbl1.Position }) then
        return nil
    end

    return React.createElement("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = var1,
        Size = UDim2.fromOffset(0, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = tbl1.ZIndex
    }, tbl1.children)
end

return SidePositioner
