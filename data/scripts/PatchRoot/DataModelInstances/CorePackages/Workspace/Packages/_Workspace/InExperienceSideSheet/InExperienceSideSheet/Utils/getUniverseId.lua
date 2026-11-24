-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getUniverseId()
    if not (game.GameId > 0) then
        return nil
    end

    return tostring(game.GameId)
end

return getUniverseId
