-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local AuthAnalyticsParent = script:FindFirstAncestor("AuthAnalytics").Parent
local LoggingProtocol = require(AuthAnalyticsParent.LoggingProtocol)

local throttlingPercentage = game:DefineFastInt("AuthPageMountThrottlingHundredthsPercent", 0)

local num1 = game:DefineFastInt("ValidCookieForNoCachedUserThrottlingHundredthsPercent", 0)

local num2 = game:DefineFastInt("AuthButtonClickedThrottlingHundredthsPercent", 0)

local num3 = game:DefineFastInt("SilentPasskeyUpgradeThrottlingHundredthsPercent", 0)

local num4 = game:DefineFastInt("DeepLinkNavigationLockThrottlingHundredthsPercent", 0)

local num5 = game:DefineFastInt("UnauthorizedErrorThrottlingHundredthsPercent", 0)

local num6 = game:DefineFastInt("IosAuthServiceLoginThrottlingHundredthsPercent", 0)

local num7 = game:DefineFastInt("IosAuthServiceHealthCounterThrottlingHundredthsPercent", 0)
local num8 = game:DefineFastInt("LuaLogoutThrottlingHundredthsPercent", 0)

local num9 = game:DefineFastInt("KeystoreTelemetryThrottlingHundredthsPercent", 0)
local num10 = game:DefineFastInt("TimeToLoginThrottlingHundredthsPercent", 0)

local num11 = game:DefineFastInt("AccountUpgradeTelemetryThrottlingHundredthsPercent", 0)

local backends = game:DefineFastFlag("FixIosAuthServiceCredentialSheetBackends", false) and { LoggingProtocol.TelemetryBackends.Counter }
    or { LoggingProtocol.TelemetryBackends.Counter, LoggingProtocol.TelemetryBackends.EventIngest }

local tbl1 = { LoggingProtocol.TelemetryBackends.EventIngest }

