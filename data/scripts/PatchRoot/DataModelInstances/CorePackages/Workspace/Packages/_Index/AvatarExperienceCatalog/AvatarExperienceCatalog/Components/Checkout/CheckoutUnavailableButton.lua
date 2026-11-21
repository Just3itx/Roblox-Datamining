-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:51:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local React = require(AvatarExperienceCatalogParent.React)
local tutils = require(AvatarExperienceCatalogParent.tutils)
local Foundation = require(AvatarExperienceCatalogParent.Foundation)

return React.memo(function(tbl1) -- name: CheckoutUnavailableButton
    return React.createElement(Foundation.View, {
        tag = "size-full-0 auto-y fill",
        LayoutOrder = tbl1.LayoutOrder
    }, {
        UnavailableButton = React.createElement(Foundation.Button, {
            text = tbl1.label,
            onActivated = tbl1.onActivated,
            variant = Foundation.Enums.ButtonVariant.Standard,
            size = Foundation.Enums.ButtonSize.Medium,
            fillBehavior = Foundation.Enums.FillBehavior.Fill
        })
    })
end, tutils.deepEqual)
