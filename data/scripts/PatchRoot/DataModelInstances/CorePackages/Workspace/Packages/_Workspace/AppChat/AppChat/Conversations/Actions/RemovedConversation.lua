-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:50:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

return require(AppChatParent.Rodux).makeActionCreator(script.Name, function(conversationId)
    return { conversationId = conversationId }
end)
