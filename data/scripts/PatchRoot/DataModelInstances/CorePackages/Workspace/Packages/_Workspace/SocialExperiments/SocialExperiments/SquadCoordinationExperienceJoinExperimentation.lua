-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:51:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialExperimentsParent = script:FindFirstAncestor("SocialExperiments").Parent

local ExperimentCacheManager = require(SocialExperimentsParent.ExperimentCacheManager).ExperimentCacheManager

local str1 = game:DefineFastString("SquadCoordinationExperienceJoinExperimentLayer", "Party.Coordination.ExperienceJoin")

local bool1 = game:DefineFastFlag("IsSquadCoordinationExperienceJoinExperimentExposureEnabled", false)
local getIsSquadLobbySessionEnabled = game:DefineFastFlag("IsSquadLobbySessionEnabled", false)

local function getIsUserInTreatment(str2: string) -- Luacid: Inlined by compiler; 4 call sites recovered
    local layerVariables = ExperimentCacheManager.default:getLayerVariables(str1)

    return if layerVariables and layerVariables[str2] ~= nil then layerVariables[str2] else false
end

return {
    getIsSquadLobbySessionEnabled = function()
        return getIsSquadLobbySessionEnabled
    end,
    getShouldOpenSLPFromExpPickerEnabled = function()
        return getIsUserInTreatment("ShouldOpenSLPFromExpPickerEnabled")
    end,
    getShouldShowFTUXOnExpPickerEnabled = function()
        return getIsUserInTreatment("ShouldShowFTUXOnExpPickerEnabled")
    end,
    getIsSearchIconOnExpPickerEnabled = function()
        return getIsUserInTreatment("IsSearchIconOnExpPickerEnabled")
    end,
    getIsNewTooltipCopyEnabled = function()
        return getIsUserInTreatment("IsNewTooltipCopyEnabled")
    end,
    logExposure = function()
        if bool1 and ExperimentCacheManager.default:getLayerVariables(str1) ~= nil then
            ExperimentCacheManager.default:logLayerExposure(str1)
        end
    end
}
