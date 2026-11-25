-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialExperimentsParent = script:FindFirstAncestor("SocialExperiments").Parent

local ExperimentCacheManager = require(SocialExperimentsParent.ExperimentCacheManager).ExperimentCacheManager

local str1 = game:DefineFastString("FStringPartyPageCarouselExpLayer", "Party.Coordination.UI")
local str2 = game:DefineFastString("PartyPageCarouselVariant", "enablePartyCoordinationUi")
local bool1 = game:DefineFastFlag("ForceEnableSocialCarouselPartyPage5", false)

local bool2 = game:DefineFastFlag("EnablePartyPageCarouselExperimentation4", false)

local function getIsUserInTreatment(str3: string) -- Luacid: unused: defined but never referenced
    local layerVariables = ExperimentCacheManager.default:getLayerVariables(str1)

    return if layerVariables and layerVariables[str3] ~= nil then layerVariables[str3] else false
end

return {
    getAppChatFormFactorEnabled = function()
        local bool3 = bool1

        if not bool3 then
            bool3 = bool2

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
    getPartyPageCarouselEnabled = function()
        local bool3 = bool1

        if not bool3 then
            bool3 = bool2

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
        if bool2 and ExperimentCacheManager.default:getLayerVariables(str1) ~= nil then
            ExperimentCacheManager.default:logLayerExposure(str1)
        end
    end
}
