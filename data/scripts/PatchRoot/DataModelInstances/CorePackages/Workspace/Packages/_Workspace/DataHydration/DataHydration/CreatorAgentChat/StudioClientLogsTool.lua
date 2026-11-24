-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:31:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local _types = require(script.Parent.types)

local function valueLooksLikeToolName(arg1): boolean -- Luacid: Inlined by compiler; 8 call sites recovered
    return typeof(arg1) == "string" and string.lower(arg1) == "ask_for_logs"
end

local function toolCallLooksLikeClientLogsRequest(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if valueLooksLikeToolName(arg1.kind) or valueLooksLikeToolName(arg1.title) then
        return true
    end

    local rawInput = arg1.rawInput
    return typeof(rawInput) == "table" and (valueLooksLikeToolName(rawInput.name) or valueLooksLikeToolName(rawInput.toolName))
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

    local tbl1 = {}
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
            table.insert(tbl1, var1)
        end
    end

    if #tbl1 > 0 then
        return table.concat(tbl1)
    end

    return nil
end

return {
    TOOL_NAME = "ask_for_logs",
    LOCAL_TOOL_DEFINITION = {
        name = "ask_for_logs",
        inputSchema = {
            type = "object",
            properties = {
                reason = { type = "string" }
            }
        }
    },
    NOT_IN_GAME_MESSAGE = "The user is not in the game.",
    STALE_LOGS_MESSAGE = "The available logs are from an older saved version. Playtest the latest version first.",
    toolCallLooksLikeClientLogsRequest = toolCallLooksLikeClientLogsRequest,
    findClientLogsRequestInTurnState = function(arg1, tbl1)
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

            if toolCall.status ~= "completed"
                and toolCall.status ~= "failed"
                and toolCall.status ~= "cancelled"
                and getPersistedToolResultText(toolCall) == nil
                and toolCallLooksLikeClientLogsRequest(toolCall)
            then
                return value, toolCall.rawInput, toolCall.turnId, toolCall.referenceId
            end
        end

        return nil, nil, nil, nil
    end,
    formatLogsContent = function(clientLogs, serverLogs)
        return {
            text = HttpService:JSONEncode({ status = "ok", clientLogs = clientLogs, serverLogs = serverLogs })
        }
    end,
    formatNotInGameContent = function()
        return {
            text = HttpService:JSONEncode({ status = "not_in_game", message = "The user is not in the game." })
        }
    end,
    formatStaleLogsContent = function()
        return {
            text = HttpService:JSONEncode(
                {
                    status = "stale",
                    message = "The available logs are from an older saved version. Playtest the latest version first."
                }
            )
        }
    end
}
