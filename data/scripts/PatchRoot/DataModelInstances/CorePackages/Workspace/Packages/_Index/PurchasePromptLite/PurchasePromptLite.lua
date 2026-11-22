-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:00:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local ProductPurchaseSurface = require(script.Enums.ProductPurchaseSurface)
return {
    Enums = {
        ProductKind = require(script.Enums.ProductKind),
        ProductPurchaseSurface = ProductPurchaseSurface,
        PurchaseLookItemStatusEnum = require(script.Enums.PurchaseLookItemStatusEnum),
        PurchaseLookStatusEnum = require(script.Enums.PurchaseLookStatusEnum)
    },
    Events = require(script.Events.PurchaseEvents),
    Thunks = {
        OpenCentralOverlayForUnifiedPurchasePrompt = require(script.State.Thunks.OpenCentralOverlayForUnifiedPurchasePrompt)
    },
    getIsUserEligibleForUnifiedPurchaseFlow = require(script.Utils.getIsUserEligibleForUnifiedPurchaseFlow),
    getTTIEventName = require(script.Utils.getTTIEventName),
    ["jest.config"] = script["jest.config"]
}
