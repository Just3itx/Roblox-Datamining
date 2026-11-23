-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent
local React = require(AvatarExperienceInspectAndBuyParent.React)
local useConvertedItemData = require(AvatarExperienceInspectAndBuy.Hooks.useConvertedItemData)
local useItemStatusLocalization = require(AvatarExperienceInspectAndBuy.Hooks.useItemStatusLocalization)
local getPriceStatus = require(AvatarExperienceInspectAndBuy.Utils.getPriceStatus)
local _BuyActionBar = require(AvatarExperienceInspectAndBuy.Components.Common.BuyActionBar)
local Foundation = require(AvatarExperienceInspectAndBuyParent.Foundation)
local _Types = require(AvatarExperienceInspectAndBuy.Types)
local PriceStatus = require(AvatarExperienceInspectAndBuy.Enums.PriceStatus)
local itemDetailsUtils = require(AvatarExperienceInspectAndBuy.Utils.itemDetailsUtils)
local isCollectible = itemDetailsUtils.isCollectible
local calculatePurchaseStatusForItem = itemDetailsUtils.calculatePurchaseStatusForItem
local getPriceInRobux = itemDetailsUtils.getPriceInRobux
local formatNumber = require(AvatarExperienceInspectAndBuy.Utils.formatNumber)

local function usePurchaseButtonProps(tbl1)
    local var1 = useConvertedItemData(tbl1.selectedItem)
    local priceStatus = getPriceStatus(var1)
    local var2 = useItemStatusLocalization(var1)

    local purchaseButtonProps = React.useMemo(function()
        return {
            purchaseButtonText = tbl1.purchaseButtonText,
            onPurchase = tbl1.onBulkPurchase,
            isDisabled = tbl1.isDisabled,
            showRobuxIcon = false,
            variant = Foundation.Enums.ButtonVariant.Emphasis
        }
    end, { tbl1 })

    local var3 = React.useMemo(function()
        local bool1 = priceStatus == PriceStatus.Free
            or priceStatus == PriceStatus.PurchaseFromRoblox
            or priceStatus == PriceStatus.PurchaseFromResale

        local module = {
            purchaseButtonText = var2[priceStatus],
            isDisabled = not bool1,
            variant = if bool1 then Foundation.Enums.ButtonVariant.Emphasis else Foundation.Enums.ButtonVariant.Standard,
            onPurchase = 0
        }

        function module.onPurchase()
            if var1 then
                local var4 = isCollectible(var1)
                local purchaseStatusForItem = calculatePurchaseStatusForItem(var1, priceStatus)
                tbl1.onPromptPurchase(
                    var1.id,
                    var1.itemType,
                    purchaseStatusForItem.collectibleItemId,
                    purchaseStatusForItem.collectibleLowestAvailableResaleProductId,
                    purchaseStatusForItem.collectibleLowestAvailableResaleItemInstanceId,
                    purchaseStatusForItem.collectibleLowestResalePrice,
                    var4
                )
            end
        end

        return module
    end, { tbl1, priceStatus, var1 })

    if tbl1.selectedItem then
        return {
            purchaseButtonProps = var3,
            priceLabel = {
                leftLabel = tbl1.localizedStrings.total or "",
                priceInRobux = formatNumber(getPriceInRobux(var1, priceStatus))
            },
            priceStatus = priceStatus
        }
    end

    return {
        purchaseButtonProps = purchaseButtonProps,
        priceLabel = {
            leftLabel = tbl1.localizedStrings.totalItems or "",
            priceInRobux = tbl1.formattedTotalPrice
        }
    }
end

return usePurchaseButtonProps
