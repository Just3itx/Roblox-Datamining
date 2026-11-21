-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:20:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceExperimentsParent = script:FindFirstAncestor("AvatarExperienceExperiments").Parent

local AppUserLayers = require(AvatarExperienceExperimentsParent.ExperimentLayers).AppUserLayers
local IXPUtils = require(AvatarExperienceExperimentsParent.IXPUtils)

local getEnabledFlag = game:DefineFastFlag("AXPrefetchMarketplaceIXP5", false)

local getEnabledForAllFlag = game:DefineFastFlag("AXPrefetchMarketplaceIXPEnabledForAll5", false)

return IXPUtils.defineIXPTest({
    name = "AvatarMarketplace.UA.PrefetchMarketplace",
    layer = AppUserLayers.AvatarExperienceUAMarketplaceView,
    recordExposure = false,
    getIsUserInExperiment = function(arg1): boolean
        return arg1.enableMarketplacePrefetch ~= nil
    end,
    getDependentFlagsEnabled = function(): boolean
        return true
    end,
    getEnabledFlag = function()
        return getEnabledFlag
    end,
    getEnabledForAllFlag = function()
        return getEnabledForAllFlag
    end,
    variables = {
        UserIsInExperiment = function(arg1, arg2)
            return arg2 or arg1.enableMarketplacePrefetch ~= nil
        end,
        EnabledForUser = function(arg1, arg2)
            return arg2 or arg1.enableMarketplacePrefetch or false
        end
    }
})
