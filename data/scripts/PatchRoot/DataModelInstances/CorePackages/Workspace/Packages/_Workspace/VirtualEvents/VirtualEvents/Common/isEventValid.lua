-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function isEventValid(tbl1): boolean
    return not (tbl1.title == nil) and not (tbl1.imageUrl == nil) and tbl1.pagePath ~= nil
end

return isEventValid
