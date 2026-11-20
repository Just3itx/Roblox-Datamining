-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:50:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local toSet = require(script.Parent.Parent.List.toSet)

local function removeValues(arg1, ...)
    local str1 = type(arg1)
    assert(str1 == "table", "expected a table for first argument, got " .. str1)

    local var1 = toSet({ ... })
    local result = ({})

    for k, value in pairs(arg1) do
        if not var1[value] then
            result[k] = value
        end
    end

    return result
end

return removeValues
