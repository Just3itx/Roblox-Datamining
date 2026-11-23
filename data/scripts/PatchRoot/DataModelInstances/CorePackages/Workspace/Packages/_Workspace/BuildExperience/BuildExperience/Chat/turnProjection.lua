-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local _chatTypes = require(script.Parent.chatTypes)
local FFlagBuildExperienceAnswerForm = require(BuildExperience.Flags.FFlagBuildExperienceAnswerForm)
local turnDisplay = require(script.Parent.turnDisplay)
local FFlagBuildExperienceManageDevProduct = require(BuildExperience.Flags.FFlagBuildExperienceManageDevProduct)
local FFlagBuildAgentAdCampaignCard = require(BuildExperience.Flags.FFlagBuildAgentAdCampaignCard)
local FFlagBuildExperienceToolDisplaySummary = require(BuildExperience.Flags.FFlagBuildExperienceToolDisplaySummary)
local getToolDisplaySummary = require(script.Parent.toolDisplaySummary).getToolDisplaySummary
local FFlagBuildExperienceThoughtStatus = CreatorAgentChat.FFlagBuildExperienceThoughtStatus
local getThoughtHeading = require(script.Parent.thoughtHeading).getThoughtHeading

local PublishToolUtils = CreatorAgentChat.PublishToolUtils
local adCampaignEligibilityTool = if FFlagBuildAgentAdCampaignCard then require(BuildExperience.Chat.adCampaignEligibilityTool) else nil
local StudioAskUserTool = CreatorAgentChat.StudioAskUserTool
local StudioProposePlanTool = CreatorAgentChat.StudioProposePlanTool

local ASSISTANT_STOPPED_TEXT = turnDisplay.ASSISTANT_STOPPED_TEXT
local countToolCalls = turnDisplay.countToolCalls
local getAskUserActivityLabel = turnDisplay.getAskUserActivityLabel
local getLocalToolWaitSeconds = turnDisplay.getLocalToolWaitSeconds
local getSummaryToolActivity = turnDisplay.getSummaryToolActivity

local tbl1 = {
    submittedToolCallIds = {},
    askUserByToolCallId = {},
    planByToolCallId = {},
    devProductByToolCallId = {}
}

local function contentBlocksToText(tbl2): string
    local tbl3 = {}
    for _, value in tbl2 do
        if value.type == "text" and typeof(value.text) == "string" then
            table.insert(tbl3, value.text)
        end
    end
    return table.concat(tbl3)
end

local function getAssistantMessageTexts(arg1)
    local assistantMessageTexts = {}
    for _, value in arg1.assistantMessageOrder do
        local var1 = arg1.assistantMessages[value]
        if var1 == nil then
            continue
        end

        local str1 = contentBlocksToText(var1)
        if str1 ~= "" then
            table.insert(assistantMessageTexts, str1)
        end
    end

    return assistantMessageTexts
end

local function makeTurnKey(arg1, tbl2) -- Luacid: Inlined by compiler; 1 call site recovered
    if tbl2.turnKey ~= nil then
        return tbl2.turnKey
    end

    local var1 = tbl2.sessionId or (if arg1 == nil then "pending-session" else arg1.sessionId)
    local sequenceId = if tbl2.turnFeedbackIds == nil or typeof(tbl2.turnFeedbackIds) == "function" then nil else tbl2.turnFeedbackIds.sequenceId

    if sequenceId ~= nil then
        return `{var1}:{sequenceId}`
    end

    return var1
end

local function makeSegmentKey(str1: string, ...): string
    local tbl2 = { str1 }
    for _, value in { ... } do
        table.insert(tbl2, tostring(value))
    end
    return table.concat(tbl2, ":")
end

