-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:31:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _types = require(script.Parent.types)
local FFlagBuildExperienceThoughtStatus = require(script.Parent.FFlagBuildExperienceThoughtStatus)

local function getSequenceIndex(arg1): number? -- Luacid: Inlined by compiler; 6 call sites recovered
    local sequenceNumber = if arg1 == nil then nil else arg1.sequenceNumber
    return if typeof(sequenceNumber) == "number" and not (sequenceNumber < 0) then sequenceNumber + 1 else nil
end

local function getMessageId(arg1): string? -- Luacid: Inlined by compiler; 3 call sites recovered
    local messageId = arg1.messageId
    return if typeof(messageId) == "string" and messageId ~= "" then messageId else nil
end

local function cloneArray(tbl1) -- Luacid: Inlined by compiler; 9 call sites recovered
    local result = {}
    for _, value in tbl1 do
        table.insert(result, value)
    end
    return result
end

local function contentBlocksToText(tbl1): string
    local tbl2 = {}
    for _, value in tbl1 do
        if value.type == "text" and typeof(value.text) == "string" then
            table.insert(tbl2, value.text)
        end
    end
    return table.concat(tbl2)
end

local function messageMapToText(tbl1, tbl2): string
    local tbl3 = {}
    for _, value in tbl2 do
        local var1 = tbl1[value]
        if var1 ~= nil then
            table.insert(tbl3, contentBlocksToText(var1))
        end
    end
    return table.concat(tbl3)
end

local function ensureMessageOrder(tbl1, str1: string) -- Luacid: Inlined by compiler; 3 call sites recovered
    for _, value in tbl1 do
        if value == str1 then
            return tbl1
        end
    end

    local tbl2 = cloneArray(tbl1)
    table.insert(tbl2, str1)
    return tbl2
end

local function replaceMessageContent(tbl1, tbl2, str1: string, tbl3) -- Luacid: unused: defined but never referenced
    local var1 = table.clone(tbl1)
    var1[str1] = cloneArray(tbl3)
    return var1, (ensureMessageOrder(tbl2, str1))
end

local function appendMessageContent(tbl1, tbl2, pendingAgentMessageId: string, arg1)
    local var1 = table.clone(tbl1)
    local var2 = var1[pendingAgentMessageId]
    local tbl3 = var2 == nil and {} or cloneArray(var2)
    table.insert(tbl3, arg1)
    var1[pendingAgentMessageId] = tbl3
    return var1, (ensureMessageOrder(tbl2, pendingAgentMessageId))
end

local function buildActivityItems(activitySlots, toolCalls)
    local activityItems = {}
    local tbl1 = {}

    for k in activitySlots do
        table.insert(tbl1, k)
    end
    table.sort(tbl1)

    for _, value in tbl1 do
        local activitySlot = activitySlots[value]
        if activitySlot.kind == "agent_message" then
            table.insert(activityItems, { kind = "agent_message", text = activitySlot.text })
        elseif FFlagBuildExperienceThoughtStatus and activitySlot.kind == "thought" then
            table.insert(activityItems, { kind = "thought", text = activitySlot.text })
        elseif activitySlot.kind == "tool_call" then
            local toolCall = toolCalls[activitySlot.toolCallId]
            table.insert(activityItems, {
                kind = "tool_call",
                toolCallId = activitySlot.toolCallId,
                title = if toolCall then toolCall.title else nil,
                status = if toolCall then toolCall.status else nil
            })
        end
    end

    return activityItems
end

local function refreshActivityItems(arg1) -- Luacid: Inlined by compiler; 10 call sites recovered
    arg1.activityItems = buildActivityItems(arg1.activitySlots, arg1.toolCalls)
end

local function recordActivitySlotAtIndex(arg1, num1: number, arg2) -- Luacid: Inlined by compiler; 7 call sites recovered
    if num1 <= 0 then
        return
    end

    local activitySlots = table.clone(arg1.activitySlots)
    activitySlots[num1] = arg2
    arg1.activitySlots = activitySlots
    refreshActivityItems(arg1)
