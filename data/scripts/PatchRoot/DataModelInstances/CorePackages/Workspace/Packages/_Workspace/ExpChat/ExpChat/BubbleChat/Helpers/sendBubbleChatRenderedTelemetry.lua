-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local TextChatService = game:GetService("TextChatService")

local _MessageEffect = require(ExpChat.MessageEffects.MessageEffect)

local shouldSendHighFrequencyTelemetry = require(ExpChat.shouldSendHighFrequencyTelemetry)
local getFFlagExpChatUseUpdatedMessageRendered = require(ExpChat.Flags.getFFlagExpChatUseUpdatedMessageRendered)

local var1 = require(ExpChat.Flags.getFIntExpChatMessageRenderUserThrottlePermyriad)()

local EngineFeatureExpChatGlobalChatEngineTelemetryEnabled = require(ExpChat.Flags.EngineFeatureExpChatGlobalChatEngineTelemetryEnabled)

local EngineFeatureTextChatReportEmojiTelemetryEnabled = require(ExpChat.Flags.EngineFeatureTextChatReportEmojiTelemetryEnabled)

local function sendBubbleChatRenderedTelemetry(textChatMessage: TextChatMessage, specialEffects)
    if not (getFFlagExpChatUseUpdatedMessageRendered() and shouldSendHighFrequencyTelemetry(var1)) then
        return
    end

    if not EngineFeatureExpChatGlobalChatEngineTelemetryEnabled then
        TextChatService:SendExpChatMessageClientRendered(textChatMessage, "bubble_chat")
        return
    end

    if EngineFeatureTextChatReportEmojiTelemetryEnabled then
        TextChatService:SendExpChatMessageClientRendered(textChatMessage, "bubble_chat", -1, "", specialEffects)
        return
    end

    TextChatService:SendExpChatMessageClientRendered(textChatMessage, "bubble_chat", -1)
end

return sendBubbleChatRenderedTelemetry
