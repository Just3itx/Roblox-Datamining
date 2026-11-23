-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:41:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AccountUpgradeParent = script:FindFirstAncestor("AccountUpgrade").Parent

local useBrowserTrackerExperiment = require(AccountUpgradeParent.RoactAppExperiment).useBrowserTrackerExperiment
local AppBtidLayers = require(AccountUpgradeParent.ExperimentLayers).AppBtidLayers
local SharedFlags = require(AccountUpgradeParent.SharedFlags)

local resolveBirthdaySelectVariant = require(AccountUpgradeParent.AuthSignup).Util.resolveBirthdaySelectVariant

local GetFFlagSignUpBirthdayPickerRequireManualSelection = SharedFlags.GetFFlagSignUpBirthdayPickerRequireManualSelection

local GetFIntSignUpBirthdayPickerManualSelectVariantOverride = SharedFlags.GetFIntSignUpBirthdayPickerManualSelectVariantOverride

local function useRequireManualSelection()
    local var1 = useBrowserTrackerExperiment({ AppBtidLayers.SignupLayer }, function(arg1)
        return {
            birthdayManualSelectVariant = (arg1[AppBtidLayers.SignupLayer] or {}).birthdayManualSelectVariant
        }
    end, false)

    return resolveBirthdaySelectVariant(
        GetFFlagSignUpBirthdayPickerRequireManualSelection(),
        GetFIntSignUpBirthdayPickerManualSelectVariantOverride(),
        var1.birthdayManualSelectVariant
    )
end

return useRequireManualSelection
