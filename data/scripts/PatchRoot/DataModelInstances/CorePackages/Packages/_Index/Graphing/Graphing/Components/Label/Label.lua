-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:40:31Z
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

local function anchorForAlignment(textXAlignment, textYAlignment): Vector2
    local x = 0
    local y = 0

    if textXAlignment == Enum.TextXAlignment.Left then
        x = 0
    elseif textXAlignment == Enum.TextXAlignment.Center then
        x = 0.5
    elseif textXAlignment == Enum.TextXAlignment.Right then
        x = 1
    end

    if textYAlignment == Enum.TextYAlignment.Top then
        y = 0
    elseif textYAlignment == Enum.TextYAlignment.Center then
        y = 0.5
    elseif textYAlignment == Enum.TextYAlignment.Bottom then
        y = 1
    end

    return Vector2.new(x, y)
end

function Label(tbl1)
    local textXAlignment = if tbl1.TextXAlignment then tbl1.TextXAlignment else Enum.TextXAlignment.Center
    local textYAlignment = if tbl1.TextYAlignment then tbl1.TextYAlignment else Enum.TextYAlignment.Center

    local anchorPoint = React.useMemo(function(): Vector2
        return anchorForAlignment(textXAlignment, textYAlignment)
    end, { tbl1.TextXAlignment, tbl1.TextYAlignment })

    local var2 = useViewportBinding2(function(arg1): UDim2
        local var2 = if tbl1.Offset then tbl1.Offset else Vector2.new(0, 0)
        local var3 = arg1.plotToView(tbl1.Position)
        return UDim2.new(var3.X, var2.X, var3.Y, var2.Y)
    end, { tbl1.Position, tbl1.Offset })

    if not useViewportVisibility(function(arg1)
        return arg1.isPointInViewport(tbl1.Position)
    end, { tbl1.Position }) then
        return nil
    end

    return React.createElement("TextLabel", {
        AnchorPoint = anchorPoint,
        Position = var2,
        Text = tbl1.Text,
        TextXAlignment = textXAlignment,
        TextYAlignment = textYAlignment,
        BackgroundTransparency = 1,
        TextColor3 = tbl1.Color3 or StyleUtil.GRID_LABEL_COLOR3,
        TextSize = tbl1.FontSize or StyleUtil.GRID_LABEL_FONT_SIZE,
        ZIndex = tbl1.ZIndex
    }, tbl1.children)
end

return Label
