-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:50:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpUpsell = script:FindFirstAncestor("AmpUpsell")
local AmpUpsellParent = AmpUpsell.Parent
local UIBlox = require(AmpUpsellParent.UIBlox)
local Foundation = require(AmpUpsellParent.Foundation)
local IconSize = Foundation.Enums.IconSize
local Loading = Foundation.Loading
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local React = require(AmpUpsellParent.React)
local useLocalization = require(AmpUpsellParent.Localization).Hooks.useLocalization
local AnalyticsService = require(AmpUpsell.Analytics.AnalyticsService)
local sendButtonClickEvent = require(AmpUpsell.Analytics.sendButtonClickEvent)
local AppScreens = require(AmpUpsell.Common.AppScreens)
local PartialPageModal = UIBlox.App.Dialog.Modal.PartialPageModal
local useStyle = UIBlox.Core.Style.useStyle
local LinkButton = UIBlox.App.Button.LinkButton
local DirectionsTile = require(script.Parent.DirectionsTile)
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local QRCodeDisplay = require(AmpUpsellParent.QRCodeDisplay)
local DisplayQRCode = QRCodeDisplay.DisplayQRCode
local ECLevels = QRCodeDisplay.ECLevels

local ProgressChecklist = require(script.Parent.ProgressChecklist)
local useSelector = require(AmpUpsellParent.RoactUtils).Hooks.RoactRodux.useSelector
local idvWithQRCodeUpsellStrings = require(AmpUpsell.Common.LocalizationStrings).idvWithQRCodeUpsellStrings

