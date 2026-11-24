-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:21:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Http = require(DataHydrationParent.Http)
local HttpRequest = require(DataHydrationParent.HttpRequest)
local HttpService = game:GetService("HttpService")
local UrlBuilder = require(DataHydrationParent.UrlBuilder).UrlBuilder

local Url = Http.Url

local function requestUserVoteUpdate(universeId: string, bool1: boolean?)
    local var1 = UrlBuilder.new({ base = Url.GAME_URL, path = "v1/games/{universeId}/user-votes" })({ universeId = universeId })

    return HttpRequest.config({
        requestFunction = function(str1: string, str2: string, arg1)
            return HttpRequest.requestFunctions.RequestInternal(str1, str2, arg1)
        end
    })(var1, "PATCH", {
        postBody = HttpService:JSONEncode({ vote = if bool1 == nil then "null" else bool1 })
    })
end
return requestUserVoteUpdate
