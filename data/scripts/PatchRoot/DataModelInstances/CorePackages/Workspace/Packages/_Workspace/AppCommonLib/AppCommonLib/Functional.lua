-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:40:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.Filter(arg1, arg2)
    local result = {}

    for i = 1, #arg1 do
        local var1 = arg1[i]
        if arg2(var1, i) then
            table.insert(result, var1)
        end
    end

    return result
end

function module.Map(arg1, arg2)
    local result = ({})

    for i = 1, #arg1 do
        result[i] = arg2(arg1[i], i)
    end

    return result
end

function module.MapReverse(arg1, arg2)
    local result = ({})

    for i = #arg1, 1, -1 do
        result[i] = arg2(arg1[i], i)
    end

    return result
end

function module.FilterMap(arg1, arg2)
    local result = {}

    for i = 1, #arg1 do
        local var1 = arg2(arg1[i], i)

        if var1 ~= nil then
            table.insert(result, var1)
        end
    end

    return result
end

function module.Fold(arg1, arg2, arg3)
    for i = 1, #arg1 do
        arg2 = arg3(arg2, arg1[i], i)
    end

    return arg2
end

function module.FoldDictionary(arg1, arg2, arg3)
    for k, value in pairs(arg1) do
        arg2 = arg3(arg2, k, value)
    end

    return arg2
end

function module.Take<T>(tbl1: {T}, arg1, arg2): {T}
    arg2 = arg2 or 1

    local var1 = arg1 + (arg2 - 1)

    local result = {}

    for i = arg2, #tbl1 < var1 and #tbl1 or var1 do
        local var2 = tbl1[i]
        result[i - (arg2 - 1)] = var2
    end

    return result
end

function module.Find(arg1, arg2)
    for i, value in ipairs(arg1) do
        if value == arg2 then
            return i
        end
    end

    return nil
end

return module