local function getSortedActivitySlotIndexes(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local sortedActivitySlotIndexes = {}
    for k in arg1.activitySlots do
        table.insert(sortedActivitySlotIndexes, k)
    end
    table.sort(sortedActivitySlotIndexes)
    return sortedActivitySlotIndexes
end

local function makeTurnActivityItem(arg1, activitySlot)
    if FFlagBuildExperienceThoughtStatus and activitySlot.kind == "thought" then
        return {
            kind = "thought",
            text = activitySlot.text
        }
    end

    if activitySlot.kind ~= "tool_call" then
        return nil
    end

    local toolCall = arg1.toolCalls[activitySlot.toolCallId]
    return {
        kind = "tool_call",
        toolCallId = activitySlot.toolCallId,
        title = if toolCall then toolCall.title else nil,
        status = if toolCall then toolCall.status else nil,
        displaySummary = if FFlagBuildExperienceToolDisplaySummary and toolCall then getToolDisplaySummary(toolCall.title, toolCall.rawInput) else nil
    }
end

local function makeAgentMessageSegment(key: string, text: string, isError: boolean?, errorCode: number?): {errorCode: number?, isError: boolean?, key: string, kind: string, text: string}? -- Luacid: Inlined by compiler; 5 call sites recovered
    return if text == "" then nil else {
        kind = "agent_message",
        key = key,
        text = text,
        isError = isError,
        errorCode = errorCode
    }
end

local function makeCompletedActivitySummary(activityItems, key: string): {actionCount: any, activityItems: {[any]: any}, isLoading: boolean, key: string, kind: string, summaryKind: string, summaryToolActivity: any}?
    return if #activityItems == 0 or FFlagBuildExperienceThoughtStatus and countToolCalls(activityItems) == 0 then nil else {
        kind = "activity_summary",
        key = key,
        summaryKind = "completed",
        summaryToolActivity = getSummaryToolActivity(activityItems, "completed"),
        activityItems = activityItems,
        actionCount = countToolCalls(activityItems),
        isLoading = false
    }
end

local function getLatestThoughtHeading(tbl2)
    for i = #tbl2, 1, -1 do
        local var1 = tbl2[i]
        if var1.kind == "thought" then
            return getThoughtHeading(var1.text)
        end
    end
    return nil
end

local function makeActiveActivitySummary(activityItems, isLoading: boolean, key: string, str1: string?, isWaitingForLocalTool: boolean?, str2: string?)
    if #activityItems == 0 and not isLoading then
        return nil
    end

    local summaryToolActivity = if str1 == nil then getSummaryToolActivity(activityItems, "active") else nil
    local bool1 = FFlagBuildExperienceToolDisplaySummary

    if bool1 then
        if summaryToolActivity == nil or summaryToolActivity.kind ~= "tool_call" then
            bool1 = false
        else
            bool1 = summaryToolActivity.displaySummary ~= nil
        end
    end

    if FFlagBuildExperienceThoughtStatus and str1 == nil and str2 ~= nil and not bool1 then
        summaryToolActivity = nil
    else
        str2 = str1
    end

    if str2 == nil and summaryToolActivity == nil then
        str2 = LocalizationStrings.CHAT_ASSISTANT_LOADING
    end
    return {
        kind = "activity_summary",
        key = key,
        summaryKind = "active",
        label = str2,
        summaryToolActivity = summaryToolActivity,
        activityItems = activityItems,
        isLoading = isLoading,
        isWaitingForLocalTool = isWaitingForLocalTool
    }
end

local function countActionsInSegments(segments)
    local num1 = 0
    for _, segment in segments do
        if segment.kind == "activity_summary" then
            num1 += segment.actionCount or countToolCalls(segment.activityItems)
        end
    end
    return num1
end

local function getAnsweredPromptsByToolCallId(arg1)
    local answeredPromptsByToolCallId = ({})
    for _, value in StudioAskUserTool.getAnsweredPromptsFromTurnState(arg1) do
        if value.toolCallId == nil then
            continue
        end

        local toolCallId = value.toolCallId
        if answeredPromptsByToolCallId[toolCallId] == nil then
            answeredPromptsByToolCallId[toolCallId] = {}
        end
        table.insert(answeredPromptsByToolCallId[toolCallId], value)
    end

    return answeredPromptsByToolCallId
end

local function getCompletedPlansByToolCallId(arg1)
    local completedPlansByToolCallId = {}
    for _, value in StudioProposePlanTool.getCompletedPlansFromTurnState(arg1) do
        if value.toolCallId ~= nil then
            completedPlansByToolCallId[value.toolCallId] = value
        end
    end
    return completedPlansByToolCallId
end

local function makeClientToolSegment(turnKey: string, toolCallId: string, callOrder: number, num1: number, isActive: boolean, answerStackPrompt, planProposal, devProductProposal) -- Luacid: Inlined by compiler; 9 call sites recovered
    return {
        kind = "client_tool",
        key = makeSegmentKey(turnKey, "client-tool", toolCallId, num1),
        toolCallId = toolCallId,
        callOrder = callOrder,
        isActive = isActive,
        answerStackPrompt = answerStackPrompt,
        planProposal = planProposal,
        devProductProposal = devProductProposal
    }
