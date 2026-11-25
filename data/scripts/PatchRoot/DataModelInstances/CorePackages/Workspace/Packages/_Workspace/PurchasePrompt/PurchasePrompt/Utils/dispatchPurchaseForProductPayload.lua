-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local SharedFlags = require(PurchasePromptParent.SharedFlags)

local ProductTypeEnum = require(PurchasePrompt.types).ProductTypeEnum
local initiatePurchase = require(PurchasePrompt.Thunks.initiatePurchase)
local initiateBundlePurchase = require(PurchasePrompt.Thunks.initiateBundlePurchase)

local FFlagUnifiedPurchaseSupportRefetchingLooksAfterUpsell = require(PurchasePrompt.Flags.FFlagUnifiedPurchaseSupportRefetchingLooksAfterUpsell)
local FFlagAXMISWithBlackbird = SharedFlags.FFlagAXMISWithBlackbird
local FFlagLuaAppsEnablePromptVIPServerPurchase = SharedFlags.FFlagLuaAppsEnablePromptVIPServerPurchase

local function dispatchPurchaseForProductPayload(callback: (...any) -> (...any), arg1, _, bool1: boolean)
    if arg1.kind == ProductTypeEnum.Asset then
        callback(
            initiatePurchase(
                arg1.id,
                Enum.InfoType.Asset,
                arg1.equipIfPurchased,
                arg1.isRobloxPurchase,
                arg1.idempotencyKey,
                nil,
                arg1.collectibleItemId,
                arg1.collectibleItemInstanceId,
                arg1.collectibleProductId,
                arg1.expectedPrice,
                nil,
                bool1
            )
        )
        return
    end

    if arg1.kind == ProductTypeEnum.Gamepass then
        callback(initiatePurchase(arg1.id, Enum.InfoType.GamePass, nil, nil, nil, nil, nil, nil, nil, nil, nil, bool1))
        return
    end

    if arg1.kind == ProductTypeEnum.Product then
        callback(
            initiatePurchase(arg1.id, Enum.InfoType.Product, arg1.equipIfPurchased, nil, nil, nil, nil, nil, nil, nil, nil, bool1)
        )
        return
    end

    if arg1.kind == ProductTypeEnum.Bundle then
        callback(
            initiateBundlePurchase(
                arg1.id,
                arg1.idempotencyKey,
                nil,
                arg1.collectibleItemId,
                arg1.collectibleItemInstanceId,
                arg1.collectibleProductId,
                arg1.expectedPrice,
                bool1
            )
        )
        return
    end

    if arg1.kind == ProductTypeEnum.Experience then
        callback(
            initiatePurchase(
                arg1.universeId,
                ProductTypeEnum.Experience,
                nil,
                nil,
                nil,
                nil,
                nil,
                nil,
                nil,
                nil,
                {
                    name = arg1.experienceName,
                    imageUrl = arg1.experienceIconUrl
                },
                bool1
            )
        )
        return
    end

    if arg1.kind == ProductTypeEnum.Look then
        callback(
            initiatePurchase(
                arg1.id,
                ProductTypeEnum.Look,
                nil,
                nil,
                nil,
                nil,
                nil,
                nil,
                nil,
                nil,
                FFlagUnifiedPurchaseSupportRefetchingLooksAfterUpsell
                    and {
                        excludedAssetIds = arg1.excludedAssetIds,
                        excludedBundleIds = arg1.excludedBundleIds,
                        timedOptions = arg1.timedOptions
                    }
                    or {
                        expectedPrice = arg1.expectedPrice
                    },
                bool1
            )
        )
        return
    end

    if FFlagAXMISWithBlackbird and arg1.kind == ProductTypeEnum.RobuxUpsell then
        callback(initiatePurchase(arg1.id, ProductTypeEnum.RobuxUpsell, nil, nil, nil, nil, nil, nil, nil, nil, nil, false))
        return
    end

    if arg1.kind ~= ProductTypeEnum.DeveloperSubscription then
        if FFlagLuaAppsEnablePromptVIPServerPurchase and arg1.kind == ProductTypeEnum.VIPServer then
            callback(
                initiatePurchase(arg1.universeId, ProductTypeEnum.VIPServer, nil, nil, nil, nil, nil, nil, nil, nil, nil, bool1)
            )
        end

        return
    end

    callback(
        initiatePurchase(
            arg1.subscriptionId,
            ProductTypeEnum.DeveloperSubscription,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil,
            arg1.expectedPrice,
            {
                expectedPrice = arg1.expectedPrice,
                name = arg1.name,
                iconImageAssetId = arg1.iconImageAssetId,
                displayPrice = arg1.displayPrice
            },
            bool1
        )
    )
end

return dispatchPurchaseForProductPayload
