-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:20:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function ChatPolicies(arg1)
    return {
        getChatConversationHeaderGroupDetails = function()
            return arg1.ChatConversationHeaderGroupDetails or false
        end,
        getChatHeaderSearch = function()
            return arg1.ChatHeaderSearch or false
        end,
        getChatHeaderCreateChatGroup = function()
            return arg1.ChatHeaderCreateChatGroup or false
        end,
        getChatHeaderHomeButton = function()
            return arg1.ChatHeaderHomeButton or false
        end,
        getChatHeaderNotifications = function()
            return arg1.ChatHeaderNotifications or false
        end,
        getChatPlayTogether = function()
            return arg1.ChatPlayTogether or false
        end,
        getChatShareGameToChatFromChat = function()
            return arg1.ChatShareGameToChatFromChat or false
        end,
        getChatTapConversationThumbnail = function()
            return arg1.ChatTapConversationThumbnail or false
        end,
        getChatReportingDisabled = function()
            return arg1.ChatReportingDisabled or false
        end,
        getChatViewProfileOption = function()
            return arg1.ChatViewProfileOption or false
        end,
        getContactImporterEnabled = function()
            return arg1.ContactImporterEnabled or false
        end
    }
end

return ChatPolicies
