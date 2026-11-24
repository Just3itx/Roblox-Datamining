-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:31:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local _types = require(script.Parent.types)

local function valueLooksLikeToolName(arg1, str1: string): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
    return typeof(arg1) == "string" and string.lower(arg1) == str1
end

local function toolCallLooksLikeRequest(arg1, str1: string)
    if valueLooksLikeToolName(arg1.kind, str1) or valueLooksLikeToolName(arg1.title, str1) then
        return true
    end

    local rawInput = arg1.rawInput
    return typeof(rawInput) == "table"
        and (valueLooksLikeToolName(rawInput.name, str1) or valueLooksLikeToolName(rawInput.toolName, str1))
end

local function hasPersistedToolResult(toolCall)
    if toolCall.content == nil then
        return false
    end

    for _, value in toolCall.content do
        if value.type ~= "content" or value.content == nil then
            continue
        end

        local content = value.content
        if content.type ~= "text" or typeof(content.text) ~= "string" then
            continue
        end

        local success, result = pcall(HttpService.JSONDecode, HttpService, content.text)
        if success and typeof(result) == "table" and typeof(result.text) == "string" and result.text ~= "" then
            return true
        end
    end

    return false
end

local function findRequestInTurnState(arg1, str1: string, tbl1)
    local tbl2 = {}
    for k in arg1.toolCalls do
        table.insert(tbl2, k)
    end
    table.sort(tbl2)

    for _, value in tbl2 do
        if tbl1 and tbl1[value] then
            continue
        end

        local toolCall = arg1.toolCalls[value]
        if (toolCall.status == nil or toolCall.status == "pending" or toolCall.status == "in_progress")
            and not hasPersistedToolResult(toolCall)
            and toolCallLooksLikeRequest(toolCall, str1)
        then
            return value, toolCall.rawInput, toolCall.turnId, toolCall.referenceId
        end
    end

    return nil, nil, nil, nil
end

return {
    SEARCH_TOOL_NAME = "search_client_datamodel",
    INSPECT_TOOL_NAME = "inspect_client_instance",
    SEARCH_LOCAL_TOOL_DEFINITION = {
        name = "search_client_datamodel",
        inputSchema = {
            type = "object",
            properties = {
                path = { type = "string" },
                instance_type = { type = "string" },
                keywords = { type = "string" },
                max_depth = { type = "integer" },
                head_limit = { type = "integer" }
            }
        }
    },
    INSPECT_LOCAL_TOOL_DEFINITION = {
        name = "inspect_client_instance",
        inputSchema = {
            type = "object",
            properties = {
                path = { type = "string" }
            },
            required = { "path" }
        }
    },
    toolCallLooksLikeRequest = toolCallLooksLikeRequest,
    findSearchRequestInTurnState = function(arg1, tbl1)
        return findRequestInTurnState(arg1, "search_client_datamodel", tbl1)
    end,
    findInspectRequestInTurnState = function(arg1, tbl1)
        return findRequestInTurnState(arg1, "inspect_client_instance", tbl1)
    end,
    formatResultContent = function(arg1)
        local success, result = pcall(HttpService.JSONEncode, HttpService, arg1)

        if not success then
            return {
                text = HttpService:JSONEncode({ status = "serialization_failed", message = "The client tool result could not be serialized." })
            }
        end

        if not (#result > 524288) then
            return { text = result }
        end

        return {
            text = HttpService:JSONEncode(
                {
                    status = "result_too_large",
                    message = "The client tool result exceeded the response size limit."
                }
            )
        }
    end
}
