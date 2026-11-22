-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:50:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")
local RobloxSubscriptionPurchaseAppParent = RobloxSubscriptionPurchaseApp.Parent

local React = require(RobloxSubscriptionPurchaseAppParent.React)

local RobloxPlusUnifiedBuyModalBannerImpression = require(RobloxSubscriptionPurchaseApp.Storage.RobloxPlusUnifiedBuyModalBannerImpression)
local FIntNewBadgeMaximumImpressionCount = require(RobloxSubscriptionPurchaseApp.Flags.FIntNewBadgeMaximumImpressionCount)

local function useRobloxPlusUpsellBannerNewBadgeInteraction(callback: (...any) -> (...any))
    local shouldShowNewBadge = React.useState(function()
        return RobloxPlusUnifiedBuyModalBannerImpression.getImpressionCount()
    end) < FIntNewBadgeMaximumImpressionCount

    return {
        shouldShowNewBadge = shouldShowNewBadge,
        onActivated = React.useCallback(function()
            if shouldShowNewBadge then
                RobloxPlusUnifiedBuyModalBannerImpression.incrementImpressionCount()
            end
            callback()
        end, { shouldShowNewBadge, callback })
    }
end

return useRobloxPlusUpsellBannerNewBadgeInteraction
