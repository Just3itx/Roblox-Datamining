-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AccountUpgrade = script:FindFirstAncestor("AccountUpgrade")

local AccountUpgradeError = require(AccountUpgrade.AccountUpgradeError)

local tbl1 = {
    [AccountUpgradeError.AccountUpgradeDisabled] = true,
    [AccountUpgradeError.NotEligible] = true,
    [AccountUpgradeError.InvalidUpgradeType] = true,
    [AccountUpgradeError.FieldNotAllowedForUpgradeType] = true,
    [AccountUpgradeError.BirthdayRequired] = true,
    [AccountUpgradeError.AccountAlreadyUpgraded] = true
}

local function isAccountUpgradeErrorUnrecoverable(num1: number?): boolean
    return not (num1 == nil) and tbl1[num1] == true
end

return isAccountUpgradeErrorUnrecoverable
