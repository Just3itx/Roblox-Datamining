-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseAppParent = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp").Parent

local Promise = require(RobloxSubscriptionPurchaseAppParent.Promise)
local Url = require(RobloxSubscriptionPurchaseAppParent.Http).Url

local HttpRequest = require(script.Parent.HttpRequest)

local featureNames = game:DefineFastString("RobloxPlusAmpFeatureName", "IsRobloxPlusSubscribed")
local namespace = game:DefineFastString("RobloxPlusAmpNamespace", "subscriptions/PlusSubscription")

local function getAmpFeatureAccess()
    local var1 = Url.APIS_URL .. "access-management/v1/feature-access?" .. Url:makeQueryString({ featureNames = featureNames, namespace = namespace })

    return HttpRequest.new():get(var1):andThen(function(arg1)
        local features = arg1 and arg1.features
        return if type(features) == "table" and #features > 0 then features[1].access else nil
    end):catch(function()
        return Promise.resolve(nil)
    end)
end

return getAmpFeatureAccess
