-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local OnPlatformSurveys = script:FindFirstAncestor("OnPlatformSurveys")
local OnPlatformSurveysParent = OnPlatformSurveys.Parent
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

local React = require(OnPlatformSurveysParent.React)

local SharedFlags = require(OnPlatformSurveysParent.SharedFlags)
local FFlagInlineSurveyEnhancements = SharedFlags.FFlagInlineSurveyEnhancements
local FFlagInlineSurveyBranching = SharedFlags.FFlagInlineSurveyBranching
local FFlagInlineSurveyPartialResponse = SharedFlags.FFlagInlineSurveyPartialResponse

local inlineSurveyHelpers = require(OnPlatformSurveys.Utils.inlineSurveyHelpers)
local inlineSurveyApi = require(OnPlatformSurveys.Api.inlineSurveyApi)
local Phase = require(OnPlatformSurveys.Enums.Phase)
local inlineSurveyReducer = require(OnPlatformSurveys.Hooks.inlineSurveyReducer)
local _InlineSurveyTypes = require(OnPlatformSurveys.Types.InlineSurveyTypes)

local function releaseKeyboardFocus() -- Luacid: Inlined by compiler; 2 call sites recovered
    local textBox = UserInputService:GetFocusedTextBox()
    if textBox ~= nil then
        textBox:ReleaseFocus()
    end
end

local function useInlineSurveyFlow(tbl1)
    local networkImpl = tbl1.networkImpl
    local eventType = tbl1.eventType

    local var1, var2 = React.useReducer(inlineSurveyReducer.reducer, tbl1.hasInvite == true, inlineSurveyReducer.getInitialState)

    local var3 = React.useRef(0)

    local var4 = React.useRef(false)

    local var5 = React.useRef(var1)
    var5.current = var1
    local var6 = React.useRef(tbl1.onClose)
    var6.current = tbl1.onClose
    local var7 = React.useRef(tbl1.onComplete)
    var7.current = tbl1.onComplete
    local var8 = React.useRef(tbl1.onEligible)
    var8.current = tbl1.onEligible
    local var9 = React.useRef(false)

    local var10 = React.useCallback(function()
        local current = var3.current + 1
        var3.current = current
        var4.current = false
        var9.current = false
        var2({ type = "fetchRequested" })
        inlineSurveyApi.fetchInlineSurvey(networkImpl, eventType):andThen(function(response)
            if var3.current ~= current then
                return
            end
            var2({ type = "questionsReceived", response = response })
        end):catch(function(arg1)
            if var3.current ~= current then
                return
            end
            warn("Inline survey fetch failed:", arg1)
            var2({ type = "fetchFailed" })
        end)
    end, { networkImpl, eventType })

    local var11 = React.useCallback(function()
        local current = var5.current
        if var4.current then
            return
        end
        local question = current.questions[current.index]
        local surveyId = current.surveyId
        if question == nil or surveyId == nil then
            return
        end

        local var11 = inlineSurveyHelpers.mergeCurrentAnswerIntoBatch(current.answersByQuestionId, question, current.answer)
        local var12 = if FFlagInlineSurveyBranching then inlineSurveyHelpers.getVisitedQuestions(current.questions, var11) else current.questions

        if not inlineSurveyHelpers.canSubmitAll(var12, var11) then
            return
        end

        local idempotencyKey = current.idempotencyKey or HttpService:GenerateGUID(false)
        local submitPayload = inlineSurveyHelpers.buildSubmitPayload(surveyId, var12, var11, idempotencyKey)

        if #submitPayload.answers == 0 then
            var2({ type = "submitSucceeded" })
            return
        end

        local var13 = var3.current + 1
        var3.current = var13
        var4.current = true
        var2({ type = "submitStarted", idempotencyKey = idempotencyKey })
        inlineSurveyApi.submitSurveyResponse(networkImpl, submitPayload):andThen(function(_)
            if var3.current ~= var13 then
                return
            end
            var4.current = false
            var2({ type = "submitSucceeded" })
        end):catch(function(arg1)
            if var3.current ~= var13 then
                return
            end
            var4.current = false
            warn("Inline survey submit failed:", arg1)
            var2({ type = "submitFailed" })
        end)
    end, { networkImpl })

    local submit = React.useCallback(function()
        local current = var5.current
        if current.questions[current.index] == nil or var4.current then
            return
        end

        if not FFlagInlineSurveyEnhancements then
            var11()
            return
        end

        if not inlineSurveyHelpers.canAdvance(current.questions, current.index, current.answersByQuestionId, current.answer) then
            return
        end

        releaseKeyboardFocus()

        if inlineSurveyHelpers.isLastQuestion(current.questions, current.index, current.answer) then
            var11()
            return
        end
        var2({ type = "next" })
    end, { var11 })

    local retry = React.useCallback(function()
        if var5.current.errorType == "submit" then
            var11()
            return
        end
        var10()
    end, { var11, var10 })

    local setAnswer = React.useCallback(function(answer)
        var2({ type = "setAnswer", answer = answer })
    end, {})

    local var15 = React.useCallback(function()
        if var4.current then
            return
        end
        local current = var5.current
        local surveyId = current.surveyId
        if surveyId == nil or current.phase == Phase.Completed then
            return
        end
        local var15 = current.idempotencyKey or HttpService:GenerateGUID(false)
        local submitPayload = inlineSurveyHelpers.buildSubmitPayload(
            surveyId,
            current.questions,
            current.answersByQuestionId,
            var15,
            { finished = false }
        )
        if #submitPayload.answers == 0 then
            return
        end
        inlineSurveyApi.submitSurveyResponse(networkImpl, submitPayload):catch(function(arg1)
            warn("Inline survey partial submit failed:", arg1)
        end)
    end, { networkImpl })

    local dismiss = React.useCallback(function()
        if FFlagInlineSurveyEnhancements then
            releaseKeyboardFocus()
        end

        if FFlagInlineSurveyPartialResponse then
            var15()
        end
        local var16 = var3
        var16.current += 1
        var4.current = false
        var2({ type = "dismissed" })
    end, FFlagInlineSurveyPartialResponse and { var15 } or {})

    local acceptInvite = React.useCallback(function()
        var2({ type = "inviteAccepted" })
    end, {})

    local declineInvite = React.useCallback(function()
        local var18 = var3
        var18.current += 1
        var4.current = false
        var2({ type = "inviteDeclined" })
    end, {})

    React.useEffect(function()
        var10()
        return function()
            local var19 = var3
            var19.current += 1
        end
    end, { var10 })

    React.useEffect(function()
        if var1.phase == Phase.Completed and var7.current then
            var7.current()
        elseif var1.phase == Phase.Closed and var6.current then
            var6.current()
        elseif (var1.phase == Phase.Started or var1.phase == Phase.Invite) and not var9.current and var8.current then
            var9.current = true
            var8.current()
        end
    end, { var1.phase })

    return {
        state = var1,
        setAnswer = setAnswer,
        submit = submit,
        retry = retry,
        dismiss = dismiss,
        acceptInvite = acceptInvite,
        declineInvite = declineInvite
    }
end

return useInlineSurveyFlow
