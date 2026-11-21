-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:31:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTileParent = script:FindFirstAncestor("GameTile").Parent
local Signals = require(GameTileParent.Signals)

local function createGameTileHiddenStore()
    local getHiddenGames, var2 = Signals.createSignal({})

    return {
        setGameHidden = function(str1: string, bool1: boolean)
            local var3 = table.clone(getHiddenGames(false))
            var3[str1] = bool1
            var2(var3)
        end,
        getHiddenGames = getHiddenGames
    }
end

return createGameTileHiddenStore
