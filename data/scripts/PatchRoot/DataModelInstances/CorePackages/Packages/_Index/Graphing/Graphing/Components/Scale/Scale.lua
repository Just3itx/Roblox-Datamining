-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Graphing = script:FindFirstAncestor("Graphing")
local GraphingParent = Graphing.Parent
local React = require(GraphingParent.React)
local SignalsReact = require(GraphingParent.SignalsReact)

local CanvasContext = require(Graphing.CanvasContext)
local Types = require(Graphing.Types)
local ScaleTick = require(Graphing.Components.ScaleTick)
local GridUtil = require(Graphing.Util.GridUtil)
local StyleUtil = require(Graphing.Util.StyleUtil)

local function isX(side): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return side == Types.SIDE_TOP or side == Types.SIDE_BOTTOM
end

function Scale(tbl1)
    local var1 = tbl1.Size or StyleUtil.SCALE_SIZE

    local var2 = React.useContext(CanvasContext)

    SignalsReact.useSignalState(var2.viewportRectGetter)
    local var3 = if isX(tbl1.Side) then Types.AXIS_X else Types.AXIS_Y
    local uDim2 = UDim2.fromScale(0, 0)
    if tbl1.Side == Types.SIDE_LEFT then
        uDim2 = UDim2.new(-var1, UDim.new(0, 0))
    elseif tbl1.Side == Types.SIDE_RIGHT then
        uDim2 = UDim2.fromScale(1, 0)
    elseif tbl1.Side == Types.SIDE_TOP then
        uDim2 = UDim2.new(UDim.new(0, 0), -var1)
    elseif tbl1.Side == Types.SIDE_BOTTOM then
        uDim2 = UDim2.fromScale(0, 1)
    else
        assert(false, `Invalid side {tbl1.Side}`)
    end

    local uDim2_2 = if isX(tbl1.Side) then UDim2.new(UDim.new(1, 0), var1) else UDim2.new(var1, UDim.new(1, 0))
    local values = GridUtil.getValues(var3, tbl1.Schema, var2)
    local var4 = not tbl1.SchemaMinor and {} or GridUtil.getValues(var3, tbl1.SchemaMinor, var2, values)

    local formatter = tbl1.Formatter or GridUtil.trimRoundingError
    local length = tbl1.TickLength or StyleUtil.SCALE_TICK_LENGTH
    local var5 = tbl1.TickLengthMinor or StyleUtil.SCALE_TICK_LENGTH_MINOR

    local tbl2 = {}
    for _, value in values do
        local str1 = `Tick{value}`
        tbl2[str1] = React.createElement(ScaleTick, {
            Side = tbl1.Side,
            Position = value,
            Length = length,
            Thickness = tbl1.TickThickness,
            TextPadding = tbl1.TickTextPadding,
            TextSize = tbl1.TickTextSize,
            Color3 = tbl1.TickColor,
            Formatter = formatter
        })
    end
    for _, value in var4 do
        local str1 = `TickM{value}`
        tbl2[str1] = React.createElement(ScaleTick, {
            Side = tbl1.Side,
            Position = value,
            Length = var5,
            Thickness = tbl1.TickThickness,
            TextPadding = tbl1.TickTextPadding,
            Color3 = tbl1.TickColor,
            HasLabel = false
        })
    end

    tbl2.Body = React.createElement("Frame", {
        Position = uDim2,
        Size = uDim2_2,
        BackgroundColor3 = tbl1.BackgroundColor3 or StyleUtil.SCALE_BACKGROUND_COLOR3,
        BackgroundTransparency = tbl1.BackgroundTransparency or StyleUtil.SCALE_BACKGROUND_TRANSPARENCY,
        BorderSizePixel = 0,
        ZIndex = -1
    }, tbl1.children)

    return React.createElement("Frame", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ZIndex = tbl1.ZIndex }, tbl2)
end

return Scale
