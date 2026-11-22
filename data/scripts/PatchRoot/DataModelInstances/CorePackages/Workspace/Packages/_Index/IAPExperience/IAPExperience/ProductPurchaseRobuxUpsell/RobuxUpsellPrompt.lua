-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:20:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Roact = require(scriptParentParentParent.Roact)

local FitFrameVertical = require(scriptParentParentParent.RoactFitComponents).FitFrameVertical

local Colors = require(scriptParentParentParent.Style).Colors

local UIBlox = require(scriptParentParentParent.UIBlox)
local normalizeFontFace = require(scriptParentParentParent.Foundation).Utility.normalizeFontFace
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local withStyle = UIBlox.Core.Style.withStyle

local FFlagLowCogsBannerInfoIcon = require(scriptParentParent.Flags.FFlagLowCogsBannerInfoIcon)
local InfoIconWithTooltip = require(scriptParentParent.Generic.InfoIconWithTooltip)

local MultiTextLocalizer = require(scriptParentParent.Locale.MultiTextLocalizer)
local LocalizationService = game:GetService("LocalizationService")
local Localization = require(scriptParentParentParent.AppLocales).Localization
local LocalizationProvider = require(scriptParentParentParent.Localization).LocalizationProvider
local withLocalization = require(scriptParentParentParent.Localization).withLocalization

local _IXPServiceWrapper = require(scriptParentParentParent.IXPServiceWrapper).IXPServiceWrapper
local SharedFlags = require(scriptParentParentParent.SharedFlags)

local default = require(scriptParentParentParent.LoggingProtocol).default
local LegacyUpsellCounter = require(scriptParentParent.Generic.Events.LegacyUpsellCounter)
local logger = require(scriptParentParent.Utility.logger)

local FFlagMobilePopularItemBadgingExperimentEnabled = require(scriptParentParent.Flags.FFlagMobilePopularItemBadgingExperimentEnabled)
local _GetFStringMobilePopularItemBadgingLayer = require(scriptParentParent.Flags.GetFStringMobilePopularItemBadgingLayer)

local ProductDetails = require(scriptParent.ProductDetails)
local ProductDetailsNew = require(scriptParent.ProductDetailsNew)

local Constants = require(scriptParentParent.Generic.Constants)
local getEnableCondenseRobuxUpsell = require(scriptParentParent.Flags.getEnableCondenseRobuxUpsell)

local FFlagIntroduceMetricsLegacyUpsell = require(scriptParentParent.Flags.FFlagIntroduceMetricsLegacyUpsell)

local var1 = Roact.Component:extend(script.Name)

var1.defaultProps = {
    anchorPoint = Vector2.new(0.5, 0.5),
    position = UDim2.new(0.5, 0, 0.5, 0),
    isLoading = false,
    isDisabled = false,
    isDelayedInput = false,
    isQuest = false,
    enableInputDelayed = false,
    inputDelaySec = 3,
    isVng = false
}

function var1.init(arg1)
    arg1.contentRef = Roact.createRef()
    arg1.state = {
        contentSize = Vector2.new(0, 0),
        footerSize = Vector2.new(0, 0),
        isCondensed = false
    }

    function arg1.validateCondensedCondition(arg2)
        if not getEnableCondenseRobuxUpsell() then
            return
        end

        local var2 = arg2.AbsoluteSize.Y + Constants.MODAL_HEIGHT_WITHOUT_CONTENT + Constants.MODAL_NORMAL_SECTION_PADDING * 2 + Constants.MODAL_NORMAL_BUTTON_HEIGHT * 2

        if arg1.state.isCondensed then
            arg1:setState({
                isCondensed = arg1.props.screenSize.Y < var2
                    + (Constants.MODAL_NORMAL_CONTENT_PADDING - Constants.MODAL_CONDENSED_CONTENT_PADDING) * 6
                    + (Constants.MODAL_NORMAL_BUTTON_MARGIN - Constants.MODAL_CONDENSED_BUTTON_MARGIN)
                    + (Constants.NORMAL_ICON_SIZE - Constants.CONDENSED_ICON_SIZE)
            })
            return
        end

        arg1:setState({ isCondensed = arg1.props.screenSize.Y < var2 + Constants.MODAL_NORMAL_BUTTON_MARGIN })
    end

    function arg1.changeContentSize(arg2)
        arg1.validateCondensedCondition(arg2)
        if arg1.state.contentSize ~= arg2.AbsoluteSize then
            arg1:setState({ contentSize = arg2.AbsoluteSize })
        end
    end
end

function var1.didMount(_)
    if not FFlagIntroduceMetricsLegacyUpsell then
        return
    end

    logger.debug({ message = "Legacy Upsell Modal Shown" })

    default:logRobloxTelemetryCounter(LegacyUpsellCounter.LegacyUpsellShownCounter, 1, {})
end

