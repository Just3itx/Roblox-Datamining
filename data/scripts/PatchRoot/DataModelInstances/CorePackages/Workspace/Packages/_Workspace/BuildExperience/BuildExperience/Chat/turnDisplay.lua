-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local StudioAskUserTool = CreatorAgentChat.StudioAskUserTool
local StudioProposePlanTool = CreatorAgentChat.StudioProposePlanTool

local function parseEmittedTimeMillis(str1: string?) -- Luacid: Inlined by compiler; 2 call sites recovered
    if typeof(str1) ~= "string" or str1 == "" then
        return nil
    end
    local dateTime = DateTime.fromIsoDate(str1)
    return if dateTime == nil then nil else dateTime.UnixTimestampMillis
end

local function toolCallIsLocalPrompt(toolCall): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return StudioProposePlanTool.extractPlanFromToolCall(toolCall) ~= nil
        or StudioAskUserTool.extractQuestionsFromToolCall(toolCall) ~= nil
end

local function isActiveToolActivity(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1.kind == "tool_call" and (arg1.status == "pending" or arg1.status == "in_progress" or arg1.status == nil)
end

local function countToolCalls(tbl1): number -- Luacid: Inlined by compiler; 1 call site recovered
    local num1 = 0
    for _, value in tbl1 do
        if value.kind == "tool_call" then
            num1 += 1
        end
    end
    return num1
end

return {
    ASSISTANT_STOPPED_TEXT = LocalizationStrings.CHAT_ASSISTANT_STOPPED,
    countToolCalls = countToolCalls,
    getAskUserActivityLabel = function(num1: number, num2: number?)
        if num2 == 0 then
            return LocalizationStrings.CHAT_QUESTION_COMPOSER_ANSWER
        end

        if num1 == 1 then
            return LocalizationStrings.CHAT_QUESTION_SINGLE
        end

        return LocalizationStrings.CHAT_QUESTION_MULTIPLE
    end,
    getLocalToolWaitSeconds = function(arg1)
        local eventMetaBySequenceId = arg1.eventMetaBySequenceId
        if eventMetaBySequenceId == nil then
            return 0
        end

        local num1 = 0
        for k, activitySlot in arg1.activitySlots do
            if activitySlot.kind ~= "tool_call" then
                continue
            end

            local toolCall = arg1.toolCalls[activitySlot.toolCallId]

            if toolCall == nil or not toolCallIsLocalPrompt(toolCall) then
                continue
            end

            local var1 = k - 1
            local var2 = eventMetaBySequenceId[var1]
            local var3 = eventMetaBySequenceId[var1 + 1]
            local emittedTime = if var2 then var2.emittedTime else nil
            local var4 = parseEmittedTimeMillis(emittedTime)
            local emittedTime2 = if var3 then var3.emittedTime else nil
            local var5 = parseEmittedTimeMillis(emittedTime2)

            if var4 ~= nil and var5 ~= nil and var4 < var5 then
                num1 += var5 - var4
            end
        end

        return num1 / 1000
    end,
    getSummaryToolActivity = function(tbl1, str1: string)
        if str1 == "active" then
            for i = #tbl1, 1, -1 do
                local var1 = tbl1[i]

                if isActiveToolActivity(var1) then
                    return var1
                end
            end
        elseif countToolCalls(tbl1) == 1 then
            for _, value in tbl1 do
                if value.kind == "tool_call" then
                    return value
                end
            end
        end
        return nil
    end
}
