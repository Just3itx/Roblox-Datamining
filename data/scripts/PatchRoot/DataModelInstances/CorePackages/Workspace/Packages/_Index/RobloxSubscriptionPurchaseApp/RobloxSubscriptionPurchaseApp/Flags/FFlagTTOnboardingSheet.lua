-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:41:23Z
-- Luau bytecode version: 14 | Luau type version: 3
local RobloxSubscriptionPurchaseAppParent = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp").Parent

local FFlagSubscriptionSheetCampaignLocalizations = require(RobloxSubscriptionPurchaseAppParent.SharedFlags).FFlagSubscriptionSheetCampaignLocalizations

return game:DefineFastFlag("TTOnboardingSheet2", false) and FFlagSubscriptionSheetCampaignLocalizations
