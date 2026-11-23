-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:41:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpUpsell = script:FindFirstAncestor("AmpUpsell")
local AmpUpsellParent = AmpUpsell.Parent
local UIBlox = require(AmpUpsellParent.UIBlox)
local normalizeFontFace = require(AmpUpsellParent.Foundation).Utility.normalizeFontFace
local React = require(AmpUpsellParent.React)
local Roact = require(AmpUpsellParent.Roact)
local useLocalization = require(AmpUpsellParent.Localization).Hooks.useLocalization
local AnalyticsService = require(AmpUpsell.Analytics.AnalyticsService)
local sendButtonClickEvent = require(AmpUpsell.Analytics.sendButtonClickEvent)
local AppScreens = require(AmpUpsell.Common.AppScreens)
local PartialPageModal = UIBlox.App.Dialog.Modal.PartialPageModal
local useStyle = UIBlox.Core.Style.useStyle
local LinkButton = UIBlox.App.Button.LinkButton
local idvWithQRCodeUpsellStrings = require(AmpUpsell.Common.LocalizationStrings).idvWithQRCodeUpsellStrings
local DirectionsTile = require(script.Parent.DirectionsTile)
local ProgressChecklist = require(script.Parent.ProgressChecklist)
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local useSelector = require(AmpUpsellParent.RoactUtils).Hooks.RoactRodux.useSelector

local function IDVDirectLinkUpsell(tbl1)
    local featureName = tbl1.featureName
    local var1 = useLocalization(idvWithQRCodeUpsellStrings)
    local var2 = useStyle()
    local onClose = tbl1.onClose
    local openPrivacyPolicyLink = tbl1.openPrivacyPolicyLink
    local baseSize = var2.Font.BaseSize
    local textEmphasisTransparency = var2.Theme.TextEmphasis.Transparency
    local textSize = baseSize * var2.Font.CaptionBody.RelativeSize
    local var4 = tbl1.analyticsService or AnalyticsService.EventStream
    local idvLink = tbl1.idvLink
    local latestStepCompleted = tbl1.latestStepCompleted
    local bool1 = latestStepCompleted > 0
    local openIdvLink = tbl1.openIdvLink
    local screenSize = useSelector(function(arg1)
        return arg1.ScreenSize
    end)

    local createElement = React.createElement
    local var6 = PartialPageModal

    local tbl2 = {
        title = var1.title,
        screenSize = screenSize,
        onCloseClicked = React.useCallback(function()
            sendButtonClickEvent(var4, AppScreens.IDVDirectLinkUpsell, featureName, "CloseModal")
            onClose()
        end, { var4, featureName }),
        buttonStackProps = {
            forcedFillDirection = Enum.FillDirection.Vertical,
            buttonHeight = 36,
            buttons = {
                {
                    buttonType = ButtonType.Secondary,
                    props = {
                        isDisabled = false,
                        onActivated = React.useCallback(function()
                            sendButtonClickEvent(var4, AppScreens.IDVDirectLinkUpsell, featureName, "CloseModal")
                            onClose()
                        end, { var4, featureName }),
                        text = var1.cancel
                    }
                },
                {
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        isDisabled = false,
                        onActivated = React.useCallback(function()
                            if idvLink ~= nil then
                                sendButtonClickEvent(var4, AppScreens.IDVDirectLinkUpsell, featureName, "OpenIdvLink")

                                openIdvLink(idvLink)
                            end
                        end, {
                            openIdvLink,
                            idvLink,
                            var4,
                            featureName
                        }),
                        text = var1.startVerification
                    }
                }
            }
        }
    }

    local tbl3 = { DirectLinkViewFrame = 0 }
    local createElement2 = React.createElement
    local str1 = "Frame"
    local tbl4 = {
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundTransparency = 1
    }
    local tbl5 = {
        UIPadding = React.createElement("UIPadding", { PaddingTop = UDim.new(0, 24), PaddingBottom = UDim.new(0, 24) }),
        UIListLayout = React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, 24)
        }),
        DirectionsFrameOrProgressChecklist = 0,
        DisclaimerFrame = 0
    }
    local element

    if not bool1 then
        element = React.createElement("Frame", {
            Size = UDim2.new(1, 0, 0, 72),
            BackgroundColor3 = var2.Theme.BackgroundContrast.Color,
            BackgroundTransparency = 0,
            LayoutOrder = 1
        }, {
            UIPadding = React.createElement("UIPadding", {
                PaddingTop = UDim.new(0, 12),
                PaddingBottom = UDim.new(0, 12),
                PaddingLeft = UDim.new(0, 12),
                PaddingRight = UDim.new(0, 12)
            }),
            UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, 8) }),
            IDDirection = React.createElement(DirectionsTile, {
                imagePath = "icons/menu/document",
                headerText = var1.idDirectionsHeader,
                descriptionText = var1.idDirectionsBody,
                frameHeight = 48
            })
        })
    else
        element = React.createElement(ProgressChecklist, { entryHeight = 18, layoutOrder = 1, latestStepCompleted = latestStepCompleted })
    end

    tbl5.DirectionsFrameOrProgressChecklist = element

    tbl5.DisclaimerFrame = React.createElement(
        "Frame",
        {
            Size = UDim2.new(1, 0, 0, 100),
            BackgroundTransparency = 1,
            LayoutOrder = 2
        },
        {
            UIListLayout = React.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Top
            }),
            Disclaimer = React.createElement("TextLabel", {
                Text = var1.disclaimer,
                FontFace = normalizeFontFace(var2.Tokens.Typography.BodyLarge.Font),
                TextSize = textSize,
                TextColor3 = var2.Theme.TextDefault.Color,
                TextTransparency = textEmphasisTransparency,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = true,
                AutomaticSize = Enum.AutomaticSize.XY,
                BackgroundTransparency = 1,
                LayoutOrder = 1
            }),
            PrivacyPolicy = Roact.createElement(LinkButton, {
                text = var1.privacyLinkText,
                layoutOrder = 2,
                fontStyle = "CaptionBody",
                underlineAlwaysEnabled = true,
                onActivated = function()
                    sendButtonClickEvent(var4, AppScreens.IDVDirectLinkUpsell, featureName, "OpenPrivacyPolicy")

                    openPrivacyPolicyLink()
                end
            })
        }
    )

    tbl3.DirectLinkViewFrame = createElement2(str1, tbl4, tbl5)
    return createElement(var6, tbl2, tbl3)
end

return IDVDirectLinkUpsell
