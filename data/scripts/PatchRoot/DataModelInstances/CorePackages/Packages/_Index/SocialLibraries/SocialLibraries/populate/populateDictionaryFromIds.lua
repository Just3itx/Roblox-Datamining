-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:00:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function populateDictionaryFromIds(arg1, arg2)
    local result = ({})

    for k, value in pairs(arg1) do
        if type(value) == "table" then
            result[k] = populateDictionaryFromIds(value, arg2)
        else
            result[k] = arg2[value]
        end
    end

    return result
end

return populateDictionaryFromIds
