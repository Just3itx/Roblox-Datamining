-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)

local Foundation = require(scriptParentParentParentParent.Foundation)
local View = Foundation.View
local ButtonVariant = Foundation.Enums.ButtonVariant
local Dialog = Foundation.Dialog
local DialogSize = Foundation.Enums.DialogSize
local EnumsOrientation = Foundation.Enums.Orientation

local LocalizationService = game:GetService("LocalizationService")
local Localization = require(scriptParentParentParentParent.AppLocales).Localization
local Localization2 = require(scriptParentParentParentParent.Localization)
local LocalizationProvider = Localization2.LocalizationProvider
local useLocalization = Localization2.Hooks.useLocalization

local UnifiedProductDetails = require(scriptParentParentParent.Generic.UnifiedProductDetails)
local PriceSummary = require(scriptParentParentParent.Generic.PriceSummary)

local UnifiedPurchaseModalTypeEnum = require(scriptParentParentParent.Enums.UnifiedPurchaseModalTypeEnum)

local logger = require(scriptParentParentParent.Utility.logger)
local getAppContext = require(scriptParentParentParent.Utility.getAppContext)

local default = require(scriptParentParentParentParent.LoggingProtocol).default
local TooExpensiveUnifiedUpsellShownCounter = require(scriptParentParentParent.Generic.Events.TooExpensiveUpsellCounter).TooExpensiveUnifiedUpsellShownCounter

local useFocusNavigationRefs = require(scriptParentParentParent.Generic.Hooks.useFocusNavigationRefs)

local function UnifiedRobuxUpsellModalTooExpensiveV2(tbl1)
    local var1 = useLocalization({
        NeedMoreRobux = "IAPExperience.RobuxUpsell.Text.NeedMoreRobux",
        ButtonCancel = "IAPExperience.InsufficientRobux.Action.Cancel",
        BuyRobux = "IAPExperience.InsufficientRobux.Action.BuyRobux"
    })

    local ref, var2 = useFocusNavigationRefs(tbl1.buttons.cancelPurchaseActivated, nil)

    React.useEffect(function()
        logger.debug({
            message = "Too Expensive Unified Upsell Modal Shown (Dialog)",
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
    local root = Dialog.Root
    local tbl2 = {
        size = DialogSize.Medium,
        onClose = tbl1.buttons.cancelPurchaseActivated,
        ref = ref,
        disablePortal = false
    }
    local tbl3 = {
        DialogTitle = React.createElement(Dialog.Title, { text = var1.NeedMoreRobux }),
        DialogContent = 0,
        DialogActions = 0
    }
    local createElement2 = React.createElement
    local content = Dialog.Content
    local var4 = nil
    local tbl4 = { ContentView = 0 }
    local createElement3 = React.createElement
    local var5 = View
    local tbl5 = {
        tag = "col gap-medium auto-y size-full-0 align-x-center align-y-start padding-bottom-medium"
    }
    local tbl6 = { ProductDetails = 0 }
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

    tbl6.ProductDetails = element
    tbl4.ContentView = createElement3(var5, tbl5, tbl6)
    tbl3.DialogContent = createElement2(content, var4, tbl4)

    tbl3.DialogActions = React.createElement(Dialog.Actions, {
        LayoutOrder = 3,
        orientation = EnumsOrientation.Horizontal,
        actions = {{
            text = var1.BuyRobux,
            onActivated = tbl1.buttons.buyItemActivated,
            variant = ButtonVariant.Emphasis,
            icon = Foundation.Enums.IconName.ArrowUpRightFromSquare,
            isDisabled = false,
            ref = var2
        }}
    })
    return createElement(root, tbl2, tbl3)
end

local function UnifiedRobuxUpsellModalTooExpensiveV2Container(tbl1)
    return React.createElement(
        LocalizationProvider,
        {
            localization = Localization.new(LocalizationService.RobloxLocaleId)
        },
        {
            RobuxUpsellModalTooExpensiveV2 = React.createElement(UnifiedRobuxUpsellModalTooExpensiveV2, tbl1)
        }
    )
end
return UnifiedRobuxUpsellModalTooExpensiveV2Container