function var1.render(arg1)
    local key = if arg1.props.isVng then "IAPExperience.RobuxUpsell.Text.VNGDisclosureTermsURL" else "IAPExperience.RobuxUpsell.Text.DisclosureTermsURL"

    if SharedFlags.FFlagLowCogsBannerExperiment then
        return Roact.createElement(
            LocalizationProvider,
            {
                localization = Localization.new(LocalizationService.RobloxLocaleId)
            },
            {
                Alert = arg1:renderNewAlert()
            }
        )
    elseif FFlagMobilePopularItemBadgingExperimentEnabled then
        return Roact.createElement(
            LocalizationProvider,
            {
                localization = Localization.new(LocalizationService.RobloxLocaleId)
            },
            {
                Alert = arg1:renderAlertNewProductDetails()
            }
        )
    end
    return Roact.createElement(MultiTextLocalizer, {
        keys = {
            InsufficientRobuxTitle = { key = "IAPExperience.RobuxUpsell.Title.InsufficientRobux" },
            AdditionalRobux = { key = "IAPExperience.RobuxUpsell.Text.AdditionalRobux" },
            WouldYouBuy = { key = "IAPExperience.RobuxUpsell.Text.WouldYouBuy" },
            DisclosurePayment = { key = "IAPExperience.RobuxUpsell.Text.DisclosurePayment" },
            DisclosureTermsURL = { key = key },
            TermsOfUse = { key = "IAPExperience.RobuxUpsell.Text.TermsOfUse" },
            BuyRobuxButton = { key = "IAPExperience.RobuxUpsell.Action.BuyRobuxAndItem" },
            ButtonCancel = { key = "IAPExperience.RobuxUpsell.Action.Cancel" },
            LoadingText = { key = "IAPExperience.RobuxUpsell.Text.Loading" },
            PurchaseNotAvialableForQuest = {
                key = "IAPExperience.RobuxUpsell.Text.PurchaseNotAvailableOnHeadSet"
            }
        },
        render = function(tbl1)
            return arg1:renderAlert(tbl1)
        end
    })
end

