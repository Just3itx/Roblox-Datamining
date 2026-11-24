-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Http = require(DataHydrationParent.Http)
local UrlBuilder = require(DataHydrationParent.UrlBuilder).UrlBuilder

local Url = Http.Url

return {
    buildFavoriteUrl = function(universeId: string)
        return UrlBuilder.new({ base = Url.GAME_URL, path = "v1/games/{universeId}/favorites" })({ universeId = universeId })
    end,
    buildFavoriteUpdateUrl = function(universeId: string)
        return UrlBuilder.new({ base = Url.GAME_URL, path = "v1/games/{universeId}/favorites" })({ universeId = universeId })
    end,
    FAVORITE_URL = UrlBuilder.new({ base = Url.GAME_URL, path = "v1/games/favorites" }),
    FAVORITE_UPDATE_URL = UrlBuilder.new({ base = Url.GAME_URL, path = "v1/games/favorites/update" })
}
