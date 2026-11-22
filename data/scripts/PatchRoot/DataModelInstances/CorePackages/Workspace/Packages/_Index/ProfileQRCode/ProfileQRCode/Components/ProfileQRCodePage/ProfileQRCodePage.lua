-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:31:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfileQRCode = script:FindFirstAncestor("ProfileQRCode")
local ProfileQRCodeParent = ProfileQRCode.Parent

local React = require(ProfileQRCodeParent.React)
local UIBlox = require(ProfileQRCodeParent.UIBlox)
local Localization = require(ProfileQRCodeParent.Localization)
local ReactFocusNavigation = require(ProfileQRCodeParent.ReactFocusNavigation)
local FocusNavigationUtils = require(ProfileQRCodeParent.FocusNavigationUtils)
local Contexts = require(ProfileQRCodeParent.SocialLuaAnalytics).Analytics.Enums.Contexts
local ProfileShareLinks = require(ProfileQRCodeParent.ProfileShareLinks)
local useAppPolicy = require(ProfileQRCodeParent.UniversalAppPolicy).useAppPolicy
local useProfileShareLink = ProfileShareLinks.Hooks.useProfileShareLink
local ProfileSharePolicyEnum = ProfileShareLinks.Enums.ProfileSharePolicyEnum
local RoactUtils = require(ProfileQRCodeParent.RoactUtils)
local useCloseWithBackButton = require(ProfileQRCodeParent.AppBlox).useCloseWithBackButton

local Button = UIBlox.App.Button.Button
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local StandardButtonSize = UIBlox.App.Button.Enum.StandardButtonSize
local VerticalScrollView = UIBlox.App.Container.VerticalScrollView

local Images = UIBlox.App.ImageSet.Images

local Foundation = require(ProfileQRCodeParent.Foundation)
local InputLabel = Foundation.InputLabel
local InputLabelSize = Foundation.Enums.InputLabelSize

