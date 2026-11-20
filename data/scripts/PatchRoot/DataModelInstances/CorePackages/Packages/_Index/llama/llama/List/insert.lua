-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:51:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function insert(arg1, arg2, ...)
    local str1 = type(arg1)
    assert(str1 == "table", "expected a table for first argument, got " .. str1)

    local num1 = #arg1
    assert(arg2 >= 1 and arg2 <= num1 + 1, "index must be in bounds of list")

    local result = ({})
    local num2 = 1

    for i = 1, num1 do
        if i == arg2 then
            local select2 = select

            for j = 1, select2("#", ...) do
                local select = select
                result[num2] = select(j, ...)
                num2 += 1
            end
        end

        result[num2] = arg1[i]
        num2 += 1
    end

    return result
end

return insert
