-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:41:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialExperimentsParent = script:FindFirstAncestor("SocialExperiments").Parent

local ExperimentCacheManager = require(SocialExperimentsParent.ExperimentCacheManager).ExperimentCacheManager

local str1 = game:DefineFastString("ExpChatGlobalTabDefaultExperimentLayer", "ExperienceChat.TabOrder")

local str2 = game:DefineFastString("ExpChatGlobalTabDefaultVariant", "globalTabDefault")

local str3 = game:DefineFastString("ExpChatGlobalTabBubbleChatVariant", "globalTabBubbleChat")

local str4 = game:DefineFastString("ExpChatGlobalTabMessagePrefixVariant", "globalTabMessagePrefix")

local str5 = game:DefineFastString("ExpChatGlobalTabShortWelcomeVariant", "globalTabShortWelcomeMessage")

local bool1 = game:DefineFastFlag("ForceEnableExpChatGlobalTabDefault", false)
local bool2 = game:DefineFastFlag("ForceEnableExpChatGlobalTabBubbleChat", false)

local bool3 = game:DefineFastFlag("ForceEnableExpChatGlobalTabMessagePrefix", false)

local bool4 = game:DefineFastFlag("ForceEnableExpChatGlobalTabShortWelcome", false)

local function getIsUserInTreatment(str6: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local layerVariables = ExperimentCacheManager.default:getLayerVariables(str1)

    return if layerVariables and layerVariables[str6] ~= nil then layerVariables[str6] else false
end

return {
    getIsGlobalTabDefault = function()
        local bool5 = bool1

        if not bool5 then
            local str6 = str2
            local layerVariables = ExperimentCacheManager.default:getLayerVariables(str1)

            if layerVariables and layerVariables[str6] ~= nil then
                return layerVariables[str6]
            end

            bool5 = false
        end

        return bool5
    end,
    getIsGlobalBubbleChatEnabled = function()
        local bool5 = bool2

        if not bool5 then
            local str6 = str3
            local layerVariables = ExperimentCacheManager.default:getLayerVariables(str1)

            if layerVariables and layerVariables[str6] ~= nil then
                return layerVariables[str6]
            end

            bool5 = false
        end

        return bool5
    end,
    getIsGlobalMessagePrefixEnabled = function()
        local bool5 = bool3

        if not bool5 then
            local str6 = str4
            local layerVariables = ExperimentCacheManager.default:getLayerVariables(str1)

            if layerVariables and layerVariables[str6] ~= nil then
                return layerVariables[str6]
            end

            bool5 = false
        end

        return bool5
    end,
    getGlobalWelcomeMessageKey = function(): string
        return if bool4 or getIsUserInTreatment(str5) then "CoreScripts.TextChat.ChatWindow.ChatEnabled.Global3" else "CoreScripts.TextChat.ChatWindow.ChatEnabled.Global2"
    end,
    logExposure = function()
        if ExperimentCacheManager.default:getLayerVariables(str1) ~= nil then
            ExperimentCacheManager.default:logLayerExposure(str1)
        end
    end
}
