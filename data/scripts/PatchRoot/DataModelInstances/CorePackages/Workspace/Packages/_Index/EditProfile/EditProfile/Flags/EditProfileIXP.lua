-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:01:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfileParent = script:FindFirstAncestor("EditProfile").Parent
local RoactAppExperiment = require(EditProfileParent.RoactAppExperiment)
local getFStringSelfProfileView = require(EditProfileParent.SharedFlags).getFStringSelfProfileView

local useUserExperiment = RoactAppExperiment.useUserExperiment
local FFlagEditProfileSetupNewExperimentFlow = require(script.Parent.FFlagEditProfileSetupNewExperimentFlow)

local str1 = game:DefineFastString("EditProfileExperimentKey", "can_view_edit_profile")

local function isExperimentEnabled(arg1): boolean
    local var1 = (arg1 or {})[getFStringSelfProfileView()] or {}

    return if FFlagEditProfileSetupNewExperimentFlow then var1[str1] == true else var1.can_view_edit_profile == true
end

return {
    isExperimentEnabled = isExperimentEnabled,
    useIsExperimentEnabled = function(tbl1)
        return useUserExperiment({ getFStringSelfProfileView() }, isExperimentEnabled, if tbl1 then tbl1.isExposureEnabled else nil)
    end
}
