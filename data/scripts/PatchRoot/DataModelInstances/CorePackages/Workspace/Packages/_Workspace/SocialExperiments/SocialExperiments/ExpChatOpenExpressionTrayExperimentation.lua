-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:50:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialExperimentsParent = script:FindFirstAncestor("SocialExperiments").Parent

local ExperimentCacheManager = require(SocialExperimentsParent.ExperimentCacheManager).ExperimentCacheManager

local str1 = game:DefineFastString("ExpChatOpenExpressionTrayExperimentLayer", "UniverseChat.OpenExpressionTray")

local bool1 = false

return {
    logExposure = function()
        if bool1 then
            return
        end

        bool1 = true

        pcall(function()
            ExperimentCacheManager.default:logLayerExposure(str1)
        end)
    end
}
