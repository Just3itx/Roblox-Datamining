-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local UrlBuilder = require(scriptParentParentParent.UrlBuilder).UrlBuilder
local NavigateDown = require(scriptParentParentParent.NavigationRodux).Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(scriptParentParentParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(scriptParentParentParent.RobloxAppNavigation).NavigationCommands else nil
local useDispatch = require(scriptParentParentParent.RoactUtils).Hooks.RoactRodux.useDispatch
local AppPage = require(scriptParentParentParent.RobloxAppEnums).AppPage

local VerifiedBadges = require(scriptParentParentParent.VerifiedBadges)
local React = require(scriptParentParentParent.React)
local GetTextSize = require(scriptParentParentParent.Style).GetTextSize

local UIBlox = require(scriptParentParentParent.UIBlox)
local PartialPageModal = UIBlox.App.Dialog.Modal.PartialPageModal
local getPartialPageModalMiddleContentWidth = UIBlox.App.Dialog.Modal.getPartialPageModalMiddleContentWidth
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local withStyle = UIBlox.Style.withStyle

local Foundation = require(scriptParentParentParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text
local Enums = Foundation.Enums
local getIconRichText = Foundation.Utility.getIconRichText
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local useTokens = Foundation.Hooks.useTokens

local MultiTextLocalizer = require(scriptParentParent.Locale.MultiTextLocalizer)
local SubscriptionTitle = require(scriptParentParent.Subscription.SubscriptionTitle)

local FFlagHideDevSubsPriceIfSubscribed = require(scriptParentParent.Parent.SharedFlags).FFlagHideDevSubsPriceIfSubscribed

local FFlagEnableDevSubsFastFollowFixes = require(scriptParentParent.Parent.SharedFlags).FFlagEnableDevSubsFastFollowFixes

local function generateTestmodeDisclaimer(text, _, theme, x: number?, arg1)
    local yOffset = GetTextSize(text, 12, arg1.Typography.CaptionSmall.Font, Vector2.new(x, math.huge), { addTemporaryPadding = false }).Y + 2
    return React.createElement("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0, 16),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        LayoutOrder = 2,
        Size = UDim2.new(1, -48, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y
    }, {
        DisclaimerText = React.createElement("TextLabel", {
            LayoutOrder = 1,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, yOffset),
            FontFace = normalizeFontFace(arg1.Typography.CaptionSmall.Font),
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,
            Text = text,
            TextSize = 12,
            TextColor3 = theme.TextDefault.Color
        })
    })
end

local function generatePromptText(arg1, _, theme, xOffset: number?, callback, layoutOrder, arg2)
    local createElement = React.createElement
    local tbl1 = {
        LayoutOrder = layoutOrder or 2,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, xOffset, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        TextXAlignment = Enum.TextXAlignment.Left,
        FontFace = normalizeFontFace(arg2.Typography.BodyLarge.Font),
        Text = arg1.description,
        TextSize = 16,
        TextWrapped = true,
        TextColor3 = theme.TextDefault.Color,
        TextTransparency = theme.TextDefault.Transparency,
        RichText = true
    }

    tbl1[React.Change.AbsoluteSize] = function(arg3)
        local textSizeY = GetTextSize(
            arg3.Text,
            arg3.TextSize,
            arg2.Typography.BodyLarge.Font,
            Vector2.new(arg3.AbsoluteSize.X, math.huge),
            { addTemporaryPadding = false }
        ).Y
        callback(textSizeY)
    end

    return createElement("TextLabel", tbl1)
end

local function createSubscribeButtonStacks(tbl1, arg1): {{buttonType: any, props: {isDisabled: boolean, layoutOrder: number, onActivated: () -> (), text: any}}} | {{buttonType: any, props: {layoutOrder: number, onActivated: () -> (), text: any}}}
    if tbl1.disablePurchase then
        return {{
            buttonType = ButtonType.PrimarySystem,
            props = {
                onActivated = function() end,
                isDisabled = true,
                text = tbl1.disablePurchaseText,
                layoutOrder = 0
            }
        }}
    end

    if tbl1.secondaryPaymentMethod == nil or tbl1.secondaryPaymentMethod == "" then
        return {{
            buttonType = ButtonType.PrimarySystem,
            props = {
                onActivated = function()
                    tbl1.purchaseSubscriptionActivated(tbl1.primaryPaymentMethod)
                end,
                text = arg1.subscribe,
                layoutOrder = 0
            }
        }}
    end

    local var1 = nil
    if tbl1.primaryPaymentMethod == "Stripe" then
        var1 = arg1.subscribeWithCreditDebitCard
    elseif tbl1.primaryPaymentMethod == "CreditBalance" then
        var1 = arg1.subscribeWithRobloxCredit
    end

    return {
        {
            buttonType = ButtonType.PrimarySystem,
            props = {
                onActivated = function()
                    tbl1.purchaseSubscriptionActivated(tbl1.primaryPaymentMethod)
                end,
                text = var1,
                layoutOrder = 0
            }
        },
        {
            buttonType = ButtonType.Secondary,
            props = {
                onActivated = function()
                    tbl1.purchaseSubscriptionActivated(tbl1.secondaryPaymentMethod)
                end,
                text = arg1.payAnotherWay,
                layoutOrder = 1
            }
        }
    }
end

local function generateDisclosure(arg1, onActivated)
    local tbl1 = string.split(arg1.DisclosureTermsURL, " {termsofuse} ")
    local var1 = "<u>" .. arg1.TermsOfUse .. "</u>"

    return React.createElement(
        View,
        {
            tag = "row wrap auto-y align-y-center align-x-center size-full-0 gap-xsmall padding-x-xsmall padding-bottom-xsmall"
        },
        {
            DisclosurePayment = React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = arg1.DisclosurePayment,
                tag = "auto-xy text-body content-default text-align-x-left content-muted text-caption-small"
            }),
            BeforeText = React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = tbl1[1],
                tag = "auto-xy text-body content-default text-align-x-left content-muted text-caption-small"
            }),
            TextLink = React.createElement(FoundationText, {
                LayoutOrder = 3,
                RichText = true,
                Text = var1,
                tag = "auto-xy text-body content-default text-align-x-left content-muted text-caption-small",
                onActivated = onActivated
            }),
            AfterText = React.createElement(FoundationText, {
                LayoutOrder = 4,
                Text = tbl1[2],
                tag = "auto-xy text-body content-default text-align-x-left content-muted text-caption-small"
            })
        }
    )
