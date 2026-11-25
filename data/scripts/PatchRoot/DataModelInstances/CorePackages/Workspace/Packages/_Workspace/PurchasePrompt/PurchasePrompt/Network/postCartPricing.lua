-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local _PurchasePromptLite = require(scriptParentParentParent.PurchasePromptLite)

local Promise = require(scriptParentParent.Promise)
local _types = require(scriptParentParent.types)
local UnifiedPurchaseTelemetry = require(scriptParentParent.Events.UnifiedPurchaseTelemetry)
local logUnifiedPurchaseTelemetryCounter = require(scriptParentParent.Utils.logUnifiedPurchaseTelemetryCounter)

local function buildCartPricingRequestBody(items, unselectedOffers) -- Luacid: Inlined by compiler; 1 call site recovered
    local tbl1 = { featureKey = "MARKETPLACE_CART", items = items }

    if unselectedOffers ~= nil then
        tbl1.unselectedOffers = unselectedOffers
    end
    return tbl1
end

local function postCartPricing(arg1, items, unselectedOffers, arg2, arg3)
    if items == nil or #items == 0 or arg1.postCartPricing == nil then
        return Promise.resolve(nil)
    end

    return arg1.postCartPricing((buildCartPricingRequestBody(items, unselectedOffers))):andThen(function<T>(arg4: T): T
        logUnifiedPurchaseTelemetryCounter(UnifiedPurchaseTelemetry.UnifiedCartPricingFetchSucceededCounter, arg2, arg3)

        return arg4
    end):catch(function(failed)
        logUnifiedPurchaseTelemetryCounter(UnifiedPurchaseTelemetry.UnifiedCartPricingFetchFailedCounter, arg2, arg3)

        warn(string.format("postCartPricing failed: %s", tostring(failed)))
        return nil
    end)
end

return postCartPricing
