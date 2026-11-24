-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:20:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Http = require(DataHydrationParent.Http)
local HttpRequest = require(DataHydrationParent.HttpRequest)
local UrlBuilder = require(DataHydrationParent.UrlBuilder).UrlBuilder

local Url = Http.Url

local function fetchGameMedia(universeId: string)
    local var1 = UrlBuilder.new({ base = Url.GAME_URL, path = "v2/games/{universeId}/media" })({ universeId = universeId })

    return HttpRequest.config({
        requestFunction = function(str1: string, str2: string, arg1)
            return HttpRequest.requestFunctions.HttpRbxApi(str1, str2, arg1)
        end
    })(var1, "GET")
end

return fetchGameMedia
