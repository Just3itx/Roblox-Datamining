-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:20:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
return require(ExpChatParent.Rodux).makeActionCreator(script.Name, function(arg1)
    return {
        bubbleChatSettings = arg1.bubbleChatSettings or {},
        chatWindowSettings = arg1.chatWindowSettings or {},
        chatInputBarSettings = arg1.chatInputBarSettings or {},
        channelTabsSettings = arg1.channelTabsSettings or {}
    }
end)
