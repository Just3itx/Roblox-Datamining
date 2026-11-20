-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:50:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ultimateList = script:FindFirstAncestor("ultimate-list")

local DataSourceMethods = require(ultimateList.DataSources.DataSourceMethods)
local _DataSources = require(ultimateList.DataSources)
local _Parent = require(script.Parent)
local exhaustiveMatch = require(ultimateList.Util.exhaustiveMatch)

local module = {}

function module.getCanvasSize(arg1, arg2, vector2: Vector2, str1: string)
    local var1 = DataSourceMethods.back(arg2)
    if var1 == nil then
        return UDim2.new()
    end

    local uDimRect = module.getUDimRect(arg1, var1, DataSourceMethods.length(arg2), vector2, str1)
    if str1 == "x" then
        return UDim2.fromOffset(uDimRect.position.X.Offset + uDimRect.size.X.Offset, 0)
    elseif str1 == "y" then
        return UDim2.fromOffset(0, uDimRect.position.Y.Offset + uDimRect.size.Y.Offset)
    end

    return (exhaustiveMatch(str1))
end

local function getUDimSizeForConsistentSize(size: number, str1: string) -- Luacid: Inlined by compiler; 4 call sites recovered
    if str1 == "x" then
        return UDim2.new(0, size, 1, 0)
    elseif str1 == "y" then
        return UDim2.new(1, 0, 0, size)
    end
    return exhaustiveMatch(str1)
end

local function getPositionForConsistentSize(num1: number, num2: number, str1: string) -- Luacid: Inlined by compiler; 4 call sites recovered
    if str1 == "x" then
        return UDim2.fromOffset(num1 * (num2 - 1), 0)
    elseif str1 == "y" then
        return UDim2.fromOffset(0, num1 * (num2 - 1))
    end
    return exhaustiveMatch(str1)
end

local function getPositionForConsistentUDim2(uDim2: UDim2, num1: number, vector2: Vector2, str1: string)
    local amountPerNonDominantInGrid = module.getAmountPerNonDominantInGrid(uDim2, vector2, str1)

    if str1 == "x" then
        return UDim2.new(
            0,
            (math.ceil(num1 / amountPerNonDominantInGrid) - 1) * uDim2.X.Offset,
            uDim2.Y.Scale * ((num1 - 1) % amountPerNonDominantInGrid),
            uDim2.Y.Offset * ((num1 - 1) % amountPerNonDominantInGrid)
        )
    end

    if str1 ~= "y" then
        return exhaustiveMatch(str1)
    end

    return UDim2.new(
        uDim2.X.Scale * ((num1 - 1) % amountPerNonDominantInGrid),
        uDim2.X.Offset * ((num1 - 1) % amountPerNonDominantInGrid),
        0,
        (math.ceil(num1 / amountPerNonDominantInGrid) - 1) * uDim2.Y.Offset
    )
end

function module.getAmountPerNonDominantInGrid(uDim2: UDim2, vector2: Vector2, str1: string)
    if str1 == "x" then
        return vector2.Y // (uDim2.Y.Offset + uDim2.Y.Scale * vector2.Y)
    elseif str1 == "y" then
        return vector2.X // (uDim2.X.Offset + uDim2.X.Scale * vector2.X)
    end
    return exhaustiveMatch(str1)
end

function module.getDominantAxis(vector2: Vector2, str1: string)
    if str1 == "x" then
        return vector2.X
    elseif str1 == "y" then
        return vector2.Y
    end
    return exhaustiveMatch(str1)
end

