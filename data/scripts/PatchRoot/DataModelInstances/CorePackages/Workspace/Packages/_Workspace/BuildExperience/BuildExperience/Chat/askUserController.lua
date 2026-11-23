-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:51:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)

local FFlagBuildExperienceAnswerForm = require(BuildExperience.Flags.FFlagBuildExperienceAnswerForm)
local Signals = if FFlagBuildExperienceAnswerForm then require(BuildExperienceParent.Signals) else nil
local _chatTypes = require(script.Parent.chatTypes)
local chatConstants = require(script.Parent.chatConstants)
local _localToolOverlay = require(script.Parent.localToolOverlay)
local toolControllerUtils = require(script.Parent.toolControllerUtils)

local StudioAskUserTool = CreatorAgentChat.StudioAskUserTool
local debug2 = CreatorAgentChat.debug
local awaitRequestState = toolControllerUtils.awaitRequestState
local getToolCallOrder = toolControllerUtils.getToolCallOrder

local function getSelectedOptionId(tbl1) -- Luacid: Inlined by compiler; 2 call sites recovered
    if tbl1 == nil then
        return nil
    end
    if tbl1.options == nil then
        return if tbl1.option == nil then nil else tbl1.option.id
    end

    local selectedOptionId = {}
    for _, option in tbl1.options do
        table.insert(selectedOptionId, option.id)
    end
    return selectedOptionId
end

local function makeAnswerStackPrompt(tbl1, tbl2) -- Luacid: unused: defined but never referenced
    return {
        question = tbl1.questions[tbl1.currentIndex],
        selectedOptionId = getSelectedOptionId(tbl2),
        customResponseText = if tbl2 == nil then nil else tbl2.customResponseText,
        toolCallId = tbl1.toolCallId,
        callOrder = tbl1.callOrder,
        isLastQuestion = tbl1.currentIndex >= #tbl1.questions
    }
end

local function buildOptimisticAskUserTool(tbl1, bool1: boolean?)
    local selections = ({})
    for k, selection in tbl1.selections do
        local tbl3 = {
            selectedOptionId = getSelectedOptionId(selection),
            customResponseText = selection.customResponseText
        }
        selections[k] = tbl3
    end

    if FFlagBuildExperienceAnswerForm then
        if bool1 == nil then
            bool1 = tbl1.submitted
        end
    else
        bool1 = nil
    end

    return {
        toolCallId = tbl1.toolCallId,
        callOrder = tbl1.callOrder,
        currentIndex = tbl1.currentIndex,
        isSubmitting = bool1,
        selections = selections,
        drafts = tbl1.drafts
    }
end

local function toggleOptionInSelection(selection, option)
    local options = {}
    local bool1 = false

    for _, value in (selection == nil or selection.options == nil) and {} or selection.options do
        if value.id == option.id then
            bool1 = true
        else
            table.insert(options, value)
        end
    end
    if not bool1 then
        table.insert(options, option)
    end
    return { options = options, option = nil, customResponseText = nil }
end

