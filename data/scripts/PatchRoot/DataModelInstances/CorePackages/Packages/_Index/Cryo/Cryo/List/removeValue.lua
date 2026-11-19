-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:41:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function removeValue(arg1, arg2)
    local result = ({})
    local num1 = 1

    for i = 1, #arg1 do
        if arg1[i] ~= arg2 then
            result[num1] = arg1[i]
            num1 += 1
        end
    end

    return result
end

return removeValue
