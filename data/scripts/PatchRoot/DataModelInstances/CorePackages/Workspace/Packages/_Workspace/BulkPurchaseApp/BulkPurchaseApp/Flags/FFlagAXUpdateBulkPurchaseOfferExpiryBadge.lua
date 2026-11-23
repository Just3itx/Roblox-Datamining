-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:50:37Z
-- Luau bytecode version: 14 | Luau type version: 3
local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")
local FFlagAXAddOffersToBulkPurchase = require(BulkPurchaseApp.Flags.FFlagAXAddOffersToBulkPurchase)

return game:DefineFastFlag("AXUpdateBulkPurchaseOfferExpiryBadge", false) and FFlagAXAddOffersToBulkPurchase
