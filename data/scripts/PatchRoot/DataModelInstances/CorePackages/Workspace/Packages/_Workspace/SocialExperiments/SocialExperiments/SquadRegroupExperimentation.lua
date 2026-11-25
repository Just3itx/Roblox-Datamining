-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:51:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialExperimentsParent = script:FindFirstAncestor("SocialExperiments").Parent

local ExperimentCacheManager = require(SocialExperimentsParent.ExperimentCacheManager).ExperimentCacheManager
local SharedFlags = require(SocialExperimentsParent.SharedFlags)

local str1 = game:DefineFastString("FStringSquadRegroupExpLayer", "Party.Coordination.UnifyCoplay")
local str2 = game:DefineFastString("SquadEnableRegroupVariant", "enableSquadRegroup")

local FFlagForceEnableSquadRegroup = SharedFlags.FFlagForceEnableSquadRegroup
local FFlagEnableSquadRegroupExperimentation = SharedFlags.FFlagEnableSquadRegroupExperimentation

local function getIsUserInTreatment(str3: string) -- Luacid: unused: defined but never referenced
    local layerVariables = ExperimentCacheManager.default:getLayerVariables(str1)

    return if layerVariables and layerVariables[str3] ~= nil then layerVariables[str3] else false
end

return {
    getSquadRegroupEnabled = function()
        local var1 = FFlagForceEnableSquadRegroup

        if not var1 then
            var1 = FFlagEnableSquadRegroupExperimentation

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
        if not FFlagForceEnableSquadRegroup
            and FFlagEnableSquadRegroupExperimentation
            and ExperimentCacheManager.default:getLayerVariables(str1) ~= nil
        then
            ExperimentCacheManager.default:logLayerExposure(str1)
        end
    end
}
