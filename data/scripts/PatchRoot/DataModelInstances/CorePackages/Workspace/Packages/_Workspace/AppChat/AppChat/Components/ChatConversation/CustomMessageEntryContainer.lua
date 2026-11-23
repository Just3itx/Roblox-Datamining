-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local EnumCustomEntryTypes = require(AppChat.Components.ChatConversation.EnumCustomEntryTypes)

local OsaContextCardOneToOneContainer = require(AppChat.Components.ChatConversation.ConversationCards.OsaContextCardOneToOneContainer)

return React.memo(function(tbl1) -- name: CustomMessageEntryContainer
    if tbl1.customEntryType == EnumCustomEntryTypes.OsaContextCardOneToOne then
        return (React.createElement(
            OsaContextCardOneToOneContainer,
            {
                conversationId = tbl1.conversationId,
                openViewProfile = tbl1.openViewProfile
            }
        ))
    end
    return nil
end)
