-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:40:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AccountUpgrade = script:FindFirstAncestor("AccountUpgrade")
local AccountUpgradeParent = AccountUpgrade.Parent

local AmpUpsell = require(AccountUpgradeParent.AmpUpsell)
local AmpApiProvider = AmpUpsell.AmpApiProvider
local AccessResponseEnum = AmpUpsell.AmpEnums.AccessResponseEnum

local MarketingConsentOptInMethod = require(AccountUpgrade.MarketingConsentOptInMethod)
local FStringAccountUpgradeAmpNameSpace = require(AccountUpgrade.Flags.FStringAccountUpgradeAmpNameSpace)

local FStringAccountUpgradeMarketingConsentAmpFeatureName = require(AccountUpgrade.Flags.FStringAccountUpgradeMarketingConsentAmpFeatureName)

local FStringAccountUpgradeMarketingConsentGateAmpFeatureName = require(AccountUpgrade.Flags.FStringAccountUpgradeMarketingConsentGateAmpFeatureName)

local FStringDebugAccountUpgradeMarketingConsentOverride = require(AccountUpgrade.Flags.FStringDebugAccountUpgradeMarketingConsentOverride)

local function getMarketingConsentOptInMethod()
    if FStringDebugAccountUpgradeMarketingConsentOverride == "AutoOptIn" then
        return MarketingConsentOptInMethod.AutoOptIn
    elseif FStringDebugAccountUpgradeMarketingConsentOverride == "Checkbox" then
        return MarketingConsentOptInMethod.Checkbox
    end

    local var1 = FStringAccountUpgradeMarketingConsentGateAmpFeatureName
    local var2 = FStringAccountUpgradeMarketingConsentAmpFeatureName
    if var1 == "" or var2 == "" then
        return MarketingConsentOptInMethod.None
    end

    local success, result = pcall(function()
        return AmpApiProvider.getFeatureAccess({ var1, var2 }, FStringAccountUpgradeAmpNameSpace)
    end)

    if not success or type(result) ~= "table" or type(result.featureAccessList) ~= "table" then
        return MarketingConsentOptInMethod.None
    end

    local tbl1 = {}
    for _, value in result.featureAccessList do
        if type(value) == "table" and type(value.feature) == "string" then
            tbl1[value.feature] = value.access
        end
    end

    if tbl1[var1] ~= AccessResponseEnum.Granted then
        return MarketingConsentOptInMethod.None
    end

    local var3 = tbl1[var2]

    if var3 == AccessResponseEnum.Granted then
        return MarketingConsentOptInMethod.AutoOptIn
    end

    if var3 == AccessResponseEnum.Denied then
        return MarketingConsentOptInMethod.Checkbox
    end

    return MarketingConsentOptInMethod.None
end

return getMarketingConsentOptInMethod