local function IDVWithQRCodeUpsell(tbl1)
    local featureName = tbl1.featureName
    local qrCodeLink = tbl1.qrCodeLink
    local var1 = useLocalization(idvWithQRCodeUpsellStrings)
    local var2 = useStyle()
    local onClose = tbl1.onClose
    local openPrivacyPolicyLink = tbl1.openPrivacyPolicyLink
    local baseSize = var2.Font.BaseSize
    local textEmphasisTransparency = var2.Theme.TextEmphasis.Transparency
    local textSize = baseSize * var2.Font.CaptionBody.RelativeSize
    local var4 = if tbl1.analyticsService then tbl1.analyticsService else AnalyticsService.EventStream
    local uDim2 = UDim2.fromOffset(153, 153)
    local latestStepCompleted = tbl1.latestStepCompleted
    local bool1 = latestStepCompleted > 0
    local screenSize = useSelector(function(arg1)
        return arg1.ScreenSize
    end)

    local createElement = React.createElement
    local var6 = PartialPageModal

    local tbl2 = {
        title = var1.title,
        screenSize = screenSize,
        onCloseClicked = function()
            sendButtonClickEvent(var4, AppScreens.IDVWithQRCodeUpsell, featureName, "CloseModal")
            onClose()
        end,
        bottomPadding = 0
    }

    local tbl3 = { QRCodeViewFrame = 0 }
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
        HeaderText = React.createElement(StyledTextLabel, {
            text = if bool1 then var1.verifyInBrowser else var1.ageVerifyPrompt,
            fontStyle = var2.Font.Header2,
            colorStyle = var2.Theme.TextEmphasis,
            size = UDim2.new(1, 0, 0, 0),
            lineHeight = 1,
            textTruncate = Enum.TextTruncate.AtEnd,
            textXAlignment = Enum.TextXAlignment.Center,
            textYAlignment = Enum.TextYAlignment.Center,
            automaticSize = Enum.AutomaticSize.XY,
            layoutOrder = 0
        }),
        DirectionsFrame = 0,
        Checklist = 0,
        BeginText = 0,
        QRCodeWrapper = 0,
        DisclaimerFrame = 0
    }
    local element

    if bool1 then
        element = nil
    else
        element = React.createElement("Frame", {
            Size = UDim2.new(1, 0, 0, 144),
            BackgroundColor3 = var2.Theme.BackgroundContrast.Color,
            BackgroundTransparency = 0,
            LayoutOrder = 1
        }, {
            UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, 8) }),
            UIPadding = React.createElement("UIPadding", {
                PaddingTop = UDim.new(0, 12),
                PaddingBottom = UDim.new(0, 12),
                PaddingLeft = UDim.new(0, 12),
                PaddingRight = UDim.new(0, 12)
            }),
            UIListLayout = React.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                Padding = UDim.new(0, 24)
            }),
            IDDirection = React.createElement(DirectionsTile, {
                imagePath = "icons/menu/document",
                headerText = var1.idDirectionsHeader,
                descriptionText = var1.idDirectionsBody,
                frameHeight = 48,
                layoutOrder = 1
            }),
            PhoneDirection = React.createElement(DirectionsTile, {
                imagePath = "icons/menu/mobile",
                headerText = var1.phoneDirectionsHeader,
                descriptionText = var1.phoneDirectionsBody,
                frameHeight = 48,
                layoutOrder = 2
            })
        })
    end

    tbl5.DirectionsFrame = element

    tbl5.Checklist = if bool1 then React.createElement(ProgressChecklist, { entryHeight = 18, layoutOrder = 1, latestStepCompleted = latestStepCompleted }) else nil
    local element2

    if bool1 then
        element2 = nil
    else
        element2 = React.createElement(StyledTextLabel, {
            text = var1.beginText,
            fontStyle = var2.Font.Header1,
            colorStyle = var2.Theme.TextEmphasis,
            size = UDim2.new(1, 0, 0, 0),
            lineHeight = 1,
            textTruncate = Enum.TextTruncate.AtEnd,
            textXAlignment = Enum.TextXAlignment.Center,
            textYAlignment = Enum.TextYAlignment.Center,
            automaticSize = Enum.AutomaticSize.XY,
            layoutOrder = 2
        })
    end

    tbl5.BeginText = element2

    tbl5.QRCodeWrapper = React.createElement(
        "Frame",
        {
            Size = uDim2,
            BackgroundColor3 = Color3.fromHex("#FFFFFF"),
            BackgroundTransparency = 0,
            LayoutOrder = 3
        },
        {
            QrCode = if qrCodeLink ~= nil then React.createElement(
                DisplayQRCode,
                {
                    ecLevel = ECLevels.EC_LEVEL_1,
                    sideLength = 150,
                    backgroundTransparency = 1,
                    toEncode = qrCodeLink
                }
            ) else React.createElement(Loading, { size = IconSize.Medium }),
            UIListLayout = React.createElement(
                "UIListLayout",
                {
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    VerticalAlignment = Enum.VerticalAlignment.Center
                }
            ),
            UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, 8) }),
            UIPadding = React.createElement("UIPadding", {
                PaddingBottom = UDim.new(0, 4),
                PaddingLeft = UDim.new(0, 4),
                PaddingRight = UDim.new(0, 4),
                PaddingTop = UDim.new(0, 4)
            })
        }
    )
    local createElement3 = React.createElement
    local str2 = "Frame"
    local tbl6 = {
        Size = UDim2.new(1, 0, 0, 100),
        BackgroundTransparency = 1,
        LayoutOrder = 4
    }

    local tbl7 = {
        UIListLayout = React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Top
        }),
        Disclaimer = 0,
        PrivacyPolicy = 0,
        HavingTroubleInfoText = 0,
        DontCloseWindowDisclaimer = 0
    }
    local element3

    if bool1 then
        element3 = nil
    else
        element3 = React.createElement("TextLabel", {
            Text = var1.disclaimer,
            FontFace = normalizeFontFace(var2.Tokens.Typography.BodyLarge.Font),
            TextSize = textSize,
            TextColor3 = var2.Theme.TextDefault.Color,
            TextTransparency = textEmphasisTransparency,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextWrapped = true,
            AutomaticSize = Enum.AutomaticSize.XY,
            Size = UDim2.new(1, 0, 0, 24),
            BackgroundTransparency = 1,
            LayoutOrder = 1
        })
    end

    tbl7.Disclaimer = element3

    tbl7.PrivacyPolicy = if bool1 then nil else React.createElement(LinkButton, {
        text = var1.privacyLinkText,
        layoutOrder = 2,
        fontStyle = "CaptionBody",
        underlineAlwaysEnabled = true,
        onActivated = function()
            sendButtonClickEvent(var4, AppScreens.IDVWithQRCodeUpsell, featureName, "OpenPrivacyPolicy")

            openPrivacyPolicyLink()
        end
    })

    local element4

    if bool1 then
        element4 = React.createElement(StyledTextLabel, {
            text = var1.havingTroubleInfoText,
            size = UDim2.new(1, 0, 0.5, 0),
            fontStyle = var2.Font.CaptionBody,
            colorStyle = var2.Theme.TextEmphasis,
            lineHeight = 1,
            textTruncate = Enum.TextTruncate.AtEnd,
            textXAlignment = Enum.TextXAlignment.Center,
            textYAlignment = Enum.TextYAlignment.Center,
            layoutOrder = 1
        })
    else
        element4 = nil
    end

    tbl7.HavingTroubleInfoText = element4
    local element5

    if bool1 then
        element5 = React.createElement(StyledTextLabel, {
            text = var1.dontCloseWindowDisclaimer,
            fontStyle = var2.Font.CaptionBody,
            size = UDim2.new(1, 0, 0.5, 0),
            colorStyle = var2.Theme.TextEmphasis,
            lineHeight = 1,
            textTruncate = Enum.TextTruncate.AtEnd,
            textXAlignment = Enum.TextXAlignment.Center,
            textYAlignment = Enum.TextYAlignment.Center,
            layoutOrder = 2
        })
    else
        element5 = nil
    end

    tbl7.DontCloseWindowDisclaimer = element5
    tbl5.DisclaimerFrame = createElement3(str2, tbl6, tbl7)
    tbl3.QRCodeViewFrame = createElement2(str1, tbl4, tbl5)
    return createElement(var6, tbl2, tbl3)
end

return IDVWithQRCodeUpsell