function module.getUDimRect(arg1, arg2, num1: number, vector2: Vector2, str1: string)
    if arg1.type == "consistentSize" then
        local tbl1 = { size = 0, position = 0 }
        local size = arg1.size
        tbl1.size = if str1 == "x" then getUDimSizeForConsistentSize(size, "x") elseif str1 == "y" then getUDimSizeForConsistentSize(size, "y") else exhaustiveMatch(str1)
        local size2 = arg1.size
        tbl1.position = if str1 == "x" then getPositionForConsistentSize(size2, num1, "x") elseif str1 == "y" then getPositionForConsistentSize(size2, num1, "y") else exhaustiveMatch(str1)
        return tbl1
    elseif arg1.type == "consistentUDim2" then
        return {
            size = arg1.udim2,
            position = getPositionForConsistentUDim2(arg1.udim2, num1, vector2, str1)
        }
    elseif arg1.type == "getter" then
        return arg1.callback(arg2, num1)
    end

    if arg1.type ~= "spaced" then
        return exhaustiveMatch(arg1.type)
    end

    if arg1.inner.type == "consistentSize" then
        local tbl1 = { size = 0, position = 0 }
        local size = arg1.inner.size
        tbl1.size = if str1 == "x" then getUDimSizeForConsistentSize(size, "x") elseif str1 == "y" then getUDimSizeForConsistentSize(size, "y") else exhaustiveMatch(str1)
        local var1 = arg1.inner.size + arg1.spacing
        tbl1.position = if str1 == "x" then getPositionForConsistentSize(var1, num1, "x") elseif str1 == "y" then getPositionForConsistentSize(var1, num1, "y") else exhaustiveMatch(str1)
        return tbl1
    elseif arg1.inner.type == "consistentUDim2" then
        return {
            size = arg1.inner.udim2,
            position = getPositionForConsistentUDim2(
                arg1.inner.udim2 + UDim2.fromOffset(if str1 ~= "x" then 0 else arg1.spacing, if str1 ~= "y" then 0 else arg1.spacing),
                num1,
                vector2,
                str1
            )
        }
    end

    if arg1.inner.type ~= "getter" and arg1.inner.type ~= "spaced" then
        return exhaustiveMatch(arg1.inner.type)
    end

    error("Unsupported spaced dimensions")
end

local function getElementsDisplayedForUDim2(uDim2: UDim2, vector2: Vector2, str1: string)
    local amountPerNonDominantInGrid = module.getAmountPerNonDominantInGrid(uDim2, vector2, str1)
    if str1 == "x" then
        return amountPerNonDominantInGrid * (vector2.X // uDim2.Y.Offset + 2)
    elseif str1 == "y" then
        return amountPerNonDominantInGrid * (vector2.Y // uDim2.X.Offset + 2)
    end
    return exhaustiveMatch(str1)
end

function module.elementsDisplayedHint(arg1, vector2: Vector2, str1: string)
    if arg1.type == "consistentSize" then
        return module.getDominantAxis(vector2, str1) // arg1.size + 2
    elseif arg1.type == "consistentUDim2" then
        return getElementsDisplayedForUDim2(arg1.udim2, vector2, str1)
    elseif arg1.type == "getter" then
        return nil
    end

    if arg1.type ~= "spaced" then
        return exhaustiveMatch(arg1.type)
    end

    if arg1.inner.type == "consistentSize" then
        return module.getDominantAxis(vector2, str1) // (arg1.inner.size + arg1.spacing) + 2
    elseif arg1.inner.type == "consistentUDim2" then
        return getElementsDisplayedForUDim2(
            arg1.inner.udim2 + UDim2.fromOffset(if str1 ~= "x" then 0 else arg1.spacing, if str1 ~= "y" then 0 else arg1.spacing),
            vector2,
            str1
        )
    end

    if arg1.inner.type ~= "spaced" and arg1.inner.type ~= "getter" then
        return exhaustiveMatch(arg1.inner.type)
    end

    error("Unsupported spaced dimensions")
end

function module.equals(arg1, arg2)
    if arg1.type ~= arg2.type then
        return false
    end

    if arg1.type == "getter" then
        assert(arg2.type == "getter", "Luau")
        return arg1.callback == arg2.callback
    elseif arg1.type == "consistentSize" then
        assert(arg2.type == "consistentSize", "Luau")
        return arg1.size == arg2.size
    elseif arg1.type == "consistentUDim2" then
        assert(arg2.type == "consistentUDim2", "Luau")
        return arg1.udim2 == arg2.udim2
    end

    if arg1.type ~= "spaced" then
        return exhaustiveMatch(arg1.type)
    end

    assert(arg2.type == "spaced", "Luau")
    return arg1.spacing == arg2.spacing
end

return module
