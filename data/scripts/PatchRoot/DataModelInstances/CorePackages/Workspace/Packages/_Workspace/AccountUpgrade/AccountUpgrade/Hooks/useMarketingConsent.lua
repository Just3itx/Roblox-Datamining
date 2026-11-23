-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:41:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AccountUpgrade = script:FindFirstAncestor("AccountUpgrade")
local AccountUpgradeParent = AccountUpgrade.Parent

local React = require(AccountUpgradeParent.React)
local Promise = require(AccountUpgradeParent.Promise)
local LegallySensitiveContent = require(AccountUpgradeParent.LegallySensitiveContent)

local AccountUpgradeAnalytics = require(AccountUpgrade.Analytics.AccountUpgradeAnalytics)
local _AccountUpgradeFlow = require(AccountUpgrade.AccountUpgradeFlow)
local _AccountUpgradeSurface = require(AccountUpgrade.AccountUpgradeSurface)
local _FlowSpec = require(AccountUpgrade.FlowSpec)
local MarketingConsentOptInMethod = require(AccountUpgrade.MarketingConsentOptInMethod)
local getMarketingConsentOptInMethod = require(AccountUpgrade.Eligibility.getMarketingConsentOptInMethod)
local sendMarketingConsent = require(AccountUpgrade.Utils.sendMarketingConsent)
local FIntAccountUpgradeMarketingConsentMinimumAge = require(AccountUpgrade.Flags.FIntAccountUpgradeMarketingConsentMinimumAge)

local ConsentName = LegallySensitiveContent.ConsentName

local function noop() end

local function useMarketingConsent(tbl1)
    local flow = tbl1.flow
    local surface = tbl1.surface
    local birthday = tbl1.birthday
    local bool1 = tbl1.spec.showsMarketingConsent == true

    local var1, current = LegallySensitiveContent.useLegallySensitiveContentAndActions(
        ConsentName.allowMarketingEmailCheckboxAccountUpgrade,
        "email-marketing-checkbox-during-account-upgrade"
    )
    local _, var2 = LegallySensitiveContent.useLegallySensitiveContentAndActions(
        ConsentName.allowMarketingEmailAutoOptInAccountUpgrade,
        "email-marketing-auto-opt-in-during-account-upgrade"
    )

    local var4 = React.useRef(current)
    var4.current = current
    local var5 = React.useRef(var2)
    var5.current = var2

    local var6, var7 = React.useState(nil)
    React.useEffect(function()
        if not bool1 then
            return nil
        end
        local var8 = Promise.try(getMarketingConsentOptInMethod):andThen(var7, function()
            var7(MarketingConsentOptInMethod.None)
        end)
        return function()
            var8:cancel()
        end
    end, { bool1 })

    local bool2 = bool1 and var6 == MarketingConsentOptInMethod.AutoOptIn
    local bool3 = not (birthday == nil) and birthday:GetAgeInYears() < FIntAccountUpgradeMarketingConsentMinimumAge
    local bool4 = not (birthday == nil) and not bool3
    local consent = var1.wordsOfConsent.consent
    local bool5 = bool1 and var6 == MarketingConsentOptInMethod.Checkbox and consent ~= nil and consent ~= ""
    local bool6 = bool5 and not bool3

    local var8, var9 = React.useState(false)
    if not bool6 and var8 then
        var9(false)
    end

    React.useEffect(function()
        if bool5 then
            AccountUpgradeAnalytics.reportMarketingConsentShown(flow, surface, false)
        end
    end, { bool5, flow, surface })

    local onToggled = React.useCallback(function()
        if not bool6 then
            return
        end
        local bool7 = not var8
        var9(bool7)
        AccountUpgradeAnalytics.reportMarketingConsentToggled(flow, surface, bool7)
    end, {
        bool6,
        var8,
        flow,
        surface
    })
    local submit = React.useCallback(function()
        Promise.try(function()
            if not bool4 then
                return
            end

            if bool2 then
                sendMarketingConsent(var5.current.getBase64EncodedAuditHeader, flow, surface)
                AccountUpgradeAnalytics.reportMarketingConsentAutoOptIn(flow, surface)
            elseif bool5 then
                if var8 then
                    sendMarketingConsent(var4.current.getBase64EncodedAuditHeader, flow, surface)
                end
                AccountUpgradeAnalytics.reportMarketingConsentSubmitted(flow, surface, var8)
            end
        end):catch(noop)
    end, {
        bool4,
        bool2,
        bool5,
        var8,
        flow,
        surface
    })

    local tbl2 = { text = 0, isChecked = 0, isDisabled = 0, onToggled = 0, submit = 0 }
    if not bool5 then
        consent = nil
    end

    tbl2.text = consent
    tbl2.isChecked = bool6 and var8
    tbl2.isDisabled = bool5 and not bool6
    tbl2.onToggled = onToggled
    tbl2.submit = submit
    return tbl2
end

return useMarketingConsent
