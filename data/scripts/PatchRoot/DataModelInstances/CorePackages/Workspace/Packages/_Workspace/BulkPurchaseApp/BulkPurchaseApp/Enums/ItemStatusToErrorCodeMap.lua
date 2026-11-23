-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:40:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local ErrorCodeEnum = require(script.Parent.ErrorCodeEnum)

return {
    [Enum.MarketplaceItemPurchaseStatus.NotForSale] = ErrorCodeEnum.NotForSale,
    [Enum.MarketplaceItemPurchaseStatus.PriceMismatch] = ErrorCodeEnum.PriceMismatch,
    [Enum.MarketplaceItemPurchaseStatus.SoldOut] = ErrorCodeEnum.SoldOut,
    [Enum.MarketplaceItemPurchaseStatus.InsufficientRobux] = ErrorCodeEnum.InsufficientRobux,
    [Enum.MarketplaceItemPurchaseStatus.QuotaExceeded] = ErrorCodeEnum.QuotaExceeded,
    [Enum.MarketplaceItemPurchaseStatus.NotAvailableForPurchaser] = ErrorCodeEnum.NotAvailableForPurchaser,
    [Enum.MarketplaceItemPurchaseStatus.AlreadyOwned] = ErrorCodeEnum.AlreadyOwned,
    [Enum.MarketplaceItemPurchaseStatus.PurchaserIsSeller] = ErrorCodeEnum.PurchaserIsSeller,
    [Enum.MarketplaceItemPurchaseStatus.QuantityLimitExceeded] = ErrorCodeEnum.QuantityLimitExceeded,
    [Enum.MarketplaceItemPurchaseStatus.InsufficientMembership] = ErrorCodeEnum.InsufficientMembership,
    [Enum.MarketplaceItemPurchaseStatus.Success] = ErrorCodeEnum.Generic,
    [Enum.MarketplaceItemPurchaseStatus.SystemError] = ErrorCodeEnum.Generic,
    [Enum.MarketplaceItemPurchaseStatus.PlaceInvalid] = ErrorCodeEnum.PlaceInvalid
}
