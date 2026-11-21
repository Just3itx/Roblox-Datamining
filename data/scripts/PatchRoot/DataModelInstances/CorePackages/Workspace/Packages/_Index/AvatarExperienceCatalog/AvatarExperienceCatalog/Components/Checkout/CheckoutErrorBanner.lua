-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local React = require(AvatarExperienceCatalogParent.React)
local Foundation = require(AvatarExperienceCatalogParent.Foundation)

local useLocalization = require(AvatarExperienceCatalogParent.Localization).Hooks.useLocalization

return React.memo(function(tbl1) -- name: CheckoutErrorBanner
    local var1 = useLocalization({
        checkoutErrorTitleSingular = "Feature.Catalog.Title.Checkout.PurchaseFailedSingular",
        checkoutErrorTitlePlural = {
            "Feature.Catalog.Title.Checkout.PurchaseFailedPlural",
            count = tbl1.erroredItemCount
        },
        checkoutErrorDescription = "Feature.Catalog.Message.Checkout.PurchaseFailed"
    })

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        tag = "size-full-0 auto-y row gap-medium bg-surface-200 items-center radius-medium padding-large",
        testId = "CheckoutErrorBanner"
    }

    local tbl3 = {
        CheckoutErrorIcon = React.createElement(Foundation.Icon, {
            name = Foundation.Enums.IconName.TriangleExclamation,
            variant = Foundation.Enums.IconVariant.Filled,
            size = Foundation.Enums.InputSize.Large
        }),
        CheckoutTextRows = 0
    }
    local createElement2 = React.createElement
    local view2 = Foundation.View
    local tbl4 = { tag = "size-full-0 col gap-small fill auto-y" }

    local tbl5 = {
        CheckoutErrorTitle = React.createElement(Foundation.Text, {
            tag = "size-full-0 auto-y text-wrap fill text-label-medium text-align-x-left content-emphasis",
            Text = if tbl1.erroredItemCount == 1 then var1.checkoutErrorTitleSingular else var1.checkoutErrorTitlePlural
        }),
        CheckoutErrorDescription = React.createElement(Foundation.Text, {
            tag = "size-full-0 auto-y text-wrap fill text-body-medium text-align-x-left content-default",
            Text = var1.checkoutErrorDescription
        })
    }
    tbl3.CheckoutTextRows = createElement2(view2, tbl4, tbl5)
    return createElement(view, tbl2, tbl3)
end)
