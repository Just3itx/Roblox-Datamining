-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialExperimentsParent = script:FindFirstAncestor("SocialExperiments").Parent

local ExperimentCacheManager = require(SocialExperimentsParent.ExperimentCacheManager).ExperimentCacheManager
local SharedFlags = require(SocialExperimentsParent.SharedFlags)

local str1 = game:DefineFastString("FStringLuckyRecommendationExpLayer", "Party.Coordination.ExperienceJoin3")

local str2 = game:DefineFastString("LuckyRecommendationEnableVariant", "enableLuckyRecommendation")

local FFlagForceEnableLuckyRecommendation = SharedFlags.FFlagForceEnableLuckyRecommendation
local FFlagEnableLuckyRecommendationExperimentation = SharedFlags.FFlagEnableLuckyRecommendationExperimentation

local function getIsUserInTreatment(str3: string) -- Luacid: unused: defined but never referenced
    local layerVariables = ExperimentCacheManager.default:getLayerVariables(str1)

    return if layerVariables and layerVariables[str3] ~= nil then layerVariables[str3] else false
end

return {
    getLuckyRecommendationEnabled = function()
        local var1 = FFlagForceEnableLuckyRecommendation

        if not var1 then
            var1 = FFlagEnableLuckyRecommendationExperimentation

            if var1 then
                local str3 = str2
                local layerVariables = ExperimentCacheManager.default:getLayerVariables(str1)

                if layerVariables and layerVariables[str3] ~= nil then
                    return layerVariables[str3]
                end

                var1 = false
            end
        end

        return var1
    end,
    logExposure = function()
        if not FFlagForceEnableLuckyRecommendation
            and FFlagEnableLuckyRecommendationExperimentation
            and ExperimentCacheManager.default:getLayerVariables(str1) ~= nil
        then
            ExperimentCacheManager.default:logLayerExposure(str1)
        end
    end
}
