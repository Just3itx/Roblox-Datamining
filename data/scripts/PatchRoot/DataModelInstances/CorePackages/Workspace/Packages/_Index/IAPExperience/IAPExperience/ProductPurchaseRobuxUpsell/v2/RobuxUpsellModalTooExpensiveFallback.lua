-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:21:00Z
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

local formatNumber = require(scriptParentParentParent.Utility.formatNumber)
local logger = require(scriptParentParentParent.Utility.logger)
local getAppContext = require(scriptParentParentParent.Utility.getAppContext)

local default = require(scriptParentParentParentParent.LoggingProtocol).default
local TooExpensiveUpsellFallbackShownCounter = require(scriptParentParentParent.Generic.Events.TooExpensiveUpsellCounter).TooExpensiveUpsellFallbackShownCounter

local function MiddleContent(tbl1)
    local var1 = useLocalization({ YouNeed = "IAPExperience.InsufficientRobux.Text.YouNeed" })

    local var2 = tbl1.product.itemRobuxCost - tbl1.balanceAmount
    local var3 = utf8.char(57346) .. formatNumber(LocalizationService.RobloxLocaleId, var2)
    local var4 = var1.YouNeed:gsub("{robux}", var3)

    return React.createElement(View, {
        tag = "col gap-medium auto-y size-full-0 align-x-center align-y-center"
    }, {
        ProductDetails = React.createElement(ProductDetails, {
            layoutOrder = 1,
            isPortrait = tbl1.isPortrait,
            model = tbl1.product.model,
            itemIcon = tbl1.product.itemIcon,
            itemName = tbl1.product.itemName,
            itemRobuxCost = tbl1.product.itemRobuxCost
        }),
        BuyRobuxDetails = React.createElement(FoundationText, {
            LayoutOrder = 2,
            Text = var4,
            padding = {
                bottom = UDim.new(0, -12)
            },
            tag = "auto-xy text-body-medium content-emphasis text-align-x-left size-full-0 text-wrap padding-x-small line-height-"
        })
    })
end

local function RobuxUpsellModalTooExpensiveFallback(tbl1)
    React.useEffect(function()
        logger.debug({
            message = "Too Expensive Upsell Fallback Modal Shown",
            screenHeight = tbl1.screenSize.Y,
            screenWidth = tbl1.screenSize.X,
            portrait = tbl1.screenSize.X < tbl1.screenSize.Y,
            appContext = getAppContext()
        })
        default:logRobloxTelemetryCounter(TooExpensiveUpsellFallbackShownCounter, 1, {
            screenHeight = tbl1.screenSize.Y,
            screenWidth = tbl1.screenSize.X,
            portrait = tbl1.screenSize.X < tbl1.screenSize.Y,
            appContext = getAppContext()
        })
    end, {})
    local var1 = useLocalization({ OK = "IAPExperience.PurchaseError.Text.Ok" })

    return React.createElement(InteractiveAlert, {
        screenSize = tbl1.screenSize,
        anchorPoint = Vector2.new(0.5, 0.5),
        position = UDim2.new(0.5, 0, 0.5, 0),
        title = "",
        titleContent = function()
            return React.createElement(
                RobuxUpsellModalTitle,
                {
                    balanceAmount = tbl1.balanceAmount,
                    cancelPurchaseActivated = tbl1.doneActivated
                }
            )
        end,
        middleContent = function()
            return React.createElement(MiddleContent, {
                product = tbl1.product,
                isQuest = tbl1.isQuest,
                balanceAmount = tbl1.balanceAmount,
                isPortrait = tbl1.screenSize.X < tbl1.screenSize.Y
            })
        end,
        buttonStackInfo = {
            buttons = {{
                buttonType = ButtonType.PrimaryContextual,
                props = {
                    onActivated = tbl1.doneActivated,
                    text = var1.OK,
                    inputIcon = tbl1.doneControllerIcon
                }
            }}
        }
    })
end

local function RobuxUpsellModalTooExpensiveFallbackContainer(tbl1)
    return React.createElement(
        LocalizationProvider,
        {
            localization = Localization.new(LocalizationService.RobloxLocaleId)
        },
        {
            RobuxUpsellModalTooExpensiveFallback = React.createElement(RobuxUpsellModalTooExpensiveFallback, tbl1)
        }
    )
end
return RobuxUpsellModalTooExpensiveFallbackContainer
