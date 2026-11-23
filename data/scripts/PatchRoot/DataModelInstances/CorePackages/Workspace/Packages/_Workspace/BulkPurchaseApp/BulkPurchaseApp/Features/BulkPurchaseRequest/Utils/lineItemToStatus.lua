-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:41:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {
    INSUFFICIENT_ROBUX = Enum.MarketplaceItemPurchaseStatus.InsufficientRobux,
    QUOTA_EXCEEDED = Enum.MarketplaceItemPurchaseStatus.QuotaExceeded,
    NOT_FOR_SALE = Enum.MarketplaceItemPurchaseStatus.NotForSale,
    NOT_AVAILABLE_FOR_PURCHASER = Enum.MarketplaceItemPurchaseStatus.NotAvailableForPurchaser,
    PRICE_MISMATCH = Enum.MarketplaceItemPurchaseStatus.PriceMismatch,
    SOLD_OUT = Enum.MarketplaceItemPurchaseStatus.SoldOut,
    PURCHASER_IS_SELLER = Enum.MarketplaceItemPurchaseStatus.PurchaserIsSeller,
    QUANTITY_LIMIT_EXCEEDED = Enum.MarketplaceItemPurchaseStatus.QuantityLimitExceeded,
    ALREADY_OWNED = Enum.MarketplaceItemPurchaseStatus.AlreadyOwned,
    INSUFFICIENT_MEMBERSHIP = Enum.MarketplaceItemPurchaseStatus.InsufficientMembership,
    PURCHASE_PLACE_INVALID = Enum.MarketplaceItemPurchaseStatus.PlaceInvalid
}

local function lineItemToStatus(tbl2)
    local var1 = tbl1[tbl2.errorReason]

    if tbl2.status == "SUCCEEDED" then
        return Enum.MarketplaceItemPurchaseStatus.Success
    end

    return var1 or Enum.MarketplaceItemPurchaseStatus.SystemError
end

return lineItemToStatus
