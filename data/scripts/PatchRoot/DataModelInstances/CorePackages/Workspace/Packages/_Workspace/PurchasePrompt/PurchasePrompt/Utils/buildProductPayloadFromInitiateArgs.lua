-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")

local ProductTypeEnum = require(PurchasePrompt.types).ProductTypeEnum

local FFlagLuaAppsEnablePromptVIPServerPurchase = require(PurchasePrompt.Parent.SharedFlags).FFlagLuaAppsEnablePromptVIPServerPurchase

local function buildProductPayloadFromInitiateArgs(universeId, arg1, equipIfPurchased: boolean?, isRobloxPurchase: boolean?, idempotencyKey: string?, purchaseAuthToken: string?, collectibleItemId: string?, collectibleItemInstanceId: string?, collectibleProductId: string?, expectedPrice: number?, arg2)
    local var1 = arg2 or {}

    if arg1 == Enum.InfoType.Asset then
        return {
            kind = ProductTypeEnum.Asset,
            id = tostring(universeId),
            equipIfPurchased = equipIfPurchased or false,
            isRobloxPurchase = isRobloxPurchase or false,
            idempotencyKey = idempotencyKey or "",
            purchaseAuthToken = purchaseAuthToken or "",
            collectibleItemId = collectibleItemId or "",
            collectibleItemInstanceId = collectibleItemInstanceId or "",
            collectibleProductId = collectibleProductId or "",
            expectedPrice = expectedPrice or 0
        }
    end

    if arg1 == Enum.InfoType.GamePass then
        return {
            kind = ProductTypeEnum.Gamepass,
            id = tostring(universeId)
        }
    end

    if arg1 == Enum.InfoType.Product then
        return {
            kind = ProductTypeEnum.Product,
            id = tostring(universeId),
            equipIfPurchased = equipIfPurchased or false,
            universeId = nil
        }
    end

    if arg1 == Enum.InfoType.Bundle then
        return {
            kind = ProductTypeEnum.Bundle,
            id = tostring(universeId),
            idempotencyKey = idempotencyKey or "",
            collectibleItemId = collectibleItemId or "",
            collectibleItemInstanceId = collectibleItemInstanceId or "",
            collectibleProductId = collectibleProductId or "",
            expectedPrice = expectedPrice or 0
        }
    end

    if arg1 == ProductTypeEnum.Experience then
        return {
            kind = ProductTypeEnum.Experience,
            universeId = tostring(universeId),
            experienceName = var1.name or "",
            experienceIconUrl = var1.imageUrl or ""
        }
    end

    if arg1 ~= ProductTypeEnum.Look then
        if FFlagLuaAppsEnablePromptVIPServerPurchase and arg1 == ProductTypeEnum.VIPServer then
            return {
                kind = ProductTypeEnum.VIPServer,
                universeId = universeId
            }
        end

        return nil
    end

    return {
        kind = ProductTypeEnum.Look,
        id = tostring(universeId),
        expectedPrice = var1.expectedPrice or expectedPrice or 0,
        salesLocationId = 0,
        excludedAssetIds = {},
        excludedBundleIds = {}
    }
end

return buildProductPayloadFromInitiateArgs
