-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:41:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecyclerRoblox = script:FindFirstAncestor("ViewRecyclerRoblox")
local Axis = require(ViewRecyclerRoblox.Parent.ViewRecycler).Axis

local module = {}

function module.mainOf(vector2: Vector2, arg1)
    return if arg1 == Axis.X then vector2.X else vector2.Y
end

function module.crossOf(vector2: Vector2, arg1)
    return if arg1 == Axis.X then vector2.Y else vector2.X
end

function module.positionFor(arg1, arg2, num1: number?): UDim2
    local crossAxisIndex = arg1.crossAxisIndex or 1
    local crossAxisCount = arg1.crossAxisCount or 1
    local var1 = (crossAxisIndex - 1) / crossAxisCount
    local var2 = (crossAxisIndex - 1) * (arg1.crossAxisSpacing or 0) / crossAxisCount
    local var3 = arg1.startOffset + (num1 or 0)

    if arg2 == Axis.X then
        return UDim2.new(0, var3, var1, var2)
    end

    return UDim2.new(var1, var2, 0, var3)
end

function module.sizeFor(arg1, arg2, bool1: boolean): UDim2
    local crossAxisCount = arg1.crossAxisCount or 1
    local var1 = 1 / crossAxisCount
    local var2 = -(crossAxisCount - 1) * (arg1.crossAxisSpacing or 0) / crossAxisCount
    local var3 = if bool1 then 0 else arg1.length

    if arg2 == Axis.X then
        return UDim2.new(0, var3, var1, var2)
    end

    return UDim2.new(var1, var2, 0, var3)
end

function module.canvasSizeFor(num1: number, arg1): UDim2
    if arg1 == Axis.X then
        return UDim2.fromOffset(num1, 0)
    end

    return UDim2.fromOffset(0, num1)
end

return module
