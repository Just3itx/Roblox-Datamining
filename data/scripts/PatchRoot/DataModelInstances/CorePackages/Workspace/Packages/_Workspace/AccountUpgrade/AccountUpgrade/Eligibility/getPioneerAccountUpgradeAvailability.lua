-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AccountUpgrade = script:FindFirstAncestor("AccountUpgrade")
local AccountUpgradeParent = AccountUpgrade.Parent

local AmpUpsell = require(AccountUpgradeParent.AmpUpsell)
local AmpApiProvider = AmpUpsell.AmpApiProvider
local AccessResponseEnum = AmpUpsell.AmpEnums.AccessResponseEnum

local FFlagAccountUpgradeInExpGate = require(AccountUpgrade.Flags.FFlagAccountUpgradeInExpGate)
local FStringAccountUpgradeAmpFeatureName = require(AccountUpgrade.Flags.FStringAccountUpgradeAmpFeatureName)
local FStringAccountUpgradeAmpNameSpace = require(AccountUpgrade.Flags.FStringAccountUpgradeAmpNameSpace)

local function malformedAvailability(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    return {
        granted = false,
        access = if type(arg1) ~= "table" or type(arg1.access) ~= "string" then "Malformed" else arg1.access
    }
end

local function getPioneerAccountUpgradeAvailability()
    if not FFlagAccountUpgradeInExpGate then
        return { granted = false, access = "Disabled" }
    end

    local var1 = FStringAccountUpgradeAmpFeatureName
    local var2 = FStringAccountUpgradeAmpNameSpace

    if var1 == "" or var2 == "" then
        return { granted = false, access = "Misconfigured" }
    end

    local success, result = pcall(function()
        return AmpApiProvider.getFeatureAccess({ var1 }, var2)
    end)

    if not success then
        return {
            granted = false,
            access = AccessResponseEnum.Error
        }
    end
    if type(result) ~= "table" then
        return malformedAvailability(result)
    end

    local featureAccessList = result.featureAccessList
    if type(featureAccessList) ~= "table" or type(featureAccessList[1]) ~= "table" then
        return malformedAvailability(result)
    end

    local access = featureAccessList[1].access

    if type(access) == "string" then
        return {
            granted = access == AccessResponseEnum.Granted,
            access = access
        }
    end

    return malformedAvailability(result)
end

return getPioneerAccountUpgradeAvailability
