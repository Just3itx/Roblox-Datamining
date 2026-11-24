-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:30:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local Signals = require(ExpChatParent.Signals)
local ExpChatShared = require(ExpChatParent.ExpChatShared)

local createChatTooltipStore = require(script.createChatTooltipStore)
local promptsApi = require(script.promptsApi)

local FFlagExpChatPresetChatEnabled = ExpChatShared.Flags.FFlagExpChatPresetChatEnabled
local FFlagExpChatUseUnifiedTooltipStore = ExpChatShared.Flags.FFlagExpChatUseUnifiedTooltipStore

return Signals.createComputed(function()
    local chatTooltipStore = createChatTooltipStore()

    if FFlagExpChatUseUnifiedTooltipStore then
        promptsApi.fetchAllTooltipEligibility(function(arg1)
            local customPrompts = arg1.customPrompts
            chatTooltipStore.setIsEligible("GlobalChatTooltip", customPrompts.GlobalChatTooltip ~= nil)

            if FFlagExpChatPresetChatEnabled then
                chatTooltipStore.setIsEligible("PresetChatTooltip", customPrompts.PresetChatTooltip ~= nil)
            end
        end)
    end

    return chatTooltipStore
end)
