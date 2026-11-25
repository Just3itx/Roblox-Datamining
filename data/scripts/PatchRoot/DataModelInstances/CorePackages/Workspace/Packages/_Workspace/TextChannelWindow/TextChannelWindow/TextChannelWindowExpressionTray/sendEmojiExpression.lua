-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:01:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextChannelWindow = script:FindFirstAncestor("TextChannelWindow")
local Logger = require(TextChannelWindow.Logger)

local FFlagExpChatTextChannelWindowExpressionTrayEmoji = require(TextChannelWindow.Flags.FFlagExpChatTextChannelWindowExpressionTrayEmoji)
local sendTextToChannel = require(TextChannelWindow.sendTextToChannel)

local function sendEmojiExpression(str1: string?, arg1, bool1: boolean)
    if not FFlagExpChatTextChannelWindowExpressionTrayEmoji or not bool1 or str1 == nil or str1 == "" then
        return false
    end
    if arg1 ~= nil then
        return sendTextToChannel(arg1, str1)
    end

    Logger:warning("Emoji not sent: no target channel")
    return false
end

return sendEmojiExpression
