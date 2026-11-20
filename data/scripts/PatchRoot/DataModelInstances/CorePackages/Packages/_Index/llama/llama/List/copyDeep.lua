-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function copyDeep(arg1)
    local str1 = type(arg1)
    assert(str1 == "table", "expected a table for first argument, got " .. str1)

    local result = ({})

    for i = 1, #arg1 do
        if type(arg1[i]) == "table" then
            result[i] = copyDeep(arg1[i])
        else
            result[i] = arg1[i]
        end
    end

    return result
end

return copyDeep
