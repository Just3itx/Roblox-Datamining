-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:31:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")

local FFlagIsSetupEnabled = game:DefineFastFlag("EnableCommunityProfilePageIXPSetupEnabled_v4", false)

local bool2 = game:DefineFastFlag("EnableCommunityProfilePageIXPEnabledForAll", false)

local EnableCommunityProfilePageExperimentLayer = game:DefineFastString("EnableCommunityProfilePageExperimentLayer", "Social.CommunityProfileView")

local IXPService = game:GetService("IXPService")

local ProfilePlatformParent = ProfilePlatform.Parent
local useUserExperiment = require(ProfilePlatformParent.RoactAppExperiment).useUserExperiment

local function isFeatureActive(arg1): boolean
    local var1 = (arg1 or {})[EnableCommunityProfilePageExperimentLayer] or {}

    return bool2 or var1.enableCommunityProfilePage == true
end

return {
    EnableCommunityProfilePageExperimentLayer = EnableCommunityProfilePageExperimentLayer,
    FFlagIsSetupEnabled = FFlagIsSetupEnabled,
    isFeatureActive = isFeatureActive,
    useIsFeatureActive = function(tbl1)
        return useUserExperiment(
            { EnableCommunityProfilePageExperimentLayer },
            isFeatureActive,
            if tbl1 then tbl1.isExposureEnabled else nil
        )
    end,
    logExposure = function()
        IXPService:LogUserLayerExposure(EnableCommunityProfilePageExperimentLayer)
    end
}
