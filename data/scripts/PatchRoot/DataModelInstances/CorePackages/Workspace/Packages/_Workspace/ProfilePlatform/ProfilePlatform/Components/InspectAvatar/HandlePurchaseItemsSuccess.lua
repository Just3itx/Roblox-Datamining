-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:01:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local SetCurrentToastMessage = require(ProfilePlatformParent.ToastRodux).Actions.SetCurrentToastMessage

local CatalogNetworking = require(ProfilePlatformParent.CatalogNetworking)
local PurchaseDetailsStore = CatalogNetworking.PurchaseDetailsStore
local BundleOwnershipStore = CatalogNetworking.BundleOwnershipStore

local _ProfileWrapperContext = require(ProfilePlatform.Contexts.ProfileWrapperContext)

local MarketplaceUnifiedAction = require(ProfilePlatformParent.AvatarExperienceAnalytics).UnifiedEventLogEnums.MarketplaceUnifiedAction

local Enums = require(ProfilePlatform.Common.Enums)
local sendProfilePurchaseEvents = require(ProfilePlatform.Analytics.sendProfilePurchaseEvents)

local FFlagProfileInspectAndBuyRefreshBalanceAfterPurchase = require(ProfilePlatform.Flags.FFlagProfileInspectAndBuyRefreshBalanceAfterPurchase)
local FFlagProfileUnifiedPurchaseLogging = require(ProfilePlatform.Flags.FFlagProfileUnifiedPurchaseLogging)

local function buildEquippableAssets(tbl1, tbl2, tbl3)
    local equippableAssets = {}
    local tbl4 = ({})

    local function append(tbl5)
        for _, value in tbl5 do
            if tbl4[value] then
                continue
            end

            local var1 = tbl3[value]
            if not var1 then
                continue
            end

            tbl4[value] = true
            table.insert(equippableAssets, { assetTypeId = tostring(var1), assetId = tostring(value) })
        end
    end

    append(tbl1)
    append(tbl2)

    return equippableAssets
end

local function parseLineItems(tbl1)
    local tbl2 = {}
    local tbl3 = {}
    local num1 = 0

    for _, value in tbl1 do
        if value.status ~= "SUCCEEDED" then
            num1 += 1
        elseif value.bundleId then
            table.insert(tbl3, tostring(value.bundleId))
            table.insert(tbl2, tostring(value.bundleId))
        elseif value.assetId then
            table.insert(tbl2, tostring(value.assetId))
        end
    end

    return tbl2, tbl3, num1
end

local function buildPurchasedItems(tbl1, purchasedItems)
    local tbl2 = {}
    if purchasedItems then
        for _, purchasedItem in purchasedItems do
            if purchasedItem.itemSubType then
                tbl2[purchasedItem.itemId] = purchasedItem.itemSubType
            end
        end
    end

    local purchasedItems2 = {}

    for _, value in tbl1 do
        if value.status ~= "SUCCEEDED" then
            continue
        end

        local var1 = if value.bundleId then tostring(value.bundleId) elseif value.assetId then tostring(value.assetId) else nil

        if not var1 then
            continue
        end

        table.insert(purchasedItems2, {
            itemId = var1,
            itemType = if value.bundleId then Enums.ItemTypes.Bundle else Enums.ItemTypes.Asset,
            itemSubType = tbl2[var1],
            priceInRobux = value.agreedPriceRobux
        })
    end

    return purchasedItems2
end

local function HandlePurchaseItemsSuccess(tbl1)
    local responseBody = tbl1.result and tbl1.result.responseBody
    local fulfillmentGroups = responseBody and responseBody.fulfillmentGroups
    local var1 = fulfillmentGroups and fulfillmentGroups[1] and fulfillmentGroups[1].lineItems or {}

    local tbl2, tbl3, num1 = parseLineItems(var1)

    if FFlagProfileUnifiedPurchaseLogging then
        sendProfilePurchaseEvents(
            MarketplaceUnifiedAction.PURCHASE_SUCCESS,
            buildPurchasedItems(var1, tbl1.purchasedItems),
            tbl1.profileWrapperContext.profileType
        )
    end

    PurchaseDetailsStore.markItemsOwned(tbl2)
    if #tbl3 > 0 then
        BundleOwnershipStore.markOwned(tbl3)
    end

    if tbl1.isWearAfterPurchaseChecked and tbl1.profileWrapperContext.postPurchase then
        local equippableAssets = buildEquippableAssets(tbl1.purchasedWearIds or {}, tbl1.ownedAssetIds or {}, tbl1.wearTypeMap or {})

        if #equippableAssets > 0 then
            if tbl1.avatarSaveContext and tbl1.avatarSaveContext.autoSaveNextNewSaveData then
                tbl1.avatarSaveContext.autoSaveNextNewSaveData()
            end
            tbl1.profileWrapperContext.postPurchase.wearAfterPurchase(equippableAssets)
        end
    end

    if FFlagProfileInspectAndBuyRefreshBalanceAfterPurchase and #tbl2 > 0 then
        local postPurchase = tbl1.profileWrapperContext.postPurchase
        if postPurchase and postPurchase.refreshRobuxBalance then
            postPurchase.refreshRobuxBalance()
        end
    end

    local tbl4 = if num1 == 0 then {
        toastMessage = if #tbl2 == 1 then tbl1.localized.purchaseSuccessSingular else tbl1.localized.purchaseSuccessPlural,
        isLocalized = true,
        toastType = "PurchaseMessage"
    } else {
        toastMessage = tbl1.localized.purchasePartialFailure,
        isLocalized = true,
        toastType = "PurchaseMessage"
    }
    tbl1.dispatch(SetCurrentToastMessage(tbl4))
end

return HandlePurchaseItemsSuccess
