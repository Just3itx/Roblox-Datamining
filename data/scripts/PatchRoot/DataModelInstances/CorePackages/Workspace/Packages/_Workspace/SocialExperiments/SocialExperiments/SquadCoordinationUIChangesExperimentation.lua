-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:51:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialExperimentsParent = script:FindFirstAncestor("SocialExperiments").Parent

local ExperimentCacheManager = require(SocialExperimentsParent.ExperimentCacheManager).ExperimentCacheManager

local str1 = game:DefineFastString("SquadCoordinationUiExperimentLayer", "Party.Coordination.UI")

local str2 = game:DefineFastString("SquadEnablePartyCoordinationUiVariant", "enablePartyCoordinationUi")
local bool1 = game:DefineFastFlag("ForceEnablePartyCoordinationUiChanges3", false)

local function getIsUserInTreatment(str3: string) -- Luacid: unused: defined but never referenced
    local layerVariables = ExperimentCacheManager.default:getLayerVariables(str1)

    return if layerVariables and layerVariables[str3] ~= nil then layerVariables[str3] else false
end

return {
    getPartyCoordinationUiChangesEnabled = function()
        local bool2 = bool1

        if not bool2 then
            local str3 = str2
            local layerVariables = ExperimentCacheManager.default:getLayerVariables(str1)

            if layerVariables and layerVariables[str3] ~= nil then
                return layerVariables[str3]
            end

            bool2 = false
        end

        return bool2
    end,
    logExposure = function()
        if ExperimentCacheManager.default:getLayerVariables(str1) ~= nil then
            ExperimentCacheManager.default:logLayerExposure(str1)
        end
    end
}
