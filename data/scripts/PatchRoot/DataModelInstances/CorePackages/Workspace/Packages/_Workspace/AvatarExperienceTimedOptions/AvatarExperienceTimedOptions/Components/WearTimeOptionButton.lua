-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:11:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceTimedOptionsParent = script:FindFirstAncestor("AvatarExperienceTimedOptions").Parent

local _AvatarExperienceCommon = require(AvatarExperienceTimedOptionsParent.AvatarExperienceCommon)
local AvatarExperienceFlags = require(AvatarExperienceTimedOptionsParent.AvatarExperienceFlags)
local React = require(AvatarExperienceTimedOptionsParent.React)
local useLocalization = require(AvatarExperienceTimedOptionsParent.Localization).Hooks.useLocalization
local Foundation = require(AvatarExperienceTimedOptionsParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local FoundationText = Foundation.Text
local Enums = Foundation.Enums

local FFlagAXDurables2Option = AvatarExperienceFlags.FFlagAXDurables2Option

return (React.forwardRef(function(tbl1, _)
    local var1 = useTokens()

    local var2 = useLocalization({
        infinite = "Feature.Durables.ItemDetails.WearTimeOptions.Button.Infinite",
        xDay = {
            "Feature.Durables.ItemDetails.WearTimeOptions.Button.XDay",
            num = tbl1.option.days
        },
        xDays = {
            "Feature.Durables.ItemDetails.WearTimeOptions.Button.XDays",
            num = tbl1.option.days
        },
        buy = if FFlagAXDurables2Option then "Feature.Catalog.Action.Buy" else nil,
        rent = if FFlagAXDurables2Option then "Feature.Catalog.Action.Rent" else nil
    })
    local var3

    if tbl1.option.days == 0 then
        if FFlagAXDurables2Option then
            var3 = var2.buy
        else
            var3 = var2.infinite
        end
    elseif tbl1.option.days == 1 then
        if FFlagAXDurables2Option then
            var3 = var2.rent
        else
            var3 = var2.xDay
        end
    elseif FFlagAXDurables2Option then
        var3 = var2.rent
    else
        var3 = var2.xDays
    end

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        tag = {
            ["row align-y-center gap-small padding-medium radius-medium stroke-standard"] = true,
            ["align-x-center"] = if FFlagAXDurables2Option then tbl1.isFullWidth else nil,
            ["stroke-thick"] = tbl1.option.selected,
            ["stroke-system-contrast"] = tbl1.option.selected,
            ["stroke-emphasis"] = not tbl1.option.selected
        },
        onActivated = tbl1.onActivated,
        AutomaticSize = if FFlagAXDurables2Option and tbl1.isFullWidth then Enum.AutomaticSize.None else Enum.AutomaticSize.X,
        Size = if FFlagAXDurables2Option and tbl1.isFullWidth then UDim2.new(1, 0, 0, var1.Size.Size_800) else UDim2.new(0, 0, 0, var1.Size.Size_1000),
        stateLayer = {
            affordance = Enums.StateLayerAffordance.None
        },
        selection = { Selectable = true }
    }

    local tbl3 = {
        DaysLabel = React.createElement(FoundationText, {
            tag = "auto-xy text-title-small content-emphasis",
            Text = var3,
            RichText = if FFlagAXDurables2Option then true else nil,
            LayoutOrder = 1,
            selection = { Selectable = false }
        }),
        PriceTag = 0,
        OriginalPriceTag = 0
    }
    local createElement2 = React.createElement
    local view2 = Foundation.View
    local tbl4 = {
        tag = if FFlagAXDurables2Option then "row align-y-center gap-xxsmall auto-xy" else "row align-y-center gap-xsmall auto-xy",
        LayoutOrder = 2
    }

    local tbl5 = {
        RobuxIcon = React.createElement(
            Foundation.Icon,
            {
                name = Enums.IconName.Robux,
                variant = Enums.IconVariant.Filled,
                size = Enums.IconSize.XSmall,
                LayoutOrder = 1
            }
        ),
        PriceLabel = 0
    }

    local createElement3 = React.createElement
    local var4 = FoundationText
    local tbl6 = {
        tag = "auto-xy text-body-small",
        Text = if FFlagAXDurables2Option and tbl1.option.selected and tbl1.option.priceInRobuxDiscountedByOffers then tostring(tbl1.option.priceInRobuxDiscountedByOffers) else tostring(tbl1.option.price),
        LayoutOrder = 2,
        selection = { Selectable = false }
    }
    tbl5.PriceLabel = createElement3(var4, tbl6)
    tbl3.PriceTag = createElement2(view2, tbl4, tbl5)
    local var6

    if FFlagAXDurables2Option
        and (tbl1.option.discountInformation
            or tbl1.option.priceInRobuxDiscountedByOffers
                and tbl1.option.selected
                and tbl1.option.priceInRobuxDiscountedByOffers < tbl1.option.price)
    then
        local createElement4 = React.createElement
        local view3 = Foundation.View
        local tbl7 = { tag = "auto-xy", LayoutOrder = 3 }

        local tbl8 = { PriceContent = 0, Strikethrough = 0 }
        local createElement5 = React.createElement
        local view4 = Foundation.View
        local tbl9 = { tag = "row align-y-center gap-xxsmall auto-xy" }

        local tbl10 = {
            RobuxIcon = React.createElement(Foundation.Icon, {
                name = Enums.IconName.Robux,
                variant = Enums.IconVariant.Filled,
                size = Enums.IconSize.XSmall,
                style = var1.Color.Content.Muted,
                LayoutOrder = 1
            }),
            PriceLabel = 0
        }

        local createElement6 = React.createElement
        local var7 = FoundationText
        local tbl11 = {
            tag = "auto-xy text-body-small content-muted",
            Text = if tbl1.option.discountInformation then tostring(tbl1.option.discountInformation.originalPrice) else tostring(tbl1.option.price),
            LayoutOrder = 2,
            selection = { Selectable = false }
        }
        tbl10.PriceLabel = createElement6(var7, tbl11)
        tbl8.PriceContent = createElement5(view4, tbl9, tbl10)

        tbl8.Strikethrough = React.createElement(
            Foundation.View,
            {
                tag = "position-center-center anchor-center-center bg-system-neutral",
                Size = UDim2.new(1, 0, 0, 1)
            }
        )
        var6 = createElement4(view3, tbl7, tbl8)
    else
        var6 = nil
    end

    tbl3.OriginalPriceTag = var6
    return createElement(view, tbl2, tbl3)
end))
