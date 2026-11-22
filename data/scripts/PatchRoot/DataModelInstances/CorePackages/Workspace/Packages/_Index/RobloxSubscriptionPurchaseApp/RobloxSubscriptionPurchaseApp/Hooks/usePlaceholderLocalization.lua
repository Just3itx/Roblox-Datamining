-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:50:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")
local RobloxSubscriptionPurchaseAppParent = RobloxSubscriptionPurchaseApp.Parent
local React = require(RobloxSubscriptionPurchaseAppParent.React)
local SignalsReact = require(RobloxSubscriptionPurchaseAppParent.SignalsReact)
local CampaignLocalizations = require(RobloxSubscriptionPurchaseApp.Store.CampaignLocalizations)

local FFlagSubscriptionSheetCampaignLocalizations = require(RobloxSubscriptionPurchaseAppParent.SharedFlags).FFlagSubscriptionSheetCampaignLocalizations

local tbl1 = {
    ["Feature.RobloxSubscription.Heading.TTGrant"] = "Lorem ipsum dolor sit amet",
    ["Feature.RobloxSubscription.Description.TTGrant"] = "Consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.",
    ["Feature.RobloxSubscription.Action.TTClaim"] = "Lorem ipsum",
    ["Feature.RobloxSubscription.Label.TTBenefitCustomize"] = "Lorem ipsum dolor",
    ["Feature.RobloxSubscription.Label.TTBenefitDiscount"] = "Sit amet consectetur",
    ["Feature.RobloxSubscription.Label.TTBenefitPrivateServer"] = "Adipiscing elit sed",
    ["Feature.RobloxSubscription.Label.TTBenefitRobux"] = "Eiusmod tempor incididunt"
}

local tbl2 = {}

local function usePlaceholderLocalization(tbl3)
    local var1 = if FFlagSubscriptionSheetCampaignLocalizations then SignalsReact.useSignalState(CampaignLocalizations.getCampaignLocalizations) else tbl2

    return React.useMemo(function()
        local result = ({})
        for value, value2 in tbl3 do
            local var2 = var1[value2]
            if FFlagSubscriptionSheetCampaignLocalizations and var2 then
                result[value] = var2
            else
                result[value] = tbl1[value2] or value2
            end
        end
        return result
    end, { tbl3, var1 })
end

return usePlaceholderLocalization
