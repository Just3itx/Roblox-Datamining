-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:10:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("SocialNetworksInEditProfileIXPSetupEnabled_v6", false)
game:DefineFastFlag("SocialNetworksInEditProfileIXPEnabled", false)

local str1 = game:DefineFastString("SocialNetworksEditProfileIXPLayer", "Social.EditProfilePage")

local EditProfileParent = script:FindFirstAncestor("EditProfile").Parent
local useUserExperiment = require(EditProfileParent.RoactAppExperiment).useUserExperiment

local Variants = {
    Control = "control",
    VisibilityLast = "visibilityLast",
    VisibilityFirst = "visibilityFirst"
}

local function GetFFlagSocialNetworksInEditProfileIXPEnabled(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return game:GetFastFlag("SocialNetworksInEditProfileIXPEnabled")
end

local function getExperimentVariant(arg1)
    if GetFFlagSocialNetworksInEditProfileIXPEnabled() then
        return ((arg1 or {})[str1] or {}).editSocialNetworks or Variants.Control
    end

    return nil
end

return {
    GetFFlagSocialNetworksInEditProfileIXPSetupEnabled = function(): boolean
        return game:GetFastFlag("SocialNetworksInEditProfileIXPSetupEnabled_v6")
    end,
    getExperimentVariant = getExperimentVariant,
    useGetExperimentVariant = function(tbl2)
        return useUserExperiment({ str1 }, getExperimentVariant, tbl2.isExposureEnabled)
    end,
    Variants = Variants
}