local AppPage = require(ProfileQRCodeParent.RobloxAppEnums).AppPage
local NavigateDown = require(ProfileQRCodeParent.NavigationRodux).Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(ProfileQRCodeParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(ProfileQRCodeParent.RobloxAppNavigation).NavigationCommands else nil
local ProfileQRCodeTopElements = require(ProfileQRCode.Components.ProfileQRCodeTopElements)
local QRCodeView = require(ProfileQRCode.Components.QRCodeView)
local TextKeys = require(ProfileQRCode.Common.TextKeys)
local useIsWideMode = require(ProfileQRCodeParent.SocialCommon).Hooks.useIsWideMode

local useLocalization = Localization.Hooks.useLocalization
local useStyle = UIBlox.Core.Style.useStyle
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useFocusGuiObject = ReactFocusNavigation.useFocusGuiObject
local useLastInputMode = FocusNavigationUtils.useLastInputMode

local white = Color3.new(1, 1, 1)

local FFlagProfileQRCodeFixFocusNavigation = require(ProfileQRCode.Flags.FFlagProfileQRCodeFixFocusNavigation)
local FFlagProfileQRCodeGamepadBackFix = require(ProfileQRCode.Flags.FFlagProfileQRCodeGamepadBackFix)
local FFlagQRCodeCopyUpdates = require(ProfileQRCodeParent.SharedFlags).FFlagQRCodeCopyUpdates
local FFlagQRCodePageVisualRefresh = require(ProfileQRCodeParent.SharedFlags).FFlagQRCodePageVisualRefresh
local FStringCanAccessTrustedContactsAmpFeature = require(ProfileQRCodeParent.SharedFlags).FStringCanAccessTrustedContactsAmpFeature
local FFlagTCPolicyCheckRedirect = require(ProfileQRCodeParent.SharedFlags).FFlagTCPolicyCheckRedirect
local FStringIsUserInTcEligibleCountryAmpFeature = require(ProfileQRCodeParent.SharedFlags).FStringIsUserInTcEligibleCountryAmpFeature
local FStringCanAccessTrustedContactsAmpNameSpace = require(ProfileQRCodeParent.SharedFlags).FStringCanAccessTrustedContactsAmpNameSpace
local AmpApiProvider = require(ProfileQRCodeParent.AmpUpsell).AmpApiProvider
local AmpEnums = require(ProfileQRCodeParent.AmpUpsell).AmpEnums

return function(tbl1)
    local var1 = useDispatch()

    local var2 = useAppPolicy(function(arg1)
        return arg1.getWebViewSupport()
    end)

    local var3 = useLocalization({
        description = TextKeys.ScanQRText,
        descriptionTrustedFriends = TextKeys.TrustedFriendsDescription,
        shareProfileLink = TextKeys.ShareProfileLink,
        copyProfileLink = TextKeys.CopyProfileLink,
        learnMore = "Feature.Chat.Action.LearnMore"
    })

    local onActivated = React.useCallback(function()
        local tbl2 = {
            name = AppPage.GenericWebPage,
            detail = "https://en.help.roblox.com/hc/en-us/articles/37725513985812",
            extraProps = { title = "" }
        }

        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl2))
            return
        end
        var1(NavigateDown(tbl2, nil))
    end, { var1 })

    local isSmallScreen, var6 = React.useState(false)
    local var7 = if FFlagProfileQRCodeFixFocusNavigation then React.useRef(nil) else nil
    local var8 = useIsWideMode()
    local var9 = useStyle()
    local var10 = if FFlagProfileQRCodeFixFocusNavigation then useLastInputMode() else nil
    local var11 = if FFlagProfileQRCodeFixFocusNavigation then useFocusGuiObject() else nil
    local ref = if FFlagProfileQRCodeGamepadBackFix then useCloseWithBackButton(nil, tbl1.onClose) else nil
    local var13 = useProfileShareLink({ context = Contexts.ProfileQRCode })
    local hasLoaded = not (var13.policy == ProfileSharePolicyEnum.Disabled) and var13.hasLoaded
    local var14 = nil
    local var15 = nil
    if var13.policy == ProfileSharePolicyEnum.Share then
        var14 = var3.shareProfileLink
        var15 = Images["icons/actions/share"]
    elseif var13.policy == ProfileSharePolicyEnum.Copy then
        var14 = var3.copyProfileLink
        var15 = Images["icons/menu/link"]
    end

    if FFlagProfileQRCodeFixFocusNavigation then
        React.useEffect(function()
            if var11 and var7 and var7.current and var10 == "Focus" then
                var11(var7.current)
            end
        end, {})
    end

    local var16, var17 = React.useState(false)
    local var18, var19 = React.useState(false)

    if FFlagQRCodeCopyUpdates then
        React.useEffect(function()
            local var20 = if FFlagTCPolicyCheckRedirect then FStringIsUserInTcEligibleCountryAmpFeature else FStringCanAccessTrustedContactsAmpFeature

            if AmpApiProvider.upsellFeatureAccess(var20, {}, FStringCanAccessTrustedContactsAmpNameSpace).access == AmpEnums.AccessResponseEnum.Granted then
                var17(true)
            end
            var19(true)
        end, {})
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ref = ref
    }
    local tbl3 = {
        WidePanel = if FFlagQRCodePageVisualRefresh and var8 then React.createElement(Foundation.View, { tag = "bg-over-media-100", Size = UDim2.fromScale(0.6, 1), ZIndex = 0 }) else nil,
        TopElements = React.createElement(ProfileQRCodeTopElements, {
            appStorageService = tbl1.appStorageService,
            onClose = tbl1.onClose,
            openQrCodeScanner = tbl1.openQrCodeScanner,
            robloxEventReceiver = tbl1.robloxEventReceiver
        }),
        VerticalScrollView = 0
    }

    local createElement2 = React.createElement
    local var20 = VerticalScrollView
    local tbl4 = {
        useAutomaticCanvasSize = true,
        size = if var8 then nil else UDim2.new(1, 0, 1, -24),
        canvasSizeY = UDim.new(),
        position = UDim2.new(0, 0, 0, 56)
    }
    local tbl5 = { GradientBackground = 0 }
    local createElement3 = React.createElement
    local str2 = "Frame"

    local tbl6 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = white,
        BackgroundTransparency = if var8 and not FFlagQRCodePageVisualRefresh then 0.7 else 1,
        Position = UDim2.fromScale(0, 0),
        Size = if var8 then UDim2.fromScale(0.6, 1) else UDim2.fromScale(1, 1),
        BorderSizePixel = 0,
        [React.Change.AbsoluteSize] = React.useCallback(function(arg1)
            if arg1.AbsoluteSize.Y >= 450 then
                var6(true)
                return
            end
            var6(false)
        end)
    }
    local tbl7 = {
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Bottom
        }),
        Content = 0,
        Gradient = 0
    }

    local createElement4 = React.createElement
    local str3 = "Frame"
    local tbl8 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Size = if var8 then UDim2.new(1, 0, 1, -56) else UDim2.new(1, 0, 0.5, 0),
        BorderSizePixel = 0
    }

    local tbl9 = {
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        Padding = React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, 24),
            PaddingRight = UDim.new(0, 24),
            PaddingBottom = UDim.new(0, 24),
            PaddingLeft = UDim.new(0, 24)
        }),
        QRCodeView = React.createElement(QRCodeView, { layoutOrder = 1, isSmallScreen = isSmallScreen }),
        Spacer1 = React.createElement("Frame", {
            AutomaticSize = Enum.AutomaticSize.Y,
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            Size = UDim2.fromOffset(0, if isSmallScreen then 12 else 24),
            LayoutOrder = 2
        }),
        Description = 0,
        LearnMoreWebLink = 0,
        ProfileShareButtonContainer = 0,
        UISizeConstraint = 0
    }
    local element

    if FFlagQRCodeCopyUpdates and var18 == false then
        element = React.createElement("Frame", { Size = UDim2.new(0, 304, 0, 45), BackgroundTransparency = 1, LayoutOrder = 3 })
    else
        element = React.createElement(StyledTextLabel, {
            layoutOrder = 3,
            text = if FFlagQRCodeCopyUpdates and var16 then var3.descriptionTrustedFriends else var3.description,
            fontStyle = var9.Font.CaptionBody,
            lineHeight = 1,
            colorStyle = var9.Theme.TextDefault,
            size = if FFlagQRCodeCopyUpdates and var16 then UDim2.new(0, 304, 0, 0) else UDim2.new(1, 0, 0, 0),
            automaticSize = Enum.AutomaticSize.Y,
            textXAlignment = if FFlagQRCodeCopyUpdates and var16 then Enum.TextXAlignment.Left else Enum.TextXAlignment.Center,
            textYAlignment = if FFlagQRCodeCopyUpdates and var16 then Enum.TextYAlignment.Top else Enum.TextYAlignment.Center,
            fluidSizing = false,
            richText = false
        })
    end

    tbl9.Description = element
    local element2

    if var2 then
        if FFlagQRCodeCopyUpdates and var18 == false then
            element2 = React.createElement("Frame", { Size = UDim2.new(0, 304, 0, 15), BackgroundTransparency = 1, LayoutOrder = 4 })
        elseif FFlagQRCodeCopyUpdates and var16 then
            element2 = React.createElement("Frame", {
                Size = UDim2.new(0, 304, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                LayoutOrder = 4
            }, {
                Layout = React.createElement(
                    "UIListLayout",
                    {
                        HorizontalAlignment = Enum.HorizontalAlignment.Left,
                        VerticalAlignment = Enum.VerticalAlignment.Top
                    }
                ),
                LearnMoreWebLink = React.createElement(InputLabel, {
                    tag = "auto-y size-full-0 text-align-x-left",
                    RichText = true,
                    Text = `<u>{var3.learnMore}</u>`,
                    size = InputLabelSize.Small,
                    onActivated = onActivated
                })
            })
        else
            element2 = React.createElement(InputLabel, {
                LayoutOrder = 4,
                tag = "auto-y size-full-0",
                RichText = true,
                Text = `<u>{var3.learnMore}</u>`,
                size = InputLabelSize.Small,
                onActivated = onActivated
            })
        end
    else
        element2 = nil
    end

    tbl9.LearnMoreWebLink = element2
    local var21

    if hasLoaded then
        local createElement5 = React.createElement
        local str4 = "Frame"
        local tbl10 = {
            AutomaticSize = Enum.AutomaticSize.Y,
            Size = UDim2.fromScale(1, 0),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            LayoutOrder = 5
        }

        local tbl11 = {
            Layout = React.createElement("UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center }),
            UIPadding = React.createElement("UIPadding", { PaddingTop = UDim.new(0, 24), PaddingBottom = UDim.new(0, 24) }),
            ProfileShareButton = React.createElement(Button, {
                buttonType = ButtonType.PrimarySystem,
                standardSize = StandardButtonSize.Regular,
                text = var14,
                icon = var15,
                maxWidth = 304,
                onActivated = var13.onActivated,
                ref = if FFlagProfileQRCodeFixFocusNavigation then var7 else nil
            })
        }
        var21 = createElement5(str4, tbl10, tbl11)
    else
        var21 = nil
    end

    tbl9.ProfileShareButtonContainer = var21

    tbl9.UISizeConstraint = React.createElement("UISizeConstraint", { MinSize = Vector2.new(0, 420) })
    tbl7.Content = createElement4(str3, tbl8, tbl9)

    tbl7.Gradient = React.createElement("UIGradient", {
        Rotation = 90,
        Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, var9.Theme.BackgroundContrast.Color), ColorSequenceKeypoint.new(1, var9.Theme.BackgroundContrast.Color) }),
        Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.4), NumberSequenceKeypoint.new(1, 0) })
    })
    tbl5.GradientBackground = createElement3(str2, tbl6, tbl7)
    tbl3.VerticalScrollView = createElement2(var20, tbl4, tbl5)
    return createElement(str1, tbl2, tbl3)
end
