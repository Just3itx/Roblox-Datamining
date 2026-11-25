-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:51:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialExperimentsParent = script:FindFirstAncestor("SocialExperiments").Parent

local ExperimentCacheManager = require(SocialExperimentsParent.ExperimentCacheManager).ExperimentCacheManager

local str1 = game:DefineFastString("SquadsUnifyCoplayExpLayer", "Party.Formation.Create.PartyNudge")

local str2 = game:DefineFastString("SquadsUnifyCoplayOneOnOnePartyCreationVariant", "enableOneOnOnePartyCreation")

local str3 = game:DefineFastString("SquadsUnifyCoplayMultiInvitePartyCreationVariant", "enableMultiInvitePartyCreation")

local bool1 = game:DefineFastFlag("EnableSquadsUnifyCoplayOneOnOnePartyCreation_dev", false)

local bool2 = game:DefineFastFlag("EnableSquadsUnifyCoplayMultiInvitePartyCreation_dev", false)

local bool3 = game:DefineFastFlag("EnableSquadsUnifyCoplayExperimentation_dev", false)
local GetFFlagIsSquadEnabled = require(SocialExperimentsParent.SharedFlags).GetFFlagIsSquadEnabled

local function getIsUserInTreatment(str4: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    local layerVariables = ExperimentCacheManager.default:getLayerVariables(str1)

    return if layerVariables and layerVariables[str4] ~= nil then layerVariables[str4] else false
end

return {
    getOneOnOnePartyCreationEnabled = function()
        return bool1 or bool3 and getIsUserInTreatment(str2) and GetFFlagIsSquadEnabled()
    end,
    getMultiInvitePartyCreationEnabled = function()
        return bool2 or bool3 and getIsUserInTreatment(str3) and GetFFlagIsSquadEnabled()
    end,
    logExposure = function()
        if bool3 and ExperimentCacheManager.default:getLayerVariables(str1) ~= nil then
            ExperimentCacheManager.default:logLayerExposure(str1)
        end
    end
}
