-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:10:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local React = require(scriptParentParentParent.React)

local Foundation = require(scriptParentParentParent.Foundation)
local FoundationText = Foundation.Text
local View = Foundation.View

local formatNumber = require(scriptParentParent.Utility.formatNumber)

local LocalizationService = game:GetService("LocalizationService")
local useLocalization = require(scriptParentParentParent.Localization).Hooks.useLocalization
local useRobuxText = require(scriptParentParent.Generic.Hooks.useRobuxText)

local FFlagUnifiedPurchaseFlowMarketplaceUIImprovements = require(scriptParentParent.Parent.SharedFlags).FFlagUnifiedPurchaseFlowMarketplaceUIImprovements

local _PricingTypes = require(scriptParentParent.ProductPurchase.PricingTypes)

return function(tbl1)
    local var1 = if tbl1.itemPrice then tbl1.itemPrice.priceInRobux else tbl1.amount
    local var2 = useLocalization({
        Total = "Feature.Catalog.Label.TotalUnformatted",
        TotalPrice = if FFlagUnifiedPurchaseFlowMarketplaceUIImprovements then "IAPExperience.PurchasePrompt.Label.TotalPriceV2" else nil
    })

    local var3 = React.useMemo(function()
        return utf8.char(57346) .. " " .. formatNumber(LocalizationService.RobloxLocaleId, var1 or 0)
    end, { var1, LocalizationService.RobloxLocaleId })
    if FFlagUnifiedPurchaseFlowMarketplaceUIImprovements then
        var3 = useRobuxText(var1)
    end

    local createElement = React.createElement
    local var4 = View
    local tbl2 = {
        tag = "size-full-1300 padding-left-xxsmall padding-right-xxsmall padding-top-small padding-bottom-large"
    }
    local tbl3 = { BorderContainer = 0 }
    local createElement2 = React.createElement
    local var5 = View
    local tbl4 = {
        tag = "auto-xy align-y-center align-x-center radius-medium padding-x-large row stroke-default padding-y-xsmall"
    }
    local tbl5 = { LeftSide = 0, RightSide = 0 }
    local createElement3 = React.createElement
    local var6 = View
    local tbl6 = {
        LayoutOrder = 1,
        tag = "row gap-small align-y-center align-x-start padding-y-xsmall",
        Size = UDim2.new(0.5, 0, 1, 0)
    }
    local tbl7 = {
        RobuxAmount = React.createElement(FoundationText, {
            LayoutOrder = 1,
            Text = if FFlagUnifiedPurchaseFlowMarketplaceUIImprovements then var2.TotalPrice else var2.Total,
            tag = if FFlagUnifiedPurchaseFlowMarketplaceUIImprovements then "auto-xy text-title-medium content-default text-align-x-left padding-y-xsmall" else "auto-xy text-label-medium content-default text-align-x-left padding-y-xsmall"
        })
    }
    tbl5.LeftSide = createElement3(var6, tbl6, tbl7)

    tbl5.RightSide = React.createElement(
        View,
        {
            LayoutOrder = 2,
            tag = "row align-y-center align-x-right gap-large padding-y-xsmall",
            Size = UDim2.new(0.5, 0, 1, 0)
        },
        {
            RobuxPrice = if FFlagUnifiedPurchaseFlowMarketplaceUIImprovements then React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = var3,
                tag = "auto-xy text-title-medium content-emphasis text-align-x-right padding-y-xsmall",
                RichText = true
            }) else React.createElement(
                FoundationText,
                {
                    LayoutOrder = 2,
                    Text = var3,
                    tag = "auto-xy text-label-medium content-emphasis text-align-x-right padding-y-xsmall"
                }
            )
        }
    )
    tbl3.BorderContainer = createElement2(var5, tbl4, tbl5)
    return createElement(var4, tbl2, tbl3)
end
