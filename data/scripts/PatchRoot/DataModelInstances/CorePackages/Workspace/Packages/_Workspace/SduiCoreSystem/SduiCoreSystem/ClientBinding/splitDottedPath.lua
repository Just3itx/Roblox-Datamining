-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:51:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = ({})

local function splitDottedPath(str1: string)
    local var1 = tbl1[str1]
    if var1 ~= nil then
        return var1
    end
    local tbl2 = string.split(str1, ".")
    table.freeze(tbl2)
    tbl1[str1] = tbl2
    return tbl2
end

return splitDottedPath