function var1.renderAlert(tbl1, tbl2)
    local props = tbl1.props
    local state = tbl1.state

    return withStyle(function(arg1)
        local theme = arg1.Theme
        local font = arg1.Font
        local var2 = font.BaseSize * font.Body.RelativeSize
        if getEnableCondenseRobuxUpsell() then
            var2 = if state.isCondensed then var2 * 0.9 or var2 else var2
        end

        local var3 = props.itemRobuxCost - props.balanceAmount
        local var4 = tbl2.AdditionalRobux:gsub("{robux}", utf8.char(57346) .. tostring(var3))

        local var5 = Color3.new(
            math.round(theme.TextEmphasis.Color.R * 255),
            math.round(theme.TextEmphasis.Color.G * 255),
            math.round(theme.TextEmphasis.Color.B * 255)
        )
        local var6 = string.format(
            "<font color=\"rgb(%s)\">%s%s</font>",
            tostring(var5),
            utf8.char(57346),
            tostring(props.robuxPurchaseAmount)
        )
        local var7 = tbl2.WouldYouBuy:gsub("{robux}", var6)

        local tbl3 = string.split(tbl2.DisclosureTermsURL, "{termsofuse}")

        local termsOfUse = tbl2.TermsOfUse
        if props.termsOfUseActivated then
            termsOfUse = "<u>" .. termsOfUse .. "</u>"
        end

        local createElement = Roact.createElement
        local var8 = InteractiveAlert

        local tbl4 = {
            screenSize = props.screenSize,
            position = props.position,
            anchorPoint = props.anchorPoint,
            title = tbl2.InsufficientRobuxTitle,
            middleContent = function()
                local createElement2 = Roact.createElement
                local var9 = FitFrameVertical
                local tbl4 = {
                    BackgroundTransparency = 1,
                    width = UDim.new(1, 0),
                    FillDirection = Enum.FillDirection.Vertical,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    contentPadding = if getEnableCondenseRobuxUpsell() then UDim.new(0, state.isCondensed and Constants.MODAL_CONDENSED_CONTENT_PADDING or Constants.MODAL_NORMAL_CONTENT_PADDING) else UDim.new(0, Constants.MODAL_NORMAL_CONTENT_PADDING),
                    [Roact.Ref] = tbl1.contentRef,
                    [Roact.Change.AbsoluteSize] = tbl1.changeContentSize
                }
                local tbl5 = {
                    ProductDetails = Roact.createElement(ProductDetails, {
                        layoutOrder = 1,
                        model = props.model,
                        itemIcon = props.itemIcon,
                        itemName = props.itemName,
                        itemRobuxCost = props.itemRobuxCost,
                        itemIconWidth = if getEnableCondenseRobuxUpsell() then state.isCondensed and Constants.CONDENSED_ICON_SIZE or nil else nil,
                        itemIconHeight = if getEnableCondenseRobuxUpsell() then state.isCondensed and Constants.CONDENSED_ICON_SIZE or nil else nil
                    }),
                    Underline = Roact.createElement("Frame", {
                        LayoutOrder = 2,
                        BorderSizePixel = 0,
                        BackgroundColor3 = theme.Divider.Color,
                        BackgroundTransparency = theme.Divider.Transparency,
                        Size = UDim2.new(1, 0, 0, 1)
                    }),
                    AdditionalBuyText = Roact.createElement("TextLabel", {
                        LayoutOrder = 3,
                        BackgroundTransparency = 1,
                        Size = UDim2.new(0, tbl1.state.contentSize.X, 0, 0),
                        RichText = true,
                        AutomaticSize = Enum.AutomaticSize.Y,
                        TextWrapped = true,
                        FontFace = normalizeFontFace(arg1.Tokens.Typography.BodyLarge.Font),
                        Text = if tbl1.props.isQuest then var4 else var4 .. " " .. var7,
                        TextSize = var2,
                        TextColor3 = theme.TextDefault.Color,
                        TextTransparency = theme.TextDefault.Transparency
                    }),
                    Underline2 = Roact.createElement("Frame", {
                        LayoutOrder = 4,
                        BorderSizePixel = 0,
                        BackgroundColor3 = theme.Divider.Color,
                        BackgroundTransparency = theme.Divider.Transparency,
                        Size = UDim2.new(1, 0, 0, 1)
                    }),
                    DisclosureFrame = 0
                }
                local createElement3 = Roact.createElement
                local var10 = FitFrameVertical
                local tbl6 = {
                    LayoutOrder = 5,
                    BackgroundTransparency = 1,
                    width = UDim.new(1, 0),
                    FillDirection = Enum.FillDirection.Vertical,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    contentPadding = UDim.new(0, 1)
                }
                local tbl7 = {
                    DisclosurePayment = Roact.createElement("TextLabel", {
                        LayoutOrder = 1,
                        BackgroundTransparency = 1,
                        AutomaticSize = Enum.AutomaticSize.XY,
                        FontFace = normalizeFontFace(arg1.Tokens.Typography.BodyLarge.Font),
                        Text = if tbl1.props.isQuest then tbl2.PurchaseNotAvailableOnHeadSet else tbl2.DisclosurePayment,
                        TextSize = var2,
                        TextColor3 = theme.TextDefault.Color,
                        TextTransparency = theme.TextDefault.Transparency,
                        TextWrapped = true
                    }),
                    DisclosureTermsFrame = 0
                }
                local var11

                if tbl1.props.isQuest then
                    var11 = nil
                else
                    local createElement4 = Roact.createElement
                    local var12 = FitFrameVertical
                    local tbl8 = {
                        LayoutOrder = 2,
                        BackgroundTransparency = 1,
                        width = UDim.new(1, 0),
                        FillDirection = Enum.FillDirection.Horizontal,
                        HorizontalAlignment = Enum.HorizontalAlignment.Center,
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        contentPadding = UDim.new(0, 1)
                    }
                    local tbl9 = {
                        BeforeDisclosureText = Roact.createElement("TextLabel", {
                            LayoutOrder = 0,
                            BackgroundTransparency = 1,
                            AutomaticSize = Enum.AutomaticSize.XY,
                            FontFace = normalizeFontFace(arg1.Tokens.Typography.BodyLarge.Font),
                            Text = tbl3[1],
                            TextSize = var2,
                            TextColor3 = theme.TextDefault.Color,
                            TextTransparency = theme.TextDefault.Transparency
                        }),
                        TermsOfUse = Roact.createElement("TextButton", {
                            LayoutOrder = 1,
                            BackgroundTransparency = 1,
                            RichText = true,
                            AutomaticSize = Enum.AutomaticSize.XY,
                            FontFace = normalizeFontFace(arg1.Tokens.Typography.BodyLarge.Font),
                            Text = termsOfUse,
                            TextSize = var2,
                            TextColor3 = theme.TextDefault.Color,
                            TextTransparency = theme.TextDefault.Transparency,
                            Selectable = props.termsOfUseActivated ~= nil,
                            [Roact.Event.Activated] = props.termsOfUseActivated
                        }),
                        AfterDisclosureText = Roact.createElement("TextLabel", {
                            LayoutOrder = 2,
                            BackgroundTransparency = 1,
                            AutomaticSize = Enum.AutomaticSize.XY,
                            FontFace = normalizeFontFace(arg1.Tokens.Typography.BodyLarge.Font),
                            Text = tbl3[2],
                            TextSize = var2,
                            TextColor3 = theme.TextDefault.Color,
                            TextTransparency = theme.TextDefault.Transparency
                        })
                    }
                    var11 = createElement4(var12, tbl8, tbl9)
                end

                tbl7.DisclosureTermsFrame = var11
                tbl5.DisclosureFrame = createElement3(var10, tbl6, tbl7)
                return createElement2(var9, tbl4, tbl5)
            end,
            buttonStackInfo = 0
        }

        local buttonStackInfo = {
            forcedFillDirection = Enum.FillDirection.Vertical,
            marginBetween = if getEnableCondenseRobuxUpsell() then state.isCondensed and Constants.MODAL_CONDENSED_BUTTON_MARGIN or Constants.MODAL_NORMAL_BUTTON_MARGIN else Constants.MODAL_NORMAL_BUTTON_MARGIN,
            buttons = 0
        }
        local tbl6

        if tbl1.props.isQuest then
            tbl6 = {{
                props = {
                    isDisabled = props.isDisabled,
                    onActivated = props.cancelPurchaseActivated,
                    text = tbl2.ButtonCancel,
                    inputIcon = props.cancelControllerIcon
                }
            }}
        else
            tbl6 = {
                {
                    props = {
                        isDisabled = props.isDisabled,
                        onActivated = props.cancelPurchaseActivated,
                        text = tbl2.ButtonCancel,
                        inputIcon = props.cancelControllerIcon
                    }
                },
                {
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        isLoading = props.isLoading,
                        isDisabled = props.isDisabled,
                        isDelayedInput = props.isDelayedInput,
                        enableInputDelayed = props.enableInputDelayed,
                        delayInputSeconds = props.inputDelaySec,
                        onActivated = props.buyItemActivated,
                        text = if props.enableInputDelayed then tbl2.LoadingText else tbl2.BuyRobuxButton,
                        inputIcon = props.buyItemControllerIcon
                    }
                }
            }
        end

        buttonStackInfo.buttons = tbl6
        tbl4.buttonStackInfo = buttonStackInfo
        return createElement(var8, tbl4)
    end)
