-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:11:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent

local Roact = require(AuthCommonParent.Roact)
local RoactRodux = require(AuthCommonParent.RoactRodux)
local UIBlox = require(AuthCommonParent.UIBlox)
local Foundation = require(AuthCommonParent.Foundation)
local normalizeFontFace = Foundation.Utility.normalizeFontFace
local LinkButton = UIBlox.App.Button.LinkButton
local ContextualMenu = UIBlox.App.Menu.ContextualMenu
local MenuDirection = UIBlox.App.Menu.MenuDirection
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local AppLinking = require(AuthCommonParent.RoactServiceTags).AppLinking
local RoactServices = require(AuthCommonParent.RoactServices).RoactServices
local RoactAppPolicy = require(AuthCommonParent.UniversalAppPolicy).RoactAppPolicy
local Cryo = require(AuthCommonParent.Cryo)
local Style = require(AuthCommonParent.Style)
local GetTextSize = Style.GetTextSize
local useDesignTokens = Style.useDesignTokens
local UiMode = require(AuthCommonParent.RobloxAppEnums).UiMode
local useUiModeInfo = require(AuthCommonParent.RobloxAppHooks).useUiModeInfo
local FFlagFoundationStylingOnSignUp = require(AuthCommonParent.SharedFlags).FFlagFoundationStylingOnSignUp
local DisclaimerLinksVariant = require(AuthCommon.Enums.DisclaimerLinksVariant)

