-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:50:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local React = require(AvatarExperienceCatalogParent.React)
local Foundation = require(AvatarExperienceCatalogParent.Foundation)
local AvatarExperienceCommon = require(AvatarExperienceCatalogParent.AvatarExperienceCommon)
local Responsive = require(AvatarExperienceCatalogParent.Responsive)
local useLocalization = require(AvatarExperienceCatalogParent.Localization).Hooks.useLocalization
local useSelector = require(AvatarExperienceCatalogParent.RoactUtils).Hooks.RoactRodux.useSelector

local Constants = AvatarExperienceCommon.Constants
local SharedFlags = require(AvatarExperienceCatalogParent.SharedFlags)
local FFlagStackedBottomNavMarketplaceCTA = SharedFlags.FFlagStackedBottomNavMarketplaceCTA
local FFlagAXFixBottomNavCTAHeight = SharedFlags.FFlagAXFixBottomNavCTAHeight
local FFlagEnableSplitPane = SharedFlags.FFlagEnableSplitPane
local Constants2 = require(AvatarExperienceCatalogParent.AppSystemBar).Constants
local useNavBarSize = require(AvatarExperienceCatalogParent.AppNavBar).useNavBarSize
local SplitPaneStore = if FFlagEnableSplitPane then require(AvatarExperienceCatalogParent.SplitPane).SplitPaneStore else nil
local useSignalState = if FFlagEnableSplitPane then require(AvatarExperienceCatalogParent.SignalsReact).useSignalState else nil

local function selectDeviceOrientation(arg1)
    return arg1.DeviceOrientation
end

local var1 = React.forwardRef(function(tbl1, ref)
    local var1 = Foundation.Hooks.useTokens()
    local var2 = if FFlagStackedBottomNavMarketplaceCTA and not FFlagAXFixBottomNavCTAHeight then useNavBarSize() else nil
    local var3 = if FFlagEnableSplitPane then useSignalState(SplitPaneStore.getStore().getIsBreakpointEnabled) else false
    local xScale = if FFlagEnableSplitPane then useSignalState(SplitPaneStore.getStore().getSupportWidthFraction) else nil
    local var4 = useSelector(selectDeviceOrientation)
    if FFlagEnableSplitPane and var3 then
        var4 = Responsive.Keys.Landscape
    end
    local bool1 = var4 == Responsive.Keys.Portrait

    local var5 = useLocalization({
        checkoutItemSingular = "Feature.Catalog.Action.CheckoutSingular",
        checkoutItemPlural = {
            "Feature.Catalog.Action.CheckoutPlural",
            count = tbl1.itemCount
        },
        checkoutButtonFtuxTooltip = "Feature.Catalog.Label.Checkout.CheckoutButtonFtuxTooltip"
    })

    local var6 = React.useRef(nil)

    local var7 = React.useMemo(function(): UDim2
        if bool1 then
            return UDim2.fromScale(1, 0)
        end

        if not FFlagEnableSplitPane then
            return UDim2.fromScale(Constants.LANDSCAPE_SCENE_WIDTH_PERCENTAGE, 0)
        end

        local xScale2 = if var3 then xScale else Constants.LANDSCAPE_SCENE_WIDTH_PERCENTAGE
        return UDim2.fromScale(xScale2, 0)
    end, { bool1, var3, xScale })

    local var8 = React.useMemo(function(): UDim2
        if bool1 then
            return UDim2.fromScale(0, 1)
        end

        if not FFlagEnableSplitPane then
            return UDim2.fromScale(Constants.LANDSCAPE_UI_WIDTH_PERCENTAGE, 1)
        end

        local xScale2 = if var3 then 1 - xScale else Constants.LANDSCAPE_UI_WIDTH_PERCENTAGE
        return UDim2.fromScale(xScale2, 1)
    end, { bool1, var3, xScale })

    local var9 = if FFlagStackedBottomNavMarketplaceCTA then React.useMemo(function()
        if not tbl1.footerVisibilityBinding then
            return var8
        end

        return (tbl1.footerVisibilityBinding:map(function(arg1)
            if not FFlagAXFixBottomNavCTAHeight then
                return var8 + UDim2.new(0, 0, 0, -(var2 - 8) * arg1)
            end

            local num1 = math.max(0, Constants2.BOTTOM_BAR_SIZE * arg1 - 8)
            return var8 + UDim2.new(0, 0, 0, -num1)
        end))
    end, { var8, tbl1.footerVisibilityBinding, var2 }) else var8

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        tag = "row items-center gap-medium auto-y padding-y-large padding-x-xlarge bg-surface-0 anchor-bottom-left",
        testId = if FFlagEnableSplitPane then "CheckoutActionBar" else nil,
        ref = ref,
        Visible = tbl1.Visible,
        Size = var7,
        Position = var9,
        ZIndex = 3,
        onAbsoluteSizeChanged = tbl1.onAbsoluteSizeChanged
    }
    local tbl3 = {
        ActionButton = React.createElement(Foundation.Button, {
            text = if tbl1.itemCount <= 1 then var5.checkoutItemSingular else var5.checkoutItemPlural,
            onActivated = tbl1.onCheckoutButtonActivated,
            variant = Foundation.Enums.ButtonVariant.Emphasis,
            size = Foundation.Enums.ButtonSize.Medium,
            fillBehavior = Foundation.Enums.FillBehavior.Fill,
            LayoutOrder = 1,
            ref = var6
        }),
        ActionButtonPopover = 0,
        ClearButton = 0
    }
    local createElement2 = React.createElement
    local root = Foundation.Popover.Root
    local tbl4 = {
        isOpen = tbl1.showCheckoutButtonTooltip
    }
    local tbl5 = {
        Anchor = React.createElement(Foundation.Popover.Anchor, { anchorRef = var6 }),
        Content = 0
    }
    local createElement3 = React.createElement
    local content = Foundation.Popover.Content
    local tbl6 = {
        align = Foundation.Enums.PopoverAlign.Center,
        side = Foundation.Enums.PopoverSide.Top,
        radius = Foundation.Enums.Radius.Medium,
        backgroundStyle = var1.Color.System.Contrast
    }
    local tbl7 = { PopCoverContent = 0 }
    local createElement4 = React.createElement
    local view2 = Foundation.View

    local tbl8 = { CategoryButtonTooltipTitle = 0 }
    local createElement5 = React.createElement
    local foundationText = Foundation.Text
    local tbl9 = {
        Text = var5.checkoutButtonFtuxTooltip,
        tag = "auto-xy text-title-medium text-truncate-end content-inverse-emphasis"
    }
    local tbl10 = {
        TooltipOverlayButton = React.createElement(
            "TextButton",
            {
                Transparency = 1,
                [React.Event.Activated] = tbl1.onTooltipButtonActivated,
                Size = UDim2.fromScale(1, 1)
            }
        )
    }
    tbl8.CategoryButtonTooltipTitle = createElement5(foundationText, tbl9, tbl10)
    tbl7.PopCoverContent = createElement4(view2, { tag = "col gap-xsmall padding-y-small padding-x-medium auto-xy" }, tbl8)
    tbl5.Content = createElement3(content, tbl6, tbl7)
    tbl3.ActionButtonPopover = createElement2(root, tbl4, tbl5)

    tbl3.ClearButton = React.createElement(Foundation.Button, {
        icon = "trash-can",
        onActivated = tbl1.onClearButtonActivated,
        variant = Foundation.Enums.ButtonVariant.Standard,
        size = Foundation.Enums.ButtonSize.Medium,
        LayoutOrder = 2
    })
    return createElement(view, tbl2, tbl3)
end)

return React.memo(var1)
