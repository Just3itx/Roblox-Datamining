-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:01:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local React = require(InExperienceShopParent.React)
local Foundation = require(InExperienceShopParent.Foundation)
local VerifiedBadges = require(InExperienceShopParent.VerifiedBadges)
local useLocalization = require(InExperienceShopParent.Localization).Hooks.useLocalization

local _Types = require(InExperienceShop.Types)

local formatPrice = require(InExperienceShop.Utils.formatPrice)

local View = Foundation.View
local FoundationText = Foundation.Text
local Image = Foundation.Image
local Icon = Foundation.Icon
local Button = Foundation.Button
local IconButton = Foundation.IconButton
local Divider = Foundation.Divider
local Menu = Foundation.Menu
local ButtonVariant = Foundation.Enums.ButtonVariant
local IconName = Foundation.Enums.IconName
local InputSize = Foundation.Enums.InputSize
local IconSize = Foundation.Enums.IconSize
local FillBehavior = Foundation.Enums.FillBehavior
local PopoverSide = Foundation.Enums.PopoverSide
local PopoverAlign = Foundation.Enums.PopoverAlign

local Constants = require(InExperienceShop.Constants)
local shopOverflowConstants = require(InExperienceShop.Components.Shared.shopOverflowConstants)
local _useShopReportOverflow = require(InExperienceShop.Hooks.useShopReportOverflow)

local OVERFLOW_ICON = shopOverflowConstants.OVERFLOW_ICON
local REPORT_ICON = shopOverflowConstants.REPORT_ICON
local REPORT_MENU_ITEM_ID = shopOverflowConstants.REPORT_MENU_ITEM_ID

local tbl1 = {
    owned = "Feature.Catalog.Label.Owned",
    buy = "Feature.Catalog.Action.Buy",
    try = "Feature.Catalog.Action.Try",
    total = "Feature.Catalog.Label.TotalUnformatted",
    category = "Feature.Catalog.Label.Category",
    updated = "Feature.GameDetails.Label.Updated",
    report = "Feature.Catalog.Action.Report",
    noDescription = "Feature.InExperienceShop.Label.NoDescription"
}

local function CreatorRow(tbl2)
    local creator = tbl2.creator
    local var1 = if creator.hasVerifiedBadge then creator.name .. VerifiedBadges.emoji.verified else creator.name
    return React.createElement(FoundationText, {
        tag = "size-full-0 auto-y text-body-large text-align-x-left text-truncate-end content-muted",
        Text = var1,
        LayoutOrder = tbl2.LayoutOrder,
        testId = "ItemDetailsView_CreatorRow"
    })
end

local function DetailRow(tbl2)
    return React.createElement(
        View,
        {
            tag = "row flex-x-between align-y-center size-full-0 auto-y padding-y-medium",
            LayoutOrder = tbl2.LayoutOrder
        },
        {
            Label = React.createElement(
                FoundationText,
                {
                    tag = "auto-xy text-body-medium content-muted",
                    Text = tbl2.label,
                    LayoutOrder = 1
                }
            ),
            Value = React.createElement(
                FoundationText,
                {
                    tag = "auto-xy text-caption-large content-emphasis",
                    Text = tbl2.value,
                    LayoutOrder = 2
                }
            )
        }
    )
end

