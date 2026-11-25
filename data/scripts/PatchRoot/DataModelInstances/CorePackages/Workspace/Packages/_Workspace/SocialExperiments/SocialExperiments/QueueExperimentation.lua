-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:51:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialExperimentsParent = script:FindFirstAncestor("SocialExperiments").Parent

local ExperimentCacheManager = require(SocialExperimentsParent.ExperimentCacheManager).ExperimentCacheManager

local str1 = game:DefineFastString("FStringQueueExpLayer", "Party.Coordination.ExperienceJoin")

local str2 = game:DefineFastString("QueueEnableAutoJoinNewServerVariant", "enableAutoJoinNewServer")

local str3 = game:DefineFastString("QueueEnableJoinNewServerVariant", "enableJoinNewServerButton")
local bool1 = game:DefineFastFlag("ForceEnableQueueAutoJoinNewServer2", false)
local bool2 = game:DefineFastFlag("ForceEnableQueueJoinNewServerButton2", false)
local engineFeature = game:DefineFastFlag("EnableQueueExperimentation2", false) and game:GetEngineFeature("PlaceJoinStateEnabled")

local function getIsUserInTreatment(str4: string) -- Luacid: unused: defined but never referenced
    local layerVariables = ExperimentCacheManager.default:getLayerVariables(str1)

    return if layerVariables and layerVariables[str4] ~= nil then layerVariables[str4] else false
end

return {
    getIsJoinNewServerButtonEnabled = function()
        local bool3 = bool2

        if not bool3 then
            bool3 = engineFeature

            if bool3 then
                local str4 = str3
                local layerVariables = ExperimentCacheManager.default:getLayerVariables(str1)

                if layerVariables and layerVariables[str4] ~= nil then
                    return layerVariables[str4]
                end

                bool3 = false
            end
        end

        return bool3
    end,
    getIsAutoJoinNewServerEnabled = function()
        local bool3 = bool1

        if not bool3 then
            bool3 = engineFeature

            if bool3 then
                local str4 = str2
                local layerVariables = ExperimentCacheManager.default:getLayerVariables(str1)

                if layerVariables and layerVariables[str4] ~= nil then
                    return layerVariables[str4]
                end

                bool3 = false
            end
        end

        return bool3
    end,
    isInExperiment = function(): boolean
        return if engineFeature then ExperimentCacheManager.default:getLayerVariables(str1) ~= nil else false
    end,
    logExposure = function()
        if engineFeature and ExperimentCacheManager.default:getLayerVariables(str1) ~= nil then
            ExperimentCacheManager.default:logLayerExposure(str1)
        end
    end
}
