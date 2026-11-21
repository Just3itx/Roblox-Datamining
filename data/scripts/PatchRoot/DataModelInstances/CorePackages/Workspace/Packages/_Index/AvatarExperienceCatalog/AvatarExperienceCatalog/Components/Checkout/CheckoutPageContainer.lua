-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")

local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent

local React = require(AvatarExperienceCatalogParent.React)

local CheckoutPage = require(AvatarExperienceCatalog.Components.Checkout.CheckoutPage)
local useCheckoutPageViewModel = require(AvatarExperienceCatalog.Components.Checkout.useCheckoutPageViewModel)

local function CheckoutPageContainer(arg1)
    local var1 = useCheckoutPageViewModel(arg1)
    return React.createElement(CheckoutPage, var1)
end

return CheckoutPageContainer
