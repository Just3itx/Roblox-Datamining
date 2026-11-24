-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:20:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function normalizeValue(arg1)
    if typeof(arg1) == "EnumItem" then
        return arg1.Name
    end

    if typeof(arg1) ~= "table" then
        return arg1
    end

    local result = ({})
    for value, value2 in arg1 do
        result[value] = normalizeValue(value2)
    end
    return result
end

return normalizeValue
