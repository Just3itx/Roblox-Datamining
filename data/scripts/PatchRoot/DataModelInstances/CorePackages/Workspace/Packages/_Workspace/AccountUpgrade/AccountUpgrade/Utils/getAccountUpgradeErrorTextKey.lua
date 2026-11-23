-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AccountUpgrade = script:FindFirstAncestor("AccountUpgrade")

local AccountUpgradeError = require(AccountUpgrade.AccountUpgradeError)

local tbl1 = {
    [AccountUpgradeError.InvalidBirthday] = "Authentication.SignUp.Response.InvalidBirthday",
    [AccountUpgradeError.InvalidUsername] = "Authentication.SignUp.Label.ErrorsWithUsername",
    [AccountUpgradeError.InvalidPassword] = "Authentication.SignUp.Response.PasswordComplexity",
    [AccountUpgradeError.InvalidEmailAddress] = "Authentication.SignUp.Response.InvalidEmail"
}

local function getAccountUpgradeErrorTextKey(num1: number?)
    return if num1 == nil then "Authentication.SignUp.Response.ErrorTryAgain2" else tbl1[num1] or "Authentication.SignUp.Response.ErrorTryAgain2"
end

return getAccountUpgradeErrorTextKey