local function createAnswerStackSync(callback: (...any) -> (...any), callback2: (...any) -> (...any), func1: (...any) -> (...any)) -- Luacid: Inlined by compiler; 1 call site recovered
    local sessionId = nil
    local var1 = nil
    local bool1 = false

    return function(arg1): boolean
        local questions, toolCallId, _, turnId, referenceId = StudioAskUserTool.findQuestionsInTurnState(arg1, func1())
        if questions == nil or toolCallId == nil then
            if bool1 then
                debug2.log("info", "ask_user answer stack cleared", { turn = debug2.formatTurnState(arg1) })

                bool1 = false
                sessionId = nil
                var1 = nil
                callback(nil)
                callback2(nil)
            end
            return false
        end

        bool1 = true
        if arg1.sessionId ~= sessionId or toolCallId ~= var1 then
            sessionId = arg1.sessionId
            var1 = toolCallId
            local tbl1 = {
                sessionId = arg1.sessionId,
                toolCallId = toolCallId,
                callOrder = getToolCallOrder(arg1, toolCallId),
                turnId = turnId,
                referenceId = referenceId,
                questions = questions,
                selections = {},
                currentIndex = 1,
                submitted = false
            }

            if FFlagBuildExperienceAnswerForm then
                local drafts = {}
                for _, question in tbl1.questions do
                    local getText, setText = Signals.createSignal(nil)
                    drafts[question.id] = { getText = getText, setText = setText }
                end
                tbl1.drafts = drafts
            end
            callback2(tbl1)
            callback({
                question = tbl1.questions[tbl1.currentIndex],
                selectedOptionId = getSelectedOptionId(nil),
                customResponseText = nil,
                toolCallId = tbl1.toolCallId,
                callOrder = tbl1.callOrder,
                isLastQuestion = tbl1.currentIndex >= #tbl1.questions
            })
            debug2.log("info", "ask_user answer stack displayed", {
                toolCallId = toolCallId,
                turnId = turnId,
                referenceId = referenceId,
                questions = debug2.formatStudioAskUserQuestions(questions),
                turn = debug2.formatTurnState(arg1)
            })
        end
        return true
    end
end

