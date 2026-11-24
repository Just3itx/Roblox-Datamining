-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:30:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local _types = require(script.Parent.types)

local function valueIs(arg1, str1: string): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
    return typeof(arg1) == "string" and string.lower(arg1) == str1
end

local function toolCallLooksLikeRequest(arg1, str1: string)
    if valueIs(arg1.kind, str1) or valueIs(arg1.title, str1) then
        return true
    end
    local rawInput = arg1.rawInput
    return typeof(rawInput) == "table" and (valueIs(rawInput.name, str1) or valueIs(rawInput.toolName, str1))
end

local function hasPersistedToolResult(toolCall)
    if toolCall.content == nil then
        return false
    end
    for _, value in toolCall.content do
        local content = value.content
        if value.type ~= "content" or content == nil or content.type ~= "text" or typeof(content.text) ~= "string" then
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

local function parseInteger(arg1): number? -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1 = tonumber(arg1)
    return if var1 == nil or var1 % 1 ~= 0 then nil else var1
end

return {
    MAXIMUM_SAFE_INTEGER = 9007199254740991,
    toolCallLooksLikeRequest = toolCallLooksLikeRequest,
    findRequestInTurnState = findRequestInTurnState,
    parsePositiveSafeInteger = function(arg1)
        local var1 = parseInteger(arg1)
        return if var1 == nil or var1 < 1 or var1 > 9007199254740991 then nil else var1
    end,
    parsePrice = function(arg1, num1: number, num2: number)
        if arg1 == nil then
            return nil, nil
        end

        local var1 = parseInteger(arg1)

        if var1 == nil or var1 < num1 or num2 < var1 then
            return nil, ("priceInRobux must be a whole number from %.0f through %.0f."):format(num1, num2)
        end
        return var1, nil
    end,
    parseCreateAndGoLive = function(arg1, str1: string)
        if arg1 == nil then
            return nil, nil
        elseif str1 ~= "create" or typeof(arg1) ~= "boolean" then
            return nil, "createAndGoLive must be a boolean on create."
        end
        return if arg1 then true else nil, nil
    end,
    parseAction = function(arg1, tbl1)
        if typeof(arg1) ~= "table" or typeof(arg1.action) ~= "string" then
            return nil, "An action is required."
        end
        local str1 = string.lower(arg1.action)
        if not table.find(tbl1, str1) then
            return nil, ("Unsupported action '%s'."):format(arg1.action)
        end
        return str1, nil
    end,
    checkStringFields = function(arg1, tbl1)
        for _, value in tbl1 do
            if arg1[value] ~= nil and typeof(arg1[value]) ~= "string" then
                return ("%s must be a string."):format(value)
            end
        end
        return nil
    end,
    createRequestFinder = function(str1: string)
        return function(arg1, arg2)
            return findRequestInTurnState(arg1, str1, arg2)
        end
    end,
    formatResultContent = function(arg1)
        local action = if typeof(arg1) ~= "table" or typeof(arg1.action) ~= "string" then "unknown" else arg1.action
        local kind = if typeof(arg1) == "table" and typeof(arg1.kind) == "string" then arg1.kind else nil
        local success, result = pcall(HttpService.JSONEncode, HttpService, arg1)
        if success and not (#result > 524288) then
            return { text = result }, false
        end

        return {
            text = HttpService:JSONEncode({
                status = "error",
                kind = kind,
                action = action,
                detailCode = if success then "result_too_large" else "result_serialization_failed",
                message = if success then "The client tool result exceeded the response size limit." else "The client tool result could not be serialized."
            })
        }, true
    end,
    formatRejectionContent = function(action: string, feedbackText: string?, kind: string?)
        return {
            text = HttpService:JSONEncode({
                status = "cancelled",
                kind = kind,
                action = action,
                accepted = false,
                message = "The creator declined the change.",
                feedbackText = feedbackText
            })
        }
    end,
    getActionKind = function(str1: string): string
        return if str1 == "list" then "read" else "mutation"
    end
}
