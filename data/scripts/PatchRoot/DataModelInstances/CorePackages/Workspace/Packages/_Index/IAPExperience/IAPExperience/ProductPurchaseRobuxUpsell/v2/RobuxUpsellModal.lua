-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:20:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)

local UIBlox = require(scriptParentParentParentParent.UIBlox)
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType

local Foundation = require(scriptParentParentParentParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text

local LocalizationService = game:GetService("LocalizationService")
local Localization = require(scriptParentParentParentParent.AppLocales).Localization
local Localization2 = require(scriptParentParentParentParent.Localization)
local LocalizationProvider = Localization2.LocalizationProvider
local useLocalization = Localization2.Hooks.useLocalization

local ProductDetails = require(scriptParentParentParent.Generic.ProductDetails)
local RobuxUpsellModalTitle = require(script.Parent.RobuxUpsellModalTitle)
local RobuxUpsellModalFooter = require(script.Parent.RobuxUpsellModalFooter)
local RobuxUpsellModalUpsellDetailsWithBonus = require(script.Parent.RobuxUpsellModalUpsellDetailsWithBonus)

local formatNumber = require(scriptParentParentParent.Utility.formatNumber)
local logger = require(scriptParentParentParent.Utility.logger)
local getAppContext = require(scriptParentParentParent.Utility.getAppContext)

local default = require(scriptParentParentParentParent.LoggingProtocol).default
local SinglePackageUpsellCounter = require(scriptParentParentParent.Generic.Events.SinglePackageUpsellCounter)
local SinglePackageUpsellShownCounter = SinglePackageUpsellCounter.SinglePackageUpsellShownCounter
local SinglePackageUpsellModalClosedCounter = SinglePackageUpsellCounter.SinglePackageUpsellModalClosedCounter
local SinglePackageUpsellModalBuyClickedCounter = SinglePackageUpsellCounter.SinglePackageUpsellModalBuyClickedCounter

local _VirtualItemBadgeType = require(scriptParentParentParent.Enums.VirtualItemBadgeType)

local useDefaultFocusBehavior = require(scriptParentParentParentParent.ReactFocusNavigation).useDefaultFocusBehavior

local FFlagAddDefaultFocusNavSelectorsOnBuyPurchasePrompt = require(scriptParentParentParent.Flags.FFlagAddDefaultFocusNavSelectorsOnBuyPurchasePrompt)

local function MiddleContent(tbl1)
    local createElement = React.createElement
    local var1 = View
    local tbl2 = { tag = "col gap-xxlarge auto-y size-full-0 align-x-center align-y-center" }

    local tbl3 = {
        ProductDetails = React.createElement(ProductDetails, {
            layoutOrder = 1,
            isPortrait = tbl1.isPortrait,
            model = tbl1.product.model,
            itemIcon = tbl1.product.itemIcon,
            itemName = tbl1.product.itemName,
            itemRobuxCost = tbl1.product.itemRobuxCost,
            badgeType = tbl1.product.badgeType
        }),
        UpsellPackageDetails = 0
    }
    local element

    if tbl1.upsell.robuxPurchaseAmountBeforeBonus then
        element = React.createElement(RobuxUpsellModalUpsellDetailsWithBonus, {
            layoutOrder = 2,
            priceString = tbl1.upsell.robuxPurchaseCost or "",
            robuxAmount = tbl1.upsell.robuxPurchaseAmountBeforeBonus,
            bonusAmount = tbl1.upsell.robuxPurchaseAmount - tbl1.upsell.robuxPurchaseAmountBeforeBonus
        })
    else
        element = React.createElement(View, {
            LayoutOrder = 2,
            tag = "row flex-between size-full-1400 align-y-center bg-surface-300 radius-medium padding-large stroke-system-contrast stroke-thick"
        }, {
            RobuxAmountContainer = React.createElement(View, { tag = "auto-xy row gap-small" }, {
                RobuxAmount = React.createElement(FoundationText, {
                    LayoutOrder = 1,
                    Text = utf8.char(57346) .. " " .. formatNumber(LocalizationService.RobloxLocaleId, tbl1.upsell.robuxPurchaseAmount),
                    tag = "auto-xy text-title-large content-emphasis text-align-x-left"
                })
            }),
            RobuxPrice = React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = tbl1.upsell.robuxPurchaseCost or "",
                tag = "auto-xy text-title-large content-emphasis text-align-x-right"
            })
        })
    end

    tbl3.UpsellPackageDetails = element
    return createElement(var1, tbl2, tbl3)
end

