-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent
local GuiService = game:GetService("GuiService")

local React = require(AuthCommonParent.React)
local UIBlox = require(AuthCommonParent.UIBlox)
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local withStyle = UIBlox.Style.withStyle
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local useScreenSize = require(AuthCommonParent.RobloxAppHooks).useScreenSize
local default = require(AuthCommonParent.LinkingProtocol).LinkingProtocol.default
local FoundationText = require(AuthCommonParent.Foundation).Text

local useAppPolicy = require(AuthCommonParent.UniversalAppPolicy).useAppPolicy
local useDispatch = require(AuthCommonParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useLocalization = require(AuthCommonParent.Localization).Hooks.useLocalization
local useNavigation = require(AuthCommonParent.Navigation).useNavigation
local AppPage = require(AuthCommonParent.RobloxAppEnums).AppPage
local NotificationType = require(AuthCommonParent.RobloxAppEnums).NotificationType
local AuthAnalytics = require(AuthCommonParent.AuthAnalytics)
local EventStreamConstants = AuthAnalytics.EventStreamConstants
local authModalShown = AuthAnalytics.Events.authModalShown
local authButtonClick = AuthAnalytics.Events.authButtonClick
local str1 = game:DefineFastString(
    "IncompatibleAccountsSupportLink",
    "https://help.roblox.com/hc/articles/360000334523-Xbox-One-App-Trouble-logging-into-Roblox-account"
)

local AccountLinkingAlertType = require(AuthCommon.Enums.AccountLinkingAlertType)

local function AccountLinkingAlert(tbl1)
    local buttons = {}

    if tbl1.secondaryButtonText and tbl1.secondaryButtonCallback then
        table.insert(buttons, {
            buttonType = ButtonType.Secondary,
            props = {
                text = tbl1.secondaryButtonText,
                onActivated = function()
                    tbl1.secondaryButtonCallback()
                end
            }
        })
    end

    if tbl1.primaryButtonText and tbl1.primaryButtonCallback then
        table.insert(buttons, {
            buttonType = ButtonType.PrimarySystem,
            props = {
                text = tbl1.primaryButtonText,
                onActivated = function()
                    tbl1.primaryButtonCallback()
                end
            }
        })
    end

    local screenSize = useScreenSize()

    local footerContent = React.useCallback(function()
        if not (tbl1.footerText and tbl1.footerCallback) then
            return nil
        end

        return React.createElement(
            "Frame",
            {
                Size = UDim2.fromScale(1, 1),
                AutomaticSize = Enum.AutomaticSize.XY,
                BackgroundTransparency = 1
            },
            {
                Text = React.createElement(FoundationText, {
                    Text = tbl1.footerText,
                    AutomaticSize = Enum.AutomaticSize.XY,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.fromScale(0.5, 0.5),
                    onActivated = tbl1.footerCallback
                })
            }
        )
    end, { tbl1.footerText, tbl1.footerCallback })

    return withStyle(function(_)
        return React.createElement(InteractiveAlert, {
            title = tbl1.titleText,
            bodyText = tbl1.bodyText,
            buttonStackInfo = { buttons = buttons },
            footerContent = footerContent,
            isRoactGamepadEnabled = false,
            position = UDim2.fromScale(0.5, 0.5),
            screenSize = screenSize
        })
    end)
end

local function useIncompatibleAccountsAlertProps(tbl1)
    local var1 = useDispatch()
    local var2 = useNavigation()

    local var3 = useAppPolicy(function(arg1)
        return arg1.getPlatformAccountName()
    end)

    local var4 = useLocalization({
        titleText = "Authentication.Login.Heading.IncompatibleAccounts",
        bodyText = { "Authentication.Login.Response.AlreadyLinked", platform = var3 },
        primaryButtonText = {
            "Authentication.Login.Button.CloseAndSwitchPlatformAccount",
            platformAccountName = var3
        },
        secondaryButtonText = "Authentication.Login.Button.UseDifferentRobloxAccount",
        footerText = "Authentication.Login.Label.LearnMore"
    })

    local primaryButtonCallback = React.useCallback(function()
        GuiService:BroadcastNotification("", NotificationType.NATIVE_EXIT)
        if tbl1.closeCentralOverlayThunk then
            var1(tbl1.closeCentralOverlayThunk())
        end
        authButtonClick(EventStreamConstants.Context.AccountLinking, EventStreamConstants.Button.PrimaryButton)
    end, { tbl1.closeCentralOverlayThunk })

    local secondaryButtonCallback = React.useCallback(function()
        var2.navigate(AppPage.Landing)
        if tbl1.closeCentralOverlayThunk then
            var1(tbl1.closeCentralOverlayThunk())
        end
        authButtonClick(EventStreamConstants.Context.AccountLinking, EventStreamConstants.Button.SecondaryButton)
    end, { var2, tbl1.closeCentralOverlayThunk })

    local footerCallback = React.useCallback(function()
        default:openURL(str1)
        authButtonClick(EventStreamConstants.Context.AccountLinking, EventStreamConstants.Button.Support)
    end, {})

    return {
        titleText = var4.titleText,
        bodyText = if tbl1.userFacingMessage then tbl1.userFacingMessage else var4.bodyText,
        primaryButtonText = var4.primaryButtonText,
        secondaryButtonText = var4.secondaryButtonText,
        primaryButtonCallback = primaryButtonCallback,
        secondaryButtonCallback = secondaryButtonCallback,
        footerText = var4.footerText,
        footerCallback = footerCallback,
        closeCentralOverlayThunk = tbl1.closeCentralOverlayThunk
    }
end

local function IncompatibleAccountsAlert(tbl1)
    local tbl2 = useIncompatibleAccountsAlertProps(tbl1)
    return React.createElement(AccountLinkingAlert, tbl2)
end

local function useRetryLogInAlertProps(tbl1)
    local var1 = useDispatch()
    local var2 = useNavigation()

    local platformAccountName = useAppPolicy(function(arg1)
        return arg1.getPlatformAccountName()
    end)

    local bodyText = tbl1.alertType == AccountLinkingAlertType.RetryLogInAlreadyLinked
        and {
            "Authentication.SignUp.Description.AccountAlreadyLinked",
            platformAccountName = platformAccountName
        }
        or (if tbl1.alertType == AccountLinkingAlertType.RetryLogInConnectionFailure then "Authentication.Login.Error.PlatformAccountConnectionFailure" else "Authentication.SignUp.Response.ErrorTryAgain")

    local var5 = useLocalization({
        titleText = "Authentication.SignUp.Heading.RetryLogIn",
        bodyText = bodyText,
        primaryButtonText = "Authentication.SignUp.Button.RetryLogIn"
    })

    local primaryButtonCallback = React.useCallback(function()
        var2.navigate(AppPage.PlatformAccountRouter)
        if tbl1.closeCentralOverlayThunk then
            var1(tbl1.closeCentralOverlayThunk())
        end
    end, { var2, tbl1.closeCentralOverlayThunk })

    return {
        titleText = var5.titleText,
        bodyText = var5.bodyText,
        primaryButtonText = var5.primaryButtonText,
        primaryButtonCallback = primaryButtonCallback,
        closeCentralOverlayThunk = tbl1.closeCentralOverlayThunk
    }
end

local function RetryLogInAlert(tbl1)
    local tbl2 = useRetryLogInAlertProps(tbl1)
    return React.createElement(AccountLinkingAlert, tbl2)
end

local function AccountLinkingAlertContainer(tbl1)
    React.useEffect(function()
        authModalShown(EventStreamConstants.Context.AccountLinking, nil, tbl1.alertType)
    end, { tbl1.alertType })
    if tbl1.alertType == AccountLinkingAlertType.IncompatibleAccounts then
        return React.createElement(IncompatibleAccountsAlert, tbl1)
    end
    if tbl1.alertType == AccountLinkingAlertType.RetryLogInAlreadyLinked
        or tbl1.alertType == AccountLinkingAlertType.RetryLogInConnectionFailure
        or tbl1.alertType == AccountLinkingAlertType.RetryLogInGenericError
    then
        return React.createElement(RetryLogInAlert, tbl1)
    end
    warn("AccountLinkingAlert: Unknown alert type: " .. tostring(tbl1.alertType))
    return nil
end

return AccountLinkingAlertContainer
