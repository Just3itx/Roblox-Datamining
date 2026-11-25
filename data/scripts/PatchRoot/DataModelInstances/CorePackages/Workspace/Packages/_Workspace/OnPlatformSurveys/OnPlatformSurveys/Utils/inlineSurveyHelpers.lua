-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:51:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local OnPlatformSurveys = script:FindFirstAncestor("OnPlatformSurveys")
local OnPlatformSurveysParent = OnPlatformSurveys.Parent

local SharedFlags = require(OnPlatformSurveysParent.SharedFlags)
local FFlagInlineSurveyBranching = SharedFlags.FFlagInlineSurveyBranching
local FFlagInlineSurveyChoiceTextEntry = SharedFlags.FFlagInlineSurveyChoiceTextEntry

local InlineQuestionType = require(OnPlatformSurveys.Enums.InlineQuestionType)
local InlineSurveyTypes = require(OnPlatformSurveys.Types.InlineSurveyTypes)

local tbl1 = {}
local tbl2 = {}

local function trim(str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    return (str1:gsub("^%s*(.-)%s*$", "%1"))
end

local function buildChoiceTexts(arg1)
    local choiceTexts = arg1.choiceTexts
    if choiceTexts == nil then
        return nil
    end
    local tbl3 = ({})
    local bool1 = false
    for _, value in arg1.choiceIds or tbl2 do
        local var1 = trim(choiceTexts[value] or "")
        if var1 ~= "" then
            tbl3[value] = var1
            bool1 = true
        end
    end

    return if bool1 then tbl3 else nil
end

local function buildResponse(arg1, arg2)
    if arg1.type == InlineQuestionType.Text then
        local text = trim(arg2.text or "")
        return if text == "" then nil else { text = text }
    end

    local choiceIds = arg2.choiceIds or {}
    if #choiceIds == 0 then
        return nil
    end
    return {
        choiceIds = choiceIds,
        choiceTexts = if FFlagInlineSurveyChoiceTextEntry then buildChoiceTexts(arg2) else nil
    }
end

local function canSubmitAll(tbl3, tbl4)
    for _, value in tbl3 do
        if value.required ~= true then
            continue
        end

        local var1 = tbl4[value.questionId] or tbl1
        local bool1

        if value.type == InlineQuestionType.Text then
            bool1 = true
        elseif value.type == InlineQuestionType.MultipleChoiceSingle then
            if var1.choiceIds == nil then
                bool1 = false
            else
                bool1 = #var1.choiceIds == 1
            end
        elseif value.type == InlineQuestionType.MultipleChoiceMulti and var1.choiceIds ~= nil then
            bool1 = #var1.choiceIds >= 1
        else
            bool1 = false
        end
        if not bool1 then
            return false
        end
    end

    return true
end

local function mergeCurrentAnswerIntoBatch(tbl3, arg1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = table.clone(tbl3)
    if arg1 ~= nil then
        var1[arg1.questionId] = arg2
    end
    return var1
end

local function indexOfQuestion(tbl3, questionId: string) -- Luacid: Inlined by compiler; 4 call sites recovered
    for value, value2 in tbl3 do
        if value2.questionId == questionId then
            return value
        end
    end
    return nil
end

local function resolveNextQuestionId(arg1, arg2)
    local choiceIds = arg2.choiceIds
    if arg1.choices ~= nil and choiceIds ~= nil and #choiceIds > 0 then
        local choiceId = choiceIds[1]
        for _, value in arg1.choices do
            if value.id == choiceId then
                return value.next or arg1.next
            end
        end
    end
    return arg1.next
end

local function resolveNextIndex(tbl3, num1: number, arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1 = tbl3[num1]
    if var1 == nil then
        return nil
    end
    local questionId = resolveNextQuestionId(var1, arg1)
    if questionId ~= nil then
        if questionId == InlineSurveyTypes.NEXT_END then
            return nil
        end

        local var2 = indexOfQuestion(tbl3, questionId)

        if var2 ~= nil then
            return var2
        end
    end

    local num2 = num1 + 1
    return if num2 <= #tbl3 then num2 else nil
end

local function getVisitedQuestions(tbl3, tbl4)
    local tbl5 = {}
    local tbl6 = ({})
    local var1 = if #tbl3 > 0 then 1 else nil
    local var2

    while true do
        local bool1 = false

        if var1 == nil or tbl6[var1] then
            return tbl5
        end

        tbl6[var1] = true
        local var3 = tbl3[var1]
        table.insert(tbl5, var3)
        local var4 = tbl4[var3.questionId] or tbl1
        local var5 = tbl3[var1]
        if var5 == nil then
            var2 = nil
        else
            local questionId = resolveNextQuestionId(var5, var4)
            if questionId == nil then
                bool1 = true
            elseif questionId == InlineSurveyTypes.NEXT_END then
                var2 = nil
            else
                var2 = indexOfQuestion(tbl3, questionId)

                if var2 == nil then
                    bool1 = true
                end
            end
        end
        if bool1 then
            var2 = var1 + 1
            if not (var2 <= #tbl3) then
                var2 = nil
            end
        end

        var1 = var2
    end
end

local function isLastQuestion(tbl3, num1: number, arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return if FFlagInlineSurveyBranching then resolveNextIndex(tbl3, num1, arg1) == nil else #tbl3 <= num1
end

return {
    isAnswerComplete = function(arg1, arg2): boolean
        if arg1.type == InlineQuestionType.Text then
            return true
        end

        if arg1.type == InlineQuestionType.MultipleChoiceSingle then
            return not (arg2.choiceIds == nil) and #arg2.choiceIds == 1
        end

        if arg1.type ~= InlineQuestionType.MultipleChoiceMulti then
            return false
        end

        return not (arg2.choiceIds == nil) and #arg2.choiceIds >= 1
    end,
    buildSubmitPayload = function(surveyId: string, tbl3, tbl4, idempotencyKey: string, tbl5)
        local answers = {}
        for _, value in tbl3 do
            local var1 = tbl4[value.questionId] or tbl1
            local response = buildResponse(value, var1)
            if response == nil then
                continue
            end

            table.insert(answers, { questionId = value.questionId, type = value.type, response = response })
        end

        return {
            surveyId = surveyId,
            idempotencyKey = idempotencyKey,
            answers = answers,
            finished = if tbl5 == nil then nil else tbl5.finished
        }
    end,
    canSubmitAll = canSubmitAll,
    canAdvance = function(tbl3, num1: number, tbl4, arg1)
        local var1 = tbl3[num1]
        if var1 == nil then
            return false
        end

        if isLastQuestion(tbl3, num1, arg1) then
            local var2 = mergeCurrentAnswerIntoBatch(tbl4, nil, nil)
            if var1 ~= nil then
                var2[var1.questionId] = arg1
            end

            if FFlagInlineSurveyBranching then
                tbl3 = getVisitedQuestions(tbl3, var2)
            end

            return (canSubmitAll(tbl3, var2))
        end

        local bool1

        if var1.required == true then
            if var1.type == InlineQuestionType.Text then
                return true
            end

            if var1.type == InlineQuestionType.MultipleChoiceSingle then
                if arg1.choiceIds ~= nil then
                    return #arg1.choiceIds == 1
                end

                bool1 = false
            else
                if var1.type == InlineQuestionType.MultipleChoiceMulti and arg1.choiceIds ~= nil then
                    return #arg1.choiceIds >= 1
                end

                bool1 = false
            end
        else
            bool1 = true
        end

        return bool1
    end,
    resolveNextIndex = resolveNextIndex,
    getVisitedQuestions = getVisitedQuestions,
    isLastQuestion = isLastQuestion,
    mergeCurrentAnswerIntoBatch = mergeCurrentAnswerIntoBatch,
    toggleChoice = function(arg1, str1: string, bool1: boolean): {string}
        if not bool1 then
            return { str1 }
        end

        local result = {}
        local bool2 = false
        for _, value in arg1.choiceIds or tbl2 do
            if value == str1 then
                bool2 = true
            else
                table.insert(result, value)
            end
        end
        if not bool2 then
            table.insert(result, str1)
        end
        return result
    end
}
