-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:31:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local FFlagBuildExperienceRemoveDevProductPriceCap = require(DataHydrationParent.SharedFlags).FFlagBuildExperienceRemoveDevProductPriceCap
local _types = require(script.Parent.types)
local FFlagCreatorAgentChatMonetizationToolHelpers = require(script.Parent.FFlagCreatorAgentChatMonetizationToolHelpers)
local monetizationClientTool = if FFlagCreatorAgentChatMonetizationToolHelpers then require(script.Parent.monetizationClientTool) else nil
local tbl1 = { create = true, list = true, update = true, activate = true, deactivate = true }

local function valueLooksLikeToolName(arg1): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
    return typeof(arg1) == "string" and string.lower(arg1) == "manage_developer_product"
end

local function toolCallLooksLikeRequest(arg1)
    if FFlagCreatorAgentChatMonetizationToolHelpers then
        return monetizationClientTool.toolCallLooksLikeRequest(arg1, "manage_developer_product")
    end

    if valueLooksLikeToolName(arg1.kind) or valueLooksLikeToolName(arg1.title) then
        return true
    end

    local rawInput = arg1.rawInput
    return typeof(rawInput) == "table" and (valueLooksLikeToolName(rawInput.name) or valueLooksLikeToolName(rawInput.toolName))
end

local function parseInteger(arg1): number? -- Luacid: Inlined by compiler; 3 call sites recovered
    local var1 = tonumber(arg1)
    return if var1 == nil or var1 % 1 ~= 0 then nil else var1
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

return {
    TOOL_NAME = "manage_developer_product",
    LOCAL_TOOL_DEFINITION = {
        name = "manage_developer_product",
        inputSchema = {
            type = "object",
            additionalProperties = false,
            required = { "action" },
            properties = {
                action = {
                    type = "string",
                    enum = {
                        "create",
                        "list",
                        "update",
                        "activate",
                        "deactivate"
                    }
                },
                name = { type = "string" },
                description = { type = "string" },
                priceInRobux = {
                    type = "integer",
                    minimum = 1,
                    maximum = if FFlagBuildExperienceRemoveDevProductPriceCap then nil else 100
                },
                productId = { type = "integer" },
                imageAssetId = { type = "integer", minimum = 1 }
            }
        }
    },
    toolCallLooksLikeRequest = toolCallLooksLikeRequest,
    findManageDevProductRequestInTurnState = function(arg1, tbl2)
        if FFlagCreatorAgentChatMonetizationToolHelpers then
            return monetizationClientTool.findRequestInTurnState(arg1, "manage_developer_product", tbl2)
        end

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
            if (toolCall.status == nil or toolCall.status == "pending" or toolCall.status == "in_progress")
                and not hasPersistedToolResult(toolCall)
                and toolCallLooksLikeRequest(toolCall)
            then
                return value, toolCall.rawInput, toolCall.turnId, toolCall.referenceId
            end
        end

        return nil, nil, nil, nil
    end,
    parseManageDevProductInput = function(arg1)
        if typeof(arg1) ~= "table" then
            return nil
        end

        local action = arg1.action
        if typeof(action) ~= "string" then
            return nil
        end
        local str1 = string.lower(action)
        if not tbl1[str1] then
            return nil
        end

        local tbl2 = { action = str1 }
        if typeof(arg1.name) == "string" then
            tbl2.name = arg1.name
        end
        if typeof(arg1.description) == "string" then
            tbl2.description = arg1.description
        end
        if arg1.priceInRobux ~= nil then
            local priceInRobux = parseInteger(arg1.priceInRobux)
            if priceInRobux == nil or priceInRobux < 1 or not FFlagBuildExperienceRemoveDevProductPriceCap and priceInRobux > 100 then
                return nil
            end
            tbl2.priceInRobux = priceInRobux
        end
        local productId = parseInteger(arg1.productId)
        if productId ~= nil then
            tbl2.productId = productId
        end
        if arg1.imageAssetId ~= nil then
            local imageAssetId = parseInteger(arg1.imageAssetId)
            if imageAssetId == nil or imageAssetId < 1 or str1 ~= "create" then
                return nil
            end
            tbl2.imageAssetId = imageAssetId
        end

        if str1 == "create" then
            if tbl2.name == nil or tbl2.name == "" or tbl2.priceInRobux == nil then
                return nil
            end
        elseif str1 == "update" then
            if tbl2.productId == nil or tbl2.name == nil and tbl2.description == nil and tbl2.priceInRobux == nil then
                return nil
            end
        elseif (str1 == "activate" or str1 == "deactivate") and tbl2.productId == nil then
            return nil
        end

        return tbl2
    end,
    getActionKind = function(str1: string)
        if FFlagCreatorAgentChatMonetizationToolHelpers then
            return monetizationClientTool.getActionKind(str1)
        end

        return if str1 == "list" then "read" else "mutation"
    end,
    formatResultContent = function(arg1)
        if FFlagCreatorAgentChatMonetizationToolHelpers then
            return monetizationClientTool.formatResultContent(arg1)
        end

        local action = if typeof(arg1) ~= "table" or typeof(arg1.action) ~= "string" then "unknown" else arg1.action

        local success, result = pcall(HttpService.JSONEncode, HttpService, arg1)
        if not success then
            return {
                text = HttpService:JSONEncode({
                    status = "error",
                    action = action,
                    detailCode = "result_serialization_failed",
                    message = "The client tool result could not be serialized."
                })
            }, true
        elseif #result > 524288 then
            return {
                text = HttpService:JSONEncode({
                    status = "error",
                    action = action,
                    detailCode = "result_too_large",
                    message = "The client tool result exceeded the response size limit."
                })
            }, true
        end
        return { text = result }, false
    end,
    formatRejectionContent = function(action: string, feedbackText: string?)
        if FFlagCreatorAgentChatMonetizationToolHelpers then
            return monetizationClientTool.formatRejectionContent(action, feedbackText)
        end

        return {
            text = HttpService:JSONEncode({
                status = "cancelled",
                action = action,
                accepted = false,
                message = "The creator declined the change.",
                feedbackText = feedbackText
            })
        }
    end
}
