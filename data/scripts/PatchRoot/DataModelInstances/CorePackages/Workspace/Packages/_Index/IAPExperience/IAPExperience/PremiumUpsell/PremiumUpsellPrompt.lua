-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:11:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Roact = require(scriptParentParentParent.Roact)

local FitFrameVertical = require(scriptParentParentParent.RoactFitComponents).FitFrameVertical

local UIBlox = require(scriptParentParentParent.UIBlox)
local normalizeFontFace = require(scriptParentParentParent.Foundation).Utility.normalizeFontFace
local PartialPageModal = UIBlox.App.Dialog.Modal.PartialPageModal
local getPartialPageModalMiddleContentWidth = UIBlox.App.Dialog.Modal.getPartialPageModalMiddleContentWidth
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local withStyle = UIBlox.Style.withStyle

local MultiTextLocalizer = require(scriptParentParent.Locale.MultiTextLocalizer)

local BulletPoint = require(scriptParent.BulletPoint)

local var1 = Roact.Component:extend(script.Name)

function var1.init(arg1)
    arg1.isCondensed = false
    arg1.contentSize = Vector2.new(0, 0)

    arg1.state = {
        padding = UDim.new(0, 24),
        iconSize = UDim2.new(1, 0, 0, 80)
    }

    function arg1.updateContentSizes(vector2: Vector2, vector2_2: Vector2)
        if vector2_2.X < 200 or vector2_2.Y > 1000 then
            return
        end

        local contentSize = arg1.contentSize
        arg1.contentSize = vector2_2

        if vector2_2.X == 0 and vector2_2.Y == 0
            or vector2.X == 0 and vector2.Y == 0
            or vector2_2 == contentSize and vector2 == arg1.props.screenSize
        then
            return
        end

        local isCondensed = if arg1.isCondensed then vector2.Y < vector2_2.Y + 120 + 80 - 48 + 24 else vector2.Y < vector2_2.Y + 120
        arg1.isCondensed = isCondensed

        arg1:setState(
            {
                padding = UDim.new(0, if isCondensed then 12 else 24),
                iconSize = UDim2.new(1, 0, 0, if isCondensed then 48 else 80)
            }
        )
    end
end

function var1.willUpdate(arg1, arg2)
    if arg1.props.screenSize ~= arg2.screenSize then
        arg1.updateContentSizes(arg2.screenSize, arg1.contentSize)
    end
end

function var1.render(arg1)
    local props = arg1.props

    local createElement = Roact.createElement
    local var2 = MultiTextLocalizer
    local tbl1 = {
        keys = {
            titleLocalizedText = {
                key = "IAPExperience.SubscriptionPurchasePrompt.Label.GetSubscription"
            },
            monthlyLocalizedText = { key = "IAPExperience.PremiumUpsell.Action.Subscribe" },
            descLocalizedText = { key = "IAPExperience.PremiumUpsell.Label.PremiumBenefitListDesc" },
            bulletPoint1Text = {
                key = "IAPExperience.PremiumUpsell.Label.RobuxPerMonth",
                params = {
                    robux = utf8.char(57346) .. tostring(props.robuxAmount)
                }
            },
            bulletPoint2Text = { key = "IAPExperience.PremiumUpsell.Label.PremiumOnlyBenefits" },
            bulletPoint3Text = props.isCatalog and {
                key = "IAPExperience.PremiumUpsell.Label.AvatarShopBenefits"
            }
                or { key = "IAPExperience.PremiumUpsell.Body.RobuxDiscount" },
            disclosure = {
                key = "IAPExperience.PremiumUpsell.Label.Disclosure",
                params = {
                    currencySymbol = props.currencySymbol,
                    price = tostring(props.robuxPrice)
                }
            },
            shortDisclosure = { key = "IAPExperience.PremiumUpsell.Label.ShortDisclosure" },
            priceLocalizedText = {
                key = "IAPExperience.PremiumUpsell.Label.PremiumPrice",
                params = {
                    currencySymbol = props.currencySymbol,
                    price = tostring(props.robuxPrice)
                }
            },
            headerLocalizedText = { key = "IAPExperience.PremiumUpsell.Label.RobloxPremium" },
            policyLocalizedText = { key = "IAPExperience.PremiumUpsell.Label.PremiumPolicy" }
        },
        render = 0
    }

    function tbl1.render(arg2)
        return arg1:renderPrompt(arg2)
    end

    return createElement(var2, tbl1)
