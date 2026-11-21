-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AssetFavorites = script:FindFirstAncestor("AssetFavorites")
local HttpService = game:GetService("HttpService")
local AssetFavoritesParent = AssetFavorites.Parent
local Url = require(AssetFavoritesParent.Http).Url

return function(arg1, str1: string, str2: string)
    return arg1(
        string.format("%s/v1/favorites/users/%s/assets/%s/favorite", Url.CATALOG_URL, str1, str2),
        "POST",
        {
            postBody = HttpService:JSONEncode({})
        }
    )
end
