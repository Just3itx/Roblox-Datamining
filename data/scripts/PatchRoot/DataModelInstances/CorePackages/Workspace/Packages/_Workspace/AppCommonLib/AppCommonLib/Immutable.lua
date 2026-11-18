-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T23:05:51Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local bool1 = game:DefineFastFlag("ImmutableJoinDictionariesUseTableClone", false)

local module = {}

function module.JoinDictionaries(...)
    local select2 = select
    local var1 = select2("#", ...)

    if bool1 and var1 > 0 then
        local var2 = table.clone(select(1, ...))
        for i = 2, var1 do
            local select = select

            for value, value2 in (select(i, ...)) do
                var2[value] = value2
            end
        end
        return var2
    end

    local result = ({})

    for i = 1, var1 do
        local select = select
        local var2 = select(i, ...)

        for k, value in pairs(var2) do
            result[k] = value
        end
    end

    return result
end

function module.JoinLists(...)
    local result = {}

    local select2 = select

    for i = 1, select2("#", ...) do
        local select = select
        local var1 = select(i, ...)
        local resultLen = #result

        for j = 1, #var1 do
            result[resultLen + j] = var1[j]
        end
    end

    return result
end

function module.Set(arg1, arg2, arg3)
    local var1 = table.clone(arg1)
    var1[arg2] = arg3
    return var1
end

function module.Append<T>(tbl1: {T}, ...): {T}
    local result = ({})
    local num1 = #tbl1

    for i = 1, num1 do
        result[i] = tbl1[i]
    end

    local select2 = select

    for i = 1, select2("#", ...) do
        local num2 = num1 + i
        local select = select
        result[num2] = select(i, ...)
    end

    return result
end

function module.RemoveFromDictionary(arg1, ...)
    local result = ({})

    for k, value in pairs(arg1) do
        local bool2 = false
        local select2 = select

        for i = 1, select2("#", ...) do
            local select = select

            if k == select(i, ...) then
                bool2 = true
                break
            end
        end

        if not bool2 then
            result[k] = value
        end
    end

    return result
end

function module.RemoveFromList(arg1, arg2)
    local result = {}

    for i = 1, #arg1 do
        if i ~= arg2 then
            table.insert(result, arg1[i])
        end
    end

    return result
end

function module.RemoveRangeFromList(arg1, arg2, arg3)
    local result = {}

    for i = 1, #arg1 do
        if i < arg2 or arg2 + arg3 <= i then
            table.insert(result, arg1[i])
        end
    end

    return result
end

function module.RemoveValueFromList(arg1, arg2)
    local result = {}

    for i = 1, #arg1 do
        if arg1[i] ~= arg2 then
            table.insert(result, arg1[i])
        end
    end

    return result
end

return module
