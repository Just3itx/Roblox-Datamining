-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialExperimentsParent = script:FindFirstAncestor("SocialExperiments").Parent

local ExperimentCacheManager = require(SocialExperimentsParent.ExperimentCacheManager).ExperimentCacheManager

local str1 = game:DefineFastString("ExpChatPresetChatEmojiTabExperimentLayer", "UniverseChat.PresetChat.Emojis")

local str2 = game:DefineFastString("ExpChatPresetChatEmojiTabEmojiIconVariable", "emojiIcon")

local str3 = game:DefineFastString("ExpChatPresetChatEmojiTabEmphasizedRenderingVariable", "emphasizedRendering")

local isExperimentEnabled = game:DefineFastFlag("ExpChatPresetChatEmojiTabExperimentEnabled", false)

local bool2 = false

local function getAssignment(str4: string) -- Luacid: Inlined by compiler; 5 call sites recovered
    local layerVariables = ExperimentCacheManager.default:getLayerVariables(str1)

    return if layerVariables and layerVariables[str4] ~= nil then layerVariables[str4] else nil
end

local function getIsTreatment(str4: string): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    if not isExperimentEnabled then
        return false
    end

    local assignment = getAssignment(str4)
    return assignment == true or assignment == 1
end

return {
    getIsEmojiIconEnabled = function(): boolean
        return getIsTreatment(str2)
    end,
    getIsEmphasizedRenderingEnabled = function(): boolean
        return getIsTreatment(str3)
    end,
    logExposure = function()
        if isExperimentEnabled and not bool2 and (getAssignment(str2) ~= nil or getAssignment(str3) ~= nil) then
            bool2 = true

            pcall(function()
                ExperimentCacheManager.default:logLayerExposure(str1)
            end)
        end
    end,
    isExperimentEnabled = isExperimentEnabled
}
