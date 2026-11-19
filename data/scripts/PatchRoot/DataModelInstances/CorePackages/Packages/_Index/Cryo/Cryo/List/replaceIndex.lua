-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T04:40:51Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function replaceIndex(arg1, arg2, arg3)
    local result = ({})
    local num1 = #arg1

    assert(arg2 <= num1, "index must be less or equal than the list length")

    for i = 1, num1 do
        if i == arg2 then
            result[i] = arg3
        else
            result[i] = arg1[i]
        end
    end

    return result
end

return replaceIndex
