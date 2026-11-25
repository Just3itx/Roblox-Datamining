-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:10:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local React = require(ProfilePlatformParent.React)
local Dash = require(ProfilePlatformParent.Dash)
local Promise = require(ProfilePlatformParent.Promise)
local RobloxAppHooks = require(ProfilePlatformParent.RobloxAppHooks)
local CatalogNetworking = require(ProfilePlatformParent.CatalogNetworking)
local useSignalState = require(ProfilePlatformParent.SignalsReact).useSignalState

local useLocalUserId = RobloxAppHooks.useLocalUserId

local Enums = require(ProfilePlatform.Common.Enums)
local myRoduxNetworkingImpl = require(ProfilePlatform.Networking.myRoduxNetworkingImpl)

local InspectAvatarUtils = require(script.Parent.InspectAvatarUtils)
local _Types = require(ProfilePlatform.Common.Types)

local PurchaseDetailsStore = CatalogNetworking.PurchaseDetailsStore
local CollectibleProductIdStore = CatalogNetworking.CollectibleProductIdStore
local BundleOwnershipStore = CatalogNetworking.BundleOwnershipStore
local ItemDetailsStore = CatalogNetworking.ItemDetailsStore

local function useLookApiData(tbl1)
    local cache = useSignalState(PurchaseDetailsStore.getCache)
    local responseIds, var3 = React.useState({})
    local isLoading, var5 = React.useState(true)

    React.useEffect(function()
        if #tbl1 == 0 then
            var5(false)
            return
        end
        local var6 = Dash.collectArray(tbl1, function(_, arg1): {id: number}?
            if arg1.itemType == Enums.ItemTypes.Bundle then
                return nil
            end

            return {
                id = tonumber(arg1.assetId) or arg1.assetId
            }
        end)

        if #var6 == 0 then
            var5(false)
            return
        end

        var5(true)
        var3({})
        PurchaseDetailsStore.fetchAll(myRoduxNetworkingImpl, var6):andThen(function(arg1)
            if arg1 and arg1.look and arg1.look.items then
                local var7 = Dash.map(arg1.look.items, function(arg2): string
                    return tostring(arg2.id)
                end)
                var3(var7)
            end
        end, function(arg1)
            warn("[useInspectAvatarData] Failed to fetch purchase details:", tostring(arg1))
        end):finally(function()
            var5(false)
        end)
    end, { tbl1 })

    return { responseIds = responseIds, cache = cache, isLoading = isLoading }
end

local function useCatalogEnrichment(tbl1, tbl2)
    local catalogDetails = useSignalState(ItemDetailsStore.getCache)
    local isCatalogLoading, var3 = React.useState(true)
    local collectibleCache = useSignalState(CollectibleProductIdStore.getCache)
    local ownershipCache = useSignalState(BundleOwnershipStore.getCache)

    React.useEffect(function()
        if tbl1.isLoading then
            return
        end

        if #tbl2 == 0 then
            var3(false)
            return
        end

        local tbl3 = {}
        local tbl4 = {}
        for _, value in tbl2 do
            local assetId = value.assetId
            tbl3[tostring(assetId)] = value.itemType or "Asset"
            if value.itemType ~= Enums.ItemTypes.Bundle then
                continue
            end

            local var6 = tonumber(value.assetId)
            if var6 then
                table.insert(tbl4, var6)
            end
        end

        local tbl5 = {}
        local tbl6 = ({})

        for _, responseId in tbl1.responseIds do
            local id = tonumber(responseId)
            if not id or tbl6[responseId] then
                continue
            end

            tbl6[responseId] = true
            table.insert(tbl5, { id = id, itemType = tbl3[responseId] or "Bundle" })
        end

        for _, value in tbl2 do
            local str1 = tostring(value.assetId)
            local id = tonumber(value.assetId)
            if not id or tbl6[str1] then
                continue
            end

            tbl6[str1] = true
            table.insert(tbl5, { id = id, itemType = value.itemType or "Asset" })
        end

        if #tbl5 == 0 and #tbl4 == 0 then
            var3(false)
            return
        end

        var3(true)
        local var6 = if #tbl5 > 0 then ItemDetailsStore.fetchAndCache(myRoduxNetworkingImpl, tbl5) else Promise.resolve()

        local var7 = if #tbl4 > 0 then BundleOwnershipStore.fetchAndCache(myRoduxNetworkingImpl, tbl4):catch(function(arg1)
            warn("[useInspectAvatarData] Failed to fetch bundle ownership:", tostring(arg1))
        end) else Promise.resolve()

        Promise.all({ var6, var7 }):andThen(function()
            var3(false)
        end):catch(function(arg1)
            warn("[useInspectAvatarData] Failed to fetch catalog details:", tostring(arg1))
            var3(false)
        end)
    end, { tbl1.responseIds, tbl1.isLoading, tbl2 })

    React.useEffect(function()
        local tbl3 = {}
        local tbl4 = ({})
        for _, value in tbl2 do
            local var6 = catalogDetails[tostring(value.assetId)]
            if not (var6 and var6.collectibleItemId) then
                continue
            end

            local collectibleItemId = var6.collectibleItemId
            if tbl4[collectibleItemId] then
                continue
            end

            local bool1 = value.itemType == Enums.ItemTypes.Bundle and not var6.isOffSale
            local bool2 = var6.hasResellers == true
            if bool1 or bool2 then
                tbl4[collectibleItemId] = true
                table.insert(tbl3, collectibleItemId)
            end
        end

        for _, responseId in tbl1.responseIds do
            local var6 = catalogDetails[responseId]
            if not (var6 and var6.collectibleItemId) then
                continue
            end

            local collectibleItemId = var6.collectibleItemId
            if not tbl4[collectibleItemId] and var6.hasResellers == true then
                tbl4[collectibleItemId] = true
                table.insert(tbl3, collectibleItemId)
            end
        end

        if #tbl3 == 0 then
            return
        end
        CollectibleProductIdStore.fetchAndCache(myRoduxNetworkingImpl, tbl3):catch(function(arg1)
            warn("[useInspectAvatarData] Failed to fetch collectible product IDs:", tostring(arg1))
        end)
    end, { catalogDetails, tbl2, tbl1.responseIds })

    return {
        catalogDetails = catalogDetails,
        isCatalogLoading = isCatalogLoading,
        ownershipCache = ownershipCache,
        collectibleCache = collectibleCache
    }
