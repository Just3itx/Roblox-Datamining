-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:01:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextChannelWindow = script:FindFirstAncestor("TextChannelWindow")
local TextChannelWindowParent = TextChannelWindow.Parent
local MessageDraftModel = require(TextChannelWindowParent.ChatUIPrimitives.MessageDraftModel)
local _MessageComposer = require(TextChannelWindowParent.ChatUIPrimitives.MessageComposer)
local Logger = require(TextChannelWindow.Logger)
local sendEmojiExpression = require(script.Parent.sendEmojiExpression)
local sendPresetExpression = require(script.Parent.sendPresetExpression)

local function sendMessageDraft(arg1, arg2, bool1: boolean, callback: (...any) -> (...any))
    local var1 = MessageDraftModel.toPreset(arg1)
    if var1 ~= nil then
        sendPresetExpression(var1.presetId, arg2)
        return
    end

    local var2 = MessageDraftModel.toEmoji(arg1)
    if var2 ~= nil then
        sendEmojiExpression(var2.unicode, arg2, bool1)
        return
    end

    local var3 = MessageDraftModel.toPlainText(arg1)
    if var3 ~= nil then
        callback(var3)
        return
    end

    Logger:warning("Draft not sent: unsupported content kind")
end

return sendMessageDraft