local function createAskUserController(arg1, tbl1, arg2, callback)
    local var1 = nil
    local onAnswerSelectedImpl = nil
    local onAnswerConfirmedImpl = nil

    local function setAnswerFlow(tbl2) -- Luacid: Inlined by compiler; 2 call sites recovered
        if FFlagBuildExperienceAnswerForm and tbl2 == nil and var1 ~= nil then
            local drafts = var1.drafts
            if drafts ~= nil then
                for _, draft in drafts do
                    draft.setText(nil)
                end
            end
        end
        var1 = tbl2
    end

    local function setCurrentAnswerStackPrompt(arg3) -- Luacid: Inlined by compiler; 1 call site recovered
        local var2 = var1
        if arg3 == nil then
            if var2 ~= nil then
                arg2.removeAskUserTool(var2.toolCallId)
                arg2.removeAnswerAction(var2.toolCallId)
            end
            return
        end
        if var2 ~= nil then
            arg2.setAskUserTool((buildOptimisticAskUserTool(var2)))
            arg2.setAnswerAction(var2.toolCallId, onAnswerSelectedImpl, onAnswerConfirmedImpl)
        end
    end

    local function getSubmittedToolCallIds()
        return tbl1
    end

    local function resetFailedSubmission(tbl2) -- Luacid: Inlined by compiler; 1 call site recovered
        tbl2.submitted = false
        if FFlagBuildExperienceAnswerForm then
            arg2.setAskUserTool((buildOptimisticAskUserTool(tbl2)))
        end
        arg2.clearSubmitted(tbl2.toolCallId)
    end

    local function recoverFailedSubmission(tbl2, num1: number?)
        resetFailedSubmission(tbl2)

        if callback == nil then
            return
        end

        local selection = tbl2.selections[tbl2.currentIndex]
        local customResponseText = if selection == nil then nil else selection.customResponseText
        tbl2.selections[tbl2.currentIndex] = nil
        arg2.setAskUserTool((buildOptimisticAskUserTool(tbl2)))
        callback(customResponseText, num1)
    end

    local answerStackSync = createAnswerStackSync(setCurrentAnswerStackPrompt, setAnswerFlow, getSubmittedToolCallIds)
    local hasDisplayedAnswerStack = false

    local function submitAskUserResponses(tbl2)
        local tbl3 = {}
        for k, question in tbl2.questions do
            local selection = tbl2.selections[k]
            if selection == nil then
                return
            end
            table.insert(tbl3, {
                question = question,
                option = selection.option,
                options = selection.options,
                customResponseText = selection.customResponseText
            })
        end

        local var2 = StudioAskUserTool.formatToolResultContent(tbl3)
        debug2.log("info", "ask_user tool_result submitting", {
            sessionId = tbl2.sessionId,
            toolCallId = tbl2.toolCallId,
            turnId = tbl2.turnId,
            referenceId = tbl2.referenceId,
            questionCount = #tbl2.questions
        })
        local startTime = os.clock()
        local var3 = arg1.submitActiveToolResult(var2, false, tbl2.turnId, tbl2.referenceId)
        if var3 == nil then
            debug2.log("warn", "ask_user tool_result submit aborted (no active session)", { toolCallId = tbl2.toolCallId })

            recoverFailedSubmission(tbl2, nil)
            return
        end
        local var4 = awaitRequestState(var3.state, os.clock() + chatConstants.CAS_RPC_TIMEOUT_SECONDS)
        local durationMs = math.floor((os.clock() - startTime) * 1000 + 0.5)
        if var4.status ~= "succeeded" then
            recoverFailedSubmission(tbl2, var4.errorCode)
            debug2.log("warn", "ask_user tool_result submit failed", {
                sessionId = tbl2.sessionId,
                toolCallId = tbl2.toolCallId,
                turnId = tbl2.turnId,
                referenceId = tbl2.referenceId,
                durationMs = durationMs,
                state = debug2.formatRequestState(var4)
            })
            return
        end

        debug2.log("info", "ask_user tool_result submitted", {
            sessionId = tbl2.sessionId,
            toolCallId = tbl2.toolCallId,
            turnId = tbl2.turnId,
            referenceId = tbl2.referenceId,
            questionCount = #tbl2.questions,
            durationMs = durationMs
        })
        tbl1[tbl2.toolCallId] = true
        arg2.markSubmitted(tbl2.toolCallId)
        arg2.removeAnswerAction(tbl2.toolCallId)
        if FFlagBuildExperienceAnswerForm then
            arg2.setAskUserTool((buildOptimisticAskUserTool(tbl2, false)))
        end

        setAnswerFlow(nil)
    end

    local function submitAskUserCancellation(tbl2)
        local var2 = StudioAskUserTool.formatCancellationContent()

        tbl1[tbl2.toolCallId] = true
        arg2.markSubmitted(tbl2.toolCallId)
        arg2.removeAnswerAction(tbl2.toolCallId)
        setCurrentAnswerStackPrompt(nil)
        setAnswerFlow(nil)
        local var3 = arg1.submitActiveToolResult(var2, false, tbl2.turnId, tbl2.referenceId)
        if var3 == nil then
            debug2.log("warn", "ask_user cancel aborted (no active session)", { toolCallId = tbl2.toolCallId })

            return
        end
        awaitRequestState(var3.state, os.clock() + chatConstants.CAS_RPC_TIMEOUT_SECONDS)
    end

    local function advanceToNextQuestion(tbl2): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
        if tbl2.currentIndex >= #tbl2.questions then
            return false
        end

        tbl2.currentIndex += 1
        arg2.setAskUserTool((buildOptimisticAskUserTool(tbl2)))
        return true
    end

    local function commitCurrentSelectionAndAdvance(tbl2)
        if advanceToNextQuestion(tbl2) then
            return
        end

        tbl2.submitted = true
        if FFlagBuildExperienceAnswerForm then
            arg2.setAskUserTool((buildOptimisticAskUserTool(tbl2)))
        end
        arg2.markSubmitted(tbl2.toolCallId)
        task.spawn(function()
            submitAskUserResponses(tbl2)
        end)
    end

    onAnswerSelectedImpl = function(arg3, option, bool2: boolean?)
        local var2 = var1
        if var2 == nil or var2.submitted then
            return
        end

        local question = var2.questions[var2.currentIndex]
        if question == nil or question.id ~= arg3.id then
            return
        end

        if question.responseType == "multi_select" then
            if FFlagBuildExperienceAnswerForm and bool2 then
                var2.selections[var2.currentIndex] = nil
            end
            var2.selections[var2.currentIndex] = toggleOptionInSelection(var2.selections[var2.currentIndex], option)
            arg2.setAskUserTool((buildOptimisticAskUserTool(var2)))
            debug2.log("info", "ask_user multi-select toggled", {
                toolCallId = var2.toolCallId,
                questionId = arg3.id,
                questionIndex = var2.currentIndex,
                optionId = option.id,
                optionTitle = option.title
            })
        else
            debug2.log("info", "ask_user answer selected", {
                toolCallId = var2.toolCallId,
                questionId = arg3.id,
                questionIndex = var2.currentIndex,
                optionId = option.id,
                optionTitle = option.title
            })
            var2.selections[var2.currentIndex] = {
                option = option,
                options = nil,
                customResponseText = nil
            }

            arg2.setAskUserTool((buildOptimisticAskUserTool(var2)))

            commitCurrentSelectionAndAdvance(var2)
        end
    end

    onAnswerConfirmedImpl = function()
        local var2 = var1
        if var2 == nil or var2.submitted then
            return
        end

        local question = var2.questions[var2.currentIndex]
        if question == nil or question.responseType ~= "multi_select" then
            return
        end

        local selection = var2.selections[var2.currentIndex]
        local options = if selection == nil then nil else selection.options

        if options == nil or #options == 0 then
            return
        end

        debug2.log(
            "info",
            "ask_user multi-select confirmed",
            {
                toolCallId = var2.toolCallId,
                questionId = question.id,
                questionIndex = var2.currentIndex,
                selectedCount = #options
            }
        )
        commitCurrentSelectionAndAdvance(var2)
    end
    local function submitCustomAnswer(tbl2, question, customResponseText: string)
        if not FFlagBuildExperienceAnswerForm and question.responseType == "multi_select" then
            return false
        end
        if FFlagBuildExperienceAnswerForm then
            customResponseText = string.match(customResponseText, "^%s*(.-)%s*$") or ""
            if customResponseText == "" then
                return false
            end
        end

        debug2.log(
            "info",
            "ask_user custom answer submitted",
            {
                toolCallId = tbl2.toolCallId,
                questionId = question.id,
                questionIndex = tbl2.currentIndex
            }
        )
        tbl2.selections[tbl2.currentIndex] = {
            option = nil,
            options = nil,
            customResponseText = customResponseText
        }
        arg2.setAskUserTool((buildOptimisticAskUserTool(tbl2)))

        if advanceToNextQuestion(tbl2) then
            return true
        end

        tbl2.submitted = true
        if FFlagBuildExperienceAnswerForm then
            arg2.setAskUserTool((buildOptimisticAskUserTool(tbl2)))
        end
        arg2.markSubmitted(tbl2.toolCallId)
        task.spawn(function()
            submitAskUserResponses(tbl2)
        end)
        return true
    end

    return {
        syncAnswerStack = function(arg3): boolean
            if not answerStackSync(arg3) then
                return false
            end

            hasDisplayedAnswerStack = true
            return true
        end,
        getSubmittedToolCallIds = getSubmittedToolCallIds,
        hasDisplayedAnswerStack = function()
            return hasDisplayedAnswerStack
        end,
        stopPendingAnswer = function(): boolean
            local var2 = var1
            if var2 == nil or var2.submitted then
                return false
            end
            var2.submitted = true
            task.spawn(function()
                submitAskUserCancellation(var2)
            end)
            return true
        end,
        trySubmitComposerText = function(str1: string)
            local var2 = var1
            if var2 == nil or var2.submitted then
                return false
            end
            local question = var2.questions[var2.currentIndex]
            if question == nil then
                return false
            end
            return (submitCustomAnswer(var2, question, str1))
        end,
        trySubmitAnswerText = function(toolCallId: string, id: string, str1: string)
            local var2 = var1
            if var2 == nil or var2.submitted or var2.toolCallId ~= toolCallId then
                return false
            end
            local question = var2.questions[var2.currentIndex]
            if question == nil or question.id ~= id then
                return false
            end
            return (submitCustomAnswer(var2, question, str1))
        end
    }
end
return createAskUserController
