-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:20:59Z
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

local formatNumber = require(scriptParentParentParent.Utility.formatNumber)
local logger = require(scriptParentParentParent.Utility.logger)
local getAppContext = require(scriptParentParentParent.Utility.getAppContext)

local default = require(scriptParentParentParentParent.LoggingProtocol).default
local TooExpensiveUpsellShownCounter = require(scriptParentParentParent.Generic.Events.TooExpensiveUpsellCounter).TooExpensiveUpsellShownCounter

local function MiddleContent(tbl1)
    local var1 = useLocalization({ DontHaveEnough = "IAPExperience.InsufficientRobux.Text.BuyRobux" })

    local var2 = tbl1.product.itemRobuxCost - tbl1.balanceAmount
    local var3 = utf8.char(57346) .. " " .. formatNumber(LocalizationService.RobloxLocaleId, var2)
    local var4 = var1.DontHaveEnough:gsub("{robux}", var3)

    return React.createElement(View, {
        tag = "col gap-xxlarge auto-y size-full-0 align-x-center align-y-center"
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
            tag = "auto-xy text-label-medium content-emphasis text-align-x-center size-full-0"
        })
    })
end

local function ButtonStackInfo(tbl1)
    local var1 = useLocalization({
        RobuxStoreButton = "IAPExperience.InsufficientRobux.Action.RobuxStore",
        ButtonCancel = "IAPExperience.InsufficientRobux.Action.Cancel"
    })

    return {
        forcedFillDirection = Enum.FillDirection.Vertical,
        buttons = tbl1.isQuest
            and {{
                props = {
                    onActivated = tbl1.buttons.cancelPurchaseActivated,
                    text = var1.ButtonCancel,
                    inputIcon = tbl1.buttons.cancelControllerIcon
                }
            }}
            or {{
                buttonType = ButtonType.PrimaryContextual,
                props = {
                    onActivated = tbl1.buttons.buyItemActivated,
                    text = var1.RobuxStoreButton,
                    inputIcon = tbl1.buttons.buyItemControllerIcon
                }
            }}
    }
end

local function RobuxUpsellModalTooExpensive(tbl1)
    React.useEffect(function()
        logger.debug({
            message = "Too Expensive Upsell Modal Shown",
            screenHeight = tbl1.screenSize.Y,
            screenWidth = tbl1.screenSize.X,
            portrait = tbl1.screenSize.X < tbl1.screenSize.Y,
            appContext = getAppContext()
        })
        default:logRobloxTelemetryCounter(TooExpensiveUpsellShownCounter, 1, {
            screenHeight = tbl1.screenSize.Y,
            screenWidth = tbl1.screenSize.X,
            portrait = tbl1.screenSize.X < tbl1.screenSize.Y,
            appContext = getAppContext()
        })
    end, {})
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
                    cancelPurchaseActivated = tbl1.buttons.cancelPurchaseActivated
                }
            )
        end,
        middleContent = function()
            return React.createElement(MiddleContent, {
                product = tbl1.product,
                balanceAmount = tbl1.balanceAmount,
                isQuest = tbl1.isQuest,
                isPortrait = tbl1.screenSize.X < tbl1.screenSize.Y
            })
        end,
        buttonStackInfo = ButtonStackInfo({ buttons = tbl1.buttons, isQuest = tbl1.isQuest }),
        footerContent = function()
            return React.createElement(RobuxUpsellModalFooter)
        end
    })
end

local function RobuxUpsellModalTooExpensiveContainer(tbl1)
    return React.createElement(
        LocalizationProvider,
        {
            localization = Localization.new(LocalizationService.RobloxLocaleId)
        },
        {
            RobuxUpsellModalTooExpensive = React.createElement(RobuxUpsellModalTooExpensive, tbl1)
        }
    )
end
return RobuxUpsellModalTooExpensiveContainer
