-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContentProvider = game:GetService("ContentProvider")

local RobloxSubscriptionPurchaseAppParent = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp").Parent
local FFlagEnablePlusReferralLandingSheet = require(RobloxSubscriptionPurchaseAppParent.SharedFlags).FFlagEnablePlusReferralLandingSheet

local function getSubscriptionPurchaseUrl(str1: string, str2: string?, num1: number?): string
    local baseUrl = ContentProvider.BaseUrl
    local str3 = if str2 then string.format(
        "%supgrades/paymentmethods?ctx=subscription&type=Blackbird&id=%s&paymentSessionId=%s",
        baseUrl,
        str1,
        str2
    ) else string.format("%supgrades/paymentmethods?ctx=subscription&type=Blackbird&id=%s", baseUrl, str1)

    if FFlagEnablePlusReferralLandingSheet and num1 then
        str3 ..= "&referrerId=" .. tostring(num1)
    end

    return str3
end

return getSubscriptionPurchaseUrl
