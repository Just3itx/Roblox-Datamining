-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:40:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Graphing = script:FindFirstAncestor("Graphing")
local GraphingParent = Graphing.Parent
local React = require(GraphingParent.React)

local StyleUtil = require(Graphing.Util.StyleUtil)
local _Types = require(Graphing.Types)
local useViewportBinding = require(Graphing.Util.useViewportBinding)
local useViewportBinding2 = useViewportBinding.useViewportBinding
local useViewportVisibility = useViewportBinding.useViewportVisibility

function Panel(tbl1)
    local var1 = useViewportBinding2(function(arg1)
        local var1 = arg1.plotToView(tbl1.Rect.Min)
        local var2 = arg1.plotToView(tbl1.Rect.Max)
        return {
            position = UDim2.fromScale(var1.X, var1.Y),
            size = UDim2.fromScale(var2.X - var1.X, var2.Y - var1.Y)
        }
    end, { tbl1.Rect })

    if not useViewportVisibility(function(arg1)
        return arg1.isRectInViewport(tbl1.Rect)
    end, { tbl1.Rect }) then
        return nil
    elseif tbl1.Image then
        local createElement = React.createElement

        local tbl2 = {
            Position = var1:map(function(arg1)
                return arg1.position
            end),
            Size = var1:map(function(arg1)
                return arg1.size
            end),
            Image = tbl1.Image,
            ImageColor3 = tbl1.ImageColor3,
            ImageTransparency = tbl1.ImageTransparency,
            BackgroundTransparency = 0,
            BorderSizePixel = 0,
            ZIndex = tbl1.ZIndex,
            [React.Tag] = tbl1.Tag
        }

        return createElement("ImageLabel", tbl2, tbl1.children)
    else
        local createElement = React.createElement

        local tbl2 = {
            Position = var1:map(function(arg1)
                return arg1.position
            end),
            Size = var1:map(function(arg1)
                return arg1.size
            end),
            BackgroundColor3 = tbl1.BackgroundColor3 or StyleUtil.GRID_BOX_BACKGROUND_COLOR3,
            BackgroundTransparency = tbl1.BackgroundTransparency or StyleUtil.GRID_BOX_BACKGROUND_TRANSPARENCY,
            BorderColor3 = tbl1.BorderColor3 or StyleUtil.GRID_BOX_BORDER_COLOR3,
            BorderSizePixel = tbl1.BorderThickness or StyleUtil.GRID_BOX_BORDER_THICKNESS,
            ZIndex = tbl1.ZIndex,
            [React.Tag] = tbl1.Tag
        }

        return createElement("Frame", tbl2, tbl1.children)
    end
end

return Panel
