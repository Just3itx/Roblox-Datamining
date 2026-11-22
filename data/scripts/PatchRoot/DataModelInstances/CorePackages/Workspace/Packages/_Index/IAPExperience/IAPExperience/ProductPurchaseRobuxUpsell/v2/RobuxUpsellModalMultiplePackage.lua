-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:20:56Z
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
local YellowBadge = require(scriptParentParentParent.Generic.YellowBadge)
local RobuxUpsellModalTitle = require(script.Parent.RobuxUpsellModalTitle)
local RobuxUpsellModalFooter = require(script.Parent.RobuxUpsellModalFooter)

local formatNumber = require(scriptParentParentParent.Utility.formatNumber)
local logger = require(scriptParentParentParent.Utility.logger)
local getAppContext = require(scriptParentParentParent.Utility.getAppContext)

local default = require(scriptParentParentParentParent.LoggingProtocol).default
local MultiplePackageUpsellCounter = require(scriptParentParentParent.Generic.Events.MultiplePackageUpsellCounter)
local MultiplePackageUpsellShownCounter = MultiplePackageUpsellCounter.MultiplePackageUpsellShownCounter
local MultiplePackageUpsellSelectedCounter = MultiplePackageUpsellCounter.MultiplePackageUpsellSelectedCounter
local MultiplePackageUpsellModalClosedCounter = MultiplePackageUpsellCounter.MultiplePackageUpsellModalClosedCounter
local MultiplePackageUpsellModalBuyClickedCounter = MultiplePackageUpsellCounter.MultiplePackageUpsellModalBuyClickedCounter

local _GetUpsellSuggestionsTypes = require(scriptParentParentParent.Api.PaymentsGateway.GetUpsellSuggestionsTypes)
local BadgeType = require(scriptParentParentParent.Enums.BadgeType)
local _VirtualItemBadgeType = require(scriptParentParentParent.Enums.VirtualItemBadgeType)

local useDefaultFocusBehavior = require(scriptParentParentParentParent.ReactFocusNavigation).useDefaultFocusBehavior

local FFlagAddDefaultFocusNavSelectorsOnBuyPurchasePrompt = require(scriptParentParentParent.Flags.FFlagAddDefaultFocusNavSelectorsOnBuyPurchasePrompt)

local function UpsellProductDetails(tbl1)
    local var1 = useLocalization({
        Popular = "IAPExperience.RobuxUpsell.Text.PopularItem",
        LastPurchased = "IAPExperience.RobuxUpsell.Text.LastPurchased"
    })
    local var2 = if tbl1.badgeType == BadgeType.Popular then var1.Popular elseif tbl1.badgeType == BadgeType.LastPurchased then var1.LastPurchased else nil
    local icon = if tbl1.badgeType == BadgeType.Popular then "icons/menu/fire_fill" else nil

    local str1 = "size-full-1400 radius-medium padding-x-large row"
    local tag = if tbl1.selected then str1 .. " bg-surface-200 stroke-system-contrast stroke-thick" else str1 .. " bg-surface-300 stroke-emphasis stroke-standard"
    local createElement = React.createElement
    local var4 = View
    local tbl2 = {
        LayoutOrder = tbl1.layoutOrder,
        onActivated = tbl1.onSelected,
        tag = tag
    }
    local tbl3 = {
        LeftSide = React.createElement(
            View,
            {
                LayoutOrder = 1,
                tag = "row gap-small align-y-center align-x-start",
                Size = UDim2.new(0.5, 0, 1, 0)
            },
            {
                RobuxAmount = React.createElement(FoundationText, {
                    LayoutOrder = 1,
                    Text = utf8.char(57346) .. " " .. formatNumber(LocalizationService.RobloxLocaleId, tbl1.product.robuxAmount),
                    tag = "auto-xy text-title-large content-emphasis text-align-x-left"
                }),
                RobuxAmountBonus = tbl1.product.robuxAmountBeforeBonus
                    and React.createElement(FoundationText, {
                        LayoutOrder = 2,
                        RichText = true,
                        Text = "<s>" .. utf8.char(57346) .. formatNumber(LocalizationService.RobloxLocaleId, tbl1.product.robuxAmountBeforeBonus) .. "</s>",
                        tag = "auto-xy text-title-large content-muted text-align-x-left"
                    })
            }
        ),
        RightSide = React.createElement(
            View,
            {
                LayoutOrder = 2,
                tag = "row align-y-center align-x-right gap-large",
                Size = UDim2.new(0.5, 0, 1, 0)
            },
            {
                Badge = if var2 then React.createElement(YellowBadge, { LayoutOrder = 1, Text = var2, Icon = icon }) else nil,
                RobuxPrice = React.createElement(FoundationText, {
                    LayoutOrder = 2,
                    Text = tbl1.product.price or "",
                    tag = "auto-xy text-title-large content-emphasis text-align-x-right"
                })
            }
        )
    }
    return createElement(var4, tbl2, tbl3)