end

local function recordActivitySlot(arg1, arg2, arg3) -- Luacid: Inlined by compiler; 4 call sites recovered
    local sequenceIndex = getSequenceIndex(arg2)

    if sequenceIndex == nil then
        return
    end

    recordActivitySlotAtIndex(arg1, sequenceIndex, arg3)
end

local function recordToolCallSequenceSlot(arg1, arg2, toolCallId: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    recordActivitySlot(arg1, arg2, { kind = "tool_call", toolCallId = toolCallId })
end

local function hasToolCallActivitySlot(arg1, toolCallId: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    for _, activitySlot in arg1.activitySlots do
        if activitySlot.kind == "tool_call" and activitySlot.toolCallId == toolCallId then
            return true
        end
    end
    return false
end

local function clearPendingAgentMessage(arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
    arg1.pendingAgentMessageId = nil
    arg1.pendingAgentMessageContent = {}
    arg1.pendingAgentMessageSequenceIndex = nil
end

local function appendPendingAgentMessage(arg1, pendingAgentMessageId: string, content, arg2)
    if arg1.pendingAgentMessageId ~= nil and arg1.pendingAgentMessageId ~= pendingAgentMessageId then
        local text = contentBlocksToText(arg1.pendingAgentMessageContent)
        if text ~= "" then
            local pendingAgentMessageSequenceIndex = arg1.pendingAgentMessageSequenceIndex
            if pendingAgentMessageSequenceIndex ~= nil then
                recordActivitySlotAtIndex(arg1, pendingAgentMessageSequenceIndex, { kind = "agent_message", text = text })
            end
        end

        clearPendingAgentMessage(arg1)
    end

    local pendingAgentMessageContent = cloneArray(arg1.pendingAgentMessageContent)
    table.insert(pendingAgentMessageContent, content)
    arg1.pendingAgentMessageId = pendingAgentMessageId
    arg1.pendingAgentMessageContent = pendingAgentMessageContent
    if arg1.pendingAgentMessageSequenceIndex == nil then
        arg1.pendingAgentMessageSequenceIndex = getSequenceIndex(arg2)
    end
end

local function flushPendingAgentMessageToActivity(arg1)
    local text = contentBlocksToText(arg1.pendingAgentMessageContent)
    if text ~= "" then
        local pendingAgentMessageSequenceIndex = arg1.pendingAgentMessageSequenceIndex
        if pendingAgentMessageSequenceIndex ~= nil then
            recordActivitySlotAtIndex(arg1, pendingAgentMessageSequenceIndex, { kind = "agent_message", text = text })
        end
    end

    clearPendingAgentMessage(arg1)
end

local function flushPendingAgentMessageToAssistant(arg1)
    local pendingAgentMessageId = arg1.pendingAgentMessageId
    if pendingAgentMessageId == nil then
        clearPendingAgentMessage(arg1)
        return
    end

    local assistantMessages = arg1.assistantMessages
    local assistantMessageOrder = arg1.assistantMessageOrder
    for _, value in arg1.pendingAgentMessageContent do
        assistantMessages, assistantMessageOrder = appendMessageContent(assistantMessages, assistantMessageOrder, pendingAgentMessageId, value)
    end
    arg1.assistantMessages = assistantMessages
    arg1.assistantMessageOrder = assistantMessageOrder
    arg1.assistantText = messageMapToText(assistantMessages, assistantMessageOrder)
    clearPendingAgentMessage(arg1)
end

local function extractRobloxMeta(arg1): {[any]: any}? -- Luacid: Inlined by compiler; 5 call sites recovered
    local _roblox = arg1._meta and arg1._meta._roblox
    return if typeof(_roblox) == "table" then _roblox else nil
end

local function recordEventMeta(arg1, num1: number?, arg2)
    if typeof(num1) ~= "number" or num1 < 0 then
        return
    end

    local var1 = extractRobloxMeta(arg2)

    if var1 == nil then
        return
    end

    local turnId = var1.turnId
    local emittedTime = var1.emittedTime
    local referenceId = var1.referenceId
    local bool1 = typeof(turnId) == "number" and turnId > 0
    local bool2 = typeof(emittedTime) == "string" and emittedTime ~= ""
    local bool3 = typeof(referenceId) == "string" and referenceId ~= ""

    if not (bool1 or bool2 or bool3) then
        return
    end

    local eventMetaBySequenceId = arg1.eventMetaBySequenceId == nil and {} or table.clone(arg1.eventMetaBySequenceId)

    local var3 = eventMetaBySequenceId[num1] == nil and {} or table.clone(eventMetaBySequenceId[num1])

    if bool1 then
        var3.turnId = turnId
    end
    if bool2 then
        var3.emittedTime = emittedTime
    end
    if bool3 then
        var3.referenceId = referenceId
    end
    eventMetaBySequenceId[num1] = var3
    arg1.eventMetaBySequenceId = eventMetaBySequenceId
end

local function extractTurnId(arg1): number? -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = extractRobloxMeta(arg1)
    local turnId = if typeof(var1) == "table" then var1.turnId else nil
    return if typeof(turnId) == "number" and turnId > 0 then turnId else nil
end

local function extractReferenceId(arg1): string? -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = extractRobloxMeta(arg1)
    local referenceId = if typeof(var1) == "table" then var1.referenceId else nil
    return if typeof(referenceId) == "string" and referenceId ~= "" then referenceId else nil
end

local function applyToolCallUpdate(arg1, arg2, arg3)
    local toolCallId = arg2.toolCallId
    if typeof(toolCallId) ~= "string" or toolCallId == "" then
        return
    end

    local toolCall = arg1.toolCalls[toolCallId]
    local bool1 = toolCall == nil
    local var1 = toolCall == nil and { toolCallId = toolCallId } or table.clone(toolCall)
    if arg2.title ~= nil then
        var1.title = arg2.title
    end
    if arg2.kind ~= nil then
        var1.kind = arg2.kind
    end
    if arg2.status ~= nil then
        var1.status = arg2.status
    end
    if arg2.rawInput ~= nil then
        var1.rawInput = arg2.rawInput
    end
    if arg2.rawOutput ~= nil then
        var1.rawOutput = arg2.rawOutput
    end
    if arg2.content ~= nil then
        var1.content = arg2.content
    end

    local turnId = extractTurnId(arg2)

    if turnId ~= nil then
        var1.turnId = turnId
    end

    local referenceId = extractReferenceId(arg2)

    if referenceId ~= nil then
        var1.referenceId = referenceId
    end

    local toolCalls = table.clone(arg1.toolCalls)
    toolCalls[toolCallId] = var1
    arg1.toolCalls = toolCalls
    if bool1 then
        arg1.toolCallCount += 1
    end

    if bool1 or not hasToolCallActivitySlot(arg1, toolCallId) then
        recordToolCallSequenceSlot(arg1, arg3, toolCallId)
        return
    end

    refreshActivityItems(arg1)
end

local function applyToolCallContentChunk(arg1, arg2, arg3)
    local toolCallId = arg2.toolCallId
    local content = arg2.content
    if typeof(toolCallId) ~= "string" or toolCallId == "" or typeof(content) ~= "table" then
        return
    end

    local toolCall = arg1.toolCalls[toolCallId]
    local bool1 = toolCall == nil
    local var1 = toolCall == nil and { toolCallId = toolCallId } or table.clone(toolCall)
    local content2 = var1.content
    local tbl1 = content2 == nil and {} or cloneArray(content2)
    table.insert(tbl1, content)
    var1.content = tbl1

    local toolCalls = table.clone(arg1.toolCalls)
    toolCalls[toolCallId] = var1
    arg1.toolCalls = toolCalls
    if bool1 then
        arg1.toolCallCount += 1
    end

    if bool1 or not hasToolCallActivitySlot(arg1, toolCallId) then
        recordToolCallSequenceSlot(arg1, arg3, toolCallId)
        return
    end

    refreshActivityItems(arg1)
end

return {
    applySessionUpdate = function(arg1, arg2, arg3)
        local sessionUpdate = arg2.sessionUpdate
        local var1 = table.clone(arg1)
        local sequenceNumber = if arg3 == nil then nil else arg3.sequenceNumber
        recordEventMeta(var1, sequenceNumber, arg2)
        if var1.status == "queued" then
            var1.status = "streaming"
        end

        if sessionUpdate ~= "agent_message_chunk"
            and (not FFlagBuildExperienceThoughtStatus or sessionUpdate ~= "agent_thought_chunk")
        then
            if sessionUpdate == "state_change" and arg2.state == "idle" then
                flushPendingAgentMessageToAssistant(var1)
            else
                flushPendingAgentMessageToActivity(var1)
            end
        end

        if sessionUpdate == "agent_message" then
            local messageId = getMessageId(arg2)
            local content = arg2.content
            if messageId ~= nil and typeof(content) == "table" then
                local assistantMessages = var1.assistantMessages
                local assistantMessageOrder = var1.assistantMessageOrder
                local var2 = table.clone(assistantMessages)
                var2[messageId] = cloneArray(content)
                local tbl1 = ensureMessageOrder(assistantMessageOrder, messageId)
                var1.assistantMessages = var2
                var1.assistantMessageOrder = tbl1

                var1.assistantText = messageMapToText(var1.assistantMessages, var1.assistantMessageOrder)
                return var1
            end
        elseif sessionUpdate == "agent_message_chunk" then
            local messageId = getMessageId(arg2)
            local content = arg2.content
            if messageId ~= nil and typeof(content) == "table" then
                appendPendingAgentMessage(var1, messageId, content, arg3)
                return var1
            end
        else
            if sessionUpdate == "tool_call_update" then
                applyToolCallUpdate(var1, arg2, arg3)
                return var1
            elseif sessionUpdate == "tool_call_content_chunk" then
                applyToolCallContentChunk(var1, arg2, arg3)
                return var1
            end

            if sessionUpdate == "state_change" then
                if arg2.state == "running" or arg2.state == "requires_action" then
                    var1.status = "streaming"
                    return var1
                end

                if arg2.state == "idle" then
                    local stopReason = arg2.stop_reason
                    if typeof(stopReason) == "string" then
                        var1.stopReason = stopReason
                    else
                        var1.stopReason = "end_turn"
                    end
                    var1.status = if var1.stopReason == "cancelled" then "cancelled" else "succeeded"
                    var1.isDone = true
                    return var1
                end
            elseif sessionUpdate == "agent_thought_chunk" then
                local content = arg2.content

                if FFlagBuildExperienceThoughtStatus
                    and typeof(content) == "table"
                    and typeof(content.text) == "string"
                    and content.text ~= ""
                then
                    var1.latestThought = {
                        messageId = getMessageId(arg2),
                        text = content.text
                    }
                    recordActivitySlot(var1, arg3, { kind = "thought", text = content.text })
                    return var1
                end
            elseif sessionUpdate == "session_info_update" then
                var1.infoUpdate = {
                    title = arg2.title
                }
            end
        end

        return var1
    end,
    createEmptyTurnState = function(sessionId: string, requestId)
        return {
            sessionId = sessionId,
            requestId = requestId,
            status = "queued",
            assistantText = "",
            assistantMessages = {},
            assistantMessageOrder = {},
            pendingAgentMessageId = nil,
            pendingAgentMessageContent = {},
            pendingAgentMessageSequenceIndex = nil,
            activitySlots = {},
            activityItems = {},
            toolCalls = {},
            toolCallCount = 0,
            infoUpdate = nil,
            stopReason = nil,
            error = nil,
            errorCode = nil,
            isDone = false,
            eventMetaBySequenceId = {}
        }
    end,
    extractTurnId = extractTurnId
}
