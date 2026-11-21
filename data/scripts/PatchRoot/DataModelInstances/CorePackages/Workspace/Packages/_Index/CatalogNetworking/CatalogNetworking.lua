-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:20:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CatalogNetworkingParentParent = script:FindFirstAncestor("CatalogNetworking").Parent.Parent

local networkRequests = script.networkRequests
local createGetItemAndBundleDetails = require(networkRequests.createGetItemAndBundleDetails)

local _Types = require(script.Types)
local FFlagSocialEnableProfileInspectAndBuy = require(CatalogNetworkingParentParent.SharedFlags).FFlagSocialEnableProfileInspectAndBuy

local module = {}

function module.config(arg1)
    return {
        GetItemAndBundleDetails = createGetItemAndBundleDetails(arg1)
    }
end

module.PurchaseDetailsStore = if FFlagSocialEnableProfileInspectAndBuy then require(script.stores.PurchaseDetailsStore) else nil

module.CollectibleProductIdStore = if FFlagSocialEnableProfileInspectAndBuy then require(script.stores.CollectibleProductIdStore) else nil

module.BundleOwnershipStore = if FFlagSocialEnableProfileInspectAndBuy then require(script.stores.BundleOwnershipStore) else nil

module.ItemDetailsStore = if FFlagSocialEnableProfileInspectAndBuy then require(script.stores.ItemDetailsStore) else nil

module["jest.config"] = script["jest.config"]
return module
