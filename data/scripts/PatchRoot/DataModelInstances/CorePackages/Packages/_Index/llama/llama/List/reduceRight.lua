-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:51:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function reduceRight(arg1, arg2, arg3)
    local str1 = type(arg1)
    assert(str1 == "table", "expected a table for first argument, got " .. str1)

    local str2 = type(arg2)
    assert(str2 == "function", "expected a function for second argument, got " .. str2)

    local num1 = #arg1
    local var1 = if arg3 == nil then arg1[num1] else arg3

    if arg3 == nil then
        num1 = num1 - 1 or num1
    end
    for i = num1, 1, -1 do
        var1 = arg2(var1, arg1[i], i)
    end

    return var1
end

return reduceRight