end

local function useInspectAvatarData(tbl1)
    local localUserId = useLocalUserId()
    local tbl2 = useLookApiData(tbl1)
    local tbl3 = useCatalogEnrichment(tbl2, tbl1)

    local displayItems = React.useMemo(function()
        if #tbl1 == 0 then
            return {}
        end

        local tbl4 = {}
        for _, value in tbl1 do
            local assetId = value.assetId
            tbl4[tostring(assetId)] = true
        end

        local var2 = InspectAvatarUtils.collectBundleComponentIds(tbl2.responseIds, tbl2.cache)
        local tbl5 = {}
        local tbl6 = ({})

        for _, responseId in tbl2.responseIds do
            local var3 = tbl2.cache[responseId]
            if not var3 then
                continue
            end

            tbl6[responseId] = true
            if not var3.assetsInBundle and var2[responseId] then
                continue
            end

            local catalogDetail = tbl3.catalogDetails[responseId]
            if not catalogDetail then
                continue
            end

            local resaleProductId

            if catalogDetail.collectibleItemId then
                local var4 = tbl3.collectibleCache[catalogDetail.collectibleItemId]
                if var4 then
                    resaleProductId = var4.resaleProductId
                else
                    resaleProductId = nil
                end
            else
                resaleProductId = nil
            end
            table.insert(tbl5, InspectAvatarUtils.buildItemData(catalogDetail, var3, tbl4, nil, nil, resaleProductId))
        end

        for _, value in tbl1 do
            local str1 = tostring(value.assetId)
            if tbl6[str1] or var2[str1] then
                continue
            end

            local catalogDetail = tbl3.catalogDetails[str1]
            if not catalogDetail then
                continue
            end

            local productId = nil
            local resaleProductId = nil
            if catalogDetail.collectibleItemId then
                local var3 = tbl3.collectibleCache[catalogDetail.collectibleItemId]
                if var3 then
                    productId = var3.productId
                    resaleProductId = var3.resaleProductId
                end
            end
            local var3 = tbl3.ownershipCache[str1]
            table.insert(tbl5, InspectAvatarUtils.buildItemData(catalogDetail, nil, tbl4, productId, var3, resaleProductId))
        end

        return InspectAvatarUtils.sortDisplayItems(tbl5)
    end, {
        tbl2.responseIds,
        tbl2.cache,
        tbl1,
        tbl3.catalogDetails,
        tbl3.collectibleCache,
        tbl3.ownershipCache
    })

    return {
        displayItems = displayItems,
        ownedAssetIds = React.useMemo(function()
            local result = {}
            local tbl4 = ({})
            for _, value in displayItems do
                if not value.isOwned then
                    continue
                end

                if #value.bundleAssetIds > 0 then
                    for _, bundleAssetId in value.bundleAssetIds do
                        if not tbl4[bundleAssetId] then
                            tbl4[bundleAssetId] = true
                            table.insert(result, bundleAssetId)
                        end
                    end
                else
                    local var3 = tonumber(value.id)
                    local var4 = if value.itemSubType then tonumber(value.itemSubType) else nil

                    if var3 and (not var4 or InspectAvatarUtils.isWearableAssetType(var4)) and not tbl4[var3] then
                        tbl4[var3] = true
                        table.insert(result, var3)
                    end
                end
            end
            return result
        end, { displayItems }),
        localUserId = localUserId,
        isLoading = tbl2.isLoading or tbl3.isCatalogLoading
    }
end

return useInspectAvatarData
