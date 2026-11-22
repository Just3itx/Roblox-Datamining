-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:11:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Roact = require(scriptParentParentParent.Roact)
local t = require(scriptParentParentParent.t)

local RoactFitComponents = require(scriptParentParentParent.RoactFitComponents)
local FitFrameVertical = RoactFitComponents.FitFrameVertical
local FitTextLabel = RoactFitComponents.FitTextLabel

local UIBlox = require(scriptParentParentParent.UIBlox)
local normalizeFontFace = require(scriptParentParentParent.Foundation).Utility.normalizeFontFace
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local withStyle = UIBlox.Core.Style.withStyle
local useDefaultFocusBehavior = require(scriptParentParentParent.ReactFocusNavigation).useDefaultFocusBehavior
local Cryo = require(scriptParentParentParent.Cryo)

local ModelViewport = require(script.Parent.Parent.Generic.ModelViewport)
local MultiTextLocalizer = require(scriptParentParent.Locale.MultiTextLocalizer)

local shouldShowNewUpsellModalExperiment = require(scriptParentParent.Utility.Experiments.shouldShowNewUpsellModalExperiment)
local DesktopUpsellExperiment = require(scriptParentParent.Utility.Experiments.DesktopUpsellExperiment)

local ProductPurchaseModal = require(script.Parent.v2.ProductPurchaseModal)

local iconsCommonRobux = Images["icons/common/robux"]
local str1 = utf8.char(57346)

local default = require(scriptParentParentParent.LoggingProtocol).default
local PurchaseModalV1ShownCounter = require(scriptParentParent.Generic.Events.PurchaseModalCounter).PurchaseModalV1ShownCounter

local logger = require(scriptParentParent.Utility.logger)
local getAppContext = require(scriptParentParent.Utility.getAppContext)

local FFlagAddDefaultFocusNavSelectorsOnBuyPurchasePrompt = require(scriptParentParent.Flags.FFlagAddDefaultFocusNavSelectorsOnBuyPurchasePrompt)

local var1 = Roact.Component:extend(script.Name)

local strictInterface = t.strictInterface
local tbl1 = {
    anchorPoint = t.optional(t.Vector2),
    position = t.optional(t.UDim2),
    screenSize = t.Vector2,
    isLoading = t.optional(t.boolean),
    isDisabled = t.optional(t.boolean),
    isDelayedInput = t.optional(t.boolean),
    enableInputDelayed = t.optional(t.boolean),
    itemIcon = t.union(t.string, t.table),
    model = t.optional(t.table),
    itemName = t.string,
    itemRobuxCost = t.number,
    currentBalance = t.number,
    currentBalanceValid = t.optional(t.boolean),
    isGamePass = t.optional(t.boolean),
    testPurchase = t.optional(t.boolean),
    buyItemControllerIcon = t.optional(t.table),
    cancelControllerIcon = t.optional(t.table),
    buyItemActivated = t.callback,
    cancelPurchaseActivated = t.callback,
    isLuobu = t.optional(t.boolean),
    defaultFocusRef = if FFlagAddDefaultFocusNavSelectorsOnBuyPurchasePrompt then t.callback else nil,
    containerRef = if FFlagAddDefaultFocusNavSelectorsOnBuyPurchasePrompt then t.callback else nil
}
var1.validateProps = strictInterface(tbl1)

var1.defaultProps = {
    anchorPoint = Vector2.new(0.5, 0.5),
    position = UDim2.new(0.5, 0, 0.5, 0),
    isLoading = false,
    isDisabled = false,
    testPurchase = false,
    isDelayedInput = false,
    enableInputDelayed = false,
    isLuobu = false,
    isGamePass = false,
    currentBalanceValid = true
}

function var1.init(arg1)
    arg1.contentRef = Roact.createRef()
    arg1.footerRef = Roact.createRef()
    arg1.state = {
        contentSize = Vector2.new(0, 0),
        footerSize = Vector2.new(0, 0)
    }

    function arg1.changeContentSize(arg2)
        if arg1.state.contentSize ~= arg2.AbsoluteSize then
            arg1:setState({ contentSize = arg2.AbsoluteSize })
        end
    end

    function arg1.changeFooterSize(arg2)
        if arg1.state.footerSize ~= arg2.AbsoluteSize then
            arg1:setState({ footerSize = arg2.AbsoluteSize })
        end
    end
end

