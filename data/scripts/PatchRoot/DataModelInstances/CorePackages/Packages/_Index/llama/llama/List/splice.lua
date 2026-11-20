-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:00:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function splice(arg1, arg2, arg3, ...)
    local str1 = type(arg1)
    assert(str1 == "table", "expected a table for first argument, got " .. str1)

    local str2 = type(arg2)
    assert(str2 == "number" and arg2 % 1 == 0, "expected an integer for second argument, got " .. str2)

    local str3 = type(arg3)
    assert(str3 == "number" and arg3 % 1 == 0, "expected an integer for third argument, got " .. str3)

    assert(arg2 <= arg3, "start index must be less than or equal to end index")

    local result = ({})
    local num1 = 1
    local num2 = #arg1

    arg2 = math.max(arg2, 1)
    math.min(arg2, num2)

    for i = 1, num2 do
        if i == arg2 then
            local select2 = select

            for j = 1, select2("#", ...) do
                local select = select
                result[num1] = select(j, ...)
                num1 += 1
            end
        else
            result[num1] = arg1[i]
            num1 += 1
        end
    end

    return result
end

return splice