end

function var1.renderAlertNewProductDetails(tbl1, _)
    local props = tbl1.props
    local state = tbl1.state
    return withLocalization({
        InsufficientRobuxTitle = "IAPExperience.RobuxUpsell.Title.InsufficientRobux",
        AdditionalRobux = "IAPExperience.RobuxUpsell.Text.AdditionalRobux",
        WouldYouBuy = "IAPExperience.RobuxUpsell.Text.WouldYouBuy",
        DisclosurePayment = "IAPExperience.RobuxUpsell.Text.DisclosurePayment",
        DisclosureTermsURL = if tbl1.props.isVng then "IAPExperience.RobuxUpsell.Text.VNGDisclosureTermsURL" else "IAPExperience.RobuxUpsell.Text.DisclosureTermsURL",
        TermsOfUse = "IAPExperience.RobuxUpsell.Text.TermsOfUse",
        BuyRobuxButton = "IAPExperience.RobuxUpsell.Action.BuyRobuxAndItem",
        ButtonCancel = "IAPExperience.RobuxUpsell.Action.Cancel",
        LoadingText = "IAPExperience.RobuxUpsell.Text.Loading",
        PurchaseNotAvialableForQuest = "IAPExperience.RobuxUpsell.Text.PurchaseNotAvailableOnHeadSet",
        NeedMoreRobux = "IAPExperience.RobuxUpsell.Text.NeedMoreRobux",
        BadgeText = "IAPExperience.RobuxUpsell.Text.PopularItem"
    })(
        function(tbl2)
            return withStyle(function(arg1)
                local theme = arg1.Theme
                local font = arg1.Font

                local var2 = font.BaseSize * font.Body.RelativeSize
                if getEnableCondenseRobuxUpsell() then
                    var2 = if state.isCondensed then var2 * 0.9 or var2 else var2
                end

                local var3 = props.itemRobuxCost - props.balanceAmount

                local var4 = tbl2.AdditionalRobux:gsub("{robux}", utf8.char(57346) .. tostring(var3))

                local var5 = Color3.new(
                    math.round(theme.TextEmphasis.Color.R * 255),
                    math.round(theme.TextEmphasis.Color.G * 255),
                    math.round(theme.TextEmphasis.Color.B * 255)
                )
                local var6 = string.format(
                    "<font color=\"rgb(%s)\">%s%s</font>",
                    tostring(var5),
                    utf8.char(57346),
                    tostring(props.robuxPurchaseAmount)
                )
                local var7 = tbl2.WouldYouBuy:gsub("{robux}", var6)

                local tbl3 = string.split(tbl2.DisclosureTermsURL, "{termsofuse}")

                local termsOfUse = tbl2.TermsOfUse
                if props.termsOfUseActivated then
                    termsOfUse = "<u>" .. termsOfUse .. "</u>"
                end

                local var8 = if game.GameId then tostring(game.GameId) else nil
                local var9 = if props.itemProductId then tostring(props.itemProductId) else nil
                local tbl4 = {
                    layoutOrder = 1,
                    model = props.model,
                    itemIcon = props.itemIcon,
                    itemName = props.itemName,
                    itemRobuxCost = props.itemRobuxCost,
                    itemIconWidth = if getEnableCondenseRobuxUpsell() then state.isCondensed and Constants.CONDENSED_ICON_SIZE or nil else nil,
                    itemIconHeight = if getEnableCondenseRobuxUpsell() then state.isCondensed and Constants.CONDENSED_ICON_SIZE or nil else nil
                }

                local isPopularItem = false
                local catalogSize = nil
                local salesRank = nil
                local userVariant = 0

                if var8 then
                    var9 = var9 and var9
                end

                local element

                if isPopularItem and userVariant ~= 0 then
                    local var12 = table.clone(tbl4)
                    var12.isPopularItem = isPopularItem
                    var12.catalogSize = catalogSize
                    var12.salesRank = salesRank
                    var12.badgeText = tbl2.BadgeText
                    var12.universeId = var8
                    var12.itemProductId = var9
                    var12.userVariant = userVariant

                    element = Roact.createElement(ProductDetailsNew, var12)
                else
                    element = Roact.createElement(ProductDetails, tbl4)
                end

                local createElement = Roact.createElement
                local var12 = InteractiveAlert

                local tbl5 = {
                    screenSize = props.screenSize,
                    position = props.position,
                    anchorPoint = props.anchorPoint,
                    title = tbl2.NeedMoreRobux,
                    middleContent = function()
                        local createElement2 = Roact.createElement
                        local var13 = FitFrameVertical
                        local tbl5 = {
                            BackgroundTransparency = 1,
                            width = UDim.new(1, 0),
                            FillDirection = Enum.FillDirection.Vertical,
                            HorizontalAlignment = Enum.HorizontalAlignment.Center,
                            VerticalAlignment = Enum.VerticalAlignment.Center,
                            contentPadding = if getEnableCondenseRobuxUpsell() then UDim.new(0, state.isCondensed and Constants.MODAL_CONDENSED_CONTENT_PADDING or Constants.MODAL_NORMAL_CONTENT_PADDING) else UDim.new(0, Constants.MODAL_NORMAL_CONTENT_PADDING),
                            [Roact.Ref] = tbl1.contentRef,
                            [Roact.Change.AbsoluteSize] = tbl1.changeContentSize
                        }
                        local tbl6 = {
                            ProductDetails = element,
                            SimulateMargin = Roact.createElement("Frame", { BackgroundTransparency = 1, LayoutOrder = 2, Size = UDim2.new(0, 12, 0, 12) }),
                            Underline = Roact.createElement("Frame", {
                                LayoutOrder = 2,
                                BorderSizePixel = 0,
                                BackgroundColor3 = theme.Divider.Color,
                                BackgroundTransparency = theme.Divider.Transparency,
                                Size = UDim2.new(1, 0, 0, 1)
                            }),
                            AdditionalBuyText = Roact.createElement("TextLabel", {
                                LayoutOrder = 3,
                                BackgroundTransparency = 1,
                                Size = UDim2.new(0, tbl1.state.contentSize.X, 0, 0),
                                RichText = true,
                                AutomaticSize = Enum.AutomaticSize.Y,
                                TextWrapped = true,
                                FontFace = normalizeFontFace(arg1.Tokens.Typography.BodyLarge.Font),
                                Text = if tbl1.props.isQuest then var4 else var4 .. " " .. var7,
                                TextSize = var2,
                                TextColor3 = theme.TextDefault.Color,
                                TextTransparency = theme.TextDefault.Transparency
                            }),
                            Underline2 = Roact.createElement("Frame", {
                                LayoutOrder = 4,
                                BorderSizePixel = 0,
                                BackgroundColor3 = theme.Divider.Color,
                                BackgroundTransparency = theme.Divider.Transparency,
                                Size = UDim2.new(1, 0, 0, 1)
                            }),
                            DisclosureFrame = 0
                        }
                        local createElement3 = Roact.createElement
                        local var14 = FitFrameVertical
                        local tbl7 = {
                            LayoutOrder = 5,
                            BackgroundTransparency = 1,
                            width = UDim.new(1, 0),
                            FillDirection = Enum.FillDirection.Vertical,
                            HorizontalAlignment = Enum.HorizontalAlignment.Center,
                            VerticalAlignment = Enum.VerticalAlignment.Center,
                            contentPadding = UDim.new(0, 1)
                        }
                        local tbl8 = {
                            DisclosurePayment = Roact.createElement("TextLabel", {
                                LayoutOrder = 1,
                                BackgroundTransparency = 1,
                                AutomaticSize = Enum.AutomaticSize.XY,
                                FontFace = normalizeFontFace(arg1.Tokens.Typography.BodyLarge.Font),
                                Text = if tbl1.props.isQuest then tbl2.PurchaseNotAvailableOnHeadSet else tbl2.DisclosurePayment,
                                TextSize = var2,
                                TextColor3 = theme.TextDefault.Color,
                                TextTransparency = theme.TextDefault.Transparency,
                                TextWrapped = true
                            }),
                            DisclosureTermsFrame = 0
                        }
                        local var15

                        if tbl1.props.isQuest then
                            var15 = nil
                        else
                            local createElement4 = Roact.createElement
                            local var16 = FitFrameVertical
                            local tbl9 = {
                                LayoutOrder = 2,
                                BackgroundTransparency = 1,
                                width = UDim.new(1, 0),
                                FillDirection = Enum.FillDirection.Horizontal,
                                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                                VerticalAlignment = Enum.VerticalAlignment.Center,
                                contentPadding = UDim.new(0, 1)
                            }
                            local tbl10 = {
                                BeforeDisclosureText = Roact.createElement("TextLabel", {
                                    LayoutOrder = 0,
                                    BackgroundTransparency = 1,
                                    AutomaticSize = Enum.AutomaticSize.XY,
                                    FontFace = normalizeFontFace(arg1.Tokens.Typography.BodyLarge.Font),
                                    Text = tbl3[1],
                                    TextSize = var2,
                                    TextColor3 = theme.TextDefault.Color,
                                    TextTransparency = theme.TextDefault.Transparency
                                }),
                                TermsOfUse = Roact.createElement("TextButton", {
                                    LayoutOrder = 1,
                                    BackgroundTransparency = 1,
                                    RichText = true,
                                    AutomaticSize = Enum.AutomaticSize.XY,
                                    FontFace = normalizeFontFace(arg1.Tokens.Typography.BodyLarge.Font),
                                    Text = termsOfUse,
                                    TextSize = var2,
                                    TextColor3 = theme.TextDefault.Color,
                                    TextTransparency = theme.TextDefault.Transparency,
                                    Selectable = props.termsOfUseActivated ~= nil,
                                    [Roact.Event.Activated] = props.termsOfUseActivated
                                }),
                                AfterDisclosureText = Roact.createElement("TextLabel", {
                                    LayoutOrder = 2,
                                    BackgroundTransparency = 1,
                                    AutomaticSize = Enum.AutomaticSize.XY,
                                    FontFace = normalizeFontFace(arg1.Tokens.Typography.BodyLarge.Font),
                                    Text = tbl3[2],
                                    TextSize = var2,
                                    TextColor3 = theme.TextDefault.Color,
                                    TextTransparency = theme.TextDefault.Transparency
                                })
                            }
                            var15 = createElement4(var16, tbl9, tbl10)
                        end

                        tbl8.DisclosureTermsFrame = var15
                        tbl6.DisclosureFrame = createElement3(var14, tbl7, tbl8)
                        return createElement2(var13, tbl5, tbl6)
                    end,
                    buttonStackInfo = 0
                }

                local buttonStackInfo = {
                    forcedFillDirection = Enum.FillDirection.Vertical,
                    marginBetween = if getEnableCondenseRobuxUpsell() then state.isCondensed and Constants.MODAL_CONDENSED_BUTTON_MARGIN or Constants.MODAL_NORMAL_BUTTON_MARGIN else Constants.MODAL_NORMAL_BUTTON_MARGIN,
                    buttons = 0
                }
                local tbl7

                if tbl1.props.isQuest then
                    tbl7 = {{
                        props = {
                            isDisabled = props.isDisabled,
                            onActivated = props.cancelPurchaseActivated,
                            text = tbl2.ButtonCancel,
                            inputIcon = props.cancelControllerIcon
                        }
                    }}
                else
                    tbl7 = {
                        {
                            props = {
                                isDisabled = props.isDisabled,
                                onActivated = props.cancelPurchaseActivated,
                                text = tbl2.ButtonCancel,
                                inputIcon = props.cancelControllerIcon
                            }
                        },
                        {
                            buttonType = ButtonType.PrimarySystem,
                            props = {
                                isLoading = props.isLoading,
                                isDisabled = props.isDisabled,
                                isDelayedInput = props.isDelayedInput,
                                enableInputDelayed = props.enableInputDelayed,
                                delayInputSeconds = props.inputDelaySec,
                                onActivated = props.buyItemActivated,
                                text = if props.enableInputDelayed then tbl2.LoadingText else tbl2.BuyRobuxButton,
                                inputIcon = props.buyItemControllerIcon
                            }
                        }
                    }
                end

                buttonStackInfo.buttons = tbl7
                tbl5.buttonStackInfo = buttonStackInfo
                return createElement(var12, tbl5)
            end)
        end
    )
