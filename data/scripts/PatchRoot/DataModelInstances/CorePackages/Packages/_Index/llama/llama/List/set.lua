-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:51:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function set(arg1, arg2, arg3)
    local str1 = type(arg1)
    assert(str1 == "table", "expected a table for first argument, got " .. str1)

    local num1 = #arg1

    assert(arg2 <= num1, "index must be less than or equal to the list length")
    assert(arg2 >= 1, "index must be greater than or equal to 1")

    local result = ({})
    local num2 = 1

    for i = 1, num1 do
        if i == arg2 then
            result[num2] = arg3
        else
            result[num2] = arg1[i]
        end

        num2 += 1
    end

    return result
end

return set
