-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:40:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Graphing = script:FindFirstAncestor("Graphing")
local GraphingParent = Graphing.Parent
local React = require(GraphingParent.React)

local Types = require(Graphing.Types)
local SidePositioner = require(Graphing.Components.SidePositioner)
local GridUtil = require(Graphing.Util.GridUtil)
local StyleUtil = require(Graphing.Util.StyleUtil)

local function isX(side): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return side == Types.SIDE_TOP or side == Types.SIDE_BOTTOM
end

function ScaleTick(tbl1)
    local length = tbl1.Length
    local var1 = tbl1.Thickness or StyleUtil.SCALE_TICK_THICKNESS
    local var2 = tbl1.TextPadding or StyleUtil.SCALE_TICK_LABEL_PADDING
    local var3 = tbl1.HasLabel == nil or tbl1.HasLabel

    local anchorPoint = GridUtil.getAnchorPointForSide(tbl1.Side)
    local textXAlignment, textYAlignment = GridUtil.getTextAlignmentsFromAnchorPoint(anchorPoint)
    local uDim2 = if isX(tbl1.Side) then UDim2.fromOffset(var1, length) else UDim2.fromOffset(length, var1)
    local var6 = length + var2

    local uDim2_2 = UDim2.fromOffset(-2 * var6 * anchorPoint.X + var6, -2 * var6 * anchorPoint.Y + var6)

    local createElement = React.createElement
    local var7 = SidePositioner
    local tbl2 = {
        Side = tbl1.Side,
        Position = tbl1.Position,
        ZIndex = tbl1.ZIndex
    }
    local tbl3 = {
        Tick = React.createElement("Frame", {
            AnchorPoint = anchorPoint,
            Size = uDim2,
            BackgroundColor3 = tbl1.Color3 or StyleUtil.SCALE_TICK_COLOR3,
            BorderSizePixel = 0
        }, tbl1.children),
        Label = 0
    }

    if var3 then
        local createElement2 = React.createElement
        local str1 = "TextLabel"
        local tbl4 = {
            AnchorPoint = anchorPoint,
            Position = uDim2_2,
            Text = if tbl1.Formatter then tbl1.Formatter(tbl1.Position) else tostring(tbl1.Position),
            TextXAlignment = textXAlignment,
            TextYAlignment = textYAlignment,
            BackgroundTransparency = 1,
            TextColor3 = tbl1.Color3 or StyleUtil.SCALE_TICK_LABEL_COLOR3,
            TextSize = tbl1.TextSize or StyleUtil.SCALE_TICK_LABEL_SIZE
        }
        var3 = createElement2(str1, tbl4)
    end

    tbl3.Label = var3
    return createElement(var7, tbl2, tbl3)
end

return ScaleTick
