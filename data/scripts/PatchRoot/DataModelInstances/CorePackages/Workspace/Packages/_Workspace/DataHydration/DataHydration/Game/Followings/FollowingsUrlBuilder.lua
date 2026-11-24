-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:11:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Http = require(DataHydrationParent.Http)
local UrlBuilder = require(DataHydrationParent.UrlBuilder).UrlBuilder

local Url = Http.Url

local urlBuilder = UrlBuilder.new({ base = Url.FOLLOWINGS_URL, path = "v1/users/universes/status" })

return {
    buildFollowingStatusUrl = function(userId: string, universeId: string)
        return UrlBuilder.new({ base = Url.FOLLOWINGS_URL, path = "v1/users/{userId}/universes/{universeId}/status" })(
            { userId = userId, universeId = universeId }
        )
    end,
    buildFollowingUpdateUrl = function(userId: string, universeId: string)
        return UrlBuilder.new({ base = Url.FOLLOWINGS_URL, path = "v1/users/{userId}/universes/{universeId}" })(
            { userId = userId, universeId = universeId }
        )
    end,
    FOLLOWING_UPDATE_URL = UrlBuilder.new({ base = Url.FOLLOWINGS_URL, path = "v1/users/universes/" }),
    FOLLOWING_STATUS_URL = urlBuilder
}
