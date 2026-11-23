-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:21:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent
local React = require(AvatarExperienceInspectAndBuyParent.React)
local Foundation = require(AvatarExperienceInspectAndBuyParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local shouldShowPriceLabel = require(AvatarExperienceInspectAndBuy.Utils.itemDetailsUtils).shouldShowPriceLabel
local _ButtonVariant = Foundation.Enums.ButtonVariant
local _PriceStatus = require(AvatarExperienceInspectAndBuy.Enums.PriceStatus)

local function BuyActionBar(tbl1)
    local var1 = useTokens()

    local var2 = React.useMemo(function()
        return shouldShowPriceLabel(tbl1.priceStatus)
    end, { tbl1.priceStatus })

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        tag = "size-full col gap-xsmall align-x-center padding-x-large padding-bottom-medium",
        LayoutOrder = 1
    }

    local tbl3 = { InfoFrame = 0, PurchaseButton = 0 }
    local var3

    if tbl1.priceLabel then
        local createElement2 = React.createElement
        local view2 = Foundation.View
        local tbl4 = {
            tag = "size-full-800 row flex-x-between align-y-center gap-small",
            BackgroundTransparency = 1,
            LayoutOrder = 1
        }

        local tbl5 = {
            PriceDescriptionLabel = React.createElement(Foundation.Text, {
                tag = "auto-xy text-title-medium content-emphasis text-truncate-end",
                Text = if var2 then tbl1.priceLabel.leftLabel else "",
                LayoutOrder = 1
            }),
            RobuxLabel = 0
        }
        local element

        if var2 then
            element = React.createElement(
                Foundation.View,
                { tag = "auto-xy row align-x-left align-y-center gap-xsmall", LayoutOrder = 2 },
                {
                    PriceText = React.createElement(Foundation.Text, {
                        tag = "auto-xy text-body-large content-emphasis text-truncate-end",
                        Text = tbl1.priceLabel.priceInRobux,
                        LayoutOrder = 2
                    }),
                    Robux = React.createElement(Foundation.Icon, {
                        name = "robux",
                        style = var1.Color.ActionStandard.Foreground,
                        size = Foundation.Enums.IconSize.Small,
                        LayoutOrder = 1
                    })
                }
            )
        else
            element = nil
        end

        tbl5.RobuxLabel = element
        var3 = createElement2(view2, tbl4, tbl5)
    else
        var3 = nil
    end

    tbl3.InfoFrame = var3

    tbl3.PurchaseButton = React.createElement(Foundation.Button, {
        size = Foundation.Enums.InputSize.Medium,
        fillBehavior = Foundation.Enums.FillBehavior.Fill,
        width = UDim.new(1, 0),
        text = tbl1.purchaseButtonProps.purchaseButtonText,
        variant = tbl1.purchaseButtonProps.variant,
        isDisabled = tbl1.purchaseButtonProps.isDisabled,
        onActivated = tbl1.purchaseButtonProps.onPurchase,
        LayoutOrder = 2
    })
    return createElement(view, tbl2, tbl3)
end

return BuyActionBar
