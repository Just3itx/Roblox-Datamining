-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:11:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Http = require(DataHydrationParent.Http)
local UrlBuilder = require(DataHydrationParent.UrlBuilder).UrlBuilder

local Url = Http.Url

return {
    buildJoinCommunityUrl = function(communityId: string)
        return UrlBuilder.new({ base = Url.GROUPS_URL, path = "v1/groups/{communityId}/users" })({ communityId = communityId })
    end
}