local FitChildren = require(AuthCommon.Components.FitChildren)
local NavigateDown = require(AuthCommonParent.NavigationRodux).Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(AuthCommonParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(AuthCommonParent.RobloxAppNavigation).NavigationCommands else nil
local AppPage = require(AuthCommonParent.RobloxAppEnums).AppPage

local TransitionAnimation = require(AuthCommon.Enums.TransitionAnimation)

local withLocalization = require(AuthCommonParent.Localization).withLocalization
local withStyle = UIBlox.Style.withStyle

local OpenExternalBrowser = require(AuthCommon.Thunks.OpenExternalBrowser)
local UrlBuilder = require(AuthCommonParent.UrlBuilder).UrlBuilder
local AuthAnalytics = require(AuthCommonParent.AuthAnalytics)
local authFormInteraction = AuthAnalytics.Events.authFormInteraction
local EventStreamConstants = AuthAnalytics.EventStreamConstants

local DisclaimerLinkButtons = require(script.Parent.DisclaimerLinkButtons)

local RegisterAuditContent = require(AuthCommon.Components.RegisterAuditContent)
local RegisterAdditionalAuditContent = require(AuthCommon.Components.RegisterAdditionalAuditContent)

local GetFFlagEnableAuditForSinglePageSignUp = require(AuthCommonParent.SharedFlags).GetFFlagEnableAuditForSinglePageSignUp

local tbl1 = {
    [DisclaimerLinksVariant.Default] = "TextDefault",
    [DisclaimerLinksVariant.Link] = nil
}
local stateLayer = {
    affordance = Foundation.Enums.StateLayerAffordance.None
}

local function createFoundationLink(text, onActivated, layoutOrder: number, underlineLinks, underlinedLinkTextTag)
    if not underlineLinks then
        return Roact.createElement(Foundation.Button, {
            text = text,
            variant = Foundation.Enums.ButtonVariant.Utility,
            size = Foundation.Enums.ButtonSize.Small,
            onActivated = onActivated,
            LayoutOrder = layoutOrder
        })
    end

    return Roact.createElement(
        Foundation.View,
        {
            tag = "auto-xy padding-small",
            onActivated = onActivated,
            stateLayer = stateLayer,
            LayoutOrder = layoutOrder
        },
        {
            Label = Roact.createElement(Foundation.Text, {
                Text = `<u>{text}</u>`,
                RichText = true,
                tag = `auto-xy content-emphasis {underlinedLinkTextTag or "text-caption-small"}`
            })
        }
    )
end

local var1 = Roact.PureComponent:extend("DisclaimerLinks")

function var1.init(arg1)
    function arg1.openDisclaimerLink(detail)
        if arg1.props.useExternalBrowserForDisclaimerLinks then
            OpenExternalBrowser(arg1.props.linking, detail)
            return
        end
        arg1.props.navigateDown({
            name = AppPage.GenericWebPage,
            detail = detail,
            extraProps = {
                title = "",
                transitionAnimation = TransitionAnimation.SlideInFromRight
            }
        })
    end

    function arg1.openTermsLink()
        local var2 = UrlBuilder.static.about.terms()
        if arg1.props.ctx then
            authFormInteraction(arg1.props.ctx, EventStreamConstants.Field.TermsOfService, arg1.props.state)
        end
        arg1.openDisclaimerLink(var2)
    end

    function arg1.openPrivacyLink()
        local var2 = UrlBuilder.static.about.privacy()
        if arg1.props.ctx then
            authFormInteraction(arg1.props.ctx, EventStreamConstants.Field.PrivacyPolicy, arg1.props.state)
        end
        arg1.openDisclaimerLink(var2)
    end
end

function var1.render(arg1)
    local isDualLayout = arg1.props.isDualLayout

    local loginView = arg1.props.tokens.LuaApps.LoginView
    local var2 = if loginView then loginView.boxPadding else 4

    return withLocalization({
        termsOfUseText = "CommonUI.Features.Label.Terms",
        termsOfUseTextLong = "CommonUI.Features.Label.TermsOfUse",
        privacyPolicyText = "CommonUI.Features.Label.Privacy",
        privacyPolicyTextLong = "CommonUI.Features.Label.PrivacyPolicy"
    })(
        function(arg2)
            return withStyle(function(arg3)
                local bool1 = arg1.props.uiModeInfo.uiMode == UiMode.TenFoot
                local layoutOrder = arg1.props.LayoutOrder
                local var3 = if FFlagFoundationStylingOnSignUp then tbl1[arg1.props.variant] else nil
                local baseSize = arg3.Font.BaseSize
                local translationKey = if isDualLayout then "CommonUI.Features.Label.TermsOfUse" else "CommonUI.Features.Label.Terms"

                local str1 = if isDualLayout then "CommonUI.Features.Label.PrivacyPolicy" else "CommonUI.Features.Label.Privacy"
                local var4 = if isDualLayout then arg2.termsOfUseTextLong else arg2.termsOfUseText
                local var5 = if isDualLayout then arg2.privacyPolicyTextLong else "<b>" .. arg2.privacyPolicyText .. "</b>"
                local offset = GetTextSize(" ", baseSize, arg3.Tokens.Typography.TitleLarge.Font, Vector2.new(10000, 10000)).X / 2

                local textSizeX = GetTextSize("-", baseSize, arg3.Tokens.Typography.TitleLarge.Font, Vector2.new(10000, 10000)).X
                local textSizeY = GetTextSize(arg2.privacyPolicyText, baseSize, arg3.Tokens.Typography.TitleLarge.Font, Vector2.new(10000, 10000)).Y
                local yOffset = textSizeY + var2

                if isDualLayout then
                    yOffset = 2 * (textSizeY + 2 * var2)
                end

                local var6 = if isDualLayout then "Frame" else FitChildren.FitFrame

                local function renderRightSideGadget()
                    return {
                        Image = Roact.createElement(ImageSetLabel, {
                            Size = UDim2.new(0, loginView.disclaimerIconSize, 0, loginView.disclaimerIconSize),
                            Position = UDim2.fromOffset(0, 0),
                            BackgroundTransparency = 1,
                            LayoutOrder = 1,
                            ScaleType = Enum.ScaleType.Fit,
                            Image = loginView.linkIcon,
                            ImageColor3 = arg3.Theme.UIEmphasis.Color,
                            ImageTransparency = 0
                        })
                    }
                end

                local function func2()
                    if not (arg1.props.enableAuditContentCapture and GetFFlagEnableAuditForSinglePageSignUp()) then
                        return {}
                    end
                    local tbl3 = {
                        TermsAuditContent = RegisterAuditContent
                            and var4
                            and Roact.createElement(RegisterAuditContent, { translationKey = translationKey, translatedSourceString = var4 }),
                        PrivacyAuditContent = RegisterAuditContent
                            and var5
                            and Roact.createElement(RegisterAuditContent, {
                                translationKey = str1,
                                translatedSourceString = if isDualLayout then arg2.privacyPolicyTextLong else arg2.privacyPolicyText
                            }),
                        TermsLinkAuditContent = RegisterAdditionalAuditContent
                            and Roact.createElement(
                                RegisterAdditionalAuditContent,
                                {
                                    contentKey = "termsLink",
                                    value = UrlBuilder.static.about.terms()
                                }
                            ),
                        PrivacyLinkAuditContent = RegisterAdditionalAuditContent
                            and Roact.createElement(
                                RegisterAdditionalAuditContent,
                                {
                                    contentKey = "privacyLink",
                                    value = UrlBuilder.static.about.privacy()
                                }
                            )
                    }
                    return tbl3
                end

                local function func3()
                    local tbl3 = {
                        UIListLayout = Roact.createElement("UIListLayout", {
                            Padding = UDim.new(0, offset),
                            SortOrder = Enum.SortOrder.LayoutOrder,
                            FillDirection = if isDualLayout then Enum.FillDirection.Vertical else Enum.FillDirection.Horizontal,
                            HorizontalAlignment = if isDualLayout then Enum.HorizontalAlignment.Left else Enum.HorizontalAlignment.Center,
                            VerticalAlignment = Enum.VerticalAlignment.Center
                        }),
                        ContextualMenu = 0,
                        TermsOfUse = 0,
                        Hyphen = 0,
                        PrivacyPolicy = 0
                    }
                    local element

                    if isDualLayout then
                        element = Roact.createElement(ContextualMenu, {
                            buttonProps = {
                                {
                                    text = var4,
                                    fontStyle = arg3.Font.Header1,
                                    onActivated = arg1.openTermsLink,
                                    rightSideGadgetSize = Vector2.new(loginView.disclaimerIconSize + loginView.disclaimerPadding, loginView.disclaimerIconSize),
                                    renderRightSideGadget = renderRightSideGadget
                                },
                                {
                                    text = var5,
                                    fontStyle = arg3.Font.Header1,
                                    onActivated = arg1.openPrivacyLink,
                                    rightSideGadgetSize = Vector2.new(loginView.disclaimerIconSize + loginView.disclaimerPadding, loginView.disclaimerIconSize),
                                    renderRightSideGadget = renderRightSideGadget
                                }
                            },
                            open = true,
                            stayOnActivated = true,
                            isElementBackgroundVisible = false,
                            isElementDividerVisible = false,
                            closeBackgroundVisible = false,
                            topElementRounded = false,
                            bottomElementRounded = false,
                            horizontalAlignment = Enum.HorizontalAlignment.Center,
                            menuDirection = MenuDirection.Down,
                            contextMenuWidthOverride = UDim.new(1, 0),
                            elementHeight = loginView.disclaimerElementHeight,
                            openPositionX = UDim.new(0, 0),
                            openPositionY = UDim.new(0, 0),
                            screenSize = Vector2.new(0, 0)
                        })
                    else
                        element = nil
                    end

                    tbl3.ContextualMenu = element
                    local element2 = if isDualLayout then nil else Roact.createElement(LinkButton, {
                        text = var4,
                        size = if isDualLayout then UDim2.new(1, 0, 0.5, 0) else UDim2.new(0, 0, 1, 0),
                        fontStyle = "Header2",
                        layoutOrder = 1,
                        underlineAlwaysEnabled = true,
                        onActivated = arg1.openTermsLink,
                        colorStyleDefault = var3,
                        colorStyleHover = var3
                    })
                    tbl3.TermsOfUse = element2
                    local element3

                    if isDualLayout then
                        element3 = nil
                    else
                        element3 = Roact.createElement("TextLabel", {
                            BackgroundTransparency = 1,
                            Text = " ",
                            Size = UDim2.new(0, textSizeX, 1, 0),
                            FontFace = normalizeFontFace(arg3.Tokens.Typography.TitleLarge.Font),
                            TextColor3 = arg3.Theme.TextEmphasis.Color,
                            TextTransparency = arg3.Theme.TextEmphasis.Transparency,
                            TextSize = baseSize,
                            LayoutOrder = 2
                        })
                    end

                    tbl3.Hyphen = element3
                    local element4 = if isDualLayout then nil else Roact.createElement(LinkButton, {
                        text = var5,
                        size = if isDualLayout then UDim2.new(1, 0, 0.5, 0) else UDim2.new(0, 0, 1, 0),
                        fontStyle = "Header2",
                        layoutOrder = 3,
                        underlineAlwaysEnabled = true,
                        onActivated = arg1.openPrivacyLink,
                        colorStyleDefault = var3,
                        colorStyleHover = var3
                    })
                    tbl3.PrivacyPolicy = element4
                    return tbl3
                end

                if arg1.props.variant == DisclaimerLinksVariant.Foundation and not (isDualLayout or bool1) then
                    return Roact.createElement(
                        "Frame",
                        {
                            Size = UDim2.new(0, 0, 0, 0),
                            AutomaticSize = Enum.AutomaticSize.XY,
                            BackgroundTransparency = 1,
                            LayoutOrder = layoutOrder
                        },
                        Cryo.Dictionary.join({
                            UIListLayout = Roact.createElement("UIListLayout", {
                                FillDirection = Enum.FillDirection.Horizontal,
                                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                                SortOrder = Enum.SortOrder.LayoutOrder
                            }),
                            TermsOfUse = createFoundationLink(
                                arg2.termsOfUseText,
                                arg1.openTermsLink,
                                1,
                                arg1.props.underlineLinks,
                                arg1.props.underlinedLinkTextTag
                            ),
                            PrivacyPolicy = createFoundationLink(
                                arg2.privacyPolicyText,
                                arg1.openPrivacyLink,
                                2,
                                arg1.props.underlineLinks,
                                arg1.props.underlinedLinkTextTag
                            )
                        }, (func2()))
                    )
                elseif bool1 then
                    if GetFFlagEnableAuditForSinglePageSignUp() then
                        return Roact.createFragment(
                            Cryo.Dictionary.join({
                                DisclaimerLinkButtons = Roact.createElement(DisclaimerLinkButtons, {
                                    textTos = var4,
                                    activatedTos = arg1.openTermsLink,
                                    textPrivacy = var5,
                                    activatedPrivacy = arg1.openPrivacyLink,
                                    fillDirection = arg1.props.fillDirection,
                                    layoutOrder = layoutOrder,
                                    tokens = loginView
                                })
                            }, (func2()))
                        )
                    end

                    return Roact.createElement(DisclaimerLinkButtons, {
                        textTos = var4,
                        activatedTos = arg1.openTermsLink,
                        textPrivacy = var5,
                        activatedPrivacy = arg1.openPrivacyLink,
                        fillDirection = arg1.props.fillDirection,
                        layoutOrder = layoutOrder,
                        tokens = loginView
                    })
                else
                    local tbl3 = {
                        fitAxis = if isDualLayout then nil else FitChildren.FitAxis.Width,
                        Size = UDim2.new(1, 0, 0, yOffset),
                        BackgroundTransparency = 1,
                        LayoutOrder = layoutOrder
                    }

                    if GetFFlagEnableAuditForSinglePageSignUp() then
                        return Roact.createElement(var6, tbl3, Cryo.Dictionary.join(func3(), (func2())))
                    end

                    return Roact.createElement(var6, tbl3, (func3()))
                end
            end)
        end
    )
end
local var2 = RoactRodux.connect(function(_, _)
    return {}
end, function(arg1)
    return {
        navigateDown = function(arg2)
            if FFlagSignalsNavP3Dispatch then
                return NavigationCommands.down(NavigationCommands.fromLegacyPage(arg2))
            end
            return arg1(NavigateDown(arg2))
        end
    }
end)(var1)

local var3 = RoactAppPolicy.connect(function(arg1)
    return {
        useExternalBrowserForDisclaimerLinks = arg1.shouldUseExternalBrowserForDisclaimerLinks()
    }
end)(var2)

local var4 = RoactServices.connect({ linking = AppLinking })(var3)

return function(arg1)
    local tokens = useDesignTokens()
    local uiModeInfo = useUiModeInfo()

    return Roact.createElement(var4, Cryo.Dictionary.join({ tokens = tokens, uiModeInfo = uiModeInfo }, arg1))
end
