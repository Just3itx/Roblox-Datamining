-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:50:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialExperimentsParent = script:FindFirstAncestor("SocialExperiments").Parent

local ExperimentCacheManager = require(SocialExperimentsParent.ExperimentCacheManager).ExperimentCacheManager

local str1 = game:DefineFastString("ExpChatNewSystemMessagesExperimentLayer", "ExperienceChat.SystemMessages")

local str2 = game:DefineFastString("ExpChatNewSystemMessagesVariant", "enableNewSystemMessages")
local bool1 = game:DefineFastFlag("ForceEnableExpChatNewSystemMessages", false)

local isExperimentEnabled = game:DefineFastFlag("EnableExpChatNewSystemMessagesExperimentation", false)

local function getIsUserInTreatment(str3: string) -- Luacid: unused: defined but never referenced
    local layerVariables = ExperimentCacheManager.default:getLayerVariables(str1)

    return if layerVariables and layerVariables[str3] ~= nil then layerVariables[str3] else false
end

return {
    getNewSystemMessagesEnabled = function()
        local bool3 = bool1

        if not bool3 then
            bool3 = isExperimentEnabled

            if bool3 then
                local str3 = str2
                local layerVariables = ExperimentCacheManager.default:getLayerVariables(str1)

                if layerVariables and layerVariables[str3] ~= nil then
                    return layerVariables[str3]
                end

                bool3 = false
            end
        end

        return bool3
    end,
    logExposure = function()
        if isExperimentEnabled and ExperimentCacheManager.default:getLayerVariables(str1) ~= nil then
            ExperimentCacheManager.default:logLayerExposure(str1)
        end
    end,
    isExperimentEnabled = isExperimentEnabled
}
