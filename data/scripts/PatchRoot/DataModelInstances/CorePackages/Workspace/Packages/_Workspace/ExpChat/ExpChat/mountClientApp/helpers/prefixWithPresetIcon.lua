-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:10:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextChatService = game:GetService("TextChatService")

local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local ExpChatShared = require(ExpChatParent.ExpChatShared)
local Config = require(ExpChat.Config)

local getPresetIconRichText = ExpChatShared.getPresetIconRichText

local function getChatWindowTextSize() -- Luacid: Inlined by compiler; 1 call site recovered
    local chatWindowConfiguration = TextChatService:FindFirstChildOfClass("ChatWindowConfiguration")
    return if chatWindowConfiguration then chatWindowConfiguration.TextSize else Config.ChatWindowTextSize
end

local function prefixWithPresetIcon(str1: string, num1: number?): string
    return `{getPresetIconRichText(num1 or getChatWindowTextSize())} {str1}`
end

return prefixWithPresetIcon