end

local function renderNewModalDesign(tbl1, arg1, theme, font, xOffset, yOffset: number?, onActivated, callback, arg2)
    local var1 = if tbl1.creatorName then tbl1.creatorName .. " " .. (tbl1.creatorVerified and VerifiedBadges.emoji.verified or "") else nil
    local var2 = (if tbl1.isRobuxSubscription then getIconRichText(Enums.IconName.Robux) .. " " else "") .. tbl1.displayPrice .. tbl1.period
    local createElement = React.createElement
    local var3 = PartialPageModal

    local tbl2 = {
        screenSize = tbl1.screenSize,
        contentPadding = UDim.new(0, 24),
        buttonStackProps = {
            buttons = createSubscribeButtonStacks(tbl1, arg1),
            buttonHeight = 48,
            forcedFillDirection = Enum.FillDirection.Vertical
        },
        onCloseClicked = tbl1.cancelPurchaseActivated,
        footerContent = function()
            if tbl1.isTestingMode then
                return generateTestmodeDisclaimer(arg1.footerText, font, theme, xOffset, arg2)
            elseif FFlagEnableDevSubsFastFollowFixes then
                return nil
            end
            return generateDisclosure(arg1, onActivated)
        end
    }
    local createElement2 = React.createElement
    local str1 = "Frame"
    local tbl3 = {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y
    }
    local tbl4 = { PromptScroll = 0 }
    local createElement3 = React.createElement
    local str2 = "ScrollingFrame"
    local tbl5 = {
        BackgroundTransparency = 1,
        LayoutOrder = 3,
        Size = UDim2.new(1, 0, 0, math.min(yOffset, tbl1.screenSize.Y - 240)),
        BorderSizePixel = 0,
        ZIndex = 2,
        ScrollingEnabled = tbl1.screenSize.Y - 240 < yOffset,
        ScrollBarThickness = if tbl1.screenSize.Y - 240 < yOffset then 5 else nil,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        Selectable = false,
        CanvasSize = UDim2.new(1, 0, 0, yOffset)
    }
    local tbl6 = {
        Padding = React.createElement("UIPadding", { PaddingTop = UDim.new(0, 24), PaddingBottom = UDim.new(0, 24) }),
        Layout = React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            Padding = UDim.new(0, 24)
        }),
        HeroImage = React.createElement(
            ImageSetLabel,
            {
                LayoutOrder = 0,
                BackgroundTransparency = 1,
                Size = UDim2.new(0, 150, 0, 150),
                ScaleType = Enum.ScaleType.Fit,
                Image = tbl1.itemIcon
            },
            {
                UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, 12) })
            }
        ),
        AttributionSection = React.createElement(View, {
            LayoutOrder = 1,
            tag = "auto-xy col align-x-start size-full-0"
        }, {
            Layout = React.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                Padding = UDim.new(0, 4)
            }),
            SubscriptionName = React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = tbl1.name,
                tag = "auto-xy content-emphasis text-align-x-left",
                fontStyle = arg2.Typography.HeadingSmall
            }),
            CreatorName = React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = var1,
                tag = "auto-xy content-default text-align-x-left",
                fontStyle = arg2.Typography.TitleLarge
            }),
            PriceRow = if tbl1.disablePurchase and FFlagHideDevSubsPriceIfSubscribed then nil else React.createElement(
                FoundationText,
                {
                    LayoutOrder = 3,
                    Text = var2,
                    RichText = true,
                    tag = "auto-xy content-emphasis text-align-x-left",
                    fontStyle = arg2.Typography.TitleLarge
                }
            )
        }),
        ActionButtonsRow = React.createElement(
            View,
            { LayoutOrder = 2, tag = "row gap-small auto-y size-full-0 align-x-left" },
            {
                ShareButton = if tbl1.onShare then React.createElement(Foundation.Chip, {
                    text = arg1.shareText,
                    leading = {
                        iconName = Enums.IconName.ArrowThickToRight
                    },
                    size = Enums.ChipSize.Small,
                    onActivated = tbl1.onShare,
                    LayoutOrder = 1
                }) else nil,
                ReportButton = if tbl1.onReport then React.createElement(Foundation.Chip, {
                    text = arg1.reportText,
                    leading = {
                        iconName = Enums.IconName.Flag
                    },
                    size = Enums.ChipSize.Small,
                    onActivated = tbl1.onReport,
                    LayoutOrder = 2
                }) else nil
            }
        ),
        generatePromptText(tbl1, font, theme, xOffset, callback, 3, arg2)
    }
    tbl4.PromptScroll = createElement3(str2, tbl5, tbl6)
    return createElement(var3, tbl2, { createElement2(str1, tbl3, tbl4) })