end

function var1.renderCondensedPremiumInfo(_, tbl1)
    return withStyle(function(arg1)
        local theme = arg1.Theme
        local font = arg1.Font

        return Roact.createElement(
            "Frame",
            {
                LayoutOrder = 1,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y
            },
            {
                Padding = Roact.createElement("UIPadding", { PaddingTop = UDim.new(0, 12), PaddingBottom = UDim.new(0, 12) }),
                Layout = Roact.createElement(
                    "UIListLayout",
                    {
                        FillDirection = Enum.FillDirection.Horizontal,
                        SortOrder = Enum.SortOrder.LayoutOrder
                    }
                ),
                IconContainer = Roact.createElement("Frame", {
                    LayoutOrder = 1,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(0, 96, 0, 96),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    AnchorPoint = Vector2.new(0, 0),
                    Position = UDim2.new(0, 0, 0, 0)
                }, {
                    Padding = Roact.createElement("UIPadding", { PaddingRight = UDim.new(0, 12) }),
                    Icon = Roact.createElement(ImageSetLabel, {
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 1, 0),
                        ScaleType = Enum.ScaleType.Fit,
                        Image = Images["icons/graphic/premium_large"]
                    })
                }),
                PremiumInfoContainer = Roact.createElement(
                    "Frame",
                    {
                        LayoutOrder = 2,
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, -80, 0, 0),
                        AutomaticSize = Enum.AutomaticSize.Y
                    },
                    {
                        Padding = Roact.createElement("UIPadding", { PaddingTop = UDim.new(0, 6) }),
                        ListLayout = Roact.createElement(
                            "UIListLayout",
                            {
                                FillDirection = Enum.FillDirection.Vertical,
                                SortOrder = Enum.SortOrder.LayoutOrder,
                                Padding = UDim.new(0, 12)
                            }
                        ),
                        PremiumHeader = Roact.createElement("TextLabel", {
                            LayoutOrder = 1,
                            BackgroundTransparency = 1,
                            Size = UDim2.new(1, 0, 0, 0),
                            AutomaticSize = Enum.AutomaticSize.Y,
                            TextXAlignment = Enum.TextXAlignment.Left,
                            TextWrapped = true,
                            FontFace = normalizeFontFace(arg1.Tokens.Typography.TitleLarge.Font),
                            RichText = true,
                            Text = tbl1.headerLocalizedText,
                            TextSize = font.BaseSize * font.Header2.RelativeSize,
                            TextColor3 = theme.TextEmphasis.Color,
                            TextTransparency = theme.TextDefault.Transparency
                        }),
                        CostPerMonth = Roact.createElement("TextLabel", {
                            LayoutOrder = 2,
                            BackgroundTransparency = 1,
                            Size = UDim2.new(1, 0, 0, 0),
                            AutomaticSize = Enum.AutomaticSize.Y,
                            TextXAlignment = Enum.TextXAlignment.Left,
                            TextWrapped = true,
                            FontFace = normalizeFontFace(arg1.Tokens.Typography.BodyLarge.Font),
                            RichText = true,
                            Text = tbl1.priceLocalizedText,
                            TextSize = font.BaseSize,
                            TextColor3 = theme.TextEmphasis.Color,
                            TextTransparency = theme.TextDefault.Transparency
                        }),
                        RenewAndCancelText = Roact.createElement("TextLabel", {
                            LayoutOrder = 3,
                            BackgroundTransparency = 1,
                            Size = UDim2.new(1, 0, 0, 0),
                            AutomaticSize = Enum.AutomaticSize.Y,
                            TextXAlignment = Enum.TextXAlignment.Left,
                            TextWrapped = true,
                            FontFace = normalizeFontFace(arg1.Tokens.Typography.BodyLarge.Font),
                            Text = tbl1.policyLocalizedText,
                            TextSize = font.BaseSize,
                            TextColor3 = theme.TextDefault.Color,
                            TextTransparency = theme.TextDefault.Transparency
                        })
                    }
                )
            }
        )
    end)