function var1.render(arg1)
    local key = if arg1.props.isLuobu then "IAPExperience.PurchasePrompt.Text.BuyItemQuestionIncludingWarning" else "IAPExperience.PurchasePrompt.Text.BuyItemQuestion"

    local isGamePass = arg1.props.isGamePass

    if shouldShowNewUpsellModalExperiment() or DesktopUpsellExperiment.shouldShowNewModal() then
        return Roact.createElement(ProductPurchaseModal, {
            product = {
                itemIcon = arg1.props.itemIcon,
                itemName = arg1.props.itemName,
                itemRobuxCost = arg1.props.itemRobuxCost
            },
            balanceAmount = arg1.props.currentBalance,
            balanceAmountValid = arg1.props.currentBalanceValid,
            buttons = {
                buyItemActivated = arg1.props.buyItemActivated,
                buyItemControllerIcon = arg1.props.buyItemControllerIcon,
                buyItemIsDelayedInput = arg1.props.isDelayedInput,
                buyItemEnableInputDelayed = arg1.props.enableInputDelayed,
                cancelActivated = arg1.props.cancelPurchaseActivated,
                isDisabled = arg1.props.isDisabled
            },
            screenSize = arg1.props.screenSize
        })
    end

    return Roact.createElement(MultiTextLocalizer, {
        keys = {
            BuyItemTitle = {
                key = if isGamePass then "IAPExperience.PurchasePrompt.Title.BuyGamepass" else "IAPExperience.PurchasePrompt.Title.BuyItem"
            },
            BuyItemQuestion = {
                key = key,
                params = {
                    name = arg1.props.itemName
                }
            },
            RemainingBalance = { key = "IAPExperience.PurchasePrompt.Text.RemainingBalance" },
            TestPurchaseText = { key = "IAPExperience.PurchasePrompt.Text.TestPurchase" },
            ButtonCancel = { key = "IAPExperience.PurchasePrompt.Action.Cancel" },
            LoadingText = { key = "IAPExperience.PurchasePrompt.Text.Loading" }
        },
        render = function(arg2)
            return arg1:renderAlert(arg2)
        end
    })
end

