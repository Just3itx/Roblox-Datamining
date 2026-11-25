-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local _PurchasePromptLite = require(scriptParentParentParent.PurchasePromptLite)

local Promise = require(scriptParentParent.Promise)
local _types = require(scriptParentParent.types)
local UnifiedPurchaseTelemetry = require(scriptParentParent.Events.UnifiedPurchaseTelemetry)
local logUnifiedPurchaseTelemetryCounter = require(scriptParentParent.Utils.logUnifiedPurchaseTelemetryCounter)

local function buildRequestBody(userId: number, featureKey: string, items, tbl1)
    local tbl2 = { userId = userId, featureKey = featureKey, items = items }

    if tbl1 ~= nil and #tbl1 > 0 then
        local offerSelections = {}
        for _, offerId in tbl1 do
            table.insert(offerSelections, { offerId = offerId, selectionType = "OFFER_SELECTION_TYPE_EXCLUDED" })
        end

        tbl2.offerSelections = offerSelections
    end
    return tbl2
end

local function postInGameItemCartPricing(arg1, userId: number, featureKey: string, items, tbl1, arg2, arg3)
    if items == nil or #items == 0 or arg1.postInGameItemCartPricing == nil then
        return Promise.resolve(nil)
    end

    return arg1.postInGameItemCartPricing((buildRequestBody(userId, featureKey, items, tbl1))):andThen(function<T>(arg4: T): T
        logUnifiedPurchaseTelemetryCounter(UnifiedPurchaseTelemetry.UnifiedCartPricingFetchSucceededCounter, arg2, arg3)

        return arg4
    end):catch(function(failed)
        logUnifiedPurchaseTelemetryCounter(UnifiedPurchaseTelemetry.UnifiedCartPricingFetchFailedCounter, arg2, arg3)

        warn(string.format("postInGameItemCartPricing failed: %s", tostring(failed)))
        return nil
    end)
end

return postInGameItemCartPricing
