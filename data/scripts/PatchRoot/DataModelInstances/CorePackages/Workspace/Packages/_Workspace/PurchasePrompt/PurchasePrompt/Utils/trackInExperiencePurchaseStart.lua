-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent

local PurchasePromptLite = require(PurchasePromptParent.PurchasePromptLite)
local ProductPurchaseSurface = PurchasePromptLite.Enums.ProductPurchaseSurface
local getTTIEventName = PurchasePromptLite.getTTIEventName
local TimeToInteractiveTracker = require(PurchasePromptParent.TimeToInteractiveTracker).TimeToInteractiveTracker
local getPurchaseSurface = require(PurchasePrompt.Utils.getPurchaseSurface)
local getProductTypeFromRequestType = require(PurchasePrompt.Utils.getProductTypeFromRequestType)

local function trackInExperiencePurchaseStart(arg1)
    local state = arg1:getState()
    if getPurchaseSurface(state.purchaseAnalyticsMetadata) ~= ProductPurchaseSurface.InExperience then
        return
    end

    local tTiEventName = getTTIEventName(ProductPurchaseSurface.InExperience)
    TimeToInteractiveTracker.trackStart(tTiEventName)
    TimeToInteractiveTracker.updateMetadata(tTiEventName, {
        page = ProductPurchaseSurface.InExperience,
        category = "unified_purchase_modal",
        subcategory = getProductTypeFromRequestType(state.promptRequest.requestType)
    })
end

return trackInExperiencePurchaseStart
