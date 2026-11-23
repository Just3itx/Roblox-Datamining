-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:40:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStorageService = game:GetService("AppStorageService")

local AccountUpgrade = script:FindFirstAncestor("AccountUpgrade")
local AccountUpgradeParent = AccountUpgrade.Parent

local React = require(AccountUpgradeParent.React)
local Foundation = require(AccountUpgradeParent.Foundation)
local Style = require(AccountUpgradeParent.Style)
local FullscreenPageWithSafeArea = require(AccountUpgradeParent.AppBlox).FullscreenPageWithSafeArea
local AuthCommon = require(AccountUpgradeParent.AuthCommon)
local AuthBackgroundContainer = AuthCommon.Components.AuthBackgroundContainer
local useOpenDisclaimerLinks = AuthCommon.Hooks.useOpenDisclaimerLinks
local isLoggedOutUserId = AuthCommon.Utils.isLoggedOutUserId
local updateLoginEntryData = AuthCommon.Utils.updateLoginEntryData
local User = AuthCommon.Thunks.User
local AuthLocalStorageKeys = AuthCommon.Enums.AuthLocalStorageKeys
local LogoutReasonNames = AuthCommon.Enums.LogoutReasonNames
local FFlagAccountUpgradeHideAccountOnSignOut = require(AccountUpgrade.Flags.FFlagAccountUpgradeHideAccountOnSignOut)
local FFlagAccountUpgradeOAuthDialogFitsContent = require(AccountUpgrade.Flags.FFlagAccountUpgradeOAuthDialogFitsContent)
local FFlagAccountUpgradeDialogDarkTheme = require(AccountUpgrade.Flags.FFlagAccountUpgradeDialogDarkTheme)

local AccountUpgradeAppShellFlow = require(AccountUpgrade.AppShell.AccountUpgradeAppShellFlow)
local AccountUpgradeFlow = require(AccountUpgrade.AccountUpgradeFlow)
local AccountUpgradePage = require(AccountUpgrade.MobilePage.AccountUpgradePage)
local FFlagAccountUpgradeFullPageOnPhone = require(AccountUpgrade.MobilePage.FFlagAccountUpgradeFullPageOnPhone)
local useMobilePage = require(AccountUpgrade.MobilePage.useMobilePage)
local _useAccountUpgradeViewModel = require(AccountUpgrade.Components.useAccountUpgradeViewModel)
local OAuth = AccountUpgradeFlow.OAuth

local View = Foundation.View

local style = {
    themeName = Foundation.Enums.ColorMode.Dark,
    fontName = Style.Constants.FontName.Gotham
}

local RoactUtils = require(AccountUpgradeParent.RoactUtils)
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useStore = RoactUtils.Hooks.RoactRodux.useStore
local useRoactService = require(AccountUpgradeParent.RobloxAppHooks).useRoactService
local RoactServiceTags = require(AccountUpgradeParent.RoactServiceTags)

local function renderLandingArt()
    return React.createElement(AuthBackgroundContainer)
end

local function BirthdayCompliancePage(tbl2)
    local var1 = useDispatch()
    local var2 = useRoactService(RoactServiceTags.RoactNetworking)
    local var3 = useRoactService(RoactServiceTags.AppGuiService)

    local currentUsername = useSelector(function(arg1)
        local user = if arg1.Users and arg1.LocalUserId then arg1.Users[arg1.LocalUserId] else nil
        return if user then user.name else nil
    end)

    local refreshUserAccess = tbl2.refreshUserAccess
    local onUnrecoverableFailure = React.useCallback(function()
        var1(refreshUserAccess(var2))
    end, { var1, refreshUserAccess, var2 })

    local var6 = tbl2.refreshUserAccessAfterUpgrade or refreshUserAccess
    local onComplete = React.useCallback(function()
        var1(var6(var2))
    end, { var1, var6, var2 })

    local var8 = useStore()
    local logoutThunk = tbl2.LogoutThunk
    local onSignOut = React.useMemo(function(): (() -> ())?
        return if logoutThunk == nil then nil else function()
            local localUserId = var8:getState().LocalUserId
            local username = if FFlagAccountUpgradeHideAccountOnSignOut then User.fromLocalStorage().username else nil
            var1(logoutThunk(var2, var3, LogoutReasonNames.Moderation))
            if not FFlagAccountUpgradeHideAccountOnSignOut then
                return
            end
            updateLoginEntryData(tostring(localUserId), { showInAccountPicker = false })

            if AppStorageService:GetItem(AuthLocalStorageKeys.CredentialValue) == username then
                AppStorageService:SetItem(AuthLocalStorageKeys.CredentialValue, "")
                AppStorageService:Flush()
            end
        end
    end, {
        var1,
        logoutThunk,
        var2,
        var3,
        var8
    })

    local var10

    if FFlagAccountUpgradeOAuthDialogFitsContent then
        local var11 = useOpenDisclaimerLinks()
        var10 = React.useCallback(function(arg1)
            if arg1 == "terms" then
                var11.openTerms()
                return
            end
            var11.openPrivacy()
        end, { var11 })
    else
        var10 = nil
    end

    local setDarkThemeOverride = tbl2.setDarkThemeOverride
    local clearThemeOverride = tbl2.clearThemeOverride
    React.useEffect(function()
        if setDarkThemeOverride then
            setDarkThemeOverride()
        end
        return function()
            if clearThemeOverride and not isLoggedOutUserId(var8:getState().LocalUserId) then
                clearThemeOverride()
            end
        end
    end, { var8, setDarkThemeOverride, clearThemeOverride })

    if if FFlagAccountUpgradeFullPageOnPhone then useMobilePage() else nil then
        return React.createElement(AccountUpgradePage, {
            flow = OAuth,
            currentUsername = currentUsername,
            onSignOut = onSignOut,
            onLegalLinkSelected = var10,
            onComplete = onComplete,
            onUnrecoverableFailure = onUnrecoverableFailure
        })
    end

    local element = React.createElement(AccountUpgradeAppShellFlow, {
        flow = OAuth,
        currentUsername = currentUsername,
        hasBackdrop = true,
        onSignOut = onSignOut,
        onLegalLinkSelected = var10,
        onComplete = onComplete,
        onUnrecoverableFailure = onUnrecoverableFailure
    })
    if FFlagAccountUpgradeDialogDarkTheme then
        element = React.createElement(
            View,
            { tag = "size-full" },
            {
                Theme = React.createElement(Style.UiModeStyleProvider, { style = style }, { Flow = element })
            }
        )
    end

    return React.createElement(
        FullscreenPageWithSafeArea,
        { includeStatusBar = true, renderFullscreenBackground = renderLandingArt },
        { Flow = element }
    )
end

return BirthdayCompliancePage
