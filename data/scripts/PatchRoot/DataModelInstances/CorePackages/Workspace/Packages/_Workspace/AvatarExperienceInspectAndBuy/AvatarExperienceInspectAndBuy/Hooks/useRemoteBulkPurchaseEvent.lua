-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:31:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent
local React = require(AvatarExperienceInspectAndBuyParent.React)
local _Types = require(AvatarExperienceInspectAndBuy.Types)
local FIntBulkPurchaseRequestLimit = require(AvatarExperienceInspectAndBuyParent.SharedFlags).FIntBulkPurchaseRequestLimit
local useSelector = require(AvatarExperienceInspectAndBuyParent.RoactUtils).Hooks.RoactRodux.useSelector
local bulkPurchaseUtils = require(AvatarExperienceInspectAndBuy.Utils.bulkPurchaseUtils)
local buildBulkPurchaseAnalyticsPayload = require(AvatarExperienceInspectAndBuy.Utils.buildBulkPurchaseAnalyticsPayload)
local tutils = require(AvatarExperienceInspectAndBuyParent.tutils)
local ItemTypeEnum = require(AvatarExperienceInspectAndBuyParent.AvatarExperienceModel).Enums.ItemTypeEnum
local useSignalState = require(AvatarExperienceInspectAndBuyParent.SignalsReact).useSignalState
local useItemSelectionStore = require(AvatarExperienceInspectAndBuy.Contexts.ItemSelectionStoreContext).useItemSelectionStore
local _createItemSelectionStore = require(AvatarExperienceInspectAndBuy.Stores.createItemSelectionStore)

local function func1(arg1)
    return {
        assets = arg1.assets,
        bundles = arg1.bundles
    }
end

local function func2(arg1)
    return arg1.collectibleResellableInstances
end

return function(tbl1, arg1)
    local var1 = useSelector(func1, tutils.deepEqual)
    local collectibleResellableInstances = useSelector(func2, tutils.deepEqual)

    local var3 = useItemSelectionStore()
    local var4 = useSignalState(var3.getItemDataMap)

    local var5 = React.useMemo(function()
        return bulkPurchaseUtils.getBulkPurchaseEligibleItems(tbl1, var1, var4)
    end, { tbl1, var1, var4 })

    return React.useCallback(function()
        coroutine.wrap(function()
            RobloxReplicatedStorage:WaitForChild("ServerSideBulkPurchaseEvent", math.huge):FireServer(var5.requestedItems)

            for _, requestedItem in var5.requestedItems do
                local itemType = if requestedItem.itemType == Enum.AvatarItemType.Asset.Value then ItemTypeEnum.Asset else ItemTypeEnum.Bundle
                local itemId = tostring(requestedItem.id)

                local storedData = var4 and var4[itemId]
                local bulkPurchaseAnalyticsPayload = buildBulkPurchaseAnalyticsPayload({
                    itemId = itemId,
                    itemType = itemType,
                    assetsMap = var1.assets,
                    bundlesMap = var1.bundles,
                    collectibleResellableInstances = collectibleResellableInstances,
                    storedData = storedData
                })
                if bulkPurchaseAnalyticsPayload then
                    arg1.reportPurchaseAttemptUnifiedEvent(itemType, itemId, bulkPurchaseAnalyticsPayload)
                end
            end
        end)()
    end, {
        var5,
        var4,
        var1,
        collectibleResellableInstances,
        arg1.reportPurchaseAttemptUnifiedEvent
    }), React.useMemo(function(): boolean
        if var5.requestedItems and #var5.requestedItems <= FIntBulkPurchaseRequestLimit then
            return #var5.requestedItems > 0
        end

        return false
    end, { var5 }), var5.totalPrice or 0
end
