-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:20:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Roact = require(scriptParentParentParent.Roact)
local t = require(scriptParentParentParent.t)

local LocalizationService = game:GetService("LocalizationService")
local Localization = require(scriptParentParentParent.AppLocales).Localization
local LocalizationProvider = require(scriptParentParentParent.Localization).LocalizationProvider
local withLocalization = require(scriptParentParentParent.Localization).withLocalization

local RoactFitComponents = require(scriptParentParentParent.RoactFitComponents)
local FitFrameVertical = RoactFitComponents.FitFrameVertical
local FitTextLabel = RoactFitComponents.FitTextLabel

local UIBlox = require(scriptParentParentParent.UIBlox)
local normalizeFontFace = require(scriptParentParentParent.Foundation).Utility.normalizeFontFace
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local IconSize = UIBlox.App.Constant.IconSize
local withStyle = UIBlox.Core.Style.withStyle

local Colors = require(scriptParentParentParent.Style).Colors

local FFlagLowCogsBannerInfoIcon = require(scriptParentParent.Flags.FFlagLowCogsBannerInfoIcon)
local InfoIconWithTooltip = require(scriptParentParent.Generic.InfoIconWithTooltip)

local SharedFlags = require(scriptParentParentParent.SharedFlags)

local MultiTextLocalizer = require(scriptParentParent.Locale.MultiTextLocalizer)

local ProductDetails = require(scriptParent.ProductDetails)

local iconsCommonRobux = Images["icons/common/robux"]

local var1 = Roact.Component:extend(script.Name)

local FFlagIntroduceMetricsLegacyUpsell = require(scriptParentParent.Flags.FFlagIntroduceMetricsLegacyUpsell)
local default = require(scriptParentParentParent.LoggingProtocol).default
local LegacyUpsellCounter = require(scriptParentParent.Generic.Events.LegacyUpsellCounter)
local logger = require(scriptParentParent.Utility.logger)

var1.validateProps = t.strictInterface({
    anchorPoint = t.optional(t.Vector2),
    position = t.optional(t.UDim2),
    screenSize = t.Vector2,
    isLoading = t.optional(t.boolean),
    isDisabled = t.optional(t.boolean),
    isDelayedInput = t.optional(t.boolean),
    enableInputDelayed = t.optional(t.boolean),
    model = t.optional(t.table),
    itemIcon = t.table,
    itemName = t.string,
    itemRobuxCost = t.number,
    robuxPurchaseAmount = t.number,
    robuxPurchaseAmountBeforeBonus = t.optional(t.number),
    balanceAmount = t.number,
    buyItemControllerIcon = t.optional(t.table),
    cancelControllerIcon = t.optional(t.table),
    buyItemActivated = t.callback,
    cancelPurchaseActivated = t.callback,
    isLuobu = t.optional(t.boolean),
    isVng = t.optional(t.boolean)
})