local function ItemDetailsView(tbl2)
    local var1 = useLocalization(tbl1)
    local var2 = if tbl2.description ~= nil and tbl2.description ~= "" then tbl2.description else var1.noDescription
    local isDisabled = tbl2.isOwned == true
    local bool2 = tbl2.isBuyDisabled == true
    local bool3 = tbl2.price ~= nil
    local isCompact = tbl2.isCompact

    local tbl3 = {
        Category = React.createElement(DetailRow, { label = var1.category, value = tbl2.categoryLabel, LayoutOrder = 1 }),
        CategoryDivider = React.createElement(Divider, { LayoutOrder = 2 })
    }

    if tbl2.updated ~= nil and tbl2.updated ~= "" then
        tbl3.Updated = React.createElement(DetailRow, { label = var1.updated, value = tbl2.updated, LayoutOrder = 3 })

        tbl3.UpdatedDivider = React.createElement(Divider, { LayoutOrder = 4 })
    end

    local bool4 = not (tbl2.creator == nil or tbl2.creator.name == nil) and tbl2.creator.name ~= ""
    local titleBlock = React.createElement(View, {
        tag = "col gap-xxsmall size-full-0 auto-y",
        LayoutOrder = 1
    }, {
        Name = React.createElement(FoundationText, {
            tag = "size-full-0 auto-y text-heading-small text-align-x-left text-truncate-end content-emphasis",
            Text = tbl2.name,
            LayoutOrder = 1
        }),
        Creator = if bool4 then React.createElement(CreatorRow, { creator = tbl2.creator, LayoutOrder = 2 }) else nil
    })

    local description = React.createElement(FoundationText, {
        tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-default",
        Text = var2,
        LayoutOrder = 2
    })

    local detailsList = React.createElement(View, { tag = "col size-full-0 auto-y", LayoutOrder = 3 }, tbl3)

    local createElement = React.createElement
    local var3 = View
    local tbl4 = { tag = "row flex-x-between align-y-center size-full-0 auto-y", LayoutOrder = 2 }

    local tbl5 = {
        TotalLabel = React.createElement(
            FoundationText,
            {
                tag = "auto-xy text-title-medium content-emphasis",
                Text = var1.total,
                LayoutOrder = 1
            }
        ),
        Price = 0
    }
    local element4

    if bool3 then
        element4 = React.createElement(View, {
            tag = "row align-y-center gap-xsmall auto-xy",
            LayoutOrder = 2
        }, {
            RobuxIcon = React.createElement(Icon, { name = Constants.ROBUX_ICON, size = IconSize.Small, LayoutOrder = 1 }),
            PriceLabel = React.createElement(
                FoundationText,
                {
                    tag = "auto-xy text-body-medium content-default",
                    Text = formatPrice(tbl2.price),
                    LayoutOrder = 2
                }
            )
        })
    else
        element4 = nil
    end

    tbl5.Price = element4
    local totalRow = createElement(var3, tbl4, tbl5)

    local items = {}
    if tbl2.isReportingEnabled then
        table.insert(items, { id = REPORT_MENU_ITEM_ID, icon = REPORT_ICON, text = var1.report })
    end

    local element6

    if tbl2.isReportingEnabled then
        element6 = React.createElement(Menu, {
            isOpen = tbl2.isOverflowMenuOpen,
            items = items,
            size = InputSize.Medium,
            side = PopoverSide.Top,
            align = PopoverAlign.End,
            onPressedOutside = tbl2.onOverflowMenuClosed,
            onActivated = tbl2.onMenuItemActivated,
            LayoutOrder = 3,
            testId = "ItemDetailsView_OverflowMenu"
        }, {
            Trigger = React.createElement(IconButton, {
                icon = OVERFLOW_ICON,
                size = InputSize.Medium,
                variant = ButtonVariant.Standard,
                onActivated = tbl2.onOverflowActivated,
                testId = "ItemDetailsView_OverflowButton"
            })
        })
    else
        element6 = React.createElement(IconButton, {
            icon = OVERFLOW_ICON,
            size = InputSize.Medium,
            variant = ButtonVariant.Standard,
            onActivated = tbl2.onOverflowActivated,
            LayoutOrder = 3,
            testId = "ItemDetailsView_OverflowButton"
        })
    end

    local createElement2 = React.createElement
    local var4 = View
    local tbl7 = { tag = "row align-y-center gap-small size-full-0 auto-y", LayoutOrder = 3 }

    local tbl8 = {
        Buy = React.createElement(Button, {
            text = if isDisabled then var1.owned else var1.buy,
            variant = if isDisabled then ButtonVariant.Standard else ButtonVariant.Emphasis,
            size = InputSize.Medium,
            fillBehavior = FillBehavior.Fill,
            isDisabled = isDisabled or bool2 or tbl2.isActionDisabled == true,
            onActivated = tbl2.onBuyActivated,
            LayoutOrder = 1
        }),
        Try = 0,
        Overflow = 0
    }
    local var5

    if tbl2.showTry and not isDisabled then
        local createElement3 = React.createElement
        local var6 = Button
        local tbl9 = {
            text = var1.try,
            variant = ButtonVariant.Standard,
            size = InputSize.Medium,
            fillBehavior = FillBehavior.Fill,
            onActivated = tbl2.onTryActivated or function() end,
            isLoading = tbl2.isActionLoading,
            isDisabled = tbl2.isActionDisabled == true and tbl2.isActionLoading ~= true,
            LayoutOrder = 2
        }
        var5 = createElement3(var6, tbl9)
    else
        var5 = nil
    end

    tbl8.Try = var5

    tbl8.Overflow = element6
    local actionRow = createElement2(var4, tbl7, tbl8)

    local buyBar = React.createElement(
        View,
        {
            tag = "col gap-medium size-full-0 auto-y padding-x-large padding-y-medium",
            LayoutOrder = if isCompact then 3 else 2
        },
        {
            TopDivider = React.createElement(Divider, { LayoutOrder = 1 }),
            TotalRow = totalRow,
            ActionRow = actionRow
        }
    )
    local element8

    if isCompact then
        local preview = React.createElement(View, {
            tag = "col align-x-center size-full-0 auto-y padding-x-xlarge padding-bottom-medium padding-top-large",
            LayoutOrder = 1
        }, {
            Thumbnail = React.createElement(
                Image,
                {
                    tag = "radius-medium",
                    Size = UDim2.fromOffset(180, 180),
                    Image = tbl2.thumbnail,
                    ScaleType = Enum.ScaleType.Fit
                }
            )
        })
        local info = React.createElement(
            View,
            {
                tag = "col fill gap-large size-full-0 padding-x-xlarge padding-bottom-large",
                LayoutOrder = 2
            },
            { TitleBlock = titleBlock, Description = description, DetailsList = detailsList }
        )

        element8 = React.createElement(
            View,
            { tag = "col fill size-full-0", LayoutOrder = 2 },
            { Preview = preview, Info = info, BuyBar = buyBar }
        )
    else
        local leftPane = React.createElement(
            View,
            {
                tag = "col fill gap-large size-full padding-x-xlarge padding-y-large",
                LayoutOrder = 1
            },
            { TitleBlock = titleBlock, Description = description, DetailsList = detailsList }
        )

        local rightPane = React.createElement(View, {
            tag = "col",
            Size = UDim2.new(0, 236, 1, 0),
            LayoutOrder = 2
        }, {
            Preview = React.createElement(View, {
                tag = "fill size-full-0 padding-large",
                LayoutOrder = 1
            }, {
                Thumbnail = React.createElement(Image, { tag = "size-full radius-medium", Image = tbl2.thumbnail, ScaleType = Enum.ScaleType.Fit })
            }),
            BuyBar = buyBar
        })

        element8 = React.createElement(
            View,
            { tag = "row align-y-top fill size-full-0", LayoutOrder = 2 },
            { LeftPane = leftPane, RightPane = rightPane }
        )
    end

    return React.createElement(
        View,
        {
            tag = "col size-full",
            testId = "ItemDetailsView",
            onAbsoluteSizeChanged = tbl2.onAbsoluteSizeChanged
        },
        {
            TopBarRow = React.createElement(
                View,
                {
                    tag = "row align-y-center size-full-0 auto-y padding-x-medium padding-top-medium",
                    LayoutOrder = 1
                },
                {
                    BackButton = React.createElement(IconButton, {
                        icon = IconName.ChevronLargeLeft,
                        isCircular = true,
                        size = InputSize.Medium,
                        variant = ButtonVariant.Utility,
                        onActivated = tbl2.onClose,
                        LayoutOrder = 1,
                        testId = "ItemDetailsView_BackButton"
                    })
                }
            ),
            Body = element8
        }
    )
end
return ItemDetailsView
