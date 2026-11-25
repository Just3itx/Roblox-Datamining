-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:50:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialExperimentsParent = script:FindFirstAncestor("SocialExperiments").Parent

local ExperimentCacheManager = require(SocialExperimentsParent.ExperimentCacheManager).ExperimentCacheManager

local str1 = game:DefineFastString("ExpChatMessageHistoryLayer", "ExperienceChat.MessageHistory")

local str2 = game:DefineFastString("ExpChatHistoryMessageCountVariable", "historyMessageCount")

local str3 = game:DefineFastString("ExpChatHistoryMaxAgeSecondsVariable", "historyMaxAgeSeconds")

local bool1 = game:DefineFastFlag("ForceEnableExpChatMessageHistory", false)
local maxCount = game:DefineFastInt("DebugExpChatHistoryMessageCount", 10)
local maxAgeSeconds = game:DefineFastInt("DebugExpChatHistoryMaxAgeSeconds", 0)

local var1 = nil
local bool2 = false

return {
    getHistoryArm = function(bool3: boolean)
        if not bool3 then
            return nil
        end

        if var1 then
            return var1
        end

        local layerVariables = ExperimentCacheManager.default:getLayerVariables(str1)
        if layerVariables == nil or layerVariables[str2] == nil then
            return if bool1 then { maxCount = maxCount, maxAgeSeconds = maxAgeSeconds } else nil
        end

        var1 = {
            maxCount = layerVariables[str2] or 0,
            maxAgeSeconds = layerVariables[str3] or 0
        }
        return var1
    end,
    logExposure = function(bool3: boolean)
        if bool2 or not bool3 then
            return
        end

        local layerVariables = ExperimentCacheManager.default:getLayerVariables(str1)
        if layerVariables == nil or layerVariables[str2] == nil then
            return
        end

        bool2 = true
        pcall(function()
            ExperimentCacheManager.default:logLayerExposure(str1)
        end)
    end
}
