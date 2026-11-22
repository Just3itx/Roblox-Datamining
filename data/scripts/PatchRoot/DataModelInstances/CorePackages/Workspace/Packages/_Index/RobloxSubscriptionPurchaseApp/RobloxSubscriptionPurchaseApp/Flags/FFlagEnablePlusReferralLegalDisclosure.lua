-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:41:04Z
-- Luau bytecode version: 14 | Luau type version: 3
local RobloxSubscriptionPurchaseAppParent = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp").Parent
local FFlagEnablePlusReferralLandingSheet = require(RobloxSubscriptionPurchaseAppParent.SharedFlags).FFlagEnablePlusReferralLandingSheet

return game:DefineFastFlag("EnablePlusReferralLegalDisclosure", false) and FFlagEnablePlusReferralLandingSheet
