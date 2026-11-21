-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:11:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getPageSideMargin(arg1): number
    return if arg1 > 600 then 48 elseif arg1 > 320 then 24 else 12
end

return getPageSideMargin