end

function var1.renderNewAlert(arg1)
    local props = arg1.props
    local state = arg1.state

    return withLocalization({
        InsufficientRobuxTitle = "IAPExperience.RobuxUpsell.Title.InsufficientRobux",
        AdditionalRobux = "IAPExperience.RobuxUpsell.Text.AdditionalRobux",
        WouldYouBuy = "IAPExperience.RobuxUpsell.Text.WouldYouBuy",
        DisclosurePayment = "IAPExperience.RobuxUpsell.Text.DisclosurePayment",
        DisclosureTermsURL = if arg1.props.isVng then "IAPExperience.RobuxUpsell.Text.VNGDisclosureTermsURL" else "IAPExperience.RobuxUpsell.Text.DisclosureTermsURL",
        TermsOfUse = "IAPExperience.RobuxUpsell.Text.TermsOfUse",
        BuyRobuxButton = "IAPExperience.RobuxUpsell.Action.BuyRobuxAndItem",
        ButtonCancel = "IAPExperience.RobuxUpsell.Action.Cancel",
        LoadingText = "IAPExperience.RobuxUpsell.Text.Loading",
        PurchaseNotAvialableForQuest = "IAPExperience.RobuxUpsell.Text.PurchaseNotAvailableOnHeadSet",
        NeedMoreRobux = "IAPExperience.RobuxUpsell.Text.NeedMoreRobux",
        BonusBannerV1 = "IAPExperience.RobuxUpsell.Text.BonusBannerV1",
        BonusBannerInfo = "IAPExperience.RobuxUpsell.Text.BonusBannerInfo"
    })(
        function(tbl1)
            return withStyle(function(arg2)
                local theme = arg2.Theme
                local font = arg2.Font
                local var2 = font.BaseSize * font.Body.RelativeSize
                if getEnableCondenseRobuxUpsell() then
                    var2 = if state.isCondensed then var2 * 0.9 or var2 else var2
                end

                local textSize = font.BaseSize * font.Footer.RelativeSize
                local var4 = props.itemRobuxCost - props.balanceAmount

                local var5 = tbl1.AdditionalRobux:gsub("{robux}", utf8.char(57346) .. tostring(var4))

                local var6 = Color3.new(
                    math.round(theme.TextEmphasis.Color.R * 255),
                    math.round(theme.TextEmphasis.Color.G * 255),
                    math.round(theme.TextEmphasis.Color.B * 255)
                )
                local var7 = string.format(
                    "<font color=\"rgb(%s)\">%s%s</font>",
                    tostring(var6),
                    utf8.char(57346),
                    tostring(props.robuxPurchaseAmount)
                )
                local var8 = tbl1.WouldYouBuy:gsub("{robux}", var7)

                local tbl2 = string.split(tbl1.DisclosureTermsURL, "{termsofuse}")

                local termsOfUse = tbl1.TermsOfUse
                if props.termsOfUseActivated then
                    termsOfUse = "<u>" .. termsOfUse .. "</u>"
                end

                local str1 = ""
                if props.robuxPurchaseAmountBeforeBonus ~= nil then
                    local str2 = tostring(props.robuxPurchaseAmountBeforeBonus)
                    local str3 = tostring(props.robuxPurchaseAmount)
                    local str4 = utf8.char(57346) .. "<s>" .. str2 .. "</s>" .. utf8.char(57346) .. str3
                    var8 = tbl1.WouldYouBuy:gsub("{robux}", str4)

                    local var9 = props.robuxPurchaseAmount - props.robuxPurchaseAmountBeforeBonus
                    local str5 = utf8.char(57346) .. tostring(var9)
                    str1 = tbl1.BonusBannerV1:gsub("{robux}", str5)
                end

                local createElement = Roact.createElement
                local var9 = InteractiveAlert

                local tbl3 = {
                    screenSize = props.screenSize,
                    position = props.position,
                    anchorPoint = props.anchorPoint,
                    title = tbl1.NeedMoreRobux,
                    middleContent = function()
                        local createElement2 = Roact.createElement
                        local var10 = FitFrameVertical
                        local tbl3 = {
                            BackgroundTransparency = 1,
                            BackgroundColor3 = Color3.fromRGB(0, 255, 0),
                            width = UDim.new(1, 0),
                            FillDirection = Enum.FillDirection.Vertical,
                            HorizontalAlignment = Enum.HorizontalAlignment.Center,
                            VerticalAlignment = Enum.VerticalAlignment.Center,
                            contentPadding = if getEnableCondenseRobuxUpsell() then UDim.new(0, state.isCondensed and Constants.MODAL_CONDENSED_CONTENT_PADDING or Constants.MODAL_NORMAL_CONTENT_PADDING) else UDim.new(0, Constants.MODAL_NORMAL_CONTENT_PADDING),
                            [Roact.Ref] = arg1.contentRef,
                            [Roact.Change.AbsoluteSize] = arg1.changeContentSize
                        }
                        local tbl4 = {
                            ProductDetails = Roact.createElement(ProductDetails, {
                                layoutOrder = 1,
                                model = props.model,
                                itemIcon = props.itemIcon,
                                itemName = props.itemName,
                                itemRobuxCost = props.itemRobuxCost,
                                itemIconWidth = if getEnableCondenseRobuxUpsell() then state.isCondensed and Constants.CONDENSED_ICON_SIZE or nil else nil,
                                itemIconHeight = if getEnableCondenseRobuxUpsell() then state.isCondensed and Constants.CONDENSED_ICON_SIZE or nil else nil
                            }),
                            Underline = Roact.createElement("Frame", {
                                LayoutOrder = 2,
                                BorderSizePixel = 0,
                                BackgroundColor3 = theme.Divider.Color,
                                BackgroundTransparency = theme.Divider.Transparency,
                                Size = UDim2.new(1, 0, 0, 1)
                            }),
                            AdditionalBuyText = Roact.createElement("TextLabel", {
                                LayoutOrder = 3,
                                BackgroundTransparency = 1,
                                Size = UDim2.new(0, arg1.state.contentSize.X, 0, 0),
                                RichText = true,
                                AutomaticSize = Enum.AutomaticSize.Y,
                                TextWrapped = true,
                                FontFace = normalizeFontFace(arg2.Tokens.Typography.BodyLarge.Font),
                                Text = if arg1.props.isQuest then var5 else var5 .. " " .. var8,
                                TextSize = var2,
                                TextColor3 = theme.TextDefault.Color,
                                TextTransparency = theme.TextDefault.Transparency
                            }),
                            Underline2 = Roact.createElement("Frame", {
                                LayoutOrder = 4,
                                BorderSizePixel = 0,
                                BackgroundColor3 = theme.Divider.Color,
                                BackgroundTransparency = theme.Divider.Transparency,
                                Size = UDim2.new(1, 0, 0, 1)
                            }),
                            DisclosureFrame = 0
                        }
                        local createElement3 = Roact.createElement
                        local var11 = FitFrameVertical
                        local tbl5 = {
                            LayoutOrder = 5,
                            BackgroundTransparency = 1,
                            width = UDim.new(1, 0),
                            FillDirection = Enum.FillDirection.Vertical,
                            HorizontalAlignment = Enum.HorizontalAlignment.Center,
                            VerticalAlignment = Enum.VerticalAlignment.Center,
                            contentPadding = UDim.new(0, 1)
                        }
                        local tbl6 = {
                            DisclosurePayment = Roact.createElement("TextLabel", {
                                LayoutOrder = 1,
                                BackgroundTransparency = 1,
                                AutomaticSize = Enum.AutomaticSize.XY,
                                FontFace = normalizeFontFace(arg2.Tokens.Typography.BodyLarge.Font),
                                Text = if arg1.props.isQuest then tbl1.PurchaseNotAvailableOnHeadSet else tbl1.DisclosurePayment,
                                TextSize = textSize,
                                TextColor3 = theme.TextDefault.Color,
                                TextTransparency = theme.TextDefault.Transparency,
                                TextWrapped = true
                            }),
                            DisclosureTermsFrame = 0
                        }
                        local var12

                        if arg1.props.isQuest then
                            var12 = nil
                        else
                            local createElement4 = Roact.createElement
                            local var13 = FitFrameVertical
                            local tbl7 = {
                                LayoutOrder = 2,
                                BackgroundTransparency = 1,
                                width = UDim.new(1, 0),
                                FillDirection = Enum.FillDirection.Horizontal,
                                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                                VerticalAlignment = Enum.VerticalAlignment.Center,
                                contentPadding = UDim.new(0, 1)
                            }
                            local tbl8 = {
                                BeforeDisclosureText = Roact.createElement("TextLabel", {
                                    LayoutOrder = 0,
                                    BackgroundTransparency = 1,
                                    AutomaticSize = Enum.AutomaticSize.XY,
                                    FontFace = normalizeFontFace(arg2.Tokens.Typography.BodyLarge.Font),
                                    Text = tbl2[1],
                                    TextSize = textSize,
                                    TextColor3 = theme.TextDefault.Color,
                                    TextTransparency = theme.TextDefault.Transparency
                                }),
                                TermsOfUse = Roact.createElement("TextButton", {
                                    LayoutOrder = 1,
                                    BackgroundTransparency = 1,
                                    RichText = true,
                                    AutomaticSize = Enum.AutomaticSize.XY,
                                    FontFace = normalizeFontFace(arg2.Tokens.Typography.BodyLarge.Font),
                                    Text = termsOfUse,
                                    TextSize = textSize,
                                    TextColor3 = theme.TextDefault.Color,
                                    TextTransparency = theme.TextDefault.Transparency,
                                    Selectable = props.termsOfUseActivated ~= nil,
                                    [Roact.Event.Activated] = props.termsOfUseActivated
                                }),
                                AfterDisclosureText = Roact.createElement("TextLabel", {
                                    LayoutOrder = 2,
                                    BackgroundTransparency = 1,
                                    AutomaticSize = Enum.AutomaticSize.XY,
                                    FontFace = normalizeFontFace(arg2.Tokens.Typography.BodyLarge.Font),
                                    Text = tbl2[2],
                                    TextSize = textSize,
                                    TextColor3 = theme.TextDefault.Color,
                                    TextTransparency = theme.TextDefault.Transparency
                                })
                            }
                            var12 = createElement4(var13, tbl7, tbl8)
                        end

                        tbl6.DisclosureTermsFrame = var12
                        tbl4.DisclosureFrame = createElement3(var11, tbl5, tbl6)
                        return createElement2(var10, tbl3, tbl4)
                    end,
                    buttonStackInfo = 0,
                    footerContent = 0
                }

                local buttonStackInfo = {
                    forcedFillDirection = Enum.FillDirection.Vertical,
                    marginBetween = if getEnableCondenseRobuxUpsell() then state.isCondensed and Constants.MODAL_CONDENSED_BUTTON_MARGIN or Constants.MODAL_NORMAL_BUTTON_MARGIN else Constants.MODAL_NORMAL_BUTTON_MARGIN,
                    buttons = 0
                }
                local tbl5

                if arg1.props.isQuest then
                    tbl5 = {{
                        props = {
                            isDisabled = props.isDisabled,
                            onActivated = props.cancelPurchaseActivated,
                            text = tbl1.ButtonCancel,
                            inputIcon = props.cancelControllerIcon
                        }
                    }}
                else
                    tbl5 = {
                        {
                            props = {
                                isDisabled = props.isDisabled,
                                onActivated = props.cancelPurchaseActivated,
                                text = tbl1.ButtonCancel,
                                inputIcon = props.cancelControllerIcon
                            }
                        },
                        {
                            buttonType = ButtonType.PrimarySystem,
                            props = {
                                isLoading = props.isLoading,
                                isDisabled = props.isDisabled,
                                isDelayedInput = props.isDelayedInput,
                                enableInputDelayed = props.enableInputDelayed,
                                delayInputSeconds = props.inputDelaySec,
                                onActivated = props.buyItemActivated,
                                text = if props.enableInputDelayed then tbl1.LoadingText else tbl1.BuyRobuxButton,
                                inputIcon = props.buyItemControllerIcon
                            }
                        }
                    }
                end

                buttonStackInfo.buttons = tbl5
                tbl3.buttonStackInfo = buttonStackInfo

                function tbl3.footerContent()
                    return arg1:renderFooterExperiment(arg2, str1, tbl1.BonusBannerInfo)
                end

                return createElement(var9, tbl3)
            end)
        end
    )
