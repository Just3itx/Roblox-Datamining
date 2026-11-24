-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")

local getMessageText = require(ExpChat.ChatWindow.Helpers.getMessageText)

local getFFlagChatTranslationUIEnabledBubbleChat = require(ExpChat.Flags.getFFlagChatTranslationUIEnabledBubbleChat)

local applyBubbleChatMessagePropertiesText = require(script.Parent.applyBubbleChatMessagePropertiesText)

local function getBubbleChatDisplayText(tbl1)
    local var1, var2 = applyBubbleChatMessagePropertiesText(tbl1.text, tbl1.translation, tbl1.bubbleChatMessageProperties)
    local useTranslation = getFFlagChatTranslationUIEnabledBubbleChat() and tbl1.useTranslation
    return getMessageText(useTranslation, var2, var1)
end

return getBubbleChatDisplayText
