-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:50:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialExperimentsParent = script:FindFirstAncestor("SocialExperiments").Parent

local ExperimentCacheManager = require(SocialExperimentsParent.ExperimentCacheManager).ExperimentCacheManager

local str1 = game:DefineFastString("ExpChatPresetChatAutocompleteExperimentLayer", "UniverseChat.PresetChatAutocomplete")

local str2 = game:DefineFastString("ExpChatPresetChatAutocompleteVariable", "AutocompleteEnabled")

local str3 = game:DefineFastString("ExpChatPresetChatAutocompleteSearchModeVariable", "AutocompleteSearchMode")

local str4 = game:DefineFastString("ExpChatPresetChatAutocompleteMinQueryLengthVariable", "AutocompleteMinQueryLength")

local num1 = game:DefineFastInt("ExpChatPresetAutocompleteRegularIxpOverride", 0)

local num2 = game:DefineFastInt("ExpChatPresetAutocompleteSearchModeOverride", -1)

local num3 = game:DefineFastInt("ExpChatPresetAutocompleteMinQueryLengthOverride", 0)

local bool1 = false

local function getAutocompleteAssignment() -- Luacid: Inlined by compiler; 2 call sites recovered
    local layerVariables = ExperimentCacheManager.default:getLayerVariables(str1)

    return if layerVariables and layerVariables[str2] ~= nil then layerVariables[str2] else nil
end

return {
    isEnabled = function(): boolean
        if num1 == 1 then
            return true
        elseif num1 == 2 then
            return false
        end

        local autocompleteAssignment = getAutocompleteAssignment()
        return autocompleteAssignment == true or autocompleteAssignment == 1
    end,
    getSearchVariant = function()
        local layerVariables = ExperimentCacheManager.default:getLayerVariables(str1) or {}
        local var1 = if num2 >= 0 then num2 else tonumber(layerVariables[str3])
        local var2 = if num3 > 0 then num3 else tonumber(layerVariables[str4])

        if var2 ~= nil and var2 < 1 then
            var2 = nil
        end

        return { mode = var1, minQueryLength = var2 }
    end,
    logExposure = function()
        if bool1 or getAutocompleteAssignment() == nil then
            return
        end

        bool1 = true

        pcall(function()
            ExperimentCacheManager.default:logLayerExposure(str1)
        end)
    end
}