end

local function makeAnswersSegment(turnKey: string, toolCallId: string, answeredPrompts) -- Luacid: Inlined by compiler; 2 call sites recovered
    local clientToolSegment = makeClientToolSegment(turnKey, toolCallId, answeredPrompts[1].callOrder or 0, 1, false, nil, nil, nil)
    clientToolSegment.answeredPrompts = answeredPrompts
    return clientToolSegment
end

local function projectAskUserSegments(arg1, turnKey: string, toolCallId: string, answeredPromptsByToolCallId, arg2)
    local toolCall = arg1.toolCalls[toolCallId]
    if toolCall == nil then
        return {}
    end

    local tbl2 = {}
    local answeredPrompts = answeredPromptsByToolCallId[toolCallId]
    if answeredPrompts ~= nil and #answeredPrompts > 0 then
        if FFlagBuildExperienceAnswerForm then
            return { (makeAnswersSegment(turnKey, toolCallId, answeredPrompts)) }
        end
        for k, answerStackPrompt in answeredPrompts do
            table.insert(
                tbl2,
                makeClientToolSegment(turnKey, toolCallId, answerStackPrompt.callOrder or k, k, false, answerStackPrompt, nil, nil)
            )
        end

        return tbl2
    end

    local var1 = StudioAskUserTool.extractQuestionsFromToolCall(toolCall)
    local var2 = arg2.askUserByToolCallId[toolCallId]
    if var1 == nil or var2 == nil then
        return tbl2
    end

    for value, question in var1 do
        local selection = var2.selections[value]

        if value == var2.currentIndex and not arg2.submittedToolCallIds[toolCallId] then
            local callOrder = var2.callOrder
            local answerStackPrompt = {
                question = question,
                selectedOptionId = if selection == nil then nil else selection.selectedOptionId,
                customResponseText = if selection == nil then nil else selection.customResponseText,
                toolCallId = toolCallId,
                callOrder = var2.callOrder,
                isLastQuestion = #var1 <= value
            }
            table.insert(tbl2, (makeClientToolSegment(turnKey, toolCallId, callOrder, value, true, answerStackPrompt, nil, nil)))
            break
        end

        if selection == nil then
            break
        end

        table.insert(
            tbl2,
            makeClientToolSegment(turnKey, toolCallId, var2.callOrder, value, false, {
                question = question,
                selectedOptionId = selection.selectedOptionId,
                customResponseText = selection.customResponseText,
                toolCallId = toolCallId,
                callOrder = var2.callOrder,
                isLastQuestion = #var1 <= value
            }, nil, nil)
        )
    end

    if not FFlagBuildExperienceAnswerForm or not arg2.submittedToolCallIds[toolCallId] or var2.isSubmitting or not (#tbl2 > 0) then
        return tbl2
    end

    local tbl3 = {}
    for _, value in tbl2 do
        table.insert(tbl3, value.answerStackPrompt)
    end

    return { (makeAnswersSegment(turnKey, toolCallId, tbl3)) }
end

local function projectPlanSegments(arg1, turnKey: string, toolCallId: string, completedPlansByToolCallId, arg2)
    local toolCall = arg1.toolCalls[toolCallId]
    if toolCall == nil then
        return {}
    end

    local planProposal = completedPlansByToolCallId[toolCallId]
    if planProposal ~= nil then
        return { makeClientToolSegment(turnKey, toolCallId, planProposal.callOrder or 0, 1, false, nil, planProposal, nil) }
    end

    local var2 = arg2.planByToolCallId[toolCallId]
    local var3 = StudioProposePlanTool.extractPlanFromToolCall(toolCall)
    if var3 == nil or var2 == nil then
        return {}
    end

    local tbl2 = {
        title = var3.title,
        textContent = var3.textContent,
        summary = var3.summary,
        toolCallId = toolCallId,
        callOrder = var2.callOrder,
        isAccepted = var2.isAccepted,
        feedbackText = var2.feedbackText
    }
    local isActive = not (var2.isAccepted == true or var2.feedbackText ~= nil) and not arg2.submittedToolCallIds[toolCallId]
    return { makeClientToolSegment(turnKey, toolCallId, var2.callOrder, 1, isActive, nil, tbl2, nil) }
end

local function projectDevProductSegments(arg1, turnKey: string, toolCallId: string, arg2)
    if arg1.toolCalls[toolCallId] == nil then
        return {}
    end

    local devProductProposal = arg2.devProductByToolCallId[toolCallId]
    if devProductProposal == nil then
        return {}
    end

    local isActive = not (devProductProposal.isApproved == true or devProductProposal.isRejected == true)
        and not arg2.submittedToolCallIds[toolCallId]
    return { makeClientToolSegment(turnKey, toolCallId, devProductProposal.callOrder, 1, isActive, nil, nil, devProductProposal) }
end

local function projectLocalToolSegments(arg1, turnKey: string, toolCallId: string, answeredPromptsByToolCallId, completedPlansByToolCallId, arg2)
    local var1 = projectAskUserSegments(arg1, turnKey, toolCallId, answeredPromptsByToolCallId, arg2)
    if #var1 > 0 then
        return var1
    end

    local tbl2 = projectPlanSegments(arg1, turnKey, toolCallId, completedPlansByToolCallId, arg2)
    if #tbl2 > 0 then
        return tbl2
    elseif FFlagBuildExperienceManageDevProduct then
        return (projectDevProductSegments(arg1, turnKey, toolCallId, arg2))
    end

    return {}
end

local function getActiveAskUserActivityLabel(arg1, toolCallId: string, arg2)
    local var1 = arg2.askUserByToolCallId[toolCallId]
    local toolCall = arg1.toolCalls[toolCallId]
    if var1 == nil or toolCall == nil then
        return nil
    end

    if arg2.submittedToolCallIds[toolCallId] then
        return LocalizationStrings.CHAT_ASSISTANT_LOADING
    end

    local var2 = StudioAskUserTool.extractQuestionsFromToolCall(toolCall)
    if var2 == nil then
        return nil
    end

    local var3 = var2[var1.currentIndex]
    local optionsLen = var3 ~= nil and #var3.options or nil
    return getAskUserActivityLabel(#var2, optionsLen)
end

local function projectWorkSegments(arg1, turnKey: string, arg2, bool1: boolean)
    local result = {}
    local tbl2 = {}
    local activeAskUserActivityLabel = nil
    local bool2 = false
    local answeredPromptsByToolCallId = getAnsweredPromptsByToolCallId(arg1)
    local completedPlansByToolCallId = getCompletedPlansByToolCallId(arg1)

    local function flushActivity(bool3: boolean, num1: number?)
        local segmentKey = makeSegmentKey(turnKey, if bool3 then "activity-trailing" else "activity", num1 or #result + 1)
        local var1 = if bool1 and bool3 then makeActiveActivitySummary(
            tbl2,
            true,
            segmentKey,
            activeAskUserActivityLabel,
            bool2,
            if FFlagBuildExperienceThoughtStatus then getLatestThoughtHeading(tbl2) else nil
        ) else makeCompletedActivitySummary(tbl2, segmentKey)

        if var1 ~= nil then
            table.insert(result, var1)
        end
        tbl2 = {}
        activeAskUserActivityLabel = nil
        bool2 = false
    end

    local str1 = contentBlocksToText(arg1.pendingAgentMessageContent)
    local bool3 = false
    local function emitPendingAgentMessage()
        bool3 = true
        if str1 == "" then
            return
        end
        flushActivity(false, arg1.pendingAgentMessageSequenceIndex)
        local segmentKey = if arg1.pendingAgentMessageSequenceIndex ~= nil then makeSegmentKey(turnKey, "agent-message", arg1.pendingAgentMessageSequenceIndex) else makeSegmentKey(turnKey, "pending-agent-message")
        local agentMessageSegment = makeAgentMessageSegment(segmentKey, str1, nil, nil)
        if agentMessageSegment ~= nil then
            table.insert(result, agentMessageSegment)
        end
    end

    for _, value in (getSortedActivitySlotIndexes(arg1)) do
        local pendingAgentMessageSequenceIndex = arg1.pendingAgentMessageSequenceIndex

        if FFlagBuildExperienceThoughtStatus
            and not bool3
            and pendingAgentMessageSequenceIndex ~= nil
            and pendingAgentMessageSequenceIndex < value
        then
            emitPendingAgentMessage()
        end
        local activitySlot = arg1.activitySlots[value]
        if activitySlot.kind == "agent_message" then
            flushActivity(false, value)
            local agentMessageSegment = makeAgentMessageSegment(makeSegmentKey(turnKey, "agent-message", value), activitySlot.text, nil, nil)
            if agentMessageSegment ~= nil then
                table.insert(result, agentMessageSegment)
            end
        elseif FFlagBuildExperienceThoughtStatus and activitySlot.kind == "thought" then
            local turnActivityItem = makeTurnActivityItem(arg1, activitySlot)
            if turnActivityItem ~= nil then
                table.insert(tbl2, turnActivityItem)
            end
        elseif activitySlot.kind == "tool_call" then
            local var1 = projectLocalToolSegments(
                arg1,
                turnKey,
                activitySlot.toolCallId,
                answeredPromptsByToolCallId,
                completedPlansByToolCallId,
                arg2
            )

            if #var1 > 0 then
                flushActivity(false, value)
                for _, value2 in var1 do
                    table.insert(result, value2)
                    if value2.isActive then
                        bool2 = true
                    end
                end
                if bool1 then
                    local turnActivityItem = makeTurnActivityItem(arg1, activitySlot)
                    if turnActivityItem ~= nil then
                        table.insert(tbl2, turnActivityItem)
                    end

                    activeAskUserActivityLabel = getActiveAskUserActivityLabel(arg1, activitySlot.toolCallId, arg2)
                end
            else
                local turnActivityItem = makeTurnActivityItem(arg1, activitySlot)
                if turnActivityItem ~= nil then
                    table.insert(tbl2, turnActivityItem)
                end
            end
        end
    end

    if not (FFlagBuildExperienceThoughtStatus and bool3) then
        emitPendingAgentMessage()
    end

    flushActivity(true, nil)
    return result
end

local function makeTurnWorkSegment(str1: string, segments, tbl2, num1: number?, num2: number?, num3: number?) -- Luacid: Inlined by compiler; 1 call site recovered
    if #segments == 0 then
        return nil
    end
    local actionCount = countActionsInSegments(segments)
    local chatTurnActivity = nil
    local var2 = nil
    if tbl2 ~= nil and num1 ~= nil and num2 ~= nil then
        local var3 = tbl2[num1]
        local var4 = tbl2[num2]
        local emittedTime = if var3 == nil then nil else var3.emittedTime
        local emittedTime2 = if var4 == nil then nil else var4.emittedTime
        local isoDate = if emittedTime == nil or emittedTime == "" then nil else DateTime.fromIsoDate(emittedTime)
        local isoDate2 = if emittedTime2 == nil or emittedTime2 == "" then nil else DateTime.fromIsoDate(emittedTime2)

        if isoDate ~= nil and isoDate2 ~= nil then
            var2 = (isoDate2.UnixTimestampMillis - isoDate.UnixTimestampMillis) / 1000
            if num3 ~= nil then
                var2 = math.max(0, var2 - num3)
            end
        end
    end

    if var2 == nil and actionCount == 0 then
        chatTurnActivity = LocalizationStrings.CHAT_TURN_ACTIVITY
    end
    return {
        kind = "turn_work",
        key = makeSegmentKey(str1, "work"),
        label = chatTurnActivity,
        segments = segments,
        actionCount = actionCount,
        workedDurationSeconds = var2
    }
end

local function addTerminalAssistantMessageSegments(tbl2, arg1, turnKey: string)
    for value, value2 in getAssistantMessageTexts(arg1) do
        local agentMessageSegment = makeAgentMessageSegment(makeSegmentKey(turnKey, "terminal-agent-message", value), value2, nil, nil)
        if agentMessageSegment ~= nil then
            table.insert(tbl2, agentMessageSegment)
        end
    end
end

local function addAgentAdCampaignCardSegments(tbl2, arg1, turnKey: string)
    local tbl3 = {}

    for _, value in (getSortedActivitySlotIndexes(arg1)) do
        local activitySlot = arg1.activitySlots[value]
        if activitySlot.kind ~= "tool_call" then
            continue
        end

        local toolCall = arg1.toolCalls[activitySlot.toolCallId]
        if not adCampaignEligibilityTool.isCompletedEligibilityToolCall(toolCall) or tbl3[toolCall.toolCallId] then
            continue
        end

        tbl3[toolCall.toolCallId] = true
        local var1 = adCampaignEligibilityTool.decodeCompletedEligibility(toolCall)
        local offers = adCampaignEligibilityTool.getCardOffers(var1)

        table.insert(tbl2, {
            kind = "agent_ad_campaign_card",
            key = makeSegmentKey(turnKey, "ad-campaign", toolCall.toolCallId),
            toolCallId = toolCall.toolCallId,
            availableCreditsSnapshot = if var1 == nil then 0 else var1.freeCreditsRemaining,
            offers = offers,
            shouldCheckCampaignStatus = var1 == nil or offers ~= nil
        })
    end
end

local function projectTurnSegments(arg1, tbl2, arg2)
    local turnKey = makeTurnKey(arg1, tbl2)
    local result = {}
    local tbl3 = projectWorkSegments(arg1, turnKey, arg2, not arg1.isDone)
    local localToolWaitSeconds = getLocalToolWaitSeconds(arg1)
    local turnWorkSegment = makeTurnWorkSegment(
        turnKey,
        tbl3,
        arg1.eventMetaBySequenceId,
        tbl2.startSequenceId,
        tbl2.endSequenceId,
        localToolWaitSeconds
    )

    if turnWorkSegment ~= nil then
        table.insert(result, turnWorkSegment)
    end

    addTerminalAssistantMessageSegments(result, arg1, turnKey)
    if FFlagBuildAgentAdCampaignCard then
        addAgentAdCampaignCardSegments(result, arg1, turnKey)
    end
    if arg1.status == "failed" or arg1.stopReason == "error" then
        local chatAssistantResponseFailed = LocalizationStrings.CHAT_ASSISTANT_RESPONSE_FAILED
        local errorCode = arg1.errorCode
        local agentMessageSegment = makeAgentMessageSegment(makeSegmentKey(turnKey, "failure"), chatAssistantResponseFailed, true, errorCode)
        if agentMessageSegment ~= nil then
            table.insert(result, agentMessageSegment)
        end
    elseif arg1.status == "cancelled" or arg1.stopReason == "cancelled" then
        local agentMessageSegment = makeAgentMessageSegment(makeSegmentKey(turnKey, "cancelled"), ASSISTANT_STOPPED_TEXT, nil, nil)
        if agentMessageSegment ~= nil then
            table.insert(result, agentMessageSegment)
        end
    end

    if arg1.isDone and PublishToolUtils.includesPublishPlaceTool(arg1) and tbl2.showPlaytestCta == true then
        table.insert(result, { kind = "playtest_cta", key = makeSegmentKey(turnKey, "playtest-cta") })
    end

    return result
end

return {
    getFinalAssistantMessageText = function(arg1)
        local assistantMessageTexts = getAssistantMessageTexts(arg1)
        return assistantMessageTexts[#assistantMessageTexts]
    end,
    projectActiveTurnSegments = function(arg1, tbl2)
        return (projectTurnSegments(arg1, tbl2 or {}, if tbl2 and tbl2.optimisticLocalTools then tbl2.optimisticLocalTools else tbl1))
    end,
    projectLoadingTurnSegments = function(tbl2): {[any]: any} | {any}
        local var1

        if tbl2 == nil then
            var1 = "loading"
        elseif tbl2.turnKey ~= nil then
            var1 = tbl2.turnKey
        else
            var1 = tbl2.sessionId or "pending-session"
            local sequenceId = if tbl2.turnFeedbackIds == nil or typeof(tbl2.turnFeedbackIds) == "function" then nil else tbl2.turnFeedbackIds.sequenceId

            if sequenceId ~= nil then
                var1 = `{var1}:{sequenceId}`
            end
        end

        local activeActivitySummary = makeActiveActivitySummary({}, true, makeSegmentKey(var1, "activity-trailing"), nil)
        local tbl3 = {}
        if activeActivitySummary ~= nil then
            table.insert(tbl3, activeActivitySummary)
        end

        local turnWorkSegment = makeTurnWorkSegment(var1, tbl3, nil, nil, nil, nil)
        return if turnWorkSegment == nil then {} else { turnWorkSegment }
    end,
    projectSetupErrorSegments = function(text: string, tbl2)
        local var1

        if tbl2 == nil then
            var1 = "setup-error"
        elseif tbl2.turnKey ~= nil then
            var1 = tbl2.turnKey
        else
            var1 = tbl2.sessionId or "pending-session"
            local sequenceId = if tbl2.turnFeedbackIds == nil or typeof(tbl2.turnFeedbackIds) == "function" then nil else tbl2.turnFeedbackIds.sequenceId

            if sequenceId ~= nil then
                var1 = `{var1}:{sequenceId}`
            end
        end

        return {{
            kind = "agent_message",
            key = makeSegmentKey(var1, "setup-error"),
            text = text
        }}
    end
}
