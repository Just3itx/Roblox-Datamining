-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:50:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AccountUpgrade = script:FindFirstAncestor("AccountUpgrade")
local AccountUpgradeParent = AccountUpgrade.Parent

local InputValidity = require(AccountUpgradeParent.AuthCommon).Enums.InputValidity
local AccountUpgradeField = require(AccountUpgrade.AccountUpgradeField)

local tbl1 = { AccountUpgradeField.Birthday, AccountUpgradeField.Username, AccountUpgradeField.Password }

local function computeIsAccountUpgradeButtonEnabled(tbl2): boolean
    if tbl2.isSubmitting then
        return false
    end

    local var1 = tbl2.requiredFields or tbl1
    local tbl3 = ({})
    for _, value in ipairs(var1) do
        tbl3[value] = true
    end

    if tbl3[AccountUpgradeField.Birthday] and tbl2.birthday == nil then
        return false
    end

    local username = tbl2.username or ""
    local password = tbl2.password or ""
    local email = tbl2.email or ""

    return not (tbl3[AccountUpgradeField.Username] and (username == "" or tbl2.usernameValid ~= InputValidity.Valid))
        and not (tbl3[AccountUpgradeField.Password] and (password == "" or tbl2.passwordValid ~= InputValidity.Valid))
        and (email == "" or tbl2.emailValid == true)
end

return computeIsAccountUpgradeButtonEnabled
