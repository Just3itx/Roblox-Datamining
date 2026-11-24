-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:10:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local React = require(InExperienceShopParent.React)
local Foundation = require(InExperienceShopParent.Foundation)
local useLocalization = require(InExperienceShopParent.Localization).Hooks.useLocalization

local View = Foundation.View
local FoundationText = Foundation.Text
local Image = Foundation.Image
local Icon = Foundation.Icon
local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize
local IconSize = Foundation.Enums.IconSize

local formatPrice = require(InExperienceShop.Utils.formatPrice)
local MEDIA_HEIGHT_SCALE_FALLBACK = require(InExperienceShop.Components.computeShopRowTileWidths).MEDIA_HEIGHT_SCALE_FALLBACK

local uDim2 = UDim2.fromOffset(50, 50)

local tbl1 = {
    buy = "Feature.Catalog.Action.Buy",
    bonusItem = "Feature.InExperienceShop.Label.BonusItem",
    robux = "Feature.Home.Robux"
}

local function getTitleText(bool1: boolean?, str1: string, bonusItem: string): string -- Luacid: Inlined by compiler; 1 call site recovered
    if bool1 then
        return `{str1} + {bonusItem}`
    end

    return str1
end

local function renderMediaContent(tbl2)
    local var1 = formatPrice(tbl2.robuxAmount)
    local bool1 = tbl2.hasBonusItem == true

    return {
        RobuxGroup = React.createElement(
            View,
            {
                tag = "row align-y-center gap-xsmall auto-xy",
                testId = "RobuxPackageTile-RobuxGroup",
                LayoutOrder = 1
            },
            {
                RobuxIcon = React.createElement(
                    Icon,
                    {
                        name = tbl2.robuxImage,
                        size = IconSize.Medium,
                        testId = "RobuxPackageTile-RobuxIcon",
                        LayoutOrder = 1
                    }
                ),
                RobuxAmount = React.createElement(FoundationText, {
                    tag = "auto-xy text-heading-medium content-emphasis",
                    Text = var1,
                    testId = "RobuxPackageTile-MediaRobuxAmount",
                    LayoutOrder = 2
                })
            }
        ),
        PlusSign = if bool1 and tbl2.bonusItemThumbnail then React.createElement(FoundationText, {
            tag = "auto-xy text-heading-medium content-emphasis",
            Text = "+",
            testId = "RobuxPackageTile-PlusSign",
            LayoutOrder = 2
        }) else nil,
        BonusItemImage = if bool1 and tbl2.bonusItemThumbnail then React.createElement(Image, {
            tag = "radius-medium bg-shift-200",
            Size = uDim2,
            Image = tbl2.bonusItemThumbnail,
            ScaleType = Enum.ScaleType.Fit,
            testId = "RobuxPackageTile-BonusItemImage",
            LayoutOrder = 3
        }) else nil
    }
end

return React.memo(function(tbl2) -- name: RobuxPackageTile
    local var1 = useLocalization(tbl1)
    local hasBonusItem = tbl2.hasBonusItem
    local robux = var1.robux
    local bonusItem = var1.bonusItem

    if hasBonusItem then
        robux = getTitleText(true, robux, bonusItem)
    end

    local yScale = tbl2.mediaHeightScale or MEDIA_HEIGHT_SCALE_FALLBACK

    local createElement = React.createElement
    local var2 = View
    local tbl3 = {
        tag = "col fill size-full-0 auto-y radius-medium clip bg-shift-200",
        testId = "RobuxPackageTile",
        LayoutOrder = tbl2.LayoutOrder,
        onActivated = tbl2.onTileActivated
    }
    local tbl4 = {
        MediaWrapper = React.createElement(View, {
            tag = "row align-x-center align-y-center gap-small size-full-0 bg-shift-200",
            Size = UDim2.fromScale(1, yScale),
            SizeConstraint = Enum.SizeConstraint.RelativeXX,
            testId = "RobuxPackageTile-MediaWrapper",
            LayoutOrder = 1
        }, (renderMediaContent(tbl2))),
        TileContent = 0
    }
    local createElement2 = React.createElement
    local var3 = View
    local tbl5 = { tag = "col gap-medium size-full-0 auto-y padding-medium", LayoutOrder = 2 }

    local tbl6 = {
        ContentHeader = React.createElement(View, {
            tag = "col size-full-0 auto-y",
            LayoutOrder = 1
        }, {
            Title = React.createElement(FoundationText, {
                tag = "size-full-0 auto-y text-title-medium text-align-x-left text-truncate-end content-emphasis",
                Text = robux,
                testId = "RobuxPackageTile-Title",
                LayoutOrder = 1
            }),
            RobuxAmount = React.createElement(
                View,
                {
                    tag = "row align-y-center auto-xy",
                    testId = "RobuxPackageTile-RobuxAmount",
                    LayoutOrder = 2
                },
                {
                    PriceLabel = React.createElement(FoundationText, {
                        tag = "auto-xy text-body-medium text-truncate-end content-default",
                        Text = tbl2.currencyAmountStr,
                        testId = "RobuxPackageTile-PriceLabel",
                        LayoutOrder = 1
                    })
                }
            )
        }),
        Footer = React.createElement(Button, {
            text = var1.buy,
            variant = if tbl2.isPrimaryRobuxPackage == true then ButtonVariant.SoftEmphasis else ButtonVariant.Standard,
            size = InputSize.Small,
            width = UDim.new(1, 0),
            onActivated = tbl2.onBuyActivated or function() end,
            isLoading = tbl2.isBuyLoading,
            testId = "RobuxPackageTile-BuyButton",
            LayoutOrder = 2
        })
    }
    tbl4.TileContent = createElement2(var3, tbl5, tbl6)
    return createElement(var2, tbl3, tbl4)
end)
