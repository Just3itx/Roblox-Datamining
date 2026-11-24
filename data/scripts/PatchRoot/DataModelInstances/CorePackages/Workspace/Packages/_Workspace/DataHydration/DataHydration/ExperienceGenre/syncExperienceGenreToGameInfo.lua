-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local getGameInfoStore = require(DataHydration.Game.GameInfo.getGameInfoStore)

local FFlagLuaAppDataHydrationUpdateItem = require(DataHydrationParent.SharedFlags).FFlagLuaAppDataHydrationUpdateItem

return {
    syncExperienceGenreToGameInfo = function(num1: number, genreL1: string?, genreL2: string?)
        if FFlagLuaAppDataHydrationUpdateItem and (genreL1 or genreL2) then
            getGameInfoStore(false).updateGameInfo(tostring(num1), { genreL1 = genreL1, genreL2 = genreL2 })
        end
    end
}
