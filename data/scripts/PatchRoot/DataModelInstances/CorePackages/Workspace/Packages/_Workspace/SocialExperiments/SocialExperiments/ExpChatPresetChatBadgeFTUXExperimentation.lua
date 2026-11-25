-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialExperimentsParent = script:FindFirstAncestor("SocialExperiments").Parent

local ExperimentCacheManager = require(SocialExperimentsParent.ExperimentCacheManager).ExperimentCacheManager

local FFlagExpChatPresetChatBadgeExperimentCleanup = require(SocialExperimentsParent.SharedFlags).FFlagExpChatPresetChatBadgeExperimentCleanup

local str1 = game:DefineFastString("ExpChatPresetChatBadgeFTUXExperimentLayer", "UniverseChat.PresetChat")

local str2 = game:DefineFastString("ExpChatPresetChatBadgeFTUXVariable", "ChatIconBadged")

local isExperimentEnabled = game:DefineFastFlag("ExpChatEnablePresetChatBadgeFTUXExperimentation", false)

local num1 = game:DefineFastInt("ExpChatPresetChatIconBadgeOverride", 0)

local bool2 = false

local function getChatIconBadged() -- Luacid: Inlined by compiler; 2 call sites recovered
    local layerVariables = ExperimentCacheManager.default:getLayerVariables(str1)

    return if layerVariables and layerVariables[str2] ~= nil then layerVariables[str2] else nil
end

return {
    getShouldShowPresetChatIconBadge = function(): boolean
        if num1 == 1 then
            return true
        elseif num1 == 2 then
            return false
        end

        if not isExperimentEnabled then
            return not FFlagExpChatPresetChatBadgeExperimentCleanup
        end

        local chatIconBadged = getChatIconBadged()

        if chatIconBadged == nil then
            return not FFlagExpChatPresetChatBadgeExperimentCleanup
        end

        if FFlagExpChatPresetChatBadgeExperimentCleanup then
            return chatIconBadged == true or chatIconBadged == 1
        end

        return chatIconBadged == 1
    end,
    logExposure = function()
        if isExperimentEnabled and not bool2 and getChatIconBadged() ~= nil then
            bool2 = true
            pcall(function()
                ExperimentCacheManager.default:logLayerExposure(str1)
            end)
        end
    end,
    isExperimentEnabled = isExperimentEnabled
}
