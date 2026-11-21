-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:10:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfileParent = script:FindFirstAncestor("EditProfile").Parent
local RoactAppExperiment = require(EditProfileParent.RoactAppExperiment)

local str1 = game:DefineFastString("RealNamesInDisplayNamesIXP_v1", "Social.DisplayNameSetting")

local str2 = game:DefineFastString("RealNamesInDisplayNamesExperimentDefinition", "can_see_real_names")
local bool1 = game:DefineFastFlag("RealNamesInDisplayNamesEnabledForAll", false)

local useUserExperiment = RoactAppExperiment.useUserExperiment

local function isExperimentEnabled(arg1): boolean
    return if bool1 then true else ((arg1 or {})[str1] or {})[str2] == true
end

return {
    isExperimentEnabled = isExperimentEnabled,
    useIsExperimentEnabled = function(tbl1)
        return useUserExperiment({ str1 }, isExperimentEnabled, tbl1.isExposureEnabled)
    end
}
