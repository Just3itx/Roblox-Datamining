-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Graphing = script:FindFirstAncestor("Graphing")

local MathUtil = require(Graphing.Util.MathUtil)
local Types = require(Graphing.Types)

local module = {}

function module.getUniformValues(arg1, num1: number, num2: number, tbl1)
    if num2 < num1 then
        local num3 = num2
        num2 = num1
        num1 = num3
    end

    local unit = arg1.Unit
    local offset = arg1.Offset or 0

    local num3 = math.ceil((num1 - offset) / unit - unit * 1e-9)
    local num4 = math.floor((num2 - offset) / unit + unit * 1e-9)

    local uniformValues = {}
    for i = num3, num4 do
        local var1 = offset + i * unit
        if not tbl1[var1] then
            table.insert(uniformValues, var1)
        end
    end
    return uniformValues
end

function module.getLogarithmicValues(arg1, num1: number, num2: number, tbl1)
    if num2 < num1 then
        local num3 = num2
        num2 = num1
        num1 = num3
    end

    local base = arg1.Base
    local subdivision = arg1.Subdivision or 0
    local num3 = math.max(arg1.MinExponent or -10, MathUtil.log(base, num1))
    local num4 = math.max(num3, MathUtil.log(base, num2))

    local logarithmicValues = {}
    local num5 = 0

    for i = math.floor(num3), math.ceil(num4) do
        local num6 = math.pow(base, i + 1 - subdivision)

        local num7 = math.pow(base, i)
        local num8 = i + 1

        for j = num7, math.pow(base, num8), num6 do
            if num2 < j then
                break
            end

            if j < num1 or j == num5 then
                continue
            end

            if tbl1[j] then
                num5 = j
            else
                table.insert(logarithmicValues, j)
                num5 = j
            end
        end
    end

    return logarithmicValues
end

function module.getValuesValues(arg1, num1: number, num2: number, tbl1)
    local valuesValues = {}
    for _, value in arg1.Values do
        if num1 <= value and value <= num2 and not tbl1[value] then
            table.insert(valuesValues, value)
        end
    end
    return valuesValues
end

function module.getValues(axisX, arg1, arg2, tbl1)
    local values = {}

    local tbl2 = ({})
    if tbl1 then
        for _, value in tbl1 do
            tbl2[value] = true
        end
    end

    local viewportRect = arg2.getViewportRect()
    local var1 = if axisX == Types.AXIS_X then viewportRect.Min.X else viewportRect.Min.Y
    local var2 = if axisX == Types.AXIS_X then viewportRect.Max.X else viewportRect.Max.Y

    if arg1.Type == Types.SCALE_UNIFORM then
        return (module.getUniformValues(arg1, var1, var2, tbl2))
    end

    if arg1.Type == Types.SCALE_LOGARITHMIC then
        return (module.getLogarithmicValues(arg1, var1, var2, tbl2))
    end

    if arg1.Type == Types.SCALE_VALUES then
        return (module.getValuesValues(arg1, var1, var2, tbl2))
    end
    assert(false, `Axis schema {arg1.Type} not supported`)

    return values
end

function module.trimRoundingError(num1: number)
    local var1 = string.format("%.10f", num1):gsub("^0*(.-)%.?0*$", "%1")
    if var1 == "" or var1:sub(1, 1) == "." then
        var1 = "0" .. var1
    end

    return var1
end

function module.getAnchorPointForSide(arg1)
    if arg1 == Types.SIDE_LEFT then
        return Vector2.new(1, 0.5)
    end

    if arg1 == Types.SIDE_RIGHT then
        return Vector2.new(0, 0.5)
    end

    if arg1 == Types.SIDE_TOP then
        return Vector2.new(0.5, 1)
    end

    if arg1 == Types.SIDE_BOTTOM then
        return Vector2.new(0.5, 0)
    end
    assert(false, `Side {arg1} not supported`)
end

function module.getTextAlignmentsFromAnchorPoint(vector2: Vector2)
    local textXAlignment = if vector2.X == 0 then Enum.TextXAlignment.Left elseif vector2.X == 1 then Enum.TextXAlignment.Right else Enum.TextXAlignment.Center

    if vector2.Y == 0 then
        return textXAlignment, Enum.TextYAlignment.Top
    elseif vector2.Y == 1 then
        return textXAlignment, Enum.TextYAlignment.Bottom
    end
    return textXAlignment, Enum.TextYAlignment.Center
end

return module
