-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:01:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent

local Signals = require(AvatarExperienceCatalogParent.Signals)
local useSignalState = require(AvatarExperienceCatalogParent.SignalsReact).useSignalState

local useAXCatalogStoreContext = require(AvatarExperienceCatalog.Context.useAXCatalogStoreContext)
local _createCatalogOffersBannerStore = require(AvatarExperienceCatalog.Stores.createCatalogOffersBannerStore)

local signal = Signals.createSignal(nil)

local function useHasAtLeastOneCatalogOffer(): boolean
    local catalogOffersBannerStore = useAXCatalogStoreContext().catalogOffersBannerStore
    local var1 = if catalogOffersBannerStore ~= nil then catalogOffersBannerStore.getPayload else signal
    local var2 = useSignalState(var1)

    if var2 == nil then
        return false
    end
    local offers = var2.offers
    return not (offers == nil) and #offers > 0
end

return useHasAtLeastOneCatalogOffer
