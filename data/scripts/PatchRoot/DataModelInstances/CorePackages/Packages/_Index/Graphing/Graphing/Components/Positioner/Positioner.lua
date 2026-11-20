-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:40:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Graphing = script:FindFirstAncestor("Graphing")
local GraphingParent = Graphing.Parent
local React = require(GraphingParent.React)

local _Types = require(Graphing.Types)
local useViewportBinding = require(Graphing.Util.useViewportBinding)
local useViewportBinding2 = useViewportBinding.useViewportBinding
local useViewportVisibility = useViewportBinding.useViewportVisibility

function Positioner(tbl1, ref)
    if typeof(tbl1.Position) ~= "Vector2" then
        return React.createElement("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = tbl1.Position,
            Size = UDim2.fromOffset(0, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ZIndex = tbl1.ZIndex,
            ref = ref,
            [React.Tag] = tbl1.Tag
        }, tbl1.children)
    end

    local position = tbl1.Position

    local var1 = useViewportBinding2(function(arg1): UDim2
        local var1 = arg1.plotToView(position)
        return UDim2.fromScale(var1.X, var1.Y)
    end, { position })

    if not useViewportVisibility(function(arg1)
        return arg1.isPointInViewport(position)
    end, { position }) then
        return nil
    end

    return React.createElement("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = var1,
        Size = UDim2.fromOffset(0, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = tbl1.ZIndex,
        ref = ref,
        [React.Tag] = tbl1.Tag
    }, tbl1.children)
end

return React.forwardRef(Positioner)