end

function var1.renderFooterExperiment(arg1, arg2, text, text2)
    local font = arg2.Font
    local flint = Colors.Flint

    if text == "" then
        return nil
    end

    local createElement = Roact.createElement
    local var2 = FitFrameVertical
    local tbl1 = {
        BackgroundTransparency = 1,
        width = UDim.new(1, 0),
        margin = { top = 0, bottom = -24, left = -24, right = -24 },
        [Roact.Ref] = arg1.footerRef,
        [Roact.Change.AbsoluteSize] = arg1.changeFooterSize
    }
    local tbl2 = { Banner = 0 }

    local createElement2 = Roact.createElement
    local str1 = "ImageLabel"
    local tbl3 = {
        BackgroundTransparency = 1,
        LayoutOrder = 2,
        Image = "rbxasset://textures/ui/BottomRoundedRect8px.png",
        ImageColor3 = Color3.fromRGB(239, 215, 140),
        Size = UDim2.new(1, 0, 0, 40),
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(8, 0, 24, 16),
        AutomaticSize = Enum.AutomaticSize.Y
    }
    local tbl4 = {
        BannerContent = Roact.createElement(FitFrameVertical, {
            LayoutOrder = 2,
            BackgroundTransparency = 1,
            width = UDim.new(1, 0),
            margin = { top = 12, bottom = 0, left = 0, right = 0 },
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center
        }, {
            BonusBefore = Roact.createElement("TextLabel", {
                LayoutOrder = 1,
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.XY,
                RichText = true,
                FontFace = normalizeFontFace(arg2.Tokens.Typography.CaptionSmall.Font),
                Text = text,
                TextSize = font.BaseSize * font.Footer.RelativeSize,
                TextColor3 = flint,
                TextWrapped = true
            }),
            InfoIcon = if FFlagLowCogsBannerInfoIcon then InfoIconWithTooltip(
                {
                    text = text2,
                    layoutOrder = 2,
                    color = flint,
                    eventActivated = arg1.bonusBannerInfoIconStateChange
                }
            ) else nil
        })
    }
    tbl2.Banner = createElement2(str1, tbl3, tbl4)
    return createElement(var2, tbl1, tbl2)
end

return var1
