-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:51:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local React = require(AvatarExperienceCatalogParent.React)
local Foundation = require(AvatarExperienceCatalogParent.Foundation)
local SharedFlags = require(AvatarExperienceCatalogParent.SharedFlags)
local useLocalization = require(AvatarExperienceCatalogParent.Localization).Hooks.useLocalization
local getIconRichText = Foundation.Utility.getIconRichText

local FFlagAXMISWithBlackbird = SharedFlags.FFlagAXMISWithBlackbird

local function CheckoutTotalLines(tbl1)
    local var1 = useLocalization({ totalItemsLabel = { "Feature.Catalog.Label.TotalItemsParenthesis", itemCount = tbl1.itemCount } })

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        tag = "size-full-0 auto-y col gap-small",
        LayoutOrder = if FFlagAXMISWithBlackbird then tbl1.LayoutOrder else nil
    }
    local tbl3 = { TotalLine = 0 }
    local createElement2 = React.createElement
    local view2 = Foundation.View
    local tbl4 = { tag = "size-full-0 auto-y fill flex-between items-center row gap-small" }

    local tbl5 = {
        ItemCount = React.createElement(
            Foundation.Text,
            {
                tag = "auto-xy text-title-medium content-emphasis",
                Text = var1.totalItemsLabel,
                LayoutOrder = 1
            }
        ),
        TotalPrice = 0
    }

    local createElement3 = React.createElement
    local view3 = Foundation.View
    local tbl6 = { tag = "auto-xy row items-center gap-small", LayoutOrder = 2 }

    local tbl7 = { OriginalPrice = 0, TotalPriceText = 0 }
    local element

    if tbl1.totalPrice and tbl1.totalOriginalPrice and tbl1.totalPrice < tbl1.totalOriginalPrice then
        element = React.createElement(Foundation.Text, {
            tag = "auto-xy text-title-small content-muted",
            Text = "<s>" .. `{getIconRichText(Foundation.Enums.IconName.Robux)} {tbl1.totalOriginalPrice}` .. "</s>",
            LayoutOrder = 1,
            RichText = true
        })
    else
        element = nil
    end

    tbl7.OriginalPrice = element

    tbl7.TotalPriceText = React.createElement(Foundation.Text, {
        tag = "auto-xy text-title-medium content-emphasis",
        Text = `{getIconRichText(Foundation.Enums.IconName.Robux)} {tbl1.totalPrice}`,
        LayoutOrder = 2,
        RichText = true
    })
    tbl5.TotalPrice = createElement3(view3, tbl6, tbl7)
    tbl3.TotalLine = createElement2(view2, tbl4, tbl5)
    return createElement(view, tbl2, tbl3)
end

return CheckoutTotalLines
