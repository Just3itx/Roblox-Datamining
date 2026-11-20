-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:01:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxGamesParent = script:FindFirstAncestor("RoduxGames").Parent
local Rodux = require(RoduxGamesParent.Rodux)

local playabilityByGameId = require(script.Games.playabilityByGameId)
local productInfoByGameId = require(script.Games.productInfoByGameId)
local byGameId = require(script.Games.byGameId)
local mediaByGameId = require(script.Games.mediaByGameId)

return function(arg1)
    return Rodux.combineReducers({
        playabilityByGameId = playabilityByGameId(arg1),
        productInfoByGameId = productInfoByGameId(arg1),
        byGameId = byGameId(arg1),
        mediaByGameId = mediaByGameId(arg1)
    })
end
