-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:30:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local debug2 = require(script.Parent.debug)
local _types = require(script.Parent.types)

local PUBLISH_PLACE_TOOL_IDENTIFIERS = { "studio_save_and_publish", "cas_save_and_publish", "save_and_publish" }

local tbl2 = {}
for _, value in PUBLISH_PLACE_TOOL_IDENTIFIERS do
    local var1 = string.gsub(value, "[_%-%s]", "")
    tbl2[string.lower(var1)] = true
end

local tbl3 = {
    save_and_publish = true,
    cas_save_and_publish = true,
    studio_save_and_publish = true
}

local function normalizeToolIdentifier(str1: string): string -- Luacid: Inlined by compiler; 5 call sites recovered
    local var1 = string.gsub(str1, "[_%-%s]", "")
    return string.lower(var1)
end

local function identifierMatchesPublish(kind: string): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local str1 = normalizeToolIdentifier(kind)
    return if tbl2[str1] then true else string.find(str1, "publishplace", 1, true) ~= nil
end

local function valueLooksLikePublishTool(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local bool1

    if typeof(arg1) == "string" and arg1 ~= "" then
        local str1 = normalizeToolIdentifier(arg1)

        if tbl2[str1] then
            return true
        end
        bool1 = string.find(str1, "publishplace", 1, true) ~= nil
    else
        bool1 = false
    end

    return bool1
end

local function isSaveAndPublishValue(arg1): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
    return typeof(arg1) == "string" and tbl3[string.lower(arg1)] == true
end

local function toolCallMatchesPublishPlace(arg1)
    local kind = arg1.kind
    local bool1 = typeof(kind) == "string" and kind ~= "" and identifierMatchesPublish(kind)

    if bool1 or valueLooksLikePublishTool(arg1.title) then
        return true
    end

    local rawInput = arg1.rawInput
    if typeof(rawInput) ~= "table" then
        return false
    end

    for _, value in {
        "tool",
        "name",
        "action",
        "command",
        "toolName"
    } do
        if valueLooksLikePublishTool(rawInput[value]) then
            return true
        end
    end

    return false
end

local function isSaveAndPublishToolCall(arg1)
    if isSaveAndPublishValue(arg1.title) or isSaveAndPublishValue(arg1.kind) then
        return true
    end

    local rawInput = arg1.rawInput
    if typeof(rawInput) ~= "table" then
        return false
    end
    for _, value in {
        "tool",
        "name",
        "action",
        "command",
        "toolName"
    } do
        if isSaveAndPublishValue(rawInput[value]) then
            return true
        end
    end
    return false
end

local function parsePublishedVersionNumber(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = string.match(str1, "^%s*Saved as version%s+(%d+)%s*%.?%s*$")
    if var1 == nil then
        return nil
    end
    return tonumber(var1)
end

local function parseTextResult(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local success, result = pcall(HttpService.JSONDecode, HttpService, str1)

    if success and typeof(result) == "table" then
        if result.type == "text" and typeof(result.text) == "string" then
            return result
        end

        return nil
    end

    return nil
end

local function getToolCallPublishedVersionNumber(arg1, bool1: boolean)
    local content = arg1.content
    if typeof(content) ~= "table" then
        return nil
    end

    for _, value in content do
        local text = if typeof(value.content) == "table" then value.content.text else value.text

        if typeof(text) ~= "string" then
            continue
        end

        local var1 = parseTextResult(text)

        if var1 ~= nil then
            text = var1.text
        elseif not bool1 then
            text = nil
        end

        if text == nil then
            continue
        end

        local var2 = parsePublishedVersionNumber(text)

        if var2 ~= nil then
            return var2
        end
    end

    return nil
end

return {
    PUBLISH_PLACE_TOOL_IDENTIFIERS = PUBLISH_PLACE_TOOL_IDENTIFIERS,
    includesPublishPlaceTool = function(arg1)
        for _, toolCall in arg1.toolCalls do
            if toolCall.status ~= "failed" and toolCallMatchesPublishPlace(toolCall) then
                return true
            end
        end
        return false
    end,
    toolCallMatchesPublishPlace = toolCallMatchesPublishPlace,
    getLatestSuccessfulResult = function(arg1, _)
        if arg1 == nil then
            return nil
        end

        local var1 = nil
        for toolCallId, toolCall in arg1.toolCalls do
            if toolCall.status ~= "completed" or not isSaveAndPublishToolCall(toolCall) then
                continue
            end

            local publishedVersionNumber = getToolCallPublishedVersionNumber(toolCall, true)
            if publishedVersionNumber == nil then
                debug2.log("warn", "completed save_and_publish result is not parseable", {
                    toolCallId = toolCall.toolCallId,
                    title = toolCall.title,
                    status = toolCall.status,
                    contentBlockCount = typeof(toolCall.content) == "table" and #toolCall.content or 0,
                    hasRawOutput = toolCall.rawOutput ~= nil
                })
            else
                var1 = {
                    toolCallId = toolCallId,
                    publishedVersionNumber = publishedVersionNumber,
                    rollbackTargetVersionNumber = if publishedVersionNumber > 1 then publishedVersionNumber - 1 else nil
                }
            end
        end
        return var1
    end
}
