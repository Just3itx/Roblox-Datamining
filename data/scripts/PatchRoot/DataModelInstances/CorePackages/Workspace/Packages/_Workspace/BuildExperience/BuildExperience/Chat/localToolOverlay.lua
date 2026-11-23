-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Signals = require(BuildExperienceParent.Signals)

local _chatTypes = require(script.Parent.chatTypes)

local function createLocalToolOverlay()
    local getOptimisticLocalTools, var2 = Signals.createSignal(
        {
            submittedToolCallIds = {},
            askUserByToolCallId = {},
            planByToolCallId = {},
            devProductByToolCallId = {}
        }
    )
    local getLocalToolActions, var4 = Signals.createSignal({
        onAnswerSelectedByToolCallId = {},
        onAnswerConfirmedByToolCallId = {},
        onPlanAcceptedByToolCallId = {},
        onDevProductApprovedByToolCallId = {},
        onDevProductRejectedByToolCallId = {}
    })

    local function updateOptimistic(callback: (...any) -> (...any))
        local var5 = getOptimisticLocalTools(false)
        local tbl1 = {
            submittedToolCallIds = table.clone(var5.submittedToolCallIds),
            askUserByToolCallId = table.clone(var5.askUserByToolCallId),
            planByToolCallId = table.clone(var5.planByToolCallId),
            devProductByToolCallId = table.clone(var5.devProductByToolCallId)
        }
        callback(tbl1)
        var2(tbl1)
    end

    local function updateActions(callback: (...any) -> (...any))
        local var5 = getLocalToolActions(false)
        local tbl1 = {
            onAnswerSelectedByToolCallId = table.clone(var5.onAnswerSelectedByToolCallId),
            onAnswerConfirmedByToolCallId = table.clone(var5.onAnswerConfirmedByToolCallId),
            onPlanAcceptedByToolCallId = table.clone(var5.onPlanAcceptedByToolCallId),
            onDevProductApprovedByToolCallId = table.clone(var5.onDevProductApprovedByToolCallId),
            onDevProductRejectedByToolCallId = table.clone(var5.onDevProductRejectedByToolCallId)
        }
        callback(tbl1)
        var4(tbl1)
    end

    return {
        getOptimisticLocalTools = getOptimisticLocalTools,
        getLocalToolActions = getLocalToolActions,
        markSubmitted = function(arg1)
            updateOptimistic(function(arg2)
                arg2.submittedToolCallIds[arg1] = true
            end)
        end,
        clearSubmitted = function(arg1)
            updateOptimistic(function(arg2)
                arg2.submittedToolCallIds[arg1] = nil
            end)
        end,
        setAskUserTool = function(arg1)
            updateOptimistic(function(arg2)
                arg2.askUserByToolCallId[arg1.toolCallId] = arg1
            end)
        end,
        removeAskUserTool = function(arg1)
            updateOptimistic(function(arg2)
                arg2.askUserByToolCallId[arg1] = nil
            end)
        end,
        setPlanTool = function(arg1)
            updateOptimistic(function(arg2)
                arg2.planByToolCallId[arg1.toolCallId] = arg1
            end)
        end,
        removePlanTool = function(arg1)
            updateOptimistic(function(arg2)
                arg2.planByToolCallId[arg1] = nil
            end)
        end,
        setAnswerAction = function(arg1, arg2, arg3)
            updateActions(function(arg4)
                arg4.onAnswerSelectedByToolCallId[arg1] = arg2
                if arg3 ~= nil then
                    arg4.onAnswerConfirmedByToolCallId[arg1] = arg3
                    return
                end
                arg4.onAnswerConfirmedByToolCallId[arg1] = nil
            end)
        end,
        removeAnswerAction = function(arg1)
            updateActions(function(arg2)
                arg2.onAnswerSelectedByToolCallId[arg1] = nil
                arg2.onAnswerConfirmedByToolCallId[arg1] = nil
            end)
        end,
        setPlanAction = function(arg1, arg2)
            updateActions(function(arg3)
                arg3.onPlanAcceptedByToolCallId[arg1] = arg2
            end)
        end,
        removePlanAction = function(arg1)
            updateActions(function(arg2)
                arg2.onPlanAcceptedByToolCallId[arg1] = nil
            end)
        end,
        setDevProductTool = function(arg1)
            updateOptimistic(function(arg2)
                arg2.devProductByToolCallId[arg1.toolCallId] = arg1
            end)
        end,
        removeDevProductTool = function(arg1)
            updateOptimistic(function(arg2)
                arg2.devProductByToolCallId[arg1] = nil
            end)
        end,
        setDevProductAction = function(arg1, arg2, arg3)
            updateActions(function(arg4)
                arg4.onDevProductApprovedByToolCallId[arg1] = arg2
                arg4.onDevProductRejectedByToolCallId[arg1] = arg3
            end)
        end,
        removeDevProductAction = function(arg1)
            updateActions(function(arg2)
                arg2.onDevProductApprovedByToolCallId[arg1] = nil
                arg2.onDevProductRejectedByToolCallId[arg1] = nil
            end)
        end
    }
end

return createLocalToolOverlay
