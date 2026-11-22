-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:50:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")
local RobloxSubscriptionPurchaseAppParent = RobloxSubscriptionPurchaseApp.Parent

local React = require(RobloxSubscriptionPurchaseAppParent.React)

local getRobloxSubscriptionProducts = require(RobloxSubscriptionPurchaseApp.Network.getRobloxSubscriptionProducts)
local isRobloxPlusFreeTrialEligible = require(RobloxSubscriptionPurchaseApp.Utils.isRobloxPlusFreeTrialEligible)

local function useRobloxPlusUpsellBannerViewModel(tbl1)
    local var1, var2 = React.useState(false)

    React.useEffect(function()
        local bool1 = false
        getRobloxSubscriptionProducts():andThen(function(arg1)
            if not bool1 then
                var2(isRobloxPlusFreeTrialEligible(arg1))
            end
        end):catch(function()
            if not bool1 then
                var2(false)
            end
        end)

        return function()
            bool1 = true
        end
    end, {})

    return {
        actionText = if var1 then tbl1.freeTrialText else tbl1.subscribeText
    }
end

return useRobloxPlusUpsellBannerViewModel