var1.defaultProps = {
    anchorPoint = Vector2.new(0.5, 0.5),
    position = UDim2.new(0.5, 0, 0.5, 0),
    isLoading = false,
    isDisabled = false,
    isDelayedInput = false,
    enableInputDelayed = false,
    isLuobu = false
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

function var1.didMount(_)
    if not FFlagIntroduceMetricsLegacyUpsell then
        return
    end

    logger.debug({ message = "Legacy Upsell Modal Shown" })

    default:logRobloxTelemetryCounter(LegacyUpsellCounter.LegacyUpsellShownCounter, 1, {})
end

function var1.render(arg1)
    local key = if arg1.props.isLuobu then "IAPExperience.RobuxUpsell.Text.BuyRobuxQuestionWithWarning" else "IAPExperience.RobuxUpsell.Text.BuyRobuxQuestion"

    local str1 = if arg1.props.isVng then "IAPExperience.RobuxUpsell.Text.VNGDisclosureTerms" else "IAPExperience.RobuxUpsell.Text.DisclosureTerms"

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
    end
    return Roact.createElement(MultiTextLocalizer, {
        keys = {
            InsufficientFundsTitle = { key = "IAPExperience.RobuxUpsell.Title.InsufficientFunds" },
            BuyRobuxQuestion = { key = key },
            DisclosurePayment = { key = "IAPExperience.RobuxUpsell.Text.DisclosurePayment" },
            DisclosureTerms = { key = str1 },
            RemainingBalance = { key = "IAPExperience.RobuxUpsell.Text.RemainingBalance" },
            BuyRobuxButton = { key = "IAPExperience.RobuxUpsell.Action.BuyRobux" },
            ButtonCancel = { key = "IAPExperience.RobuxUpsell.Action.Cancel" },
            LoadingText = { key = "IAPExperience.RobuxUpsell.Text.Loading" }
        },
        render = function(arg2)
            return arg1:renderAlert(arg2)
        end
    })
end

function var1.renderAlert(arg1, arg2)
    return withStyle(function(arg3)
        local theme = arg3.Theme
        local font = arg3.Font

        local balanceAmount = arg1.props.balanceAmount or 0
        local robuxPurchaseAmount = arg1.props.robuxPurchaseAmount or 0
        local itemRobuxCost = arg1.props.itemRobuxCost or 0

        local var2 = balanceAmount + robuxPurchaseAmount - itemRobuxCost

        return Roact.createElement(InteractiveAlert, {
            screenSize = arg1.props.screenSize,
            position = arg1.props.position,
            anchorPoint = arg1.props.anchorPoint,
            title = arg2.InsufficientFundsTitle,
            middleContent = function()
                local createElement = Roact.createElement
                local var3 = FitFrameVertical
                local tbl1 = {
                    BackgroundTransparency = 1,
                    width = UDim.new(1, 0),
                    FillDirection = Enum.FillDirection.Vertical,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    contentPadding = UDim.new(0, 15),
                    [Roact.Ref] = arg1.contentRef,
                    [Roact.Change.AbsoluteSize] = arg1.changeContentSize
                }
                local tbl2 = {
                    ItemDetails = Roact.createElement(ProductDetails, {
                        layoutOrder = 1,
                        model = arg1.props.model,
                        itemIcon = arg1.props.itemIcon,
                        itemName = arg1.props.itemName,
                        itemRobuxCost = arg1.props.itemRobuxCost
                    }),
                    Underline = Roact.createElement("Frame", {
                        LayoutOrder = 2,
                        BorderSizePixel = 0,
                        BackgroundColor3 = theme.Divider.Color,
                        BackgroundTransparency = theme.Divider.Transparency,
                        Size = UDim2.new(1, 0, 0, 1)
                    }),
                    ConfirmationFrame = 0,
                    DisclosureFrame = 0
                }
                local createElement2 = Roact.createElement
                local var4 = FitFrameVertical
                local tbl3 = {
                    LayoutOrder = 3,
                    BackgroundTransparency = 1,
                    width = UDim.new(1, 0),
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    contentPadding = UDim.new(0, 1)
                }
                local tbl4 = {
                    WouldYouLikeText = Roact.createElement(FitTextLabel, {
                        LayoutOrder = 1,
                        BackgroundTransparency = 1,
                        width = FitTextLabel.Width.FitToText,
                        TextWrapped = true,
                        maximumWidth = arg1.state.contentSize.X * 0.8,
                        Font = font.Body.Font,
                        Text = arg2.BuyRobuxQuestion,
                        TextSize = font.BaseSize * font.Body.RelativeSize,
                        TextColor3 = theme.TextDefault.Color
                    }),
                    RobuxIcon = Roact.createElement(ImageSetLabel, {
                        LayoutOrder = 2,
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 5, 0, 5),
                        Size = UDim2.new(0, 24, 0, 24),
                        ScaleType = Enum.ScaleType.Stretch,
                        Image = iconsCommonRobux,
                        ImageColor3 = theme.IconEmphasis.Color,
                        ImageTransparency = theme.IconEmphasis.Transparency
                    }),
                    RemainingRobux = Roact.createElement(FitTextLabel, {
                        LayoutOrder = 3,
                        BackgroundTransparency = 1,
                        width = FitTextLabel.Width.FitToText,
                        Font = font.Body.Font,
                        Text = tostring(arg1.props.robuxPurchaseAmount),
                        TextSize = font.BaseSize * font.Body.RelativeSize,
                        TextColor3 = theme.TextEmphasis.Color
                    })
                }
                tbl2.ConfirmationFrame = createElement2(var4, tbl3, tbl4)

                tbl2.DisclosureFrame = Roact.createElement(FitFrameVertical, {
                    LayoutOrder = 4,
                    BackgroundTransparency = 1,
                    width = UDim.new(1, 0),
                    FillDirection = Enum.FillDirection.Vertical,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    contentPadding = UDim.new(0, 1)
                }, {
                    DisclosurePayment = Roact.createElement(FitTextLabel, {
                        LayoutOrder = 1,
                        BackgroundTransparency = 1,
                        width = FitTextLabel.Width.FitToText,
                        Font = font.Footer.Font,
                        Text = arg2.DisclosurePayment,
                        TextSize = font.BaseSize * font.Footer.RelativeSize,
                        TextColor3 = theme.TextDefault.Color,
                        TextWrapped = true
                    }),
                    DisclosureTerms = Roact.createElement(FitTextLabel, {
                        LayoutOrder = 2,
                        BackgroundTransparency = 1,
                        width = FitTextLabel.Width.FitToText,
                        Font = font.Footer.Font,
                        Text = arg2.DisclosureTerms,
                        TextSize = font.BaseSize * font.Footer.RelativeSize,
                        TextColor3 = theme.TextDefault.Color
                    })
                })
                return createElement(var3, tbl1, tbl2)
            end,
            buttonStackInfo = {
                buttons = {
                    {
                        props = {
                            isDisabled = arg1.props.isDisabled,
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
                            text = arg2.BuyRobuxButton,
                            inputIcon = arg1.props.buyItemControllerIcon
                        }
                    }
                }
            },
            footerContent = function()
                local tbl1 = string.split(arg2.RemainingBalance, " {robux} ")
                local str1 = tbl1[1]
                local str2 = tbl1[2]
                return Roact.createElement(FitFrameVertical, {
                    BackgroundTransparency = 1,
                    width = UDim.new(1, 0),
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    contentPadding = UDim.new(0, 1),
                    [Roact.Ref] = arg1.footerRef,
                    [Roact.Change.AbsoluteSize] = arg1.changeFooterSize
                }, {
                    RemainingBalanceBefore = Roact.createElement(FitTextLabel, {
                        LayoutOrder = 1,
                        BackgroundTransparency = 1,
                        width = FitTextLabel.Width.FitToText,
                        Font = font.Footer.Font,
                        Text = str1,
                        TextSize = font.BaseSize * font.Footer.RelativeSize,
                        TextColor3 = theme.TextDefault.Color
                    }),
                    RobuxIcon = Roact.createElement(ImageSetLabel, {
                        LayoutOrder = 2,
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 5, 0, 5),
                        Size = UDim2.new(0, IconSize.Small, 0, IconSize.Small),
                        ScaleType = Enum.ScaleType.Stretch,
                        Image = iconsCommonRobux,
                        ImageColor3 = theme.IconEmphasis.Color,
                        ImageTransparency = theme.IconEmphasis.Transparency
                    }),
                    RemainingRobux = Roact.createElement(FitTextLabel, {
                        LayoutOrder = 3,
                        BackgroundTransparency = 1,
                        width = FitTextLabel.Width.FitToText,
                        Font = font.Footer.Font,
                        Text = var2,
                        TextSize = font.BaseSize * font.Footer.RelativeSize,
                        TextColor3 = theme.TextDefault.Color
                    }),
                    RemainingBalanceAfter = Roact.createElement(FitTextLabel, {
                        LayoutOrder = 4,
                        BackgroundTransparency = 1,
                        width = FitTextLabel.Width.FitToText,
                        Font = font.Footer.Font,
                        Text = str2,
                        TextSize = font.BaseSize * font.Footer.RelativeSize,
                        TextColor3 = theme.TextDefault.Color
                    })
                })
            end
        })
    end)
