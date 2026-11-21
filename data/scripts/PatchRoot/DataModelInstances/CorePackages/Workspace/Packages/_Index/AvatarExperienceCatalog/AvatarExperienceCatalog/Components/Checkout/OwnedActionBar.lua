-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local React = require(AvatarExperienceCatalogParent.React)
local Foundation = require(AvatarExperienceCatalogParent.Foundation)
local Localization = require(AvatarExperienceCatalogParent.Localization)
local AvatarExperienceFlags = require(AvatarExperienceCatalogParent.AvatarExperienceFlags)

local useLocalization = Localization.Hooks.useLocalization

local FFlagAXShowMoreButtonOnOwnedItems = AvatarExperienceFlags.FFlagAXShowMoreButtonOnOwnedItems

local var1 = React.forwardRef(function(tbl1, ref)
    local var1 = Foundation.Hooks.useTokens()
    local uDim2 = UDim2.fromScale(1, 0)
    local uDim2_2 = UDim2.fromScale(0, 1)

    local var2 = useLocalization({ manageInCustomize = "Feature.Catalog.Action.Checkout.ManageInCustomize" })

    return React.createElement(Foundation.View, {
        tag = {
            ["row items-center gap-medium anchor-bottom-left size-full-0 auto-y padding-x-xlarge padding-y-large bg-surface-0"] = FFlagAXShowMoreButtonOnOwnedItems,
            ["row items-center auto-y size-full-0 padding-y-large padding-x-xlarge bg-surface-0 anchor-bottom-left"] = not FFlagAXShowMoreButtonOnOwnedItems
        },
        ref = ref,
        backgroundStyle = {
            Color3 = var1.Color.Surface.Surface_0.Color3,
            Transparency = var1.Color.Surface.Surface_0.Transparency
        },
        Size = uDim2,
        Position = uDim2_2,
        ZIndex = 3
    }, {
        ActionButton = React.createElement(Foundation.Button, {
            text = var2.manageInCustomize,
            onActivated = tbl1.onActivated,
            variant = Foundation.Enums.ButtonVariant.Standard,
            size = Foundation.Enums.ButtonSize.Medium,
            fillBehavior = Foundation.Enums.FillBehavior.Fill,
            LayoutOrder = if FFlagAXShowMoreButtonOnOwnedItems then 1 else nil
        }),
        MoreButton = if FFlagAXShowMoreButtonOnOwnedItems and tbl1.onMoreButtonActivated then React.createElement(
            Foundation.Button,
            {
                icon = "circle-three-dots-horizontal",
                onActivated = tbl1.onMoreButtonActivated,
                variant = Foundation.Enums.ButtonVariant.Standard,
                size = Foundation.Enums.ButtonSize.Medium,
                LayoutOrder = 2
            }
        ) else nil
    })
end)

return React.memo(var1)
