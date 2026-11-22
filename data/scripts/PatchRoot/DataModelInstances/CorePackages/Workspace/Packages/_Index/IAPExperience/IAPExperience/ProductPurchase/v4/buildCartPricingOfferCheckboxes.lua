-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:20:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local React = require(scriptParentParentParentParent.React)

local OfferCheckboxRow = require(script.Parent.OfferCheckboxRow)

local _useCartPricing = require(script.Parent.useCartPricing)

local function buildCartPricingOfferCheckboxes(tbl1)
    local cartPricing = tbl1.cartPricing
    local cartPricingOfferCheckboxes = ({})

    if not cartPricing.showCartOfferUi then
        return cartPricingOfferCheckboxes
    end

    for layoutOrder, cartPricingOffer in cartPricing.cartPricingOffers do
        local offerId = cartPricingOffer.offerId
        local var1 = "CartPricingOffer_" .. offerId
        local createElement = React.createElement
        local var2 = OfferCheckboxRow
        local tbl2 = {
            LayoutOrder = layoutOrder,
            label = cartPricingOffer.localizedDescription,
            isChecked = cartPricingOffer.selected,
            isDisabled = tbl1.isDisabled,
            expirationTimeUtc = cartPricingOffer.expirationTimeUtc,
            onActivated = 0
        }

        function tbl2.onActivated()
            cartPricing.toggleCartPricingOffer(offerId)
        end

        cartPricingOfferCheckboxes[var1] = createElement(var2, tbl2)
    end

    return cartPricingOfferCheckboxes
end

return buildCartPricingOfferCheckboxes
