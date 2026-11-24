-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _types = require(script.Parent.types)
local HttpService = game:GetService("HttpService")

local tbl1 = {
    single_select = "single_select",
    multi_select = "multi_select",
    free_text = "free_text"
}

local function valueLooksLikeToolName(arg1): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
    return typeof(arg1) == "string" and string.lower(arg1) == "ask_user"
end

local function getQuestionsPayload(rawInput) -- Luacid: Inlined by compiler; 1 call site recovered
    if typeof(rawInput) ~= "table" then
        return nil
    end

    if typeof(rawInput[1]) == "table" then
        return rawInput
    end

    if typeof(rawInput.questions) == "table" then
        return rawInput.questions
    end

    return if typeof(rawInput.data) == "table" then rawInput.data else nil
end

local function resolveResponseType(responseType, num1: number) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = if typeof(responseType) == "string" then tbl1[responseType] else nil
    return if var1 == nil then if num1 > 0 then "single_select" else "free_text" else var1
end

local function toAnswerQuestions(rawInput)
    local questionsPayload = getQuestionsPayload(rawInput)

    if typeof(questionsPayload) ~= "table" then
        return nil
    end

    local tbl2 = {}
    for value, value2 in questionsPayload do
        if typeof(value2) ~= "table" or typeof(value2.question) ~= "string" then
            continue
        end

        local tbl3 = {}
        local options = value2.options
        if typeof(options) == "table" then
            for k, option in options do
                if typeof(option) ~= "table" or typeof(option.optionText) ~= "string" then
                    continue
                end

                table.insert(tbl3, {
                    id = `q{value}-o{k}`,
                    title = option.optionText,
                    description = if typeof(option.clarificationText) ~= "string" then "" else option.clarificationText
                })
            end
        end

        table.insert(tbl2, {
            id = `q{value}`,
            question = value2.question,
            options = tbl3,
            responseType = resolveResponseType(value2.responseType, #tbl3)
        })
    end

    return if #tbl2 > 0 then tbl2 else nil
end

local function extractQuestionsFromToolCall(arg1)
    local var1 = toAnswerQuestions(arg1.rawInput)
    if var1 == nil then
        return nil
    end

    if valueLooksLikeToolName(arg1.kind) or valueLooksLikeToolName(arg1.title) then
        return var1
    end

    local rawInput = arg1.rawInput
    return if typeof(rawInput) == "table" and (valueLooksLikeToolName(rawInput.name) or valueLooksLikeToolName(rawInput.toolName)) then var1 else nil
end

local function decodePersistedToolResultText(text: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local success, result = pcall(HttpService.JSONDecode, HttpService, text)
    if not success or typeof(result) ~= "table" then
        return nil
    end

    return if typeof(result.text) == "string" then result.text else nil
end

local function getPersistedToolResultText(toolCall)
    if toolCall.content == nil then
        return nil
    end

    local tbl2 = {}
    for _, value in toolCall.content do
        if value.type ~= "content" or value.content == nil then
            continue
        end

        local content = value.content
        if content.type ~= "text" or typeof(content.text) ~= "string" then
            continue
        end

        local var1 = decodePersistedToolResultText(content.text)
        if var1 ~= nil and var1 ~= "" then
            table.insert(tbl2, var1)
        end
    end

    if #tbl2 > 0 then
        return table.concat(tbl2)
    end

    return nil
end

local function formatToolResultText(tbl2): string
    local answers = {}
    for _, value in tbl2 do
        local options = value.options
        if options ~= nil and #options > 0 then
            local selectedOptionId = {}
            local tbl5 = {}
            for _, option in options do
                table.insert(selectedOptionId, option.id)
                table.insert(tbl5, option.title)
            end
            table.insert(
                answers,
                {
                    questionId = value.question.id,
                    selectedOptionId = selectedOptionId,
                    content = table.concat(tbl5, ", ")
                }
            )
        elseif value.option ~= nil then
            local option = value.option
            table.insert(answers, { questionId = value.question.id, selectedOptionId = option.id, content = option.title })
        elseif value.customResponseText ~= nil then
            table.insert(answers, { questionId = value.question.id, content = value.customResponseText })
        end
    end

    return HttpService:JSONEncode({ answers = answers })
end

local function findSelectedOptionById(question, id: string?) -- Luacid: Inlined by compiler; 1 call site recovered
    if id == nil then
        return nil
    end
    for _, option in question.options do
        if option.id == id then
            return option
        end
    end
    return nil
end

local function findSelectedOptionsByIds(question, selectedOptionId)
    local tbl2 = {}
    for _, option in question.options do
        tbl2[option.id] = option
    end

    local selectedOptionsByIds = {}
    for _, value in selectedOptionId do
        local var1 = tbl2[value]
        if var1 == nil then
            return nil
        end
        table.insert(selectedOptionsByIds, var1)
    end
    return selectedOptionsByIds
end

local function normalizeSelectedOptionId(selectedOptionId)
    if typeof(selectedOptionId) == "string" then
        return selectedOptionId
    end
    if typeof(selectedOptionId) ~= "table" then
        return nil
    end

    local tbl2 = {}
    for _, value in selectedOptionId do
        if typeof(value) ~= "string" then
            return nil
        end
        table.insert(tbl2, value)
    end
    return if #tbl2 > 0 then tbl2 else nil
end

local function getAnswersByQuestionId(persistedToolResultText: string)
    local answersByQuestionId = ({})
    local success, result = pcall(HttpService.JSONDecode, HttpService, persistedToolResultText)
    if not success or typeof(result) ~= "table" then
        return answersByQuestionId
    end

    local answers = result.answers
    if typeof(answers) ~= "table" then
        return answersByQuestionId
    end
    for _, answer in answers do
        if typeof(answer) ~= "table" or typeof(answer.questionId) ~= "string" or typeof(answer.content) ~= "string" then
            continue
        end

        local questionId = answer.questionId
        answersByQuestionId[questionId] = {
            questionId = answer.questionId,
            selectedOptionId = normalizeSelectedOptionId(answer.selectedOptionId),
            content = answer.content
        }
    end

    return answersByQuestionId
end

local function getPromptFromToolResult(question, tbl2, toolCallId: string, callOrder: number)
    if tbl2 == nil then
        return nil
    end

    local selectedOptionId = tbl2.selectedOptionId
    if typeof(selectedOptionId) == "table" then
        return if findSelectedOptionsByIds(question, selectedOptionId) == nil then nil else {
            question = question,
            selectedOptionId = selectedOptionId,
            toolCallId = toolCallId,
            callOrder = callOrder
        }
    end

    local selectedOptionById = findSelectedOptionById(question, selectedOptionId)

    if selectedOptionId ~= nil and selectedOptionById == nil then
        return nil
    end

    local content = if selectedOptionById == nil then tbl2.content else nil
    return {
        question = question,
        selectedOptionId = if selectedOptionById == nil then nil else selectedOptionById.id,
        customResponseText = content,
        toolCallId = toolCallId,
        callOrder = callOrder
    }
end

local function getToolCallOrder(arg1, toolCallId: string)
    if arg1.activityItems ~= nil then
        for k, activityItem in arg1.activityItems do
            if activityItem.kind == "tool_call" and activityItem.toolCallId == toolCallId then
                return k
            end
        end
    end

    local tbl2 = {}
    for k in arg1.toolCalls do
        table.insert(tbl2, k)
    end
    table.sort(tbl2)
    for value, value2 in tbl2 do
        if value2 == toolCallId then
            return value
        end
    end

    return 0
end

return {
    TOOL_NAME = "ask_user",
    LOCAL_TOOL_DEFINITION = {
        name = "ask_user",
        inputSchema = {
            type = "array",
            items = {
                type = "object",
                required = { "question", "options" },
                properties = {
                    question = { type = "string" },
                    responseType = {
                        type = "string",
                        enum = { "single_select", "multi_select", "free_text" }
                    },
                    options = {
                        type = "array",
                        items = {
                            type = "object",
                            required = { "optionText" },
                            properties = {
                                optionText = { type = "string" },
                                clarificationText = { type = "string" }
                            }
                        }
                    }
                }
            }
        }
    },
    CANCELLATION_TEXT = "User cancelled answering the question",
    extractQuestionsFromToolCall = extractQuestionsFromToolCall,
    findQuestionsInTurnState = function(arg1, tbl2)
        local tbl3 = {}
        for k in arg1.toolCalls do
            table.insert(tbl3, k)
        end
        table.sort(tbl3)

        for _, value in tbl3 do
            if tbl2 and tbl2[value] then
                continue
            end

            local toolCall = arg1.toolCalls[value]
            if toolCall.status == "completed"
                or toolCall.status == "failed"
                or toolCall.status == "cancelled"
                or getPersistedToolResultText(toolCall) ~= nil
            then
                continue
            end

            local var1 = extractQuestionsFromToolCall(toolCall)
            if var1 ~= nil then
                return var1, value, toolCall.rawInput, toolCall.turnId, toolCall.referenceId
            end
        end

        return nil, nil, nil, nil, nil
    end,
    formatToolResultText = formatToolResultText,
    formatToolResultContent = function(tbl2)
        return {
            text = formatToolResultText(tbl2)
        }
    end,
    getAnsweredPromptsFromTurnState = function(arg1)
        local answeredPromptsFromTurnState = {}
        local tbl2 = {}
        for k in arg1.toolCalls do
            table.insert(tbl2, k)
        end
        table.sort(tbl2)

        for _, value in tbl2 do
            local toolCall = arg1.toolCalls[value]
            local var1 = extractQuestionsFromToolCall(toolCall)
            local persistedToolResultText = getPersistedToolResultText(toolCall)
            if var1 == nil or persistedToolResultText == nil then
                continue
            end

            local answersByQuestionId = getAnswersByQuestionId(persistedToolResultText)
            for _, value2 in var1 do
                local promptFromToolResult = getPromptFromToolResult(value2, answersByQuestionId[value2.id], value, (getToolCallOrder(arg1, value)))

                if promptFromToolResult ~= nil then
                    table.insert(answeredPromptsFromTurnState, promptFromToolResult)
                end
            end
        end

        return answeredPromptsFromTurnState
    end,
    formatCancellationContent = function()
        return { text = "User cancelled answering the question" }
    end
}
