-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:00:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function populateListFromIds(arg1, arg2)
    local result = {}

    for _, value in ipairs(arg1) do
        if type(value) == "table" then
            table.insert(result, populateListFromIds(value, arg2))
        else
            table.insert(result, arg2[value])
        end
    end

    return result
end

return populateListFromIds
