-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:40:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local HttpService = game:GetService("HttpService")

local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent
local Url = require(AvatarExperienceCatalogParent.Http).Url
local _LuauPolyfill = require(AvatarExperienceCatalogParent.LuauPolyfill)

local function createMakeupLook(func1: (...any) -> (...any), input)
    local var1, var2 = func1(`{Url.AVATAR_URL}v3/outfits/create`, "POST", { postBody = HttpService:JSONEncode(input) })

    return var1, var2
end

return createMakeupLook
