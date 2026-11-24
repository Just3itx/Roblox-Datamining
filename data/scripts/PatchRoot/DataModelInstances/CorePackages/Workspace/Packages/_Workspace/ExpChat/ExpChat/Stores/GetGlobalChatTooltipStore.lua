-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:30:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local Signals = require(ExpChatParent.Signals)
local createGlobalChatTooltipStore = require(script.createGlobalChatTooltipStore)
local fetchGlobalChatTooltipEligibility = require(script.fetchGlobalChatTooltipEligibility)

return Signals.createComputed(function()
    local globalChatTooltipStore = createGlobalChatTooltipStore()
    globalChatTooltipStore.reportImpression = fetchGlobalChatTooltipEligibility.reportImpression

    fetchGlobalChatTooltipEligibility.fetchEligibility(function(arg1)
        globalChatTooltipStore.setIsGlobalChatTooltipEligible(arg1.shouldShowTooltip)
    end)

    return globalChatTooltipStore
end)
