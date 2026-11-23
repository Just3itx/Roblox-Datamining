-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:31:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Foundation = require(AppChatParent.Foundation)

local UniversalAppPolicy = require(AppChatParent.UniversalAppPolicy)

return function()
    local getCanSeeChatTerminology = UniversalAppPolicy.getAppFeaturePolicies().getCanSeeChatTerminology

    local uDim2 = UDim2.new(0, 0, 0, 0)
    return {
        label = if getCanSeeChatTerminology() then "CommonUI.Features.Label.Chat" else "Feature.Squads.Label.Party",
        icon = if getCanSeeChatTerminology() then Foundation.Enums.IconName.SpeechBubbleAlignCenter else Foundation.Enums.IconName.TwoPeopleSpeechBubble,
        badgeOffset = uDim2
    }
end
