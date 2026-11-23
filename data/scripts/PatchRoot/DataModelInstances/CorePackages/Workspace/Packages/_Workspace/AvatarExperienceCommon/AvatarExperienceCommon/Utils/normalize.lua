-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T14:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function normalizeType(arg1, arg2)
    if type(arg1) == arg2 then
        return arg1
    end
    return nil, `Type {arg2} required, got {type(arg1)}.`
end

local function prepareValuesForError(tbl1): string
    local tbl2 = {}
    for _, value in tbl1 do
        table.insert(tbl2, tostring(value))
    end
    return table.concat(tbl2, ", ")
end

local function normalizeValue(arg1, tbl1)
    if table.find(tbl1, arg1) then
        return arg1
    end
    return nil, `Expected value to be one of {prepareValuesForError(tbl1)}, got {arg1}.`
end

local function normalizeString(arg1)
    return normalizeType(arg1, "string")
end

local function normalizeTable(arg1, tbl1)
    local tbl2 = {}
    if type(arg1) ~= "table" then
        return nil, `Type table required, got {type(arg1)}.`
    end

    local tbl3 = ({})
    for value, value2 in tbl1 do
        local required = type(value2) == "table" and value2.required

        if type(value2) == "table" then
            value2 = value2.fn
        end

        local var1 = arg1[value]

        if type(var1) == "nil" and not required then
            continue
        end

        local var2, var3 = value2(var1)

        if var3 then
            table.insert(tbl2, `{value} normalization failed with: {var3}`)
        end

        if var3 and required then
            return nil, table.concat(tbl2, " ")
        end

        tbl3[value] = var2
    end

    return tbl3, if next(tbl2) then table.concat(tbl2, " ") else nil
end

local function normalizeList(arg1, func1: (...any) -> (...any))
    if type(arg1) ~= "table" then
        return nil, `Type table required, got {type(arg1)}.`
    end

    local tbl1 = {}
    local tbl2 = {}
    for value, value2 in arg1 do
        local var1, var2 = func1(value2)
        if var2 then
            table.insert(tbl1, `{value} normalization failed with: {var2}`)
        end
        if var1 then
            table.insert(tbl2, var1)
        end
    end

    return tbl2, if next(tbl1) then table.concat(tbl1, " ") else nil
end

local function normalizeUnion(arg1, tbl1)
    for _, value in tbl1 do
        local var1, _ = value(arg1)
        if var1 then
            return var1
        end
    end
    return nil, "Value did not match any union."
end

return {
    normalizeType = normalizeType,
    normalizeValue = normalizeValue,
    normalizeBoolean = function(arg1)
        return normalizeType(arg1, "boolean")
    end,
    normalizeString = normalizeString,
    normalizeNumber = function(arg1)
        return normalizeType(arg1, "number")
    end,
    normalizeTable = normalizeTable,
    normalizeList = normalizeList,
    normalizeUnion = normalizeUnion,
    normalizeStringToBoolean = function(str1: string?)
        if str1 then
            return str1 == "true"
        end
        return nil, "value is nil"
    end,
    makeNormalizeTableFn = function(tbl1)
        return function(arg1)
            return normalizeTable(arg1, tbl1)
        end
    end,
    makeNormalizeListFn = function(func1: (...any) -> (...any))
        return function(arg1)
            return normalizeList(arg1, func1)
        end
    end,
    makeNormalizeUnionFn = function(tbl1)
        return function(arg1)
            return normalizeUnion(arg1, tbl1)
        end
    end,
    makeNormalizeValueFn = function(arg1)
        return function(arg2)
            return normalizeValue(arg2, arg1)
        end
    end,
    makeRequired = function(fn: (...any) -> (...any))
        return { fn = fn, required = true }
    end,
    normalizeNotEmptyString = function(arg1)
        if arg1 == nil or arg1 == "" then
            return nil, nil
        end
        return normalizeString(arg1)
    end
}