end

function var1.renderNewAlert(arg1)
    local buyRobuxQuestion = if arg1.props.isLuobu then "IAPExperience.RobuxUpsell.Text.BuyRobuxQuestionWithWarning" else "IAPExperience.RobuxUpsell.Text.BuyRobuxQuestion"

    local disclosureTerms = if arg1.props.isVng then "IAPExperience.RobuxUpsell.Text.VNGDisclosureTerms" else "IAPExperience.RobuxUpsell.Text.DisclosureTerms"

    return withLocalization({
        InsufficientFundsTitle = "IAPExperience.RobuxUpsell.Title.InsufficientFunds",
        BuyRobuxQuestion = buyRobuxQuestion,
        DisclosurePayment = "IAPExperience.RobuxUpsell.Text.DisclosurePayment",
        DisclosureTerms = disclosureTerms,
        RemainingBalance = "IAPExperience.RobuxUpsell.Text.RemainingBalance",
        BuyRobuxButton = "IAPExperience.RobuxUpsell.Action.BuyRobux",
        ButtonCancel = "IAPExperience.RobuxUpsell.Action.Cancel",
        LoadingText = "IAPExperience.RobuxUpsell.Text.Loading",
        NeedMoreRobux = "IAPExperience.RobuxUpsell.Text.NeedMoreRobux",
        BonusBannerV1 = "IAPExperience.RobuxUpsell.Text.BonusBannerV1",
        BonusBannerInfo = "IAPExperience.RobuxUpsell.Text.BonusBannerInfo"
    })(
        function(tbl1)
            return withStyle(function(arg2)
                local theme = arg2.Theme
                local font = arg2.Font

                local var2 = tbl1.BuyRobuxQuestion .. " " .. utf8.char(57346) .. tostring(arg1.props.robuxPurchaseAmount)
                local str3 = ""
                if arg1.props.robuxPurchaseAmountBeforeBonus ~= nil then
                    local str4 = (utf8.char(57346) .. "<s>" .. tostring(arg1.props.robuxPurchaseAmountBeforeBonus) .. "</s>") .. " " .. utf8.char(57346) .. tostring(arg1.props.robuxPurchaseAmount)
                    var2 = tbl1.BuyRobuxQuestion .. " " .. str4

                    local var3 = arg1.props.robuxPurchaseAmount - arg1.props.robuxPurchaseAmountBeforeBonus
                    local str5 = utf8.char(57346) .. tostring(var3)
                    str3 = tbl1.BonusBannerV1:gsub("{robux}", str5)
                end

                return Roact.createElement(InteractiveAlert, {
                    screenSize = arg1.props.screenSize,
                    position = arg1.props.position,
                    anchorPoint = arg1.props.anchorPoint,
                    title = tbl1.NeedMoreRobux,
                    middleContent = function()
                        return Roact.createElement(FitFrameVertical, {
                            BackgroundTransparency = 1,
                            width = UDim.new(1, 0),
                            FillDirection = Enum.FillDirection.Vertical,
                            HorizontalAlignment = Enum.HorizontalAlignment.Center,
                            VerticalAlignment = Enum.VerticalAlignment.Center,
                            contentPadding = UDim.new(0, 15),
                            [Roact.Ref] = arg1.contentRef,
                            [Roact.Change.AbsoluteSize] = arg1.changeContentSize
                        }, {
                            ItemDetails = Roact.createElement(ProductDetails, {
                                layoutOrder = 1,
                                model = arg1.props.model,
                                itemIcon = arg1.props.itemIcon,
                                itemName = arg1.props.itemName,
                                itemRobuxCost = arg1.props.itemRobuxCost
                            }),
                            Underline = Roact.createElement("Frame", {
                                LayoutOrder = 2,
                                BorderSizePixel = 0,
                                BackgroundColor3 = theme.Divider.Color,
                                BackgroundTransparency = theme.Divider.Transparency,
                                Size = UDim2.new(1, 0, 0, 1)
                            }),
                            ConfirmationFrame = Roact.createElement(FitFrameVertical, {
                                LayoutOrder = 3,
                                BackgroundTransparency = 1,
                                width = UDim.new(1, 0),
                                FillDirection = Enum.FillDirection.Horizontal,
                                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                                VerticalAlignment = Enum.VerticalAlignment.Center,
                                contentPadding = UDim.new(0, 1)
                            }, {
                                WouldYouLikeText = Roact.createElement(FitTextLabel, {
                                    LayoutOrder = 1,
                                    BackgroundTransparency = 1,
                                    width = FitTextLabel.Width.FitToText,
                                    TextWrapped = true,
                                    maximumWidth = arg1.state.contentSize.X * 0.8,
                                    RichText = true,
                                    Font = font.Body.Font,
                                    Text = var2,
                                    TextSize = font.BaseSize * font.Body.RelativeSize,
                                    TextColor3 = theme.TextDefault.Color
                                })
                            }),
                            DisclosureFrame = Roact.createElement(FitFrameVertical, {
                                LayoutOrder = 4,
                                BackgroundTransparency = 1,
                                width = UDim.new(1, 0),
                                FillDirection = Enum.FillDirection.Vertical,
                                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                                VerticalAlignment = Enum.VerticalAlignment.Center,
                                contentPadding = UDim.new(0, 1)
                            }, {
                                DisclosurePayment = Roact.createElement(FitTextLabel, {
                                    LayoutOrder = 1,
                                    BackgroundTransparency = 1,
                                    width = FitTextLabel.Width.FitToText,
                                    Font = font.Footer.Font,
                                    Text = tbl1.DisclosurePayment,
                                    TextSize = font.BaseSize * font.Footer.RelativeSize,
                                    TextColor3 = theme.TextDefault.Color,
                                    TextWrapped = true
                                }),
                                DisclosureTerms = Roact.createElement(FitTextLabel, {
                                    LayoutOrder = 2,
                                    BackgroundTransparency = 1,
                                    width = FitTextLabel.Width.FitToText,
                                    Font = font.Footer.Font,
                                    Text = tbl1.DisclosureTerms,
                                    TextSize = font.BaseSize * font.Footer.RelativeSize,
                                    TextColor3 = theme.TextDefault.Color
                                })
                            })
                        })
                    end,
                    buttonStackInfo = {
                        buttons = {
                            {
                                props = {
                                    isDisabled = arg1.props.isDisabled,
                                    onActivated = arg1.props.cancelPurchaseActivated,
                                    text = tbl1.ButtonCancel,
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
                                    text = tbl1.BuyRobuxButton,
                                    inputIcon = arg1.props.buyItemControllerIcon
                                }
                            }
                        }
                    },
                    footerContent = function()
                        return arg1:renderFooterExperiment(arg2, str3, tbl1.BonusBannerInfo)
                    end
                })
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
        AutomaticSize = Enum.AutomaticSize.Y,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(8, 0, 24, 16)
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
                TextWrap = true
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
