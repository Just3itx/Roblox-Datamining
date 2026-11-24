-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Http = require(DataHydrationParent.Http)
local UrlBuilder = require(DataHydrationParent.UrlBuilder).UrlBuilder

local Url = Http.Url

return {
    buildGamePassesUrl = UrlBuilder.new(
        {
            base = Url.APIS_URL,
            path = "game-passes/v1/universes/{universeId}/game-passes",
            query = "pageSize=50&passView=Full"
        }
    )
}
