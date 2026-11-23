-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:50:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AccountUpgrade = script:FindFirstAncestor("AccountUpgrade")
local AccountUpgradeParent = AccountUpgrade.Parent

local React = require(AccountUpgradeParent.React)
local Foundation = require(AccountUpgradeParent.Foundation)
local Style = require(AccountUpgradeParent.Style)
local useIOSStatusBarStyler = require(AccountUpgradeParent.RoactUtils).Hooks.useIOSStatusBarStyler

local _AccountUpgradeFlow = require(AccountUpgrade.AccountUpgradeFlow)
local AccountUpgradeSurface = require(AccountUpgrade.AccountUpgradeSurface)
local _AccountUpgradeAppShellFlow = require(AccountUpgrade.AppShell.AccountUpgradeAppShellFlow)
local useAccountUpgradeViewModel = require(AccountUpgrade.Components.useAccountUpgradeViewModel)
local isAccountUpgradeErrorUnrecoverable = require(AccountUpgrade.Utils.isAccountUpgradeErrorUnrecoverable)
local AccountUpgradePageView = require(script.Parent.AccountUpgradePageView)

local View = Foundation.View

local style = {
    themeName = Foundation.Enums.ColorMode.Dark,
    fontName = Style.Constants.FontName.Gotham
}

local function AccountUpgradePage(tbl2)
    local onComplete = tbl2.onComplete
    local onSignUpComplete = React.useCallback(function(arg1)
        if arg1.isSuccess then
            onComplete(arg1)
        end
    end, { onComplete })

    local onUnrecoverableFailure = tbl2.onUnrecoverableFailure
    local onSignUpFailed = React.useCallback(function(num1: number?)
        if onUnrecoverableFailure and isAccountUpgradeErrorUnrecoverable(num1) then
            onUnrecoverableFailure()
        end
    end, { onUnrecoverableFailure })

    local var3 = useAccountUpgradeViewModel({
        flow = tbl2.flow,
        surface = AccountUpgradeSurface.FullPage,
        currentUsername = tbl2.currentUsername,
        onSignUpComplete = onSignUpComplete,
        onSignUpFailed = onSignUpFailed,
        onSignOut = tbl2.onSignOut,
        onLegalLinkSelected = tbl2.onLegalLinkSelected
    })

    useIOSStatusBarStyler(true)

    return React.createElement(View, { tag = "size-full", testId = "AccountUpgradePageTheme" }, {
        Theme = React.createElement(
            Style.UiModeStyleProvider,
            { style = style },
            {
                Page = React.createElement(AccountUpgradePageView, var3)
            }
        )
    })
end
return AccountUpgradePage
