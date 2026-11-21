-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameInfosRoduxParent = script:FindFirstAncestor("GameInfosRodux").Parent

local makeActionCreator = require(GameInfosRoduxParent.Rodux).makeActionCreator
local _DiscoveryTypes = require(GameInfosRoduxParent.DiscoveryTypes)

return makeActionCreator(script.Name, function(games)
    assert(type(games) == "table", string.format("AddGames action expects games to be a table, was %s", type(games)))

    return { games = games }
end)
