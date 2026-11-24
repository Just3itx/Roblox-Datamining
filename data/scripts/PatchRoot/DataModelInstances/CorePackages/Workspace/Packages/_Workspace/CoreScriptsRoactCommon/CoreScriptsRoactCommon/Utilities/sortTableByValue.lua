-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:31:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function defaultCompareFn(arg1, arg2): boolean
    return arg1.value < arg2.value
end

local function sortTableByValue(tbl1, func1: ((...any) -> (...any))?)
    local result = {}
    local var1 = func1 or defaultCompareFn

    for key, value in tbl1 do
        table.insert(result, { key = key, value = value })
    end

    table.sort(result, var1)

    return result
end

return sortTableByValue
