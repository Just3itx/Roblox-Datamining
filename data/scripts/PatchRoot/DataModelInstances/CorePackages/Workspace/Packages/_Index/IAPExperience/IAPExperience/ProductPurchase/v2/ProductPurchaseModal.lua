-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:11:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local GetTextSize = require(scriptParentParentParentParent.Style).GetTextSize

local UIBlox = require(scriptParentParentParentParent.UIBlox)
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType

local Foundation = require(scriptParentParentParentParent.Foundation)
local FoundationText = Foundation.Text
local useTokens = Foundation.Hooks.useTokens
local useTextSizeOffset = Foundation.Hooks.useTextSizeOffset

local useDefaultFocusBehavior = require(scriptParentParentParentParent.ReactFocusNavigation).useDefaultFocusBehavior

local ProductDetails = require(scriptParentParentParent.Generic.ProductDetails)

local LocalizationService = game:GetService("LocalizationService")
local Localization = require(scriptParentParentParentParent.AppLocales).Localization
local Localization2 = require(scriptParentParentParentParent.Localization)
local LocalizationProvider = Localization2.LocalizationProvider
local useLocalization = Localization2.Hooks.useLocalization

local formatNumber = require(scriptParentParentParent.Utility.formatNumber)
local logger = require(scriptParentParentParent.Utility.logger)
local getAppContext = require(scriptParentParentParent.Utility.getAppContext)

local default = require(scriptParentParentParentParent.LoggingProtocol).default
local PurchaseModalV2ShownCounter = require(scriptParentParentParent.Generic.Events.PurchaseModalCounter).PurchaseModalV2ShownCounter

local FFlagAddDefaultFocusNavSelectorsOnBuyPurchasePrompt = require(scriptParentParentParent.Flags.FFlagAddDefaultFocusNavSelectorsOnBuyPurchasePrompt)

local function ProductPurchaseModal(tbl1)
    local var1, var2

    if FFlagAddDefaultFocusNavSelectorsOnBuyPurchasePrompt then
        var1, var2 = useDefaultFocusBehavior()
    else
        var2 = nil
        var1 = nil
    end
    React.useEffect(function()
        logger.debug({
            message = "Purchase Modal V2 Shown",
            screenHeight = tbl1.screenSize.Y,
            screenWidth = tbl1.screenSize.X,
            portrait = tbl1.screenSize.X < tbl1.screenSize.Y,
            appContext = getAppContext()
        })
        default:logRobloxTelemetryCounter(PurchaseModalV2ShownCounter, 1, {
            screenHeight = tbl1.screenSize.Y,
            screenWidth = tbl1.screenSize.X,
            portrait = tbl1.screenSize.X < tbl1.screenSize.Y,
            appContext = getAppContext()
        })
    end, {})

    local var3 = useLocalization({
        BuyItem = "IAPExperience.PurchasePrompt.Title.BuyItem",
        RemainingBalance = "IAPExperience.PurchasePrompt.Text.RemainingBalanceV2"
    })

    local var4 = tbl1.balanceAmount - tbl1.product.itemRobuxCost
    local var5 = utf8.char(57346) .. " " .. formatNumber(LocalizationService.RobloxLocaleId, var4)

    local text = utf8.char(57346) .. " " .. formatNumber(LocalizationService.RobloxLocaleId, tbl1.product.itemRobuxCost)

    local var7 = useTokens()
    local var8 = useTextSizeOffset()
    local var9, var10 = React.useState(0)
    local x = var9
    local var11 = var10
    local captionSmall = var7.Typography.CaptionSmall

    local var12 = var3.RemainingBalance:gsub("{robux}", var5)

    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        if x ~= arg1.AbsoluteSize.X then
            var11(arg1.AbsoluteSize.X)
        end
    end, { tbl1 })

    local yOffset = React.useMemo(function()
        return captionSmall.LineHeight * GetTextSize(var12, captionSmall.FontSize, captionSmall.Font, Vector2.new(x, math.huge), { addTemporaryPadding = false }).Y
    end, { x, var8, var12 })

    local createElement = React.createElement
    local var14 = InteractiveAlert
    local tbl2 = {
        defaultChildRef = 0,
        screenSize = 0,
        anchorPoint = 0,
        position = 0,
        bottomMargin = 12,
        title = 0,
        onCloseClicked = 0,
        onAbsoluteSizeChanged = 0,
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

    tbl2.title = var3.BuyItem
    function tbl2.onCloseClicked()
        if not tbl1.buttons.isDisabled then
            tbl1.buttons.cancelActivated()
        end
    end
    tbl2.onAbsoluteSizeChanged = onAbsoluteSizeChanged
    function tbl2.middleContent()
        return React.createElement(
            ProductDetails,
            {
                isPortrait = false,
                layoutOrder = 1,
                itemIcon = tbl1.product.itemIcon,
                itemName = tbl1.product.itemName
            }
        )
    end

    local buttonStackInfo = {
        forcedFillDirection = Enum.FillDirection.Vertical,
        disableGamepadRefs = if FFlagAddDefaultFocusNavSelectorsOnBuyPurchasePrompt then true else nil,
        buttons = 0
    }
    local tbl4 = {
        buttonType = ButtonType.PrimaryContextual,
        props = 0
    }
    local props = {
        isDisabled = tbl1.buttons.isDisabled,
        isDelayedInput = tbl1.buttons.buyItemIsDelayedInput,
        enableInputDelayed = tbl1.buttons.buyItemEnableInputDelayed,
        onActivated = tbl1.buttons.buyItemActivated,
        text = text,
        inputIcon = tbl1.buttons.buyItemControllerIcon,
        buttonRef = 0
    }

    if not FFlagAddDefaultFocusNavSelectorsOnBuyPurchasePrompt then
        var1 = nil
    end

    props.buttonRef = var1
    tbl4.props = props
    buttonStackInfo.buttons = { tbl4 }
    tbl2.buttonStackInfo = buttonStackInfo

    function tbl2.footerContent()
        if not tbl1.balanceAmountValid then
            return React.None
        end
        return React.createElement(FoundationText, {
            Text = var12,
            Size = UDim2.new(1, 0, 0, yOffset),
            onAbsoluteSizeChanged = onAbsoluteSizeChanged,
            tag = "content-muted text-caption-small align-x-center text-wrap"
        })
    end

    return createElement(var14, tbl2)
end

local function ProductPurchaseModalContainer(tbl1)
    return React.createElement(
        LocalizationProvider,
        {
            localization = Localization.new(LocalizationService.RobloxLocaleId)
        },
        {
            ProductPurchaseModal = React.createElement(ProductPurchaseModal, tbl1)
        }
    )
end
return ProductPurchaseModalContainer
