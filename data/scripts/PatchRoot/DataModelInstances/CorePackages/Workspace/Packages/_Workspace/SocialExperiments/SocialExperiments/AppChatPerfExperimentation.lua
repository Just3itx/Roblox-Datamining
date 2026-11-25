-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:41:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialExperimentsParent = script:FindFirstAncestor("SocialExperiments").Parent

local ExperimentCacheManager = require(SocialExperimentsParent.ExperimentCacheManager).ExperimentCacheManager

local str1 = game:DefineFastString("AppChatPerfExperimentLayer", "Party.Chat.Perf")

local function getIsUserInTreatment(str2: string) -- Luacid: Inlined by compiler; 4 call sites recovered
    local layerVariables = ExperimentCacheManager.default:getLayerVariables(str1)

    return if layerVariables and layerVariables[str2] ~= nil then layerVariables[str2] else false
end

return {
    getChatLandingPaginationEnabled = function()
        return getIsUserInTreatment("IsChatLandingPaginationEnabled")
    end,
    getChatConversationPaginationEnabled = function()
        return getIsUserInTreatment("IsChatConversationPaginationEnabled")
    end,
    getChatMembersPaginationEnabled = function()
        return getIsUserInTreatment("IsChatMembersPaginationEnabled")
    end,
    getChatConversationRenderingFixEnabled = function()
        return getIsUserInTreatment("IsChatConversationRenderingFixEnabled")
    end,
    logExposure = function()
        if ExperimentCacheManager.default:getLayerVariables(str1) ~= nil then
            ExperimentCacheManager.default:logLayerExposure(str1)
        end
    end
}
