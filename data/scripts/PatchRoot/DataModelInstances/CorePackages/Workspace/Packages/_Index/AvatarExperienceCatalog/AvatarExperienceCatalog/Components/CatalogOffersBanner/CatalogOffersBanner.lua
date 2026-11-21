-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:50:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent
local React = require(AvatarExperienceCatalogParent.React)
local _Foundation = require(AvatarExperienceCatalogParent.Foundation)

local CatalogOffersBannerView = require(script.Parent.CatalogOffersBannerView)
local useCatalogOffersBannerViewModel = require(script.Parent.useCatalogOffersBannerViewModel)

local function CatalogOffersBanner(tbl1)
    local var1 = useCatalogOffersBannerViewModel(
        {
            Size = tbl1.Size,
            Position = tbl1.Position,
            onBannerVisibleChanged = tbl1.onOffersBannerVisibleChanged
        }
    )

    if var1.status == "hidden" then
        return nil
    elseif var1.modals then
        return React.createElement(
            React.Fragment,
            nil,
            {
                Banner = React.createElement(CatalogOffersBannerView, var1.viewProps),
                Modals = var1.modals
            }
        )
    end

    return React.createElement(CatalogOffersBannerView, var1.viewProps)
end

return CatalogOffersBanner
