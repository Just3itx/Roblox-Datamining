-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:21:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)

local Foundation = require(scriptParentParentParentParent.Foundation)
local View = Foundation.View
local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior
local Button = Foundation.Button
local Sheet = Foundation.Sheet
local useScaledValue = Foundation.Hooks.useScaledValue

local LocalizationService = game:GetService("LocalizationService")
local Localization = require(scriptParentParentParentParent.AppLocales).Localization
local Localization2 = require(scriptParentParentParentParent.Localization)
local LocalizationProvider = Localization2.LocalizationProvider
local useLocalization = Localization2.Hooks.useLocalization

local UnifiedProductDetails = require(scriptParentParentParent.Generic.UnifiedProductDetails)
local PriceSummary = require(scriptParentParentParent.Generic.PriceSummary)
local UnifiedPurchaseModalHeader = require(scriptParentParentParent.Generic.UnifiedPurchaseModalHeader)

local UnifiedPurchaseModalTypeEnum = require(scriptParentParentParent.Enums.UnifiedPurchaseModalTypeEnum)

local logger = require(scriptParentParentParent.Utility.logger)
local getAppContext = require(scriptParentParentParent.Utility.getAppContext)

local default = require(scriptParentParentParentParent.LoggingProtocol).default
local TooExpensiveUnifiedUpsellShownCounter = require(scriptParentParentParent.Generic.Events.TooExpensiveUpsellCounter).TooExpensiveUnifiedUpsellShownCounter

local useFocusNavigationRefs = require(scriptParentParentParent.Generic.Hooks.useFocusNavigationRefs)
local useInitialButtonDisableDelay = require(scriptParentParentParent.Generic.Hooks.useInitialButtonDisableDelay)

local UNIFIED_ROBUX_UPSELL_MODAL_TOO_EXPENSIVE_MIN_HEIGHT_PIXELS = require(scriptParentParentParent.Generic.Constants).UNIFIED_ROBUX_UPSELL_MODAL_TOO_EXPENSIVE_MIN_HEIGHT_PIXELS

local FFlagUnifiedPurchaseFlowMarketplaceUIImprovements = require(scriptParentParentParent.Parent.SharedFlags).FFlagUnifiedPurchaseFlowMarketplaceUIImprovements

local function UnifiedRobuxUpsellModalTooExpensive(tbl1)
    local var1 = useLocalization({
        NeedMoreRobux = "IAPExperience.RobuxUpsell.Text.NeedMoreRobux",
        ButtonCancel = "IAPExperience.InsufficientRobux.Action.Cancel",
        BuyRobux = "IAPExperience.InsufficientRobux.Action.BuyRobux"
    })

    local var2, ref = useFocusNavigationRefs(tbl1.buttons.cancelPurchaseActivated, nil)
    local isDisabled = useInitialButtonDisableDelay()

    React.useEffect(function()
        logger.debug({
            message = "Too Expensive Unified Upsell Modal Shown",
            screenHeight = tbl1.screenSize.Y,
            screenWidth = tbl1.screenSize.X,
            portrait = tbl1.screenSize.X < tbl1.screenSize.Y,
            appContext = getAppContext()
        })
        default:logRobloxTelemetryCounter(TooExpensiveUnifiedUpsellShownCounter, 1, {
            screenHeight = tbl1.screenSize.Y,
            screenWidth = tbl1.screenSize.X,
            portrait = tbl1.screenSize.X < tbl1.screenSize.Y,
            appContext = getAppContext()
        })
    end, {})
    local createElement = React.createElement
    local root = Sheet.Root
    local tbl2 = {
        onClose = tbl1.buttons.cancelPurchaseActivated,
        snapPoints = { useScaledValue(UNIFIED_ROBUX_UPSELL_MODAL_TOO_EXPENSIVE_MIN_HEIGHT_PIXELS), 0.8 },
        preferCenterSheet = true,
        ref = 0
    }
    if isDisabled then
        var2 = nil
    end

    tbl2.ref = var2
    local tbl3 = { Header = 0, Content = 0, Actions = 0 }
    local createElement2 = React.createElement
    local header = Sheet.Header
    local tbl4 = {
        hasCloseAffordance = if FFlagUnifiedPurchaseFlowMarketplaceUIImprovements then if tbl1.hideUserRobuxBalance then true else nil else nil
    }

    local tbl5 = {
        ModalHeader = React.createElement(UnifiedPurchaseModalHeader, {
            titleText = var1.NeedMoreRobux,
            robuxBalanceAmount = tbl1.balanceAmount,
            hideUserRobuxBalance = if FFlagUnifiedPurchaseFlowMarketplaceUIImprovements then tbl1.hideUserRobuxBalance else nil
        })
    }
    tbl3.Header = createElement2(header, tbl4, tbl5)

    local createElement3 = React.createElement
    local content = Sheet.Content
    local tbl6 = { LayoutOrder = 2 }

    local tbl7 = { SheetContentContainer = 0 }
    local createElement4 = React.createElement
    local var5 = View
    local tbl8 = {
        tag = "col gap-medium auto-y size-full-0 align-x-center align-y-start padding-bottom-medium"
    }
    local tbl9 = { ProductDetails = 0 }
    local element

    if tbl1.purchaseModalType == UnifiedPurchaseModalTypeEnum.MultiItem then
        element = React.createElement(PriceSummary, { amount = tbl1.product.itemRobuxCost })
    else
        element = React.createElement(UnifiedProductDetails, {
            layoutOrder = 1,
            isPortrait = tbl1.screenSize.X < tbl1.screenSize.Y,
            model = tbl1.product.model,
            itemIcon = tbl1.product.itemIcon,
            itemName = tbl1.product.itemName,
            itemRobuxCost = tbl1.product.itemRobuxCost
        })
    end

    tbl9.ProductDetails = element
    tbl7.SheetContentContainer = createElement4(var5, tbl8, tbl9)
    tbl3.Content = createElement3(content, tbl6, tbl7)

    local createElement5 = React.createElement
    local actions = Sheet.Actions
    local tbl10 = { LayoutOrder = 3 }
    local element2

    if tbl1.isQuest then
        element2 = React.createElement(Button, {
            text = var1.ButtonCancel,
            onActivated = tbl1.buttons.cancelPurchaseActivated,
            fillBehavior = FillBehavior.Fill,
            variant = ButtonVariant.Standard
        })
    else
        element2 = React.createElement(Button, {
            text = var1.BuyRobux,
            onActivated = tbl1.buttons.buyItemActivated,
            fillBehavior = FillBehavior.Fill,
            variant = ButtonVariant.Emphasis,
            icon = Foundation.Enums.IconName.ArrowUpRightFromSquare,
            isDisabled = isDisabled,
            ref = ref
        })
    end

    tbl3.Actions = createElement5(actions, tbl10, { element2 })
    return createElement(root, tbl2, tbl3)
end

local function UnifiedRobuxUpsellModalTooExpensiveContainer(tbl1)
    return React.createElement(
        LocalizationProvider,
        {
            localization = Localization.new(LocalizationService.RobloxLocaleId)
        },
        {
            RobuxUpsellModalTooExpensive = React.createElement(UnifiedRobuxUpsellModalTooExpensive, tbl1)
        }
    )
end
return UnifiedRobuxUpsellModalTooExpensiveContainer
