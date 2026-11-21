-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:40:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent
local Url = require(AvatarExperienceCatalogParent.Http).Url
local _LuauPolyfill = require(AvatarExperienceCatalogParent.LuauPolyfill)

local makeAXResponseHandler = require(AvatarExperienceCatalog.Utils.makeAXResponseHandler)
local normalizeFaeStatus = require(script.Parent.normalizeFaeStatus)
local constants = require(script.Parent.constants)

return {
    getFaeStatus = function(func1: (...any) -> (...any))
        local var1 = Url:makeQueryString({
            featureNames = "ShowFaeUpsellInMarketplace,AllowFaeItemToBeClaimed",
            nameSpace = "avatar_marketplace_user_journey/MarketplaceUserJourney"
        })

        local var2, var3 = func1(`{Url.APIS_URL}access-management/v1/feature-access?{var1}`, "GET")

        return makeAXResponseHandler(var2, normalizeFaeStatus, {
            modelMismatchCounter = constants.FETCH_FAE_STATUS_MODEL_MISMATCH_COUNTER_NAME,
            latencyCounter = constants.FETCH_FAE_STATUS_LATENCY_COUNTER_NAME
        }), var3
    end
}
