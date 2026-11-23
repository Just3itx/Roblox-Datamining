-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:31:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent
local AppUserLayers = require(AvatarExperienceCommonParent.ExperimentLayers).AppUserLayers
local IXPUtils = require(AvatarExperienceCommonParent.IXPUtils)

local AvatarExperienceFlags = require(AvatarExperienceCommonParent.AvatarExperienceFlags)
local FFlagAXAvatarsTabIXP = AvatarExperienceFlags.FFlagAXAvatarsTabIXP
local FFlagAXAvatarsTabIXPEnabledForAll = AvatarExperienceFlags.FFlagAXAvatarsTabIXPEnabledForAll

return IXPUtils.defineIXPTest({
    name = "AvatarExperience.UA.MarketplaceView.AvatarsTab",
    layer = AppUserLayers.AvatarExperienceUAMarketplaceView,
    recordExposure = false,
    getIsUserInExperiment = function(arg1): boolean
        return arg1.IsAvatarsTabEnabled ~= nil
    end,
    getDependentFlagsEnabled = function(): boolean
        return true
    end,
    getEnabledFlag = function()
        return FFlagAXAvatarsTabIXP
    end,
    getEnabledForAllFlag = function()
        return FFlagAXAvatarsTabIXPEnabledForAll
    end,
    variables = {
        EnabledForUser = function(arg1, arg2)
            return arg2 or arg1.IsAvatarsTabEnabled or false
        end
    }
})