return {
    LandingPageMountTelemetryConfig = {
        eventName = "luaLandingPageMount",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 25, 4, 7 },
        description = "Report when landing page is mounted.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    LoginPageMountTelemetryConfig = {
        eventName = "luaLoginPageMount",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 25, 4, 14 },
        description = "Report when login page is mounted.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    SignupPageMountTelemetryConfig = {
        eventName = "luaSignupPageMount",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 25, 4, 14 },
        description = "Report when signup page is mounted.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    AddAuthMethodPageMountTelemetryConfig = {
        eventName = "luaAddAuthMethodPageMount",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 25, 4, 14 },
        description = "Report when add auth method page is mounted.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    ConsoleSSOAttemptedTelemetryConfig = {
        eventName = "luaConsoleSSOAttempted",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 25, 4, 17 },
        description = "Report when a console SSO attempt is made.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    SingleSignOnErrorMountTelemetryConfig = {
        eventName = "luaSingleSignOnErrorMount",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 26, 1, 28 },
        description = "Report when the single sign on error is mounted.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    ValidCookieForNoCachedUserTelemetryConfig = {
        eventName = "luaValidCookieForNoCachedUser",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = num1,
        lastUpdated = { 26, 5, 7 },
        description = "Report when a valid cookie is found for a user that is not cached.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    NoCookieForCachedUserTelemetryConfig = {
        eventName = "luaNoCookieForCachedUser",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = num1,
        lastUpdated = { 25, 4, 11 },
        description = "Report when a user with a cached user does not have a valid cookie.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    LaunchAppThunkInitiatedConfig = {
        eventName = "luaLaunchAppThunkInitiated",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = num1,
        lastUpdated = { 25, 4, 14 },
        description = "Report when the launch app thunk is initiated.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    LandingLoginButtonClickedConfig = {
        eventName = "luaLandingLoginButtonClicked",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = num2,
        lastUpdated = { 25, 4, 14 },
        description = "Report when the landing login button is clicked.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    LandingSignupButtonClickedConfig = {
        eventName = "luaLandingSignupButtonClicked",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = num2,
        lastUpdated = { 25, 4, 14 },
        description = "Report when the landing signup button is clicked.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    LogoutButtonClickedConfig = {
        eventName = "luaLogoutButtonClicked",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = num2,
        lastUpdated = { 25, 4, 14 },
        description = "Report when the logout button is clicked.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    SilentPasskeyUpgradeAvailableConfig = {
        eventName = "luaSilentPasskeyUpgradeAvailable",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = num3,
        lastUpdated = { 25, 10, 22 },
        description = "Report when a device is eligible for a silent passkey upgrade.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    SilentPasskeyUpgradeAttemptedConfig = {
        eventName = "luaSilentPasskeyUpgradeAttempted",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = num3,
        lastUpdated = { 25, 10, 22 },
        description = "Report when a silent passkey upgrade is attempted.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    SilentPasskeyUpgradeSuccessConfig = {
        eventName = "luaSilentPasskeyUpgradeSuccess",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = num3,
        lastUpdated = { 25, 10, 22 },
        description = "Report when a silent passkey upgrade attempt succeeds.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    SilentPasskeyUpgradeFailureConfig = {
        eventName = "luaSilentPasskeyUpgradeFailure",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = num3,
        lastUpdated = { 25, 10, 22 },
        description = "Report when a silent passkey upgrade attempt fails.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    SilentPasskeyUpgradeNoPasskeyConfig = {
        eventName = "luaSilentPasskeyUpgradeNoPasskey",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = num3,
        lastUpdated = { 26, 1, 12 },
        description = "Report when a silent passkey upgrade proceeds because the user does not have a passkey.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    DeepLinkPendingDueToNavigationLockConfig = {
        eventName = "luaDeepLinkPendingDueToNavigationLock",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = num4,
        lastUpdated = { 25, 10, 24 },
        description = "Report when a deeplink is queued because navigation is locked.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    DeepLinkProcessedAfterNavigationUnlockConfig = {
        eventName = "luaDeepLinkProcessedAfterNavigationUnlock",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = num4,
        lastUpdated = { 25, 10, 24 },
        description = "Report when a queued deeplink is processed after navigation unlocks.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    SingleSignOnErrorRetryButtonClickedConfig = {
        eventName = "luaSingleSignOnErrorRetryButtonClicked",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = num2,
        lastUpdated = { 26, 1, 28 },
        description = "Report when the SSO error screen retry button is clicked.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    LuaLogoutTelemetryConfig = {
        eventName = "LuaLogout",
        backends = { "RobloxTelemetryCounter" },
        throttlingPercentage = num8,
        lastUpdated = { 26, 1, 21 },
        description = "Counting logouts by reason.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    UnauthorizedErrorTelemetryConfig = {
        eventName = "luaUnauthorizedError",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = num5,
        lastUpdated = { 26, 1, 21 },
        description = "Report when a unauthorized error is encountered.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    IosAuthServiceLoginPasswordSaveAttemptedConfig = {
        eventName = "iosAuthServiceLoginPasswordSaveAttempted",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = num6,
        lastUpdated = { 26, 2, 11 },
        description = "Report when save password to iOS Keychain is attempted after login.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    IosAuthServiceLoginPasswordSaveSuccessConfig = {
        eventName = "iosAuthServiceLoginPasswordSaveSuccess",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = num6,
        lastUpdated = { 26, 2, 11 },
        description = "Report when save password to iOS Keychain succeeds after login.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    IosAuthServiceLoginPasswordSaveFailureConfig = {
        eventName = "iosAuthServiceLoginPasswordSaveFailure",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = num6,
        lastUpdated = { 26, 2, 11 },
        description = "Report when save password to iOS Keychain fails after login.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    IosAuthServiceLoginPasswordSaveSkippedConfig = {
        eventName = "iosAuthServiceLoginPasswordSaveSkipped",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = num6,
        lastUpdated = { 26, 2, 11 },
        description = "Report when save password to iOS Keychain is skipped after login.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    IosAuthServiceLoginCredentialSheetShownConfig = {
        eventName = "iosAuthServiceLoginCredentialSheetShown",
        backends = backends,
        throttlingPercentage = num6,
        lastUpdated = { 26, 2, 11 },
        description = "Report when the iOS credential sheet is shown during login.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    IosAuthServiceLoginCredentialSheetPasswordSelectedConfig = {
        eventName = "iosAuthServiceLoginCredentialSheetPasswordSelected",
        backends = backends,
        throttlingPercentage = num6,
        lastUpdated = { 26, 2, 11 },
        description = "Report when a user selects a password from the iOS credential sheet during login.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    IosAuthServiceLoginCredentialSheetPasskeySelectedConfig = {
        eventName = "iosAuthServiceLoginCredentialSheetPasskeySelected",
        backends = backends,
        throttlingPercentage = num6,
        lastUpdated = { 26, 2, 11 },
        description = "Report when a user selects a passkey from the iOS credential sheet during login.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    IosAuthServiceLoginCredentialSheetErrorConfig = {
        eventName = "iosAuthServiceLoginCredentialSheetError",
        backends = backends,
        throttlingPercentage = num6,
        lastUpdated = { 26, 2, 11 },
        description = "Report when the iOS credential sheet returns an error during login.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    IosAuthServiceLoginCredentialSheetDismissedConfig = {
        eventName = "iosAuthServiceLoginCredentialSheetDismissed",
        backends = backends,
        throttlingPercentage = num6,
        lastUpdated = { 26, 2, 11 },
        description = "Report when the iOS credential sheet is dismissed without selection during login.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    KeystoreGetCredentialsTelemetryConfig = {
        eventName = "keystoreGetCredentials",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = num9,
        lastUpdated = { 26, 4, 21 },
        description = "Counter for keystore get-credentials operations by result.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    KeystoreAutoLoginTelemetryConfig = {
        eventName = "keystoreAutoLogin",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = num9,
        lastUpdated = { 26, 4, 21 },
        description = "Counter for keystore auto-login outcomes by result.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    KeystoreSaveCredentialsTelemetryConfig = {
        eventName = "keystoreSaveCredentials",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = num9,
        lastUpdated = { 26, 4, 21 },
        description = "Counter for keystore save-credentials operations by result.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    KeystoreDeleteCredentialsTelemetryConfig = {
        eventName = "keystoreDeleteCredentials",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = num9,
        lastUpdated = { 26, 4, 21 },
        description = "Counter for keystore delete-credentials operations by reason.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    KeystoreRedirectTelemetryConfig = {
        eventName = "keystoreRedirect",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = num9,
        lastUpdated = { 26, 4, 21 },
        description = "Counter for keystore redirect operations by destination.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    IosAuthServiceLoginCredentialSheetLoginSuccessConfig = {
        eventName = "iosAuthServiceLoginCredentialSheetLoginSuccess",
        backends = backends,
        throttlingPercentage = num6,
        lastUpdated = { 26, 6, 23 },
        description = "Report when a login attempt using a credential selected from the iOS credential sheet succeeds.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    IosAuthServiceLoginCredentialSheetLoginFailureConfig = {
        eventName = "iosAuthServiceLoginCredentialSheetLoginFailure",
        backends = backends,
        throttlingPercentage = num6,
        lastUpdated = { 26, 6, 23 },
        description = "Report when a login attempt using a credential selected from the iOS credential sheet fails.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    IosAuthServiceLoginCredentialSheetUnavailableConfig = {
        eventName = "iosAuthServiceLoginCredentialSheetUnavailable",
        backends = backends,
        throttlingPercentage = num6,
        lastUpdated = { 26, 6, 24 },
        description = "Report when the iOS credential sheet could not be shown during login because no supported credential types (password or passkey) were available.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    IosAuthServiceLoginCredentialSheetShownEventConfig = {
        eventName = "iosAuthServiceLoginCredentialSheetShown",
        backends = tbl1,
        throttlingPercentage = num6,
        lastUpdated = { 26, 8, 18 },
        description = "EventStream twin: the iOS credential sheet was shown during login.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    IosAuthServiceLoginCredentialSheetPasswordSelectedEventConfig = {
        eventName = "iosAuthServiceLoginCredentialSheetPasswordSelected",
        backends = tbl1,
        throttlingPercentage = num6,
        lastUpdated = { 26, 8, 18 },
        description = "EventStream twin: a user selected a password from the iOS credential sheet during login.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    IosAuthServiceLoginCredentialSheetPasskeySelectedEventConfig = {
        eventName = "iosAuthServiceLoginCredentialSheetPasskeySelected",
        backends = tbl1,
        throttlingPercentage = num6,
        lastUpdated = { 26, 8, 18 },
        description = "EventStream twin: a user selected a passkey from the iOS credential sheet during login.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    IosAuthServiceLoginCredentialSheetErrorEventConfig = {
        eventName = "iosAuthServiceLoginCredentialSheetError",
        backends = tbl1,
        throttlingPercentage = num6,
        lastUpdated = { 26, 8, 18 },
        description = "EventStream twin: the iOS credential sheet returned an error during login.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    IosAuthServiceLoginCredentialSheetDismissedEventConfig = {
        eventName = "iosAuthServiceLoginCredentialSheetDismissed",
        backends = tbl1,
        throttlingPercentage = num6,
        lastUpdated = { 26, 8, 18 },
        description = "EventStream twin: the iOS credential sheet was dismissed without selection during login.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    IosAuthServiceLoginCredentialSheetLoginSuccessEventConfig = {
        eventName = "iosAuthServiceLoginCredentialSheetLoginSuccess",
        backends = tbl1,
        throttlingPercentage = num6,
        lastUpdated = { 26, 8, 18 },
        description = "EventStream twin: a login using a credential selected from the iOS credential sheet succeeded.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    IosAuthServiceLoginCredentialSheetLoginFailureEventConfig = {
        eventName = "iosAuthServiceLoginCredentialSheetLoginFailure",
        backends = tbl1,
        throttlingPercentage = num6,
        lastUpdated = { 26, 8, 18 },
        description = "EventStream twin: a login using a credential selected from the iOS credential sheet failed.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    IosAuthServiceLoginCredentialSheetUnavailableEventConfig = {
        eventName = "iosAuthServiceLoginCredentialSheetUnavailable",
        backends = tbl1,
        throttlingPercentage = num6,
        lastUpdated = { 26, 8, 18 },
        description = "EventStream twin: the iOS credential sheet could not be shown during login.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    IosAuthServiceLoginSuccessConfig = {
        eventName = "iosAuthServiceLoginSuccess",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = num7,
        lastUpdated = { 26, 6, 24 },
        description = "iOS Auth Service health: a lua-observed login succeeded.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    IosAuthServiceLoginFailureConfig = {
        eventName = "iosAuthServiceLoginFailure",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = num7,
        lastUpdated = { 26, 6, 24 },
        description = "iOS Auth Service health: a lua-observed login failed.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    IosAuthServiceLoginTwoStepRequiredConfig = {
        eventName = "iosAuthServiceLoginTwoStepRequired",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = num7,
        lastUpdated = { 26, 6, 24 },
        description = "iOS Auth Service health: a lua-observed login required two-step verification (2SV/OTP) and is not yet complete.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    IosAuthServiceSignupSuccessConfig = {
        eventName = "iosAuthServiceSignupSuccess",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = num7,
        lastUpdated = { 26, 6, 24 },
        description = "iOS Auth Service health: a lua-observed signup succeeded.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    IosAuthServiceSignupFailureConfig = {
        eventName = "iosAuthServiceSignupFailure",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = num7,
        lastUpdated = { 26, 6, 24 },
        description = "iOS Auth Service health: a lua-observed signup failed.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    IosAuthServicePasswordSaveSuccessConfig = {
        eventName = "iosAuthServicePasswordSaveSuccess",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = num7,
        lastUpdated = { 26, 6, 24 },
        description = "iOS Auth Service health: a lua-observed password save succeeded.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    IosAuthServicePasswordSaveFailureConfig = {
        eventName = "iosAuthServicePasswordSaveFailure",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = num7,
        lastUpdated = { 26, 6, 24 },
        description = "iOS Auth Service health: a lua-observed password save failed.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    TimeToLoginStatConfig = {
        eventName = "luaTimeToLogin",
        backends = { LoggingProtocol.TelemetryBackends.Stats },
        throttlingPercentage = num10,
        lastUpdated = { 26, 9, 15 },
        description = "Time from credential submission until the Home page becomes interactive, in milliseconds. Tagged with twoStepVerification so attempts that included a human 2SV step can be excluded from latency alerting.",
        links = "https://roblox.atlassian.net/browse/AA-7175"
    },
    TimeToLoginInvalidDurationConfig = {
        eventName = "luaTimeToLoginInvalidDuration",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = num10,
        lastUpdated = { 26, 9, 15 },
        description = "Report when a time-to-login measurement is discarded because the elapsed duration was negative or older than the staleness bound.",
        links = "https://roblox.atlassian.net/browse/AA-7175"
    },
    AccountUpgradePageMountConfig = {
        eventName = "luaAccountUpgradePageMount",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = num11,
        lastUpdated = { 26, 10, 6 },
        description = "Report when the account upgrade form opens.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    AccountUpgradeCloseButtonClickedConfig = {
        eventName = "luaAccountUpgradeCloseButtonClicked",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = num11,
        lastUpdated = { 26, 10, 6 },
        description = "Report when the user presses the X on the account upgrade form.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    AccountUpgradeCloseWarningBackButtonClickedConfig = {
        eventName = "luaAccountUpgradeCloseWarningBackButtonClicked",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = num11,
        lastUpdated = { 26, 10, 6 },
        description = "Report when the user presses Back in the account upgrade close warning.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    AccountUpgradeCloseWarningCloseButtonClickedConfig = {
        eventName = "luaAccountUpgradeCloseWarningCloseButtonClicked",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = num11,
        lastUpdated = { 26, 10, 6 },
        description = "Report when the user presses Close in the account upgrade close warning, which signs them out.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    AccountUpgradeSuccessConfig = {
        eventName = "luaAccountUpgradeSuccess",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = num11,
        lastUpdated = { 26, 10, 6 },
        description = "Report when an account upgrade request succeeds.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    AccountUpgradeFailureConfig = {
        eventName = "luaAccountUpgradeFailure",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = num11,
        lastUpdated = { 26, 10, 6 },
        description = "Report the first failed account upgrade request in each opening of the form. Also tagged with errorCode.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    AccountUpgradeMarketingConsentWriteSuccessConfig = {
        eventName = "luaAccountUpgradeMarketingConsentWriteSuccess",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = num11,
        lastUpdated = { 26, 10, 16 },
        description = "Report when the marketing email consent write succeeds after an account upgrade.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    },
    AccountUpgradeMarketingConsentWriteFailureConfig = {
        eventName = "luaAccountUpgradeMarketingConsentWriteFailure",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        throttlingPercentage = num11,
        lastUpdated = { 26, 10, 16 },
        description = "Report when the marketing email consent write fails after an account upgrade, tagged with the HTTP status code as errorCode.",
        links = "https://roblox.atlassian.net/wiki/spaces/AUTH/pages/3475702046/Lua+Client-Side+Telemetry+Planning"
    }
}
