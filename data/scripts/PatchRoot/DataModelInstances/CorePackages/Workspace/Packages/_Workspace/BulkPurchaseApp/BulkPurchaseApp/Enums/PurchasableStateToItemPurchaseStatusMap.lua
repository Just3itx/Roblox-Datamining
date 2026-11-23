-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local PurchasableStateEnum = require(script.Parent.PurchasableStateEnum)

return {
    [PurchasableStateEnum.Unknown] = Enum.MarketplaceItemPurchaseStatus.SystemError,
    [PurchasableStateEnum.AlreadyOwned] = Enum.MarketplaceItemPurchaseStatus.AlreadyOwned,
    [PurchasableStateEnum.QuantityLimitExceeded] = Enum.MarketplaceItemPurchaseStatus.QuantityLimitExceeded,
    [PurchasableStateEnum.NotForSale] = Enum.MarketplaceItemPurchaseStatus.NotForSale,
    [PurchasableStateEnum.SoldOut] = Enum.MarketplaceItemPurchaseStatus.NotForSale
}
