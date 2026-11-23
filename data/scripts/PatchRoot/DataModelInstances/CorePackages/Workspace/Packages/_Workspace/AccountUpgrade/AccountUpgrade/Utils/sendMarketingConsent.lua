-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AccountUpgrade = script:FindFirstAncestor("AccountUpgrade")
local AccountUpgradeParent = AccountUpgrade.Parent

local Promise = require(AccountUpgradeParent.Promise)
local LegallySensitiveContent = require(AccountUpgradeParent.LegallySensitiveContent)

local AccountUpgradeAnalytics = require(AccountUpgrade.Analytics.AccountUpgradeAnalytics)
local _AccountUpgradeFlow = require(AccountUpgrade.AccountUpgradeFlow)
local _AccountUpgradeSurface = require(AccountUpgrade.AccountUpgradeSurface)

local FIntAccountUpgradeMarketingConsentWriteDelayMs = require(AccountUpgrade.Flags.FIntAccountUpgradeMarketingConsentWriteDelayMs)

local UserSetting = LegallySensitiveContent.UserSetting

local tbl1 = {
    channelSettings = {{ channelName = "Email", setting = "Enabled" }}
}

local function noop() end

local function getStatusCode(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return if type(arg1) == "table" then arg1.statusCode else nil
end

local function getErrorMessage(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if type(arg1) == "table" and type(arg1.message) == "string" then
        return arg1.message
    end
    return tostring(arg1)
end

local function waitForWriteDelay() -- Luacid: Inlined by compiler; 1 call site recovered
    if FIntAccountUpgradeMarketingConsentWriteDelayMs <= 0 then
        return Promise.resolve()
    end
    return Promise.delay(FIntAccountUpgradeMarketingConsentWriteDelayMs / 1000)
end

local function sendMarketingConsent(func1: (...any) -> (...any), arg1, arg2)
    Promise.try(function()
        local var1 = func1()
        return waitForWriteDelay():andThen(function()
            return LegallySensitiveContent.updateUserSettingV2(UserSetting.allowPromotionalOffersNotifications, tbl1, var1)
        end)
    end):andThen(function()
        AccountUpgradeAnalytics.reportMarketingConsentWriteSucceeded(arg1, arg2)
    end, function(arg3)
        warn(`AccountUpgrade: marketing consent write failed, {getErrorMessage(arg3)}`)
        AccountUpgradeAnalytics.reportMarketingConsentWriteFailed(arg1, arg2, (getStatusCode(arg3)))
    end):catch(noop)
end

return sendMarketingConsent
