-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local chatTypes = require(script.Parent.chatTypes)
local FFlagBuildAdUpsell = require(BuildExperience.Flags.FFlagBuildAdUpsell)
local FFlagBuildExperienceThoughtStatus = CreatorAgentChat.FFlagBuildExperienceThoughtStatus

local PublishToolUtils = CreatorAgentChat.PublishToolUtils
local TurnStateReducer = CreatorAgentChat.TurnStateReducer
local SubagentTasks = CreatorAgentChat.SubagentTasks

local function contentBlockToText(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return if arg1 == nil or arg1.type ~= "text" or typeof(arg1.text) ~= "string" then "" else arg1.text
end

local function contentBlockToImage(arg1): {uri: any}? -- Luacid: Inlined by compiler; 2 call sites recovered
    return if arg1 == nil or arg1.type ~= "image" or typeof(arg1.uri) ~= "string" or arg1.uri == "" then nil else {
        uri = arg1.uri
    }
end

local function contentBlockToResourceAttachment(arg1)
    if arg1 == nil
        or arg1.type ~= "resource_link"
        or typeof(arg1.name) ~= "string"
        or arg1.name == ""
        or typeof(arg1.uri) ~= "string"
        or arg1.uri == ""
    then
        if arg1 == nil
            or arg1.type ~= "resource"
            or typeof(arg1.resource) ~= "table"
            or typeof(arg1.resource.uri) ~= "string"
            or arg1.resource.uri == ""
            or typeof(arg1.resource.text) ~= "string"
        then
            return nil
        end

        return {
            type = "resource",
            resource = arg1.resource
        }
    end

    return {
        type = "resource_link",
        name = arg1.name,
        uri = arg1.uri,
        mimeType = if typeof(arg1.mimeType) == "string" then arg1.mimeType else nil
    }
end

local function contentBlocksToText(content): string
    if typeof(content) ~= "table" then
        return ""
    end
    local tbl1 = {}
    for _, value in content do
        local var1 = contentBlockToText(value)

        if var1 ~= "" then
            table.insert(tbl1, var1)
        end
    end
    return table.concat(tbl1)
end

local function contentBlocksToImages(content)
    local result = {}
    if typeof(content) ~= "table" then
        return result
    end
    for _, value in content do
        local tbl1 = contentBlockToImage(value)

        if tbl1 ~= nil then
            table.insert(result, tbl1)
        end
    end
    return result
end

local function contentBlocksToResourceAttachments(content)
    local result = {}
    if typeof(content) ~= "table" then
        return result
    end
    for _, value in content do
        local var1 = contentBlockToResourceAttachment(value)
        if var1 ~= nil then
            table.insert(result, var1)
        end
    end
    return result
end

local function getSequenceId(arg1): number? -- Luacid: Inlined by compiler; 6 call sites recovered
    local sequenceId = arg1.sequenceId
    return if typeof(sequenceId) == "number" and sequenceId >= 0 then sequenceId else nil
end

local function asOptimisticallyCancelled(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return TurnStateReducer.applySessionUpdate(
        arg1,
        { sessionUpdate = "state_change", state = "idle", stop_reason = "cancelled" },
        nil
    )
end

local function getMessageId(arg1): string? -- Luacid: Inlined by compiler; 1 call site recovered
    local messageId = arg1.messageId
    return if typeof(messageId) == "string" and messageId ~= "" then messageId else nil
end

local function isAssistantTurnUpdate(sessionUpdate) -- Luacid: Inlined by compiler; 1 call site recovered
    return sessionUpdate == "agent_message"
        or sessionUpdate == "agent_message_chunk"
        or sessionUpdate == "tool_call_update"
        or sessionUpdate == "tool_call_content_chunk"
        or sessionUpdate == "state_change"
        or FFlagBuildExperienceThoughtStatus and sessionUpdate == "agent_thought_chunk"
end

local function hasAssistantTurnContent(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return arg1.assistantText ~= "" or #arg1.activityItems > 0 or arg1.toolCallCount > 0
end

local function hasContentBeyondThoughts(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1.assistantText ~= "" or arg1.toolCallCount > 0 then
        return true
    end
    for _, activityItem in arg1.activityItems do
        if activityItem.kind ~= "thought" then
            return true
        end
    end
    return false
end

local function shouldEmitAssistantTurn(arg1, bool1: boolean?): boolean
    return (if FFlagBuildExperienceThoughtStatus then hasContentBeyondThoughts(arg1) else hasAssistantTurnContent(arg1))
        or #arg1.pendingAgentMessageContent > 0
        or FFlagBuildExperienceThoughtStatus and bool1 and arg1.latestThought ~= nil and not arg1.isDone
        or arg1.status == "cancelled"
        or arg1.stopReason == "cancelled"
        or arg1.stopReason == "error"
end

local function orderedBySequenceId(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = table.clone(tbl1)
    table.sort(var1, function(arg1, arg2): boolean
        local sequenceId = getSequenceId(arg1)
        local sequenceId2 = getSequenceId(arg2)
        return (sequenceId or -1) < (sequenceId2 or -1)
    end)

    return var1
end

local function parseChatItems(tbl1, sessionId: string)
    local result = {}
    local var1 = nil
    local var2 = nil
    local var3 = nil
    local tbl2 = {}
    local bool1 = false

    local function flushActiveTurn(bool2: boolean?)
        if var1 ~= nil and bool1 then
            local func1 = shouldEmitAssistantTurn
            local var4 = var1
            if not FFlagBuildExperienceThoughtStatus then
                bool2 = nil
            end

            if func1(var4, bool2) then
                table.insert(
                    result,
                    {
                        kind = "assistant_turn",
                        startSequenceId = var2,
                        endSequenceId = var3,
                        sequenceIds = tbl2,
                        turnState = var1
                    }
                )
            end
        end

        var1 = nil
        var2 = nil
        var3 = nil
        tbl2 = {}
        bool1 = false
    end

    local function appendUserMessage(messageId: string?, sequenceId: number?, text: string, images, resourceAttachments)
        if text == "" and #images == 0 and #resourceAttachments == 0 then
            return
        end
        local var4 = result[#result]
        if var4 ~= nil and var4.kind == "user_message" and var4.messageId == messageId then
            var4.text ..= text
            for _, value in images do
                table.insert(var4.images, value)
            end
            for _, resourceAttachment in resourceAttachments do
                table.insert(var4.resourceAttachments, resourceAttachment)
            end
            return
        end
        table.insert(result, {
            kind = "user_message",
            messageId = messageId,
            sequenceId = sequenceId,
            text = text,
            images = images,
            resourceAttachments = resourceAttachments
        })
    end
    for _, value in tbl1 do
        local sessionUpdate = value.sessionUpdate
        local sequenceNumber = getSequenceId(value)

        if sessionUpdate == "user_message" or sessionUpdate == "user_message_chunk" then
            if var1 ~= nil and hasAssistantTurnContent(var1) then
                flushActiveTurn()
            end

            local var4 = if sessionUpdate == "user_message" then contentBlocksToText(value.content) else contentBlockToText(value.content)
            local tbl3

            if sessionUpdate == "user_message" then
                tbl3 = contentBlocksToImages(value.content)
            else
                tbl3 = {}
                local content = value.content
                local tbl4 = contentBlockToImage(content)

                if tbl4 ~= nil then
                    table.insert(tbl3, tbl4)
                end
            end

            local tbl4

            if sessionUpdate == "user_message" then
                tbl4 = contentBlocksToResourceAttachments(value.content)
            else
                tbl4 = {}
                local var5 = contentBlockToResourceAttachment(value.content)
                if var5 ~= nil then
                    table.insert(tbl4, var5)
                end
            end
            appendUserMessage(getMessageId(value), sequenceNumber, var4, tbl3, tbl4)
        elseif isAssistantTurnUpdate(sessionUpdate) then
            if var1 == nil then
                var1 = TurnStateReducer.createEmptyTurnState(sessionId)
            end
            if sessionUpdate == "state_change" and value.state == "running" then
                bool1 = true
            end
            if sequenceNumber ~= nil then
                table.insert(tbl2, sequenceNumber)
                if var2 == nil or sequenceNumber < var2 then
                    var2 = sequenceNumber
                end
                if var3 == nil or var3 < sequenceNumber then
                    var3 = sequenceNumber
                end
            end
            var1 = TurnStateReducer.applySessionUpdate(var1, value, { sequenceNumber = sequenceNumber })

            if var1.isDone then
                flushActiveTurn()
            end
        end
    end

    flushActiveTurn(if FFlagBuildExperienceThoughtStatus then true else nil)
    return result
end

local function buildUserMessageItem(tbl1, sessionId: string?)
    return {
        kind = "user_message",
        id = if sessionId ~= nil and tbl1.sequenceId ~= nil then `{sessionId}:{tbl1.sequenceId}:user` else tbl1.messageId,
        text = tbl1.text,
        images = tbl1.images,
        resourceAttachments = if #tbl1.resourceAttachments > 0 then tbl1.resourceAttachments else nil
    }
end

local function getEventMeta(turnState, num1: number?) -- Luacid: Inlined by compiler; 2 call sites recovered
    return if num1 == nil or turnState.eventMetaBySequenceId == nil then nil else turnState.eventMetaBySequenceId[num1]
end

local function resolveTurnId(turnState, tbl1)
    local eventMeta = getEventMeta(turnState, tbl1.endSequenceId)
    if eventMeta ~= nil and eventMeta.turnId ~= nil then
        return eventMeta.turnId
    end
    for _, sequenceId in tbl1.sequenceIds do
        local eventMeta2 = getEventMeta(turnState, sequenceId)

        if eventMeta2 ~= nil and eventMeta2.turnId ~= nil then
            return eventMeta2.turnId
        end
    end
    return nil
end

local function buildTurnFeedbackIds(tbl1, tbl2)
    local latestSuccessfulResult = PublishToolUtils.getLatestSuccessfulResult(tbl1.turnState)
    return {
        universeId = tbl2.universeId,
        placeId = tbl2.placeId,
        sessionId = tbl2.sessionId,
        sequenceId = tbl1.endSequenceId,
        turnId = resolveTurnId(tbl1.turnState, tbl1),
        publishedVersionNumber = if latestSuccessfulResult == nil then nil else latestSuccessfulResult.publishedVersionNumber,
        rollbackTargetVersionNumber = if latestSuccessfulResult == nil then nil else latestSuccessfulResult.rollbackTargetVersionNumber
    }
end

local function parseSessionStream(tbl1, tbl2)
    local sessionId = tbl2.sessionId
    local tbl3 = parseChatItems(orderedBySequenceId(tbl1), sessionId or "")

    local var1 = nil
    for _, value in tbl1 do
        local sequenceId = getSequenceId(value)

        if sequenceId ~= nil and (var1 == nil or var1 < sequenceId) then
            var1 = sequenceId
        end
    end

    local messages = {}
    local bool1 = false
    local var2 = nil
    local var3 = nil
    local var4 = nil
    local startSequenceId = nil
    local sequenceIds = nil
    local var5 = nil

    for _, value in tbl3 do
        if value.kind == "user_message" then
            table.insert(messages, (buildUserMessageItem(value, sessionId)))
        else
            local turnState = value.turnState
            local bool2 = not (tbl2.optimisticCancelledStartSequenceId == nil or value.startSequenceId ~= tbl2.optimisticCancelledStartSequenceId)
                and not turnState.isDone

            if bool2 then
                turnState = asOptimisticallyCancelled(turnState)
            end

            local var6 = PublishToolUtils.includesPublishPlaceTool(turnState)
            if var6 then
                bool1 = true
            end

            local turnState2 = SubagentTasks.fromTurnState(turnState)
            if turnState2 == nil then
                turnState2 = var2
            end

            var2 = turnState2
            local var7 = if sessionId == nil or value.startSequenceId == nil then nil else `{sessionId}:{value.startSequenceId}`
            local bool3 = not turnState.isDone
            table.insert(messages, {
                kind = "assistant_turn",
                id = var7,
                isDone = turnState.isDone,
                turnState = turnState,
                turnKey = var7,
                startSequenceId = value.startSequenceId,
                endSequenceId = value.endSequenceId,
                isOptimisticallyCancelled = if FFlagBuildAdUpsell then if bool2 then true else nil else nil,
                optimisticLocalTools = if bool3 then tbl2.optimisticLocalTools else nil,
                universeId = tbl2.universeId,
                sessionId = sessionId,
                turnFeedbackIds = buildTurnFeedbackIds(value, tbl2)
            })

            if var6 then
                var5 = turnState.isDone and #messages or var5
            end

            if bool3 then
                var3 = #messages

                startSequenceId = value.startSequenceId
                sequenceIds = value.sequenceIds
                var4 = turnState
            end
        end
    end

    if var5 ~= nil then
        messages[var5].isLatestPublishTurn = true
    end

    local bool2 = false
    local pendingUserMessage = tbl2.pendingUserMessage
    local pendingUserImages = tbl2.pendingUserImages or {}
    local resourceAttachments = tbl2.pendingUserResourceAttachments or {}
    if pendingUserMessage ~= nil and pendingUserMessage ~= "" or #pendingUserImages > 0 or #resourceAttachments > 0 then
        local pendingUserMessageAfterSequenceId = tbl2.pendingUserMessageAfterSequenceId or -1
        local bool3 = false
        for _, value in tbl3 do
            if value.kind ~= "user_message" then
                continue
            end

            local sequenceId = value.sequenceId
            if sequenceId ~= nil and pendingUserMessageAfterSequenceId < sequenceId then
                bool3 = true
                break
            end
        end

        if not bool3 then
            bool2 = true
            table.insert(messages, {
                kind = "user_message",
                id = if sessionId == nil then nil else `{sessionId}{chatTypes.PENDING_USER_MESSAGE_ID_SUFFIX}`,
                text = pendingUserMessage or "",
                images = pendingUserImages,
                resourceAttachments = resourceAttachments
            })
        end
    end

    local liveAssistantMessage = tbl2.liveAssistantMessage
    local var7 = messages[#messages]
    local bool3 = not (var7 == nil) and var7.kind == "assistant_turn"

    if bool3 then
        local startSequenceId2 = var7.startSequenceId
        bool3 = startSequenceId2 == nil or (tbl2.pendingUserMessageAfterSequenceId or -1) < startSequenceId2
    end
    if liveAssistantMessage ~= nil and not bool3 then
        local var8 = if sessionId == nil then nil else `{sessionId}:live`
        table.insert(messages, {
            kind = "assistant_turn",
            id = var8,
            isDone = false,
            turnKey = var8,
            loading = liveAssistantMessage.setupErrorText == nil or nil,
            setupErrorText = liveAssistantMessage.setupErrorText,
            universeId = tbl2.universeId,
            turnFeedbackIds = {}
        })
    end

    return {
        messages = messages,
        includesPublishTool = bool1,
        activeTurnItemIndex = var3,
        activeTurnState = var4,
        activeTurnStartSequenceId = startSequenceId,
        activeTurnSequenceIds = sequenceIds,
        subagentTaskState = var2,
        isAwaitingUserMessageEcho = bool2,
        latestSequenceId = var1
    }
end

return parseSessionStream
