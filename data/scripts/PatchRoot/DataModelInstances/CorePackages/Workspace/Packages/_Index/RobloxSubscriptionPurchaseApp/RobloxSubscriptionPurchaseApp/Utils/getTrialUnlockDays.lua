-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")
local _GetRobloxSubscriptionProductsModel = require(RobloxSubscriptionPurchaseApp.Models.GetRobloxSubscriptionProductsModel)
local FIntRobloxPlusTrialDiscountBaseDays = require(RobloxSubscriptionPurchaseApp.Flags.FIntRobloxPlusTrialDiscountBaseDays)

local tbl1 = { week = 7, month = 30, year = 365 }

local function periodToDays(num1: number, str1: string?) -- Luacid: unused: defined but never referenced
    return num1 * (tbl1[string.lower(str1 or "")] or 30)
end

local function getTrialUnlockDays(arg1, num1: number?, str1: string?)
    local var1 = if num1 ~= nil then num1 * (tbl1[string.lower(str1 or "")] or tbl1.month) else FIntRobloxPlusTrialDiscountBaseDays
    local var2

    if arg1 == nil then
        var2 = 0
    else
        local duration = arg1.Duration
        local periodType = arg1.PeriodType
        var2 = duration * (tbl1[string.lower(periodType or "")] or tbl1.month)
    end
    return var1 + var2
end

return getTrialUnlockDays
