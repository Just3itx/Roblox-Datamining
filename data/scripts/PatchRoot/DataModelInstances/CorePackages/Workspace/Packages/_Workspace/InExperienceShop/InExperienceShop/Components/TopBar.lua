-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:11:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local React = require(InExperienceShopParent.React)
local Foundation = require(InExperienceShopParent.Foundation)
local useLocalization = require(InExperienceShopParent.Localization).Hooks.useLocalization

local shopOverflowConstants = require(InExperienceShop.Components.Shared.shopOverflowConstants)

local View = Foundation.View
local FoundationText = Foundation.Text
local IconButton = Foundation.IconButton
local Menu = Foundation.Menu
local IconName = Foundation.Enums.IconName
local IconVariant = Foundation.Enums.IconVariant
local InputSize = Foundation.Enums.InputSize
local ButtonVariant = Foundation.Enums.ButtonVariant
local PopoverSide = Foundation.Enums.PopoverSide
local PopoverAlign = Foundation.Enums.PopoverAlign
local Chip = Foundation.Chip
local ChipSize = Foundation.Enums.ChipSize
local ChipVariant = Foundation.Enums.ChipVariant

local OVERFLOW_ICON = shopOverflowConstants.OVERFLOW_ICON
local REPORT_ICON = shopOverflowConstants.REPORT_ICON
local REPORT_MENU_ITEM_ID = shopOverflowConstants.REPORT_MENU_ITEM_ID

local tbl1 = { title = "Feature.Avatar.Action.Shop", report = "Feature.Catalog.Action.Report" }

local function TopBar(tbl2)
    local var1 = useLocalization(tbl1)

    local items = {}
    if tbl2.isReportingEnabled then
        table.insert(items, { id = REPORT_MENU_ITEM_ID, icon = REPORT_ICON, text = var1.report })
    end

    local element

    if tbl2.isReportingEnabled then
        element = React.createElement(Menu, {
            isOpen = tbl2.isOverflowMenuOpen,
            items = items,
            size = InputSize.Medium,
            side = PopoverSide.Top,
            align = PopoverAlign.End,
            onPressedOutside = tbl2.onOverflowMenuClosed,
            onActivated = tbl2.onMenuItemActivated,
            LayoutOrder = 2,
            testId = "TopBar_OverflowMenu"
        }, {
            Trigger = React.createElement(IconButton, {
                icon = OVERFLOW_ICON,
                isCircular = false,
                size = InputSize.Medium,
                variant = ButtonVariant.Utility,
                onActivated = tbl2.onOverflowActivated,
                testId = "TopBar_OverflowButton"
            })
        })
    else
        element = nil
    end

    local createElement = React.createElement
    local var2 = View
    local tbl4 = {
        tag = "row flex-between align-y-center size-full-1200 padding-x-xlarge radius-medium bg-surface-0"
    }
    local tbl5 = {
        Leading = React.createElement(View, {
            tag = "row align-y-center gap-small auto-xy",
            LayoutOrder = 1
        }, {
            CloseButtonContainer = React.createElement(View, {
                tag = "auto-xy padding-top-xxsmall",
                LayoutOrder = 1
            }, {
                CloseButton = React.createElement(IconButton, {
                    icon = IconName.X,
                    isCircular = false,
                    size = InputSize.Medium,
                    variant = ButtonVariant.Utility,
                    onActivated = tbl2.onClose
                })
            }),
            Title = React.createElement(FoundationText, {
                tag = "size-0-1000 auto-x text-heading-small text-align-y-center content-emphasis",
                Text = var1.title,
                LayoutOrder = 2
            })
        }),
        Trailing = 0
    }

    local createElement2 = React.createElement
    local var3 = View
    local tbl6 = { tag = "row align-y-center gap-small auto-xy", LayoutOrder = 3 }

    local tbl7 = { OfferChip = 0, Overflow = 0, SearchButton = 0 }
    local element2

    if tbl2.showOfferChip then
        element2 = React.createElement(Chip, {
            text = tbl2.offerChipText,
            leading = {
                iconName = tbl2.offerChipIcon and IconName[tbl2.offerChipIcon] or IconName.Tag,
                iconVariant = IconVariant.Filled
            },
            size = ChipSize.Small,
            variant = ChipVariant.Standard,
            onActivated = tbl2.onOfferChipActivated,
            LayoutOrder = 1,
            testId = "OfferChip"
        })
    else
        element2 = nil
    end

    tbl7.OfferChip = element2

    tbl7.Overflow = element
    tbl7.SearchButton = React.createElement(IconButton, {
        icon = IconName.MagnifyingGlass,
        isCircular = false,
        size = InputSize.Medium,
        variant = ButtonVariant.Utility,
        onActivated = tbl2.onSearchOpen,
        LayoutOrder = 3,
        testId = "SearchButton"
    })
    tbl5.Trailing = createElement2(var3, tbl6, tbl7)
    return createElement(var2, tbl4, tbl5)
end

return TopBar
