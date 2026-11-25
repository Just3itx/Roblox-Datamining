-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:51:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local React = require(PurchasePromptParent.React)
local _IAPExperience = require(PurchasePromptParent.IAPExperience)

local PurchasePromptApp = require(PurchasePrompt.Components.PurchasePromptApp)
local SetPurchaseCallbacks = require(PurchasePrompt.Actions.SetPurchaseCallbacks)
local SetPostPurchaseActions = require(PurchasePrompt.Actions.SetPostPurchaseActions)
local SetProductPayload = require(PurchasePrompt.Actions.SetProductPayload)
local SetPurchaseAnalyticsMetadata = require(PurchasePrompt.Actions.SetPurchaseAnalyticsMetadata)
local SetPurchaseOptions = require(PurchasePrompt.Actions.SetPurchaseOptions)
local dispatchPurchaseForProductPayload = require(PurchasePrompt.Utils.dispatchPurchaseForProductPayload)
local _types = require(PurchasePrompt.types)
local SharedFlags = require(PurchasePromptParent.SharedFlags)

local FFlagAXSupportRentalPurchaseInUnifiedProductPurchaseFlow = SharedFlags.FFlagAXSupportRentalPurchaseInUnifiedProductPurchaseFlow
local FFlagPurchasePromptSubtitleForTimedOptions = SharedFlags.FFlagPurchasePromptSubtitleForTimedOptions

local _types2 = require(PurchasePrompt.types)

local function UnifiedPurchasePrompt(tbl1)
    local store = tbl1.store
    React.useEffect(function()
        local productPayload = tbl1.productPayload

        store:dispatch(SetProductPayload(productPayload))

        if tbl1.purchaseCallbacks then
            store:dispatch(SetPurchaseCallbacks(tbl1.purchaseCallbacks))
        end

        if tbl1.postPurchaseActions then
            store:dispatch(SetPostPurchaseActions(tbl1.postPurchaseActions))
        end

        if tbl1.purchaseAnalyticsMetadata then
            store:dispatch(
                SetPurchaseAnalyticsMetadata({
                    surface = tbl1.purchaseAnalyticsMetadata.surface,
                    productUniverseId = tbl1.purchaseAnalyticsMetadata.productUniverseId
                })
            )
        end
        if FFlagAXSupportRentalPurchaseInUnifiedProductPurchaseFlow and tbl1.purchaseOptions then
            store:dispatch(SetPurchaseOptions(tbl1.purchaseOptions))
        end

        dispatchPurchaseForProductPayload(function(arg1)
            store:dispatch(arg1)
        end, productPayload, nil, false)
    end, { tbl1.productPayload, tbl1.purchaseCallbacks, tbl1.postPurchaseActions })

    return React.createElement(PurchasePromptApp, {
        store = store,
        network = tbl1.network,
        subtitleView = if FFlagPurchasePromptSubtitleForTimedOptions then tbl1.subtitleView else nil
    })
end

return UnifiedPurchasePrompt
