-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:10:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Http = require(DataHydrationParent.Http)
local UrlBuilder = require(DataHydrationParent.UrlBuilder).UrlBuilder
local Url = Http.Url

return {
    buildBadgeRemoveUrl = function(assetId: string)
        return UrlBuilder.new({ base = Url.BADGES_URL, path = "v1/user/badges/{assetId}" })({ assetId = assetId })
    end,
    BADGE_REMOVE_URL = UrlBuilder.new({ base = Url.BADGES_URL, path = "v1/user/badges/" })()
}
