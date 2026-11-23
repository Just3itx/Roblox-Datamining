-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:31:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AccountUpgrade = script:FindFirstAncestor("AccountUpgrade")
local AccountUpgradeParent = AccountUpgrade.Parent

local React = require(AccountUpgradeParent.React)

local _AccountUpgradeFlow = require(AccountUpgrade.AccountUpgradeFlow)
local AccountUpgradeContainer = require(AccountUpgrade.Components.AccountUpgradeContainer)
local _useAccountUpgradeViewModel = require(AccountUpgrade.Components.useAccountUpgradeViewModel)
local isAccountUpgradeErrorUnrecoverable = require(AccountUpgrade.Utils.isAccountUpgradeErrorUnrecoverable)

local function AccountUpgradeAppShellFlow(tbl1)
    local onComplete = tbl1.onComplete
    local onSignUpComplete = React.useCallback(function(tbl2)
        if tbl2.isSuccess then
            onComplete(tbl2)
        end
    end, { onComplete })

    local onUnrecoverableFailure = tbl1.onUnrecoverableFailure
    local onSignUpFailed = React.useCallback(function(num1: number?)
        if onUnrecoverableFailure and isAccountUpgradeErrorUnrecoverable(num1) then
            onUnrecoverableFailure()
        end
    end, { onUnrecoverableFailure })

    return React.createElement(AccountUpgradeContainer, {
        flow = tbl1.flow,
        currentUsername = tbl1.currentUsername,
        hasBackdrop = tbl1.hasBackdrop,
        onClose = tbl1.onDismiss,
        onSignOut = tbl1.onSignOut,
        onLegalLinkSelected = tbl1.onLegalLinkSelected,
        onSignUpComplete = onSignUpComplete,
        onSignUpFailed = onSignUpFailed
    })
end

return AccountUpgradeAppShellFlow
