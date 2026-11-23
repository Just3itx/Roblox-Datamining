-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:41:31Z
-- Luau bytecode version: 14 | Luau type version: 3
local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")
local FFlagAXAddPlusUpsellToBulkPurchase = require(BulkPurchaseApp.Flags.FFlagAXAddPlusUpsellToBulkPurchase)

return game:DefineFastFlag("AXAddOffersToBulkPurchase", false)
    and FFlagAXAddPlusUpsellToBulkPurchase
    and game:GetEngineFeature("PromptBulkPurchaseRequestedV3EventEnabled")
    and game:GetEngineFeature("BulkPurchaseOffersEnabled")
