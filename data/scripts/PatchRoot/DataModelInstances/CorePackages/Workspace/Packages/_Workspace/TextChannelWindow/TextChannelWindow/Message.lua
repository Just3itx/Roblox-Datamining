-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _ChatUIPrimitives = require(scriptParentParent.ChatUIPrimitives)

local HttpService = game:GetService("HttpService")
local getFFlagExpChatProtectedChatInternalAPIs = require(scriptParentParent.SharedFlags).getFFlagExpChatProtectedChatInternalAPIs
local getTextAndTranslation = require(script.Parent.getTextAndTranslation)

local function createUserMessage(tbl1)
    return {
        messageType = "user",
        messageId = tbl1.messageId,
        senderUserId = tbl1.senderUserId,
        content = tbl1.content,
        prefixText = tbl1.prefixText,
        timestamp = tbl1.timestamp,
        isOutgoing = tbl1.isOutgoing,
        status = tbl1.status,
        wasRewritten = tbl1.wasRewritten,
        originalText = tbl1.originalText,
        translation = tbl1.translation,
        textChatMessageInstance = tbl1.textChatMessageInstance,
        presetId = tbl1.presetId
    }
end

return {
    markHistorical = function(arg1)
        local var1 = table.clone(arg1)
        var1.isHistorical = true
        return var1
    end,
    createSystemMessage = function(content: string, messageId: string?)
        return {
            messageId = messageId or HttpService:GenerateGUID(false),
            messageType = "system-roblox",
            content = content,
            timestamp = DateTime.now()
        }
    end,
    createExperienceSystemMessage = function(content: string, messageId: string?, iconName: string?)
        return {
            messageId = messageId or HttpService:GenerateGUID(false),
            messageType = "system-experience",
            content = content,
            iconName = iconName,
            timestamp = DateTime.now()
        }
    end,
    createSystemMessageFromTextChatMessage = function(textChatMessageInstance)
        return {
            messageId = textChatMessageInstance.MessageId,
            messageType = "system-roblox",
            content = if getFFlagExpChatProtectedChatInternalAPIs() then textChatMessageInstance.TextInternal else textChatMessageInstance.Text,
            timestamp = textChatMessageInstance.Timestamp,
            textChatMessageInstance = textChatMessageInstance
        }
    end,
    createUserMessage = createUserMessage,
    createUserMessageFromTextChatMessage = function(textChatMessageInstance, str1: string)
        local textSource = textChatMessageInstance.TextSource

        local content, translation = getTextAndTranslation(textChatMessageInstance)
        return (createUserMessage({
            messageId = textChatMessageInstance.MessageId,
            senderUserId = tostring(textSource.UserId),
            prefixText = if getFFlagExpChatProtectedChatInternalAPIs() then textChatMessageInstance.PrefixTextInternal else textChatMessageInstance.PrefixText,
            content = content,
            translation = translation,
            wasRewritten = if textChatMessageInstance.WasRewritten then true else nil,
            originalText = if textChatMessageInstance.WasRewritten then textChatMessageInstance.OriginalText else nil,
            timestamp = textChatMessageInstance.Timestamp,
            isOutgoing = tostring(textSource.UserId) == str1,
            status = nil,
            textChatMessageInstance = textChatMessageInstance,
            presetId = if game:GetEngineFeature("TextChatPresetsEnabled") then textChatMessageInstance.PresetId else nil
        }))
    end
}
