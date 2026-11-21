-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:50:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local React = require(AvatarExperienceCatalogParent.React)
local Foundation = require(AvatarExperienceCatalogParent.Foundation)
local getFoundationIconName = require(script.Parent.getFoundationIconName)
local AvatarExperienceFlags = require(AvatarExperienceCatalogParent.AvatarExperienceFlags)
local OfferExpiryBadge = require(AvatarExperienceCatalogParent.AvatarExperienceCommon).Components.OfferExpiryBadge

local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local IconVariant = Foundation.Enums.IconVariant
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize
local useTokens = Foundation.Hooks.useTokens

local FFlagAXUpdateOffersEndsUIWithBadge = AvatarExperienceFlags.FFlagAXUpdateOffersEndsUIWithBadge
local FFlagAXRemoveOfferBannerIcon = AvatarExperienceFlags.FFlagAXRemoveOfferBannerIcon

local function CatalogOffersBannerView(tbl1)
    local var1 = if FFlagAXUpdateOffersEndsUIWithBadge then useTokens() else nil
    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        tag = tbl1.rootTags,
        backgroundStyle = if FFlagAXUpdateOffersEndsUIWithBadge then tbl1.backgroundStyle else nil,
        Size = tbl1.Size,
        Position = tbl1.Position,
        testId = "CatalogOffersBanner"
    }
    local tbl3 = { BannerRow = 0 }
    local createElement2 = React.createElement
    local view2 = Foundation.View
    local tbl4 = {
        tag = if FFlagAXUpdateOffersEndsUIWithBadge then "row items-center gap-xsmall size-full-0 auto-y padding-x-medium padding-bottom-small padding-top-xsmall" else "row items-center gap-medium size-full-0 auto-y padding-x-medium padding-bottom-small padding-top-xsmall",
        LayoutOrder = 1
    }

    local tbl5 = { Leading = 0, Close = 0 }
    local var2

    if tbl1.offerModalTapAreaEnabled and tbl1.onOfferBannerActivated then
        local createElement3 = React.createElement
        local view3 = Foundation.View
        local tbl6 = {
            tag = "grow auto-y",
            LayoutOrder = 1,
            testId = "CatalogOffersBannerDirectApiTapArea"
        }

        local tbl7 = { HitTarget = 0 }
        local createElement4 = React.createElement
        local str1 = "TextButton"
        local tbl8 = {
            Text = "",
            AutoButtonColor = false,
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            Selectable = false,
            [React.Event.Activated] = tbl1.onOfferBannerActivated
        }
        local tbl9 = { TapInner = 0 }
        local createElement5 = React.createElement
        local view4 = Foundation.View
        local tbl10 = { tag = "row items-center gap-medium size-full-0 auto-y" }

        local tbl11 = { Icon = 0, Title = 0, ExpiryBadge = 0 }
        local element

        if FFlagAXRemoveOfferBannerIcon and not getFoundationIconName(tbl1.iconName) then
            element = nil
        else
            element = React.createElement(Foundation.Icon, {
                name = getFoundationIconName(tbl1.iconName),
                variant = IconVariant.Filled,
                size = IconSize.Large,
                style = if FFlagAXUpdateOffersEndsUIWithBadge then var1.Color.System.Contrast else tbl1.iconEmphasisStyle,
                AnchorPoint = Vector2.new(0.5, 0.5),
                LayoutOrder = 1
            })
        end

        tbl11.Icon = element

        tbl11.Title = React.createElement(Foundation.Text, {
            Text = tbl1.titleText,
            RichText = true,
            textStyle = tbl1.titleContentEmphasisStyle,
            tag = "align-y-center grow auto-xy text-title-medium text-wrap text-align-x-left",
            LayoutOrder = 2
        })

        tbl11.ExpiryBadge = if FFlagAXUpdateOffersEndsUIWithBadge and tbl1.expirationTimeInUTC then React.createElement(OfferExpiryBadge, { layoutOrder = 3, expirationTimeInUTC = tbl1.expirationTimeInUTC }) else nil
        tbl9.TapInner = createElement5(view4, tbl10, tbl11)
        tbl7.HitTarget = createElement4(str1, tbl8, tbl9)
        var2 = createElement3(view3, tbl6, tbl7)
    else
        local createElement3 = React.createElement
        local view3 = Foundation.View
        local tbl6 = { tag = "row items-center grow gap-medium auto-y", LayoutOrder = 1 }

        local tbl7 = { Icon = 0, Title = 0 }
        local element

        if FFlagAXRemoveOfferBannerIcon and not getFoundationIconName(tbl1.iconName) then
            element = nil
        else
            element = React.createElement(Foundation.Icon, {
                name = getFoundationIconName(tbl1.iconName),
                variant = IconVariant.Regular,
                size = IconSize.Large,
                style = if FFlagAXUpdateOffersEndsUIWithBadge then var1.Color.System.Contrast else tbl1.iconEmphasisStyle,
                AnchorPoint = Vector2.new(0.5, 0.5),
                LayoutOrder = 1
            })
        end

        tbl7.Icon = element

        tbl7.Title = React.createElement(Foundation.Text, {
            Text = tbl1.titleText,
            RichText = true,
            textStyle = tbl1.titleContentEmphasisStyle,
            tag = "align-y-center grow auto-xy text-title-medium text-wrap text-align-x-left",
            LayoutOrder = 2
        })
        var2 = createElement3(view3, tbl6, tbl7)
    end

    tbl5.Leading = var2

    tbl5.Close = React.createElement(Foundation.View, {
        tag = "row items-center auto-xy",
        LayoutOrder = 2,
        ZIndex = 2
    }, {
        CloseButton = React.createElement(Foundation.IconButton, {
            icon = IconName.XSmall,
            isCircular = true,
            variant = ButtonVariant.Utility,
            size = InputSize.Small,
            onActivated = tbl1.onCloseActivated,
            testId = "CatalogOffersBannerClose"
        })
    })
    tbl3.BannerRow = createElement2(view2, tbl4, tbl5)
    return createElement(view, tbl2, tbl3)
end

return CatalogOffersBannerView