local function ButtonStackInfo(tbl1)
    local var1 = useLocalization({
        BuyRobuxButton = if tbl1.buttons.opensBuyRobuxPage then "IAPExperience.RobuxUpsell.Action.BuyRobux" else "IAPExperience.RobuxUpsell.Action.BuyRobuxAndItem",
        ButtonCancel = "IAPExperience.RobuxUpsell.Action.Cancel",
        LoadingText = "IAPExperience.RobuxUpsell.Text.Loading"
    })

    local tbl2 = {
        forcedFillDirection = Enum.FillDirection.Vertical,
        disableGamepadRefs = if FFlagAddDefaultFocusNavSelectorsOnBuyPurchasePrompt then true else nil,
        buttons = 0
    }
    local tbl3

    if tbl1.isQuest then
        tbl3 = {{
            props = {
                onActivated = tbl1.buttons.cancelPurchaseActivated,
                text = var1.ButtonCancel,
                inputIcon = tbl1.buttons.cancelControllerIcon
            }
        }}
    else
        tbl3 = {{
            buttonType = ButtonType.PrimaryContextual,
            props = {
                isDisabled = tbl1.buttons.buyItemDisabled,
                isDelayedInput = tbl1.buttons.buyItemisDelayedInput,
                enableInputDelayed = tbl1.buttons.buyItemEnableInputDelayed,
                onActivated = tbl1.buttons.buyItemActivated,
                text = var1.BuyRobuxButton,
                inputIcon = tbl1.buttons.buyItemControllerIcon,
                buttonRef = if FFlagAddDefaultFocusNavSelectorsOnBuyPurchasePrompt then tbl1.buttons.buttonRef else nil
            }
        }}
    end

    tbl2.buttons = tbl3
    return tbl2
end

local function RobuxUpsellModal(tbl1)
    local var1, var2

    if FFlagAddDefaultFocusNavSelectorsOnBuyPurchasePrompt then
        var1, var2 = useDefaultFocusBehavior()
    else
        var1 = nil
        var2 = nil
    end

    React.useEffect(function()
        logger.debug({
            message = "Single Package Upsell Modal Shown",
            screenHeight = tbl1.screenSize.Y,
            screenWidth = tbl1.screenSize.X,
            portrait = tbl1.screenSize.X < tbl1.screenSize.Y,
            appContext = getAppContext(),
            buyRobuxVariant = if tbl1.buttons.opensBuyRobuxPage == nil then 0 elseif tbl1.buttons.opensBuyRobuxPage then 1 else 2
        })
        default:logRobloxTelemetryCounter(SinglePackageUpsellShownCounter, 1, {
            screenHeight = tbl1.screenSize.Y,
            screenWidth = tbl1.screenSize.X,
            portrait = tbl1.screenSize.X < tbl1.screenSize.Y,
            appContext = getAppContext(),
            buyRobuxVariant = if tbl1.buttons.opensBuyRobuxPage == nil then 0 elseif tbl1.buttons.opensBuyRobuxPage then 1 else 2
        })
    end, {})

    local function cancelPurchaseActivated()
        logger.debug({ message = "Single Package Upsell Modal Closed" })

        default:logRobloxTelemetryCounter(SinglePackageUpsellModalClosedCounter, 1, { appContext = getAppContext() })
        tbl1.buttons.cancelPurchaseActivated()
    end

    local buyItemActivated = tbl1.buttons.buyItemActivated
    local function func1()
        logger.debug({ message = "Single Package Upsell Modal Buy Clicked" })

        default:logRobloxTelemetryCounter(SinglePackageUpsellModalBuyClickedCounter, 1, { appContext = getAppContext() })
        buyItemActivated()
    end
    tbl1.buttons.buyItemActivated = func1
    if FFlagAddDefaultFocusNavSelectorsOnBuyPurchasePrompt then
        tbl1.buttons.buttonRef = var1
    end

    local createElement = React.createElement
    local var3 = InteractiveAlert
    local tbl2 = {
        defaultChildRef = 0,
        screenSize = 0,
        anchorPoint = 0,
        position = 0,
        title = "",
        titleContent = 0,
        middleContent = 0,
        buttonStackInfo = 0,
        footerContent = 0
    }

    if not FFlagAddDefaultFocusNavSelectorsOnBuyPurchasePrompt then
        var2 = nil
    end

    tbl2.defaultChildRef = var2
    tbl2.screenSize = tbl1.screenSize
    tbl2.anchorPoint = Vector2.new(0.5, 0.5)
    tbl2.position = UDim2.new(0.5, 0, 0.5, 0)

    function tbl2.titleContent()
        return React.createElement(
            RobuxUpsellModalTitle,
            {
                balanceAmount = tbl1.upsell.balanceAmount,
                cancelPurchaseActivated = cancelPurchaseActivated
            }
        )
    end

    function tbl2.middleContent()
        return React.createElement(
            MiddleContent,
            {
                product = tbl1.product,
                upsell = tbl1.upsell,
                isPortrait = tbl1.screenSize.X < tbl1.screenSize.Y
            }
        )
    end

    tbl2.buttonStackInfo = ButtonStackInfo({ buttons = tbl1.buttons, isQuest = tbl1.isQuest })

    function tbl2.footerContent()
        return React.createElement(RobuxUpsellModalFooter)
    end

    return createElement(var3, tbl2)
end

local function RobuxUpsellModalContainer(tbl1)
    return React.createElement(
        LocalizationProvider,
        {
            localization = Localization.new(LocalizationService.RobloxLocaleId)
        },
        {
            RobuxUpsellModal = React.createElement(RobuxUpsellModal, tbl1)
        }
    )
end
return RobuxUpsellModalContainer
