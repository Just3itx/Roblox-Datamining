-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local toSet = require(script.Parent.toSet)

local function removeIndex(arg1, ...)
    local str1 = type(arg1)
    assert(str1 == "table", "expected a table for first argument, got " .. str1)

    local result = ({})
    local var1 = toSet({ ... })
    local num1 = 1

    for i = 1, #arg1 do
        if not var1[i] then
            result[num1] = arg1[i]
            num1 += 1
        end
    end

    return result
end

return removeIndex
