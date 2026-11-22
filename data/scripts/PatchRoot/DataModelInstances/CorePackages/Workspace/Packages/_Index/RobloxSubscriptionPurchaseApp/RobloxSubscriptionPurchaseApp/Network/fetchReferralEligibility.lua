-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseAppParent = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp").Parent

local Url = require(RobloxSubscriptionPurchaseAppParent.Http).Url
local HttpRequest = require(script.Parent.HttpRequest)

local var1 = Url.APIS_URL .. "subscriptions/v2/referral-eligibility?"

return function(num1: number)
    local var2 = var1 .. Url:makeQueryString({ referrerId = tostring(num1) })

    return HttpRequest.new():get(var2):andThen(function(arg1)
        if arg1 and arg1.eligibility == "Eligible" then
            return { eligible = true, reason = nil }
        end
        return {
            eligible = false,
            reason = if arg1 then arg1.ineligibilityReason else nil
        }
    end, function()
        return { eligible = false, reason = nil }
    end)
end
