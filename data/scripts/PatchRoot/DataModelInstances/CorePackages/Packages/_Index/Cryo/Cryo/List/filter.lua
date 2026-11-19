-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function filter(arg1, arg2)
    local result = ({})
    local num1 = 1

    for i = 1, #arg1 do
        local var1 = arg1[i]
        if arg2(var1, i) then
            result[num1] = var1
            num1 += 1
        end
    end

    return result
end

return filter