end

local function MiddleContent(tbl1)
    local createElement = React.createElement
    local var1 = View
    local tbl2 = { tag = "col gap-xxlarge auto-y size-full-0 align-x-center align-y-center" }

    local tbl3 = {
        ProductDetails = React.createElement(ProductDetails, {
            layoutOrder = 1,
            isPortrait = tbl1.isPortrait and #tbl1.upsellSuggestions == 1,
            model = tbl1.product.model,
            itemIcon = tbl1.product.itemIcon,
            itemName = tbl1.product.itemName,
            itemRobuxCost = tbl1.product.itemRobuxCost,
            badgeType = tbl1.product.badgeType
        }),
        UpsellSuggestions = React.createElement(
            View,
            {
                LayoutOrder = 2,
                tag = "col gap-medium auto-y size-full-0 align-x-center align-y-center"
            },
            {
                UpsellPackage1 = React.createElement(UpsellProductDetails, {
                    layoutOrder = 1,
                    product = tbl1.upsellSuggestions[1],
                    selected = tbl1.selectedUpsellIndex == 1,
                    onSelected = function()
                        tbl1.onUpsellSuggestionsSelected(1)
                    end
                }),
                UpsellPackage2 = if #tbl1.upsellSuggestions > 1 then React.createElement(UpsellProductDetails, {
                    layoutOrder = 2,
                    product = tbl1.upsellSuggestions[2],
                    selected = tbl1.selectedUpsellIndex == 2,
                    onSelected = function()
                        tbl1.onUpsellSuggestionsSelected(2)
                    end,
                    badgeType = tbl1.upsellSuggestions[2].badgeType
                }) else nil
            }
        )
    }

    return createElement(var1, tbl2, tbl3)
end

local function ButtonStackInfo(tbl1)
    local var1 = useLocalization({
        BuyRobuxButton = "IAPExperience.RobuxUpsell.Action.BuyRobuxAndItem",
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
            message = "Multiple Package Upsell Modal Shown",
            suggestionCount = #tbl1.upsellSuggestions,
            screenHeight = tbl1.screenSize.Y,
            screenWidth = tbl1.screenSize.X,
            portrait = tbl1.screenSize.X < tbl1.screenSize.Y
        })
        default:logRobloxTelemetryCounter(MultiplePackageUpsellShownCounter, 1, {
            suggestionCount = #tbl1.upsellSuggestions,
            screenHeight = tbl1.screenSize.Y,
            screenWidth = tbl1.screenSize.X,
            portrait = tbl1.screenSize.X < tbl1.screenSize.Y
        })
    end, { tbl1.upsellSuggestions })

    local function onUpsellSuggestionsSelected(selectedIndex: number)
        logger.debug({
            message = "Multiple Package Upsell Option Selected",
            suggestionCount = #tbl1.upsellSuggestions,
            previousIndex = tbl1.selectedUpsellIndex,
            selectedIndex = selectedIndex
        })
        default:logRobloxTelemetryCounter(
            MultiplePackageUpsellSelectedCounter,
            1,
            {
                suggestionCount = #tbl1.upsellSuggestions,
                previousIndex = tbl1.selectedUpsellIndex,
                selectedIndex = selectedIndex
            }
        )
        tbl1.onUpsellSuggestionsSelected(selectedIndex)
    end

    local function cancelPurchaseActivated()
        logger.debug({ message = "Multiple Package Upsell Modal Closed", suggestionCount = #tbl1.upsellSuggestions })

        default:logRobloxTelemetryCounter(
            MultiplePackageUpsellModalClosedCounter,
            1,
            {
                suggestionCount = #tbl1.upsellSuggestions
            }
        )
        tbl1.buttons.cancelPurchaseActivated()
    end

    local buyItemActivated = tbl1.buttons.buyItemActivated
    local function func1()
        logger.debug({
            message = "Multiple Package Upsell Modal Buy Clicked",
            appContext = getAppContext(),
            suggestionCount = #tbl1.upsellSuggestions,
            selectedIndex = tbl1.selectedUpsellIndex
        })
        default:logRobloxTelemetryCounter(
            MultiplePackageUpsellModalBuyClickedCounter,
            1,
            {
                appContext = getAppContext(),
                suggestionCount = #tbl1.upsellSuggestions,
                selectedIndex = tbl1.selectedUpsellIndex
            }
        )
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
                balanceAmount = tbl1.userBalance,
                cancelPurchaseActivated = cancelPurchaseActivated
            }
        )
    end

    function tbl2.middleContent()
        return React.createElement(MiddleContent, {
            product = tbl1.product,
            upsellSuggestions = tbl1.upsellSuggestions,
            selectedUpsellIndex = tbl1.selectedUpsellIndex,
            onUpsellSuggestionsSelected = onUpsellSuggestionsSelected,
            isPortrait = tbl1.screenSize.X < tbl1.screenSize.Y
        })
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
