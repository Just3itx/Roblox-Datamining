-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local _types = require(script.Parent.types)

local tbl1 = { present_plan = true, propose_plan = true }

local function valueLooksLikeToolName(arg1): boolean -- Luacid: Inlined by compiler; 16 call sites recovered
    return typeof(arg1) == "string" and tbl1[string.lower(arg1)] == true
end

local function getRawInputContent(rawInput)
    if typeof(rawInput) == "string" then
        return rawInput, nil, nil
    elseif typeof(rawInput) ~= "table" then
        return nil, nil, nil
    else
        local content = rawInput.content
        if typeof(content) ~= "string" or content == "" then
            return nil, nil, nil
        end

        local title = if typeof(rawInput.title) == "string" and rawInput.title ~= "" then rawInput.title else nil
        if typeof(rawInput.summary) == "string" and rawInput.summary ~= "" then
            return content, title, rawInput.summary
        end

        return content, title, nil
    end
end

local function toolCallLooksLikeProposePlan(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    if valueLooksLikeToolName(arg1.kind) or valueLooksLikeToolName(arg1.title) then
        return true
    end

    local rawInput = arg1.rawInput
    return typeof(rawInput) == "table" and (valueLooksLikeToolName(rawInput.name) or valueLooksLikeToolName(rawInput.toolName))
end

local function extractPlanFromToolCall(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    if not toolCallLooksLikeProposePlan(arg1) then
        return nil
    end

    local textContent, title, summary = getRawInputContent(arg1.rawInput)
    return if textContent == nil then nil else {
        title = title or "Proposed Plan",
        textContent = textContent,
        summary = summary
    }
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

local function decodePlanResult(persistedToolResultText: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local success, result = pcall(HttpService.JSONDecode, HttpService, persistedToolResultText)
    if not success or typeof(result) ~= "table" then
        return nil
    end

    if typeof(result.accepted) == "boolean" then
        if result.feedbackText == nil or typeof(result.feedbackText) == "string" then
            return result
        end

        return nil
    end

    return nil
end

return {
    TOOL_NAME = "present_plan",
    LOCAL_TOOL_DEFINITION = {
        name = "present_plan",
        inputSchema = {
            type = "object",
            required = { "content" },
            properties = {
                content = { type = "string" },
                summary = { type = "string" },
                title = { type = "string" }
            }
        }
    },
    extractPlanFromToolCall = extractPlanFromToolCall,
    findPlanInTurnState = function(arg1, tbl2)
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

            local var1 = extractPlanFromToolCall(toolCall)

            if var1 ~= nil then
                return var1, value, toolCall.rawInput, toolCall.turnId, toolCall.referenceId
            end
        end

        return nil, nil, nil, nil, nil
    end,
    getCompletedPlansFromTurnState = function(arg1)
        local completedPlansFromTurnState = {}
        local tbl2 = {}
        for k in arg1.toolCalls do
            table.insert(tbl2, k)
        end
        table.sort(tbl2)

        for _, toolCallId in tbl2 do
            local toolCall = arg1.toolCalls[toolCallId]
            local var1 = extractPlanFromToolCall(toolCall)
            local persistedToolResultText = getPersistedToolResultText(toolCall)
            local var2 = if persistedToolResultText == nil then nil else decodePlanResult(persistedToolResultText)

            if var1 == nil or var2 == nil then
                continue
            end

            table.insert(completedPlansFromTurnState, {
                title = var1.title,
                textContent = var1.textContent,
                summary = var1.summary,
                toolCallId = toolCallId,
                callOrder = getToolCallOrder(arg1, toolCallId),
                isAccepted = var2.accepted,
                feedbackText = var2.feedbackText
            })
        end

        return completedPlansFromTurnState
    end,
    formatAcceptedContent = function()
        return {
            text = HttpService:JSONEncode({ accepted = true })
        }
    end,
    formatFeedbackContent = function(feedbackText: string)
        return {
            text = HttpService:JSONEncode({ accepted = false, feedbackText = feedbackText })
        }
    end
}
