-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local Display = require(ExpChatParent.Display)
local Signals = require(ExpChatParent.Signals)
local createSignal = Signals.createSignal

return function()
    local getShouldShowGlobalChatTooltip, setShouldShowGlobalChatTooltip = createSignal(false)
    local getIsChatWindowOpen, setIsChatWindowOpen = createSignal(false)
    local getIsGlobalChatTooltipDismissed, setIsGlobalChatTooltipDismissed = createSignal(false)
    local getIsGlobalChatTooltipEligible, setIsGlobalChatTooltipEligible = createSignal(false)

    return {
        getShouldShowGlobalChatTooltip = getShouldShowGlobalChatTooltip,
        setShouldShowGlobalChatTooltip = setShouldShowGlobalChatTooltip,
        getIsChatWindowOpen = getIsChatWindowOpen,
        setIsChatWindowOpen = setIsChatWindowOpen,
        getIsGlobalChatTooltipDismissed = getIsGlobalChatTooltipDismissed,
        setIsGlobalChatTooltipDismissed = setIsGlobalChatTooltipDismissed,
        getIsGlobalChatTooltipEligible = getIsGlobalChatTooltipEligible,
        setIsGlobalChatTooltipEligible = setIsGlobalChatTooltipEligible,
        getIsScreenWideEnough = Signals.createComputed(function(arg1): boolean
            return Display.GetDisplayStore(arg1).getViewportSize(arg1).X >= 720
        end),
        reportImpression = function() end
    }
end
