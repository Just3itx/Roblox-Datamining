-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:21:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _types = require(script.Parent.types)
local StudioAskUserTool = require(script.Parent.StudioAskUserTool)
local StudioProposePlanTool = require(script.Parent.StudioProposePlanTool)
local SubagentTasks = require(script.Parent.SubagentTasks)

local function getAskItemKey(arg1, num1: number): string -- Luacid: Inlined by compiler; 2 call sites recovered
    return `ask-{arg1.toolCallId or arg1.question.id}-{arg1.question.id}-{num1}`
end

local function getPlanItemKey(arg1): string -- Luacid: Inlined by compiler; 2 call sites recovered
    return `plan-{arg1.toolCallId or arg1.title}`
end

local function getSubagentTasksItemKey(): string -- Luacid: Inlined by compiler; 2 call sites recovered
    return "subagent-tasks"
end

local function getSubagentTasksCallOrder(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    for k, activityItem in arg1.activityItems do
        if activityItem.kind == "tool_call" and activityItem.title == SubagentTasks.TOOL_NAME then
            return k
        end
    end
    return 0
end

local function sortClientToolItems(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    table.sort(tbl1, function(arg1, arg2): boolean
        if arg1.callOrder == arg2.callOrder then
            return arg1.key < arg2.key
        end

        return arg1.callOrder < arg2.callOrder
    end)

    return tbl1
end

local function makeSubagentTasksItem(subagentTaskState, num1: number, isActive: boolean) -- Luacid: Inlined by compiler; 1 call site recovered
    return {
        kind = "subagent_tasks",
        key = getSubagentTasksItemKey(),
        toolCallId = nil,
        callOrder = num1 * 1000,
        isActive = isActive,
        subagentTaskState = subagentTaskState
    }
end

return {
    getAskItemKey = getAskItemKey,
    getPlanItemKey = getPlanItemKey,
    getSubagentTasksItemKey = getSubagentTasksItemKey,
    getSubagentTasksCallOrder = getSubagentTasksCallOrder,
    sortClientToolItems = sortClientToolItems,
    makeAskItem = function(answerStackPrompt, num1: number, isActive: boolean, onAnswerSelected: ((...any) -> (...any))?)
        local tbl1 = {
            kind = "ask_user",
            key = getAskItemKey(answerStackPrompt, num1),
            toolCallId = answerStackPrompt.toolCallId,
            callOrder = (answerStackPrompt.callOrder or num1) * 1000 + num1,
            isActive = isActive,
            answerStackPrompt = answerStackPrompt,
            onAnswerSelected = 0
        }

        if not isActive then
            onAnswerSelected = nil
        end

        tbl1.onAnswerSelected = onAnswerSelected
        return tbl1
    end,
    makePlanItem = function(planProposal, isActive: boolean, onPlanAccepted: ((...any) -> (...any))?)
        local tbl1 = {
            kind = "plan",
            key = getPlanItemKey(planProposal),
            toolCallId = planProposal.toolCallId,
            callOrder = (planProposal.callOrder or 0) * 1000,
            isActive = isActive,
            planProposal = planProposal,
            onPlanAccepted = 0
        }

        if not isActive then
            onPlanAccepted = nil
        end

        tbl1.onPlanAccepted = onPlanAccepted
        return tbl1
    end,
    makeSubagentTasksItem = makeSubagentTasksItem,
    getCompletedItemsFromTurnState = function(arg1)
        local tbl1 = {}

        for value, answerStackPrompt in StudioAskUserTool.getAnsweredPromptsFromTurnState(arg1) do
            table.insert(tbl1, {
                kind = "ask_user",
                key = getAskItemKey(answerStackPrompt, value),
                toolCallId = answerStackPrompt.toolCallId,
                callOrder = (answerStackPrompt.callOrder or value) * 1000 + value,
                isActive = false,
                answerStackPrompt = answerStackPrompt,
                onAnswerSelected = nil
            })
        end
        for _, planProposal in StudioProposePlanTool.getCompletedPlansFromTurnState(arg1) do
            table.insert(tbl1, {
                kind = "plan",
                key = getPlanItemKey(planProposal),
                toolCallId = planProposal.toolCallId,
                callOrder = (planProposal.callOrder or 0) * 1000,
                isActive = false,
                planProposal = planProposal,
                onPlanAccepted = nil
            })
        end
        local turnState = SubagentTasks.fromTurnState(arg1)
        if turnState ~= nil then
            table.insert(tbl1, (makeSubagentTasksItem(turnState, getSubagentTasksCallOrder(arg1), false)))
        end

        return sortClientToolItems(tbl1)
    end
}