end

function var1.renderBulletInfo(tbl1, tbl2)
    return withStyle(function(arg1)
        local theme = arg1.Theme
        local font = arg1.Font

        local width = getPartialPageModalMiddleContentWidth(tbl1.props.screenSize.X)

        return Roact.createElement(
            "Frame",
            {
                LayoutOrder = 2,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y
            },
            {
                Padding = Roact.createElement("UIPadding", { PaddingBottom = UDim.new(0, 12) }),
                ListLayout = Roact.createElement(
                    "UIListLayout",
                    {
                        FillDirection = Enum.FillDirection.Vertical,
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        Padding = UDim.new(0, 12)
                    }
                ),
                BulletListText = Roact.createElement("TextLabel", {
                    LayoutOrder = 1,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(0, width, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    FontFace = normalizeFontFace(arg1.Tokens.Typography.BodyLarge.Font),
                    Text = tbl2.descLocalizedText,
                    TextSize = font.BaseSize * font.Body.RelativeSize,
                    TextColor3 = theme.TextDefault.Color,
                    TextTransparency = theme.TextDefault.Transparency
                }),
                BulletList = Roact.createElement(
                    FitFrameVertical,
                    {
                        LayoutOrder = 2,
                        BackgroundTransparency = 1,
                        width = UDim.new(1, 0),
                        contentPadding = UDim.new(0, 12)
                    },
                    {
                        BulletText1 = Roact.createElement(BulletPoint, { text = tbl2.bulletPoint1Text, width = width, layoutOrder = 1 }),
                        BulletText2 = Roact.createElement(BulletPoint, { text = tbl2.bulletPoint2Text, width = width, layoutOrder = 2 }),
                        BulletText3 = Roact.createElement(BulletPoint, { text = tbl2.bulletPoint3Text, width = width, layoutOrder = 3 })
                    }
                )
            }
        )
    end)
end

function var1.renderDisclosure(_, tbl1)
    return withStyle(function(arg1)
        local theme = arg1.Theme
        local font = arg1.Font

        return Roact.createElement(
            "Frame",
            {
                LayoutOrder = 5,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y
            },
            {
                Padding = Roact.createElement("UIPadding", { PaddingBottom = UDim.new(0, 12) }),
                Disclosure = Roact.createElement("TextLabel", {
                    LayoutOrder = 1,
                    BackgroundTransparency = 1,
                    AutomaticSize = Enum.AutomaticSize.XY,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    RichText = true,
                    TextWrapped = true,
                    FontFace = normalizeFontFace(arg1.Tokens.Typography.BodyLarge.Font),
                    Text = tbl1.shortDisclosure,
                    TextSize = font.BaseSize * font.Body.RelativeSize,
                    TextColor3 = theme.TextDefault.Color,
                    TextTransparency = theme.TextDefault.Transparency
                })
            }
        )
    end)
end

function var1.renderLandscapePrompt(tbl1, tbl2)
    local props = tbl1.props

    return withStyle(function(_)
        return Roact.createElement(PartialPageModal, {
            title = tbl2.titleLocalizedText,
            screenSize = props.screenSize,
            buttonStackProps = {
                buttons = {{
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        onActivated = props.purchasePremiumActivated,
                        text = tbl2.monthlyLocalizedText,
                        inputIcon = props.acceptControllerIcon
                    }
                }},
                buttonHeight = 48
            },
            onCloseClicked = props.cancelPurchaseActivated
        }, { Roact.createElement("ScrollingFrame", {
                LayoutOrder = 1,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, props.screenSize.Y / 2),
                BorderSizePixel = 0,
                ZIndex = 2,
                ScrollingEnabled = true,
                ScrollBarThickness = 5,
                ScrollingDirection = Enum.ScrollingDirection.Y,
                Selectable = false,
                CanvasSize = UDim2.new(1, 0, 0, math.min(props.screenSize.Y / 2 + 96 + 12, 450))
            }, {
                Layout = Roact.createElement(
                    "UIListLayout",
                    {
                        FillDirection = Enum.FillDirection.Vertical,
                        SortOrder = Enum.SortOrder.LayoutOrder
                    }
                ),
                IconAndPremiumInfoContainer = tbl1:renderCondensedPremiumInfo(tbl2),
                BulletList = tbl1:renderBulletInfo(tbl2),
                Disclosure = tbl1:renderDisclosure(tbl2)
            }) })
    end)
