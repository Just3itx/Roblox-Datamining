-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:20:34Z
-- Luau bytecode version: 14 | Luau type version: 3
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Http = require(DataHydrationParent.Http)
local UrlBuilder = require(DataHydrationParent.UrlBuilder).UrlBuilder

local Url = Http.Url

return {
    buildStatusesUrl = UrlBuilder.new({
        base = Url.APIS_URL,
        path = "game-transactions/v1/receipts",
        query = "playerId={playerId}&placeId={placeId}&status=pending&locationType=ExperienceDetailPage"
    })
}
