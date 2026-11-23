-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:00:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local CreatorAgentChat = require(BuildExperience.Parent.DataHydration.CreatorAgentChat)
local _chatTypes = require(script.Parent.chatTypes)

local function getActiveAnswerForm(arg1, arg2, arg3)
    if arg1 == nil or arg1.isDone then
        return nil
    end
    for toolCallId, value2 in arg2.askUserByToolCallId do
        local toolCall = arg1.toolCalls[toolCallId]
        if toolCall == nil or arg3.onAnswerSelectedByToolCallId[toolCallId] == nil then
            continue
        end

        local var1 = CreatorAgentChat.StudioAskUserTool.extractQuestionsFromToolCall(toolCall)
        if var1 == nil or var1[value2.currentIndex] == nil then
            continue
        end

        local selection = value2.selections[value2.currentIndex]
        local draft = if value2.drafts then value2.drafts[var1[value2.currentIndex].id] else nil
        assert(draft ~= nil, "Active answer form requires a question draft")
        return {
            draft = draft,
            sessionId = arg1.sessionId,
            question = var1[value2.currentIndex],
            toolCallId = toolCallId,
            questionIndex = value2.currentIndex,
            questionCount = #var1,
            selectedOptionId = if selection == nil then nil else selection.selectedOptionId,
            isSubmitting = value2.isSubmitting == true
        }
    end
    return nil
end

return getActiveAnswerForm