end

function var1.renderPortraitPrompt(tbl1, tbl2)
    local props = tbl1.props

    return withStyle(function(_)
        return Roact.createElement(PartialPageModal, {
            title = tbl2.titleLocalizedText,
            screenSize = props.screenSize,
            buttonStackProps = {
                buttons = {{
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        onActivated = props.purchasePremiumActivated,
                        text = tbl2.monthlyLocalizedText,
                        inputIcon = props.acceptControllerIcon
                    }
                }},
                buttonHeight = 48
            },
            onCloseClicked = props.cancelPurchaseActivated
        }, { Roact.createElement(
                "Frame",
                {
                    LayoutOrder = 1,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y
                },
                {
                    Layout = Roact.createElement(
                        "UIListLayout",
                        {
                            FillDirection = Enum.FillDirection.Vertical,
                            SortOrder = Enum.SortOrder.LayoutOrder
                        }
                    ),
                    IconAndPremiumInfoContainer = tbl1:renderCondensedPremiumInfo(tbl2),
                    BulletList = tbl1:renderBulletInfo(tbl2),
                    Disclosure = tbl1:renderDisclosure(tbl2)
                }
            ) })
    end)
end

function var1.renderUpdatedPrompt(tbl1, tbl2)
    local props = tbl1.props

    return withStyle(function(arg1)
        local theme = arg1.Theme
        local font = arg1.Font

        local width = getPartialPageModalMiddleContentWidth(tbl1.props.screenSize.X)

        local createElement = Roact.createElement
        local var2 = PartialPageModal
        local tbl3 = {
            title = tbl2.titleLocalizedText,
            screenSize = props.screenSize,
            buttonStackProps = {
                buttons = {{
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        onActivated = props.purchasePremiumActivated,
                        text = tbl2.monthlyLocalizedText,
                        inputIcon = props.acceptControllerIcon
                    }
                }},
                buttonHeight = 48
            },
            onCloseClicked = props.cancelPurchaseActivated
        }
        local createElement2 = Roact.createElement
        local var3 = FitFrameVertical
        local tbl4 = {
            BackgroundTransparency = 1,
            width = UDim.new(1, 0),
            contentPadding = UDim.new(0, 12),
            margin = { top = 12, bottom = 12 }
        }

        tbl4[Roact.Change.AbsoluteSize] = function(arg2)
            if tbl1.contentSize.X ~= arg2.AbsoluteSize.X or tbl1.contentSize.Y ~= arg2.AbsoluteSize.Y then
                tbl1.updateContentSizes(tbl1.props.screenSize, arg2.AbsoluteSize)
            end
        end

        return createElement(var2, tbl3, {
            createElement2(var3, tbl4, {
                Icon = Roact.createElement(ImageSetLabel, {
                    LayoutOrder = 1,
                    BackgroundTransparency = 1,
                    Size = tbl1.state.iconSize,
                    ScaleType = Enum.ScaleType.Fit,
                    Image = Images["icons/graphic/premium_large"]
                }),
                PremiumInfoContainer = Roact.createElement(
                    "Frame",
                    {
                        LayoutOrder = 2,
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, 0),
                        AutomaticSize = Enum.AutomaticSize.Y
                    },
                    {
                        Padding = Roact.createElement("UIPadding", { PaddingBottom = UDim.new(0, 12) }),
                        ListLayout = Roact.createElement(
                            "UIListLayout",
                            {
                                FillDirection = Enum.FillDirection.Vertical,
                                SortOrder = Enum.SortOrder.LayoutOrder,
                                Padding = UDim.new(0, 12)
                            }
                        ),
                        PremiumHeader = Roact.createElement("TextLabel", {
                            LayoutOrder = 1,
                            BackgroundTransparency = 1,
                            Size = UDim2.new(1, 0, 0, 0),
                            AutomaticSize = Enum.AutomaticSize.Y,
                            TextXAlignment = Enum.TextXAlignment.Center,
                            FontFace = normalizeFontFace(arg1.Tokens.Typography.TitleLarge.Font),
                            RichText = true,
                            Text = tbl2.headerLocalizedText,
                            TextSize = font.BaseSize * font.Header2.RelativeSize,
                            TextColor3 = theme.TextEmphasis.Color,
                            TextTransparency = theme.TextDefault.Transparency
                        }),
                        CostPerMonth = Roact.createElement("TextLabel", {
                            LayoutOrder = 2,
                            BackgroundTransparency = 1,
                            Size = UDim2.new(1, 0, 0, 0),
                            AutomaticSize = Enum.AutomaticSize.Y,
                            TextXAlignment = Enum.TextXAlignment.Center,
                            FontFace = normalizeFontFace(arg1.Tokens.Typography.BodyLarge.Font),
                            RichText = true,
                            Text = tbl2.priceLocalizedText,
                            TextSize = font.BaseSize,
                            TextColor3 = theme.TextEmphasis.Color,
                            TextTransparency = theme.TextDefault.Transparency
                        }),
                        CancelText = Roact.createElement("TextLabel", {
                            LayoutOrder = 3,
                            BackgroundTransparency = 1,
                            Size = UDim2.new(1, 0, 0, 0),
                            AutomaticSize = Enum.AutomaticSize.Y,
                            TextXAlignment = Enum.TextXAlignment.Center,
                            FontFace = normalizeFontFace(arg1.Tokens.Typography.BodyLarge.Font),
                            Text = tbl2.policyLocalizedText,
                            TextSize = font.BaseSize,
                            TextColor3 = theme.TextDefault.Color,
                            TextTransparency = theme.TextDefault.Transparency
                        })
                    }
                ),
                BulletListText = Roact.createElement("TextLabel", {
                    LayoutOrder = 3,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(0, width, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    FontFace = normalizeFontFace(arg1.Tokens.Typography.BodyLarge.Font),
                    Text = tbl2.descLocalizedText,
                    TextSize = font.BaseSize * font.Body.RelativeSize,
                    TextColor3 = theme.TextDefault.Color,
                    TextTransparency = theme.TextDefault.Transparency
                }),
                BulletList = Roact.createElement(
                    FitFrameVertical,
                    {
                        LayoutOrder = 4,
                        BackgroundTransparency = 1,
                        width = UDim.new(1, 0),
                        contentPadding = UDim.new(0, 12)
                    },
                    {
                        BulletText1 = Roact.createElement(BulletPoint, { text = tbl2.bulletPoint1Text, width = width, layoutOrder = 1 }),
                        BulletText2 = Roact.createElement(BulletPoint, { text = tbl2.bulletPoint2Text, width = width, layoutOrder = 2 }),
                        BulletText3 = Roact.createElement(BulletPoint, { text = tbl2.bulletPoint3Text, width = width, layoutOrder = 3 })
                    }
                ),
                Disclosure = tbl1:renderDisclosure(tbl2)
            })
        })
    end)
end

function var1.renderPrompt(tbl1, tbl2)
    local props = tbl1.props

    if props.screenSize.Y < 450 then
        return tbl1:renderLandscapePrompt(tbl2)
    elseif props.screenSize.X < 450 then
        return tbl1:renderPortraitPrompt(tbl2)
    end
    return tbl1:renderUpdatedPrompt(tbl2)
end

return var1
