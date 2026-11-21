-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:40:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent
local _AvatarExperienceCommon = require(AvatarExperienceCatalogParent.AvatarExperienceCommon)
local Url = require(AvatarExperienceCatalogParent.Http).Url
local _LuauPolyfill = require(AvatarExperienceCatalogParent.LuauPolyfill)

local makeAXResponseHandler = require(AvatarExperienceCatalog.Utils.makeAXResponseHandler)
local normalizeCatalogCategories = require(script.Parent.normalizeCatalogCategories)
local constants = require(script.Parent.constants)

return {
    getCatalogCategories = function(func1: (...any) -> (...any), versionId: number)
        local var1 = Url:makeQueryString({ versionId = versionId })

        local var2, var3 = func1(`{Url.APIS_URL}marketplace-widgets/v1/pills?{var1}`, "GET")

        return makeAXResponseHandler(var2, normalizeCatalogCategories, {
            modelMismatchCounter = constants.FETCH_CATALOG_CATEGORIES_MODEL_MISMATCH_COUNTER_NAME,
            latencyCounter = constants.FETCH_CATALOG_CATEGORIES_LATENCY_COUNTER_NAME
        }), var3
    end
}
