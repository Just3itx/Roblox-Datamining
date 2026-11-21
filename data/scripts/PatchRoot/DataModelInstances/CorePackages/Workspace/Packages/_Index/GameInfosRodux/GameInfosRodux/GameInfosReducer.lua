-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:11:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameInfosRoduxParent = script:FindFirstAncestor("GameInfosRodux").Parent

local AddGames = require(script.Parent.AddGames)
local Cryo = require(GameInfosRoduxParent.Cryo)
local _DiscoveryTypes = require(GameInfosRoduxParent.DiscoveryTypes)

local function getMergedState(tbl1, games)
    local tbl2 = ({})
    for k, _ in pairs(games) do
        if tbl1[k] then
            tbl2[k] = Cryo.Dictionary.join(tbl1[k], games[k])
        else
            tbl2[k] = games[k]
        end
    end

    return (Cryo.Dictionary.join(tbl1, tbl2))
end

return {
    key = "GameInfosKey",
    reducer = function(tbl1, arg1)
        tbl1 = tbl1 or {}
        assert(tbl1, "")

        if arg1.type == AddGames.name then
            tbl1 = getMergedState(tbl1, arg1.games)
        end

        return tbl1
    end
}
