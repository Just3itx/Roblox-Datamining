-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getAppContext(): string
    return if game.GameId == 0 then "UA" else "IN_EXPERIENCE"
end

return getAppContext
