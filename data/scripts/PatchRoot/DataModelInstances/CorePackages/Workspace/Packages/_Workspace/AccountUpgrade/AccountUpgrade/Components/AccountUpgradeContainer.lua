-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:31:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AccountUpgrade = script:FindFirstAncestor("AccountUpgrade")
local AccountUpgradeParent = AccountUpgrade.Parent
local React = require(AccountUpgradeParent.React)

local AccountUpgradeView = require(script.Parent.AccountUpgradeView)
local useAccountUpgradeViewModel = require(script.Parent.useAccountUpgradeViewModel)
local FFlagEnableDesktopSsoSignupDialog = require(AccountUpgrade.Flags.FFlagEnableDesktopSsoSignupDialog)

local function AccountUpgradeContainer(arg1)
    local var1 = useAccountUpgradeViewModel(arg1)
    if FFlagEnableDesktopSsoSignupDialog and arg1.isHidden then
        return nil
    end
    return React.createElement(AccountUpgradeView, var1)
end

return AccountUpgradeContainer
