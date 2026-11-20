-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:51:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function map(arg1, arg2)
    local str1 = type(arg1)
    assert(str1 == "table", "expected a table for first argument, got " .. str1)

    local str2 = type(arg2)
    assert(str2 == "function", "expected a function for second argument, got " .. str2)

    local result = ({})
    local num1 = 1

    for i = 1, #arg1 do
        local var1 = arg2(arg1[i], i)

        if var1 ~= nil then
            result[num1] = var1
            num1 += 1
        end
    end

    return result
end

return map
