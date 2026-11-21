-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T21:21:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameProductInfoRodux = script:FindFirstAncestor("GameProductInfoRodux")
local GameProductInfoRoduxParent = GameProductInfoRodux.Parent
local Immutable = require(GameProductInfoRoduxParent.AppCommonLib).Immutable
local SetGamesProductInfo = require(GameProductInfoRodux.SetGamesProductInfo)
local _GameProductInfo = require(GameProductInfoRodux.GameProductInfo)

return {
    key = "GamesProductInfoKey",
    reducer = function(tbl1, arg1)
        tbl1 = tbl1 or {}
        assert(tbl1, "")

        if arg1.type == SetGamesProductInfo.name then
            tbl1 = Immutable.JoinDictionaries(tbl1, arg1.gamesProductInfo)
        end

        return tbl1
    end
}
