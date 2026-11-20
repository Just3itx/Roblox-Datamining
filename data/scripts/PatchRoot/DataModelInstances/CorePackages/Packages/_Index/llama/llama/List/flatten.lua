-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function flatten(arg1)
    local str1 = type(arg1)
    assert(str1 == "table", "expected a table for first argument, got " .. str1)

    local result = ({})
    local num1 = 1

    for i = 1, #arg1 do
        if type(arg1[i]) == "table" then
            local var1 = flatten(arg1[i])

            for j = 1, #var1 do
                result[num1] = var1[j]
                num1 += 1
            end
        else
            result[num1] = arg1[i]
            num1 += 1
        end
    end

    return result
end

return flatten
