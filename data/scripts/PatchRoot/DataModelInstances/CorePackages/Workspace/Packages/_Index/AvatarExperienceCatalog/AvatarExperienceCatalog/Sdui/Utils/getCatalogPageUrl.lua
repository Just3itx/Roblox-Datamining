-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:11:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent

local UrlBuilder = require(AvatarExperienceCatalogParent.UrlBuilder).UrlBuilder
local Url = require(AvatarExperienceCatalogParent.Http).Url
local Constants = require(AvatarExperienceCatalog.Sdui.Constants)

local urlBuilder = UrlBuilder.new({ base = Url.APIS_URL, path = Constants.CatalogSduiUrl })

local function getCatalogPageUrl()
    return urlBuilder()
end
return getCatalogPageUrl
