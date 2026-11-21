-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")

local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent
local React = require(AvatarExperienceCatalogParent.React)

local useCheckoutActionBarProps = require(AvatarExperienceCatalog.Components.Checkout.useCheckoutActionBarProps)
local CheckoutActionBar = require(AvatarExperienceCatalog.Components.Checkout.CheckoutActionBar)

local var1 = React.forwardRef(function(arg1, arg2)
    local var1 = useCheckoutActionBarProps(arg1, arg2)
    return React.createElement(CheckoutActionBar, var1)
end)

return React.memo(var1)
