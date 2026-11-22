-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:31:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")
local RobloxSubscriptionPurchaseAppParent = RobloxSubscriptionPurchaseApp.Parent

local React = require(RobloxSubscriptionPurchaseAppParent.React)

local useRobloxPlusUpsellBannerViewModel = require(RobloxSubscriptionPurchaseApp.Hooks.useRobloxPlusUpsellBannerViewModel)

return React.memo(function(tbl1) -- name: RobloxPlusUpsellBanner
    local var1 = useRobloxPlusUpsellBannerViewModel({ subscribeText = tbl1.subscribeText, freeTrialText = tbl1.freeTrialText })

    return tbl1.renderBanner({
        message = tbl1.message,
        actionText = var1.actionText,
        onActivated = tbl1.onActivated,
        showPlusIcon = tbl1.showPlusIcon,
        LayoutOrder = tbl1.LayoutOrder,
        testId = tbl1.testId
    })
end)