end

local function SubscriptionPurchasePrompt(tbl1)
    local yOffset, var1 = React.useState(0)
    local var2 = useDispatch()
    local var3 = useTokens()

    local function openTermsOfUse()
        local detail = UrlBuilder.static.about.terms()
        local tbl2 = {
            name = AppPage.GenericWebPage,
            detail = detail
        }
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl2))
            return
        end
        var2(NavigateDown(tbl2))
    end

    local function calculatePromptHeight(arg1)
        if tbl1.shouldUseNewModalDesign then
            var1(338 + arg1 + 24)
            return
        end

        var1(24 + SubscriptionTitle:getTitleHeight(tbl1.screenSize.Y - 240) + 24 + arg1)
    end

    return React.createElement(MultiTextLocalizer, {
        keys = {
            titleText = { key = "IAPExperience.SubscriptionPurchasePrompt.Label.GetSubscription" },
            subscribe = { key = "Feature.Subscription.Action.Subscribe" },
            subscribeWithCreditDebitCard = {
                key = "Feature.Subscription.Action.SubscribeWithCreditDebitCard"
            },
            subscribeWithRobloxCredit = {
                key = "Feature.Subscription.Action.SubscribeWithRobloxCredit"
            },
            payAnotherWay = { key = "Feature.Subscription.Action.SubscribePayAnotherWay" },
            footerText = {
                key = "IAPExperience.SubscriptionPurchasePrompt.Label.TestFlowDisclaimer"
            },
            DisclosurePayment = { key = "IAPExperience.RobuxUpsell.Text.DisclosurePayment" },
            DisclosureTermsURL = { key = "IAPExperience.RobuxUpsell.Text.DisclosureTermsURL" },
            TermsOfUse = { key = "IAPExperience.RobuxUpsell.Text.TermsOfUse" },
            shareText = { key = "Feature.SocialShare.Action.Share" },
            reportText = { key = "Feature.GameDetails.Action.Report" }
        },
        render = function(arg1)
            return withStyle(function(arg2)
                local theme = arg2.Theme
                local font = arg2.Font
                local partialPageModalMiddleContentWidth = getPartialPageModalMiddleContentWidth(tbl1.screenSize.X)

                if tbl1.shouldUseNewModalDesign then
                    return renderNewModalDesign(
                        tbl1,
                        arg1,
                        theme,
                        font,
                        partialPageModalMiddleContentWidth,
                        yOffset,
                        openTermsOfUse,
                        calculatePromptHeight,
                        var3
                    )
                end

                local createElement = React.createElement
                local var4 = PartialPageModal

                local tbl2 = {
                    title = arg1.titleText,
                    screenSize = tbl1.screenSize,
                    contentPadding = UDim.new(0, 24),
                    buttonStackProps = {
                        buttons = createSubscribeButtonStacks(tbl1, arg1),
                        buttonHeight = 48,
                        forcedFillDirection = Enum.FillDirection.Vertical
                    },
                    onCloseClicked = tbl1.cancelPurchaseActivated,
                    footerContent = function()
                        if tbl1.isTestingMode then
                            return generateTestmodeDisclaimer(arg1.footerText, font, theme, partialPageModalMiddleContentWidth, var3)
                        elseif FFlagEnableDevSubsFastFollowFixes then
                            return nil
                        end
                        return generateDisclosure(arg1, openTermsOfUse)
                    end
                }
                local createElement2 = React.createElement
                local tbl3 = {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y
                }
                local tbl4 = {
                    PromptScroll = React.createElement("ScrollingFrame", {
                        BackgroundTransparency = 1,
                        LayoutOrder = 3,
                        Size = UDim2.new(1, 0, 0, math.min(yOffset, tbl1.screenSize.Y - 240)),
                        BorderSizePixel = 0,
                        ZIndex = 2,
                        ScrollingEnabled = yOffset > tbl1.screenSize.Y - 240,
                        ScrollBarThickness = if yOffset > tbl1.screenSize.Y - 240 then 5 else nil,
                        ScrollingDirection = Enum.ScrollingDirection.Y,
                        Selectable = false,
                        CanvasSize = UDim2.new(1, 0, 0, yOffset)
                    }, {
                        Padding = React.createElement("UIPadding", { PaddingTop = UDim.new(0, 24), PaddingBottom = UDim.new(0, 24) }),
                        Layout = React.createElement("UIListLayout", {
                            SortOrder = Enum.SortOrder.LayoutOrder,
                            HorizontalAlignment = Enum.HorizontalAlignment.Center,
                            Padding = UDim.new(0, 24)
                        }),
                        SubscriptionTitleSection = React.createElement(SubscriptionTitle, {
                            subscriptionProviderName = tbl1.subscriptionProviderName,
                            name = tbl1.name,
                            displayPrice = tbl1.displayPrice,
                            period = tbl1.period,
                            disclaimerText = tbl1.disclaimerText,
                            layoutOrder = 2,
                            contentHeight = tbl1.screenSize.Y - 240,
                            itemIcon = tbl1.itemIcon
                        }),
                        generatePromptText(tbl1, font, theme, partialPageModalMiddleContentWidth, calculatePromptHeight, 2, var3)
                    })
                }
                return createElement(var4, tbl2, { createElement2("Frame", tbl3, tbl4) })
            end)
        end
    })
end

return SubscriptionPurchasePrompt
