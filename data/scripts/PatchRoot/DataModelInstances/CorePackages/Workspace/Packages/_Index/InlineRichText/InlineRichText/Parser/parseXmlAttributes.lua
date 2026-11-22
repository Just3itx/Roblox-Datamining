-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function parseXmlAttributes(str1: string)
    local var1 = str1:gmatch("%s*([A-Za-z0-9_-]+)=\"([^\"]*)\"%s*")
    local var2 = str1:gmatch("%s*([A-Za-z0-9_-]+)='([^']*)'%s*")

    local result = ({})
    for value, value2 in var1 do
        result[value] = value2 or ""
    end
    for value, value2 in var2 do
        result[value] = value2 or ""
    end
    return result
end

return parseXmlAttributes
