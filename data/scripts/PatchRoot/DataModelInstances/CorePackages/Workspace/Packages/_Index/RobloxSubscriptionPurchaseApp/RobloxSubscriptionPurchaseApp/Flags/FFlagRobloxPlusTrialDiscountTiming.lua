-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:41:16Z
-- Luau bytecode version: 14 | Luau type version: 3
local FFlagRobloxSubscriptionProductsDirectFetch = require(script.Parent.FFlagRobloxSubscriptionProductsDirectFetch)
local engineFeature = game:GetEngineFeature("EnableSubscriptionFreeTrialOfferDetails")

return game:DefineFastFlag("RobloxPlusTrialDiscountTiming", false)
    and (engineFeature or FFlagRobloxSubscriptionProductsDirectFetch)
