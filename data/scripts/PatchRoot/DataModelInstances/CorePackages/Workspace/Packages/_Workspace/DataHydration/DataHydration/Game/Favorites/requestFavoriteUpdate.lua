-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:11:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local HttpRequest = require(DataHydrationParent.HttpRequest)
local HttpService = game:GetService("HttpService")
local FavoritesUrlBuilder = require(script.Parent.FavoritesUrlBuilder)

local function requestUpdateFavorite(str1: string, isFavorited: boolean)
    local favoriteUpdateUrl = FavoritesUrlBuilder.buildFavoriteUpdateUrl(str1)

    local postBody = HttpService:JSONEncode({ isFavorited = isFavorited })

    return HttpRequest.config({
        requestFunction = function(str3: string, str4: string, arg1)
            return HttpRequest.requestFunctions.HttpRbxApi(str3, str4, arg1)
        end
    })(favoriteUpdateUrl, "POST", { postBody = postBody })
end

return requestUpdateFavorite