function var1.renderAlert(arg1, arg2)
    local props = arg1.props
    logger.debug({
        message = "Purchase Modal V1 Shown",
        screenHeight = props.screenSize.Y,
        screenWidth = props.screenSize.X,
        portrait = props.screenSize.X < props.screenSize.Y,
        appContext = getAppContext()
    })
    default:logRobloxTelemetryCounter(PurchaseModalV1ShownCounter, 1, {
        screenHeight = props.screenSize.Y,
        screenWidth = props.screenSize.X,
        portrait = props.screenSize.X < props.screenSize.Y,
        appContext = getAppContext()
    })

    return withStyle(function(arg3)
        local theme = arg3.Theme
        local font = arg3.Font
        local iconEmphasisColor = theme.IconEmphasis.Color

        local num1 = math.round(iconEmphasisColor.R * 255)
        local num2 = math.round(iconEmphasisColor.G * 255)
        local num3 = math.round(iconEmphasisColor.B * 255)
        local str2 = string.format("rgb(%d,%d,%d)", num1, num2, num3)
        local xOffset = arg1.state.contentSize.X * 0.85

        local str3 = string.format(
            "%s <font color=\"%s\">%s</font>%d",
            arg2.RemainingBalance,
            str2,
            str1,
            arg1.props.currentBalance - arg1.props.itemRobuxCost
        )
        local element

        if arg1.props.model then
            element = Roact.createElement(
                ModelViewport,
                {
                    model = arg1.props.model,
                    LayoutOrder = 1,
                    Size = UDim2.fromOffset(85, 85),
                    Position = UDim2.fromOffset(5, 5)
                }
            )
        else
            element = Roact.createElement(ImageSetLabel, {
                LayoutOrder = 1,
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 5, 0, 5),
                Size = UDim2.new(0, 85, 0, 85),
                ScaleType = Enum.ScaleType.Stretch,
                Image = arg1.props.itemIcon,
                ImageTransparency = 0
            })
        end

        local createElement = Roact.createElement
        local var2 = InteractiveAlert
        local tbl2 = {
            defaultChildRef = if FFlagAddDefaultFocusNavSelectorsOnBuyPurchasePrompt then arg1.props.containerRef else nil,
            screenSize = arg1.props.screenSize,
            position = arg1.props.position,
            anchorPoint = arg1.props.anchorPoint,
            title = arg2.BuyItemTitle,
            middleContent = 0,
            buttonStackInfo = 0,
            footerContent = 0
        }

        function tbl2.middleContent()
            return Roact.createElement(FitFrameVertical, {
                BackgroundTransparency = 1,
                width = UDim.new(1, 0),
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                contentPadding = UDim.new(0, 24),
                [Roact.Ref] = arg1.contentRef,
                [Roact.Change.AbsoluteSize] = arg1.changeContentSize
            }, {
                ItemIcon = element,
                ItemName = Roact.createElement(FitTextLabel, {
                    LayoutOrder = 2,
                    BackgroundTransparency = 1,
                    TextWrapped = true,
                    width = FitTextLabel.Width.FitToText,
                    maximumWidth = arg1.state.contentSize.X,
                    Font = font.Footer.Font,
                    Text = arg2.BuyItemQuestion,
                    TextSize = font.BaseSize * font.Body.RelativeSize,
                    TextColor3 = theme.TextDefault.Color
                })
            })
        end
        local buttonStackInfo = {
            disableGamepadRefs = if FFlagAddDefaultFocusNavSelectorsOnBuyPurchasePrompt then true else nil,
            buttons = {
                {
                    props = {
                        isDisabled = arg1.props.isDisabled or arg1.props.isLoading,
                        onActivated = arg1.props.cancelPurchaseActivated,
                        text = arg2.ButtonCancel,
                        inputIcon = arg1.props.cancelControllerIcon
                    }
                },
                {
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        isLoading = arg1.props.isLoading,
                        isDisabled = arg1.props.isDisabled,
                        isDelayedInput = arg1.props.isDelayedInput,
                        enableInputDelayed = arg1.props.enableInputDelayed,
                        delayInputSeconds = 3,
                        onActivated = arg1.props.buyItemActivated,
                        icon = iconsCommonRobux,
                        text = tostring(arg1.props.itemRobuxCost),
                        inputIcon = arg1.props.buyItemControllerIcon,
                        buttonRef = if FFlagAddDefaultFocusNavSelectorsOnBuyPurchasePrompt then arg1.props.defaultFocusRef else nil
                    }
                }
            }
        }
        tbl2.buttonStackInfo = buttonStackInfo

        function tbl2.footerContent()
            if not arg1.props.currentBalanceValid then
                return Roact.None
            elseif not arg1.props.testPurchase then
                return Roact.createElement(FitFrameVertical, {
                    BackgroundTransparency = 1,
                    width = UDim.new(1, 0),
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    contentPadding = UDim.new(0, 2),
                    [Roact.Ref] = arg1.footerRef,
                    [Roact.Change.AbsoluteSize] = arg1.changeFooterSize
                }, {
                    RemainingBalanceText = Roact.createElement("TextLabel", {
                        LayoutOrder = 1,
                        BackgroundTransparency = 1,
                        RichText = true,
                        Position = UDim2.fromScale(0, 0.5),
                        Size = UDim2.fromOffset(xOffset, 0),
                        AutomaticSize = Enum.AutomaticSize.Y,
                        TextWrapped = true,
                        FontFace = normalizeFontFace(arg3.Tokens.Typography.CaptionSmall.Font),
                        Text = str3,
                        TextSize = font.BaseSize * font.Footer.RelativeSize,
                        TextColor3 = theme.TextDefault.Color
                    })
                })
            end
            return Roact.createElement(FitFrameVertical, {
                BackgroundTransparency = 1,
                width = UDim.new(1, 0),
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                contentPadding = UDim.new(0, 2),
                [Roact.Ref] = arg1.footerRef,
                [Roact.Change.AbsoluteSize] = arg1.changeFooterSize
            }, {
                TestPurchaseTest = Roact.createElement(FitTextLabel, {
                    LayoutOrder = 1,
                    BackgroundTransparency = 1,
                    width = FitTextLabel.Width.FitToText,
                    Font = font.Footer.Font,
                    Text = arg2.TestPurchaseText,
                    TextSize = font.BaseSize * font.Footer.RelativeSize,
                    TextColor3 = theme.TextDefault.Color
                })
            })
        end

        return createElement(var2, tbl2)
    end)
end

return if FFlagAddDefaultFocusNavSelectorsOnBuyPurchasePrompt then function(arg1)
    local defaultFocusRef, containerRef = useDefaultFocusBehavior()

    return Roact.createElement(
        var1,
        Cryo.Dictionary.join(arg1, { defaultFocusRef = defaultFocusRef, containerRef = containerRef })
    )
end else var1
