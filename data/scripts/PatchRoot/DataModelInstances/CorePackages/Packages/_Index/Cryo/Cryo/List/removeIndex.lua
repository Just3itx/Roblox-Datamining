-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T04:40:45Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function removeIndex(arg1, arg2)
    local result = {}
    local num1 = 0

    for i = 1, #arg1 do
        if i == arg2 then
            num1 = 1
        else
            result[i - num1] = arg1[i]
        end
    end

    return result
end

return removeIndex
