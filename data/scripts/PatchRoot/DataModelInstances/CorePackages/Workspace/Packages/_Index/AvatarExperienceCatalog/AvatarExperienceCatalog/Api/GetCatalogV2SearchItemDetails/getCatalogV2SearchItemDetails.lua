-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent
local Url = require(AvatarExperienceCatalogParent.Http).Url
local _LuauPolyfill = require(AvatarExperienceCatalogParent.LuauPolyfill)

local _CatalogV2SearchItemDetails = require(AvatarExperienceCatalog.Models.CatalogV2SearchItemDetails)
local makeAXResponseHandler = require(AvatarExperienceCatalog.Utils.makeAXResponseHandler)
local normalizeCatalogV2SearchItemDetails = require(script.Parent.normalizeCatalogV2SearchItemDetails)
local constants = require(script.Parent.constants)

local tbl1 = { assetTypeIds = true, bundleTypeIds = true }

if require(AvatarExperienceCatalogParent.AvatarExperienceFlags).FFlagAXCatalogSpecialFeaturesFilter then
    tbl1.requiredPropertyFilters = true
end

local function buildQueryStringWithArrayParams(arg1): string
    local tbl2 = {}

    for value, value2 in arg1 do
        if tbl1[value] and type(value2) == "table" then
            for _, value3 in value2 do
                table.insert(tbl2, `{value}={HttpService:UrlEncode(tostring(value3))}`)
            end
        elseif not tbl1[value] then
            table.insert(tbl2, `{value}={HttpService:UrlEncode(tostring(value2))}`)
        end
    end

    return table.concat(tbl2, "&")
end

return {
    getCatalogV2SearchItemDetails = function(func1: (...any) -> (...any), arg1)
        local queryStringWithArrayParams = buildQueryStringWithArrayParams(arg1)
        local var1, var2 = func1(`{Url.CATALOG_URL}v2/search/items/details?{queryStringWithArrayParams}`, "GET")

        return makeAXResponseHandler(var1, normalizeCatalogV2SearchItemDetails, {
            modelMismatchCounter = constants.FETCH_CATALOG_V2_SEARCH_ITEM_DETAILS_MODEL_MISMATCH_COUNTER_NAME,
            latencyCounter = constants.FETCH_CATALOG_V2_SEARCH_ITEM_DETAILS_LATENCY_COUNTER_NAME
        }), var2
    end,
    buildQueryStringWithArrayParams = buildQueryStringWithArrayParams
}
