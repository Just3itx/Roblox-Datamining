-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:11:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local React = require(scriptParentParentParent.React)

local Foundation = require(scriptParentParentParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text

local LocalizationService = game:GetService("LocalizationService")

local formatNumber = require(scriptParentParent.Utility.formatNumber)

local FFlagUnifiedPurchaseFlowMarketplaceUIImprovements = require(scriptParentParent.Parent.SharedFlags).FFlagUnifiedPurchaseFlowMarketplaceUIImprovements

local useRobuxText = require(scriptParentParent.Generic.Hooks.useRobuxText)

local function UnifiedPurchaseModalHeader(tbl1)
    local var1 = React.useMemo(function()
        return utf8.char(57346) .. " " .. formatNumber(LocalizationService.RobloxLocaleId, tbl1.robuxBalanceAmount or 0)
    end, { tbl1.robuxBalanceAmount, LocalizationService.RobloxLocaleId })

    if FFlagUnifiedPurchaseFlowMarketplaceUIImprovements then
        var1 = useRobuxText(tbl1.robuxBalanceAmount or 0)
    end
    return React.createElement(View, { tag = "auto-xy align-y-center align-x-start row" }, {
        LeftSide = React.createElement(
            View,
            {
                LayoutOrder = 1,
                tag = "row gap-small align-y-center align-x-start",
                Size = UDim2.new(0.5, 0, 1, 0)
            },
            {
                RobuxAmount = React.createElement(
                    FoundationText,
                    {
                        LayoutOrder = 1,
                        Text = tbl1.titleText,
                        tag = "auto-xy text-heading-small content-default text-align-x-left"
                    }
                )
            }
        ),
        RightSide = if FFlagUnifiedPurchaseFlowMarketplaceUIImprovements and tbl1.hideUserRobuxBalance then nil else React.createElement(
            View,
            {
                LayoutOrder = 2,
                tag = "row align-y-center align-x-right gap-large",
                Size = UDim2.new(0.5, 0, 1, 0)
            },
            {
                RobuxPrice = React.createElement(FoundationText, {
                    LayoutOrder = 2,
                    Text = var1,
                    tag = "auto-xy text-label-medium content-emphasis text-align-x-right",
                    RichText = if FFlagUnifiedPurchaseFlowMarketplaceUIImprovements then true else nil
                })
            }
        )
    })
end

return UnifiedPurchaseModalHeader
