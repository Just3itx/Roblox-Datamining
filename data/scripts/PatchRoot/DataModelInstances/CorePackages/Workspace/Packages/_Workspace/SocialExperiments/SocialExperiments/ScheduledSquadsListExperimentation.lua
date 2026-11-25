-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialExperimentsParent = script:FindFirstAncestor("SocialExperiments").Parent

local ExperimentCacheManager = require(SocialExperimentsParent.ExperimentCacheManager).ExperimentCacheManager

local str1 = game:DefineFastString("ScheduledSquadsListExpLayer", "")

local str2 = game:DefineFastString("ScheduledSquadsListChatLandingScreenEntrypointVariant", "enableTopBarEntrypoint")

local bool1 = game:DefineFastFlag("EnableScheduledSquadsListExperimentation_dev", false)

local bool2 = game:DefineFastFlag("EnableScheduledSquadsTopBarEntrypoint_dev", false)

local function getIsUserInTreatment(str3: string) -- Luacid: unused: defined but never referenced
    local layerVariables = ExperimentCacheManager.default:getLayerVariables(str1)

    return if layerVariables and layerVariables[str3] ~= nil then layerVariables[str3] else false
end

return {
    getIsTopBarEntrypointEnabled = function()
        local bool3 = bool2

        if not bool3 then
            bool3 = bool1

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
        if bool1 and ExperimentCacheManager.default:getLayerVariables(str1) ~= nil then
            ExperimentCacheManager.default:logLayerExposure(str1)
        end
    end
}
