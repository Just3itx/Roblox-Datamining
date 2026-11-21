-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CustomForms = script:FindFirstAncestor("CustomForms")
local CustomFormsParent = CustomForms.Parent
local Players = game:GetService("Players")

local React = require(CustomFormsParent.React)
local Foundation = require(CustomFormsParent.Foundation)
local SduiCoreSystem = require(CustomFormsParent.SduiCoreSystem)
local CustomFormContainer = require(CustomForms.Form.CustomFormContainer)
local CustomFormSelection = require(CustomForms.Form.CustomFormSelection)
local SduiCustomFormData = require(script.Parent.SduiCustomFormData)
local _getSduiCustomFormVerticalRegistry = require(script.Parent.getSduiCustomFormVerticalRegistry)

local function getViewerUserId(): number? -- Luacid: unused: defined but never referenced
    local localPlayer = Players.LocalPlayer
    local userId = if localPlayer then localPlayer.UserId else nil
    return if userId and userId > 0 then userId else nil
end

local function useResultsRefresh(str1: string?, current, resultsRefreshIntervalSeconds, current2)
    local var1 = React.useRef(current)
    var1.current = current
    local var2 = React.useRef(current2)
    var2.current = current2
    local bool1 = type(current) == "function"
    React.useEffect(function()
        if str1 == nil or not bool1 or type(resultsRefreshIntervalSeconds) ~= "number" or resultsRefreshIntervalSeconds <= 0 then
            return nil
        end
        local bool2 = true
        local var3 = nil

        local bool3 = false
        local function reportFailure(arg1)
            local current3 = var2.current
            if bool3 or not current3 then
                return
            end
            bool3 = true
            current3.dependencies.logger.reportError(
                SduiCoreSystem.SduiErrors.SduiErrorType.FailedToExecuteAction,
                {
                    componentType = SduiCoreSystem.SduiComponentType.CustomForm,
                    propName = "onRefreshResults",
                    message = tostring(arg1)
                },
                current3.appPage
            )
        end

        local function schedule() -- Luacid: Inlined by compiler; 1 call site recovered
            var3 = task.delay(resultsRefreshIntervalSeconds, function()
                var3 = nil
                if not bool2 then
                    return
                end
                local success, result = pcall(var1.current, nil, nil, nil)
                if not success or type(result) ~= "table" or type(result.andThen) ~= "function" then
                    if not success then
                        reportFailure(result)
                    end
                    schedule()

                    return
                end

                result:andThen(function()
                    if bool2 then
                        schedule()
                    end
                end, function(arg1)
                    if bool2 then
                        reportFailure(arg1)
                        schedule()
                    end
                end)
            end)
        end

        schedule()

        return function()
            bool2 = false
            if var3 then
                task.cancel(var3)
            end
        end
    end, { str1, bool1, resultsRefreshIntervalSeconds })
end

local function errorText(tbl1)
    local submissionErrorMessage = tbl1.submissionErrorMessage
    if not submissionErrorMessage or submissionErrorMessage == "" then
        return nil
    end

    return (React.createElement(Foundation.Text, {
        Text = submissionErrorMessage,
        LayoutOrder = tbl1.layoutOrder or 0,
        testId = `{tbl1.testId or "--sdui-custom-form"}--error`,
        tag = "size-full-0 auto-y text-body-medium text-align-x-left content-alert"
    }))
end

return React.memo(function(tbl1) -- name: SduiCustomForm
    local definition, var2 = SduiCustomFormData.readDefinition(tbl1.formDefinition)
    local bool1 = tbl1.viewerResponse ~= nil
    useResultsRefresh(
        if definition and bool1 then CustomFormSelection.draftKey(definition) else nil,
        tbl1.onRefreshResults,
        tbl1.resultsRefreshIntervalSeconds,
        tbl1.sduiContext
    )

    if tbl1.formDefinition == nil or var2 then
        return nil
    end

    if not definition then
        return (errorText(tbl1))
    end

    local var3 = if bool1 then SduiCustomFormData.readResponse(tbl1.viewerResponse, definition) else nil
    local results = if tbl1.results == nil then nil else SduiCustomFormData.readResults(tbl1.results, definition)
    local hasInvalidData = if bool1 and var3 == nil then true else not (tbl1.results == nil) and results == nil
    local onSubmit = tbl1.onSubmit
    local sduiContext = tbl1.sduiContext
    local var1 = type(onSubmit) == "function" and function(arg1, arg2)
        local tbl2 = {}
        for _, section in definition.sections do
            for _, field in section.fields do
                tbl2[field.fieldId] = field.fieldType
            end
        end
        local answers = {}
        for _, answer in arg1.answers do
            table.insert(answers, { fieldId = answer.fieldId, fieldType = tbl2[answer.fieldId], optionIds = answer.optionIds })
        end

        local success, result = pcall(onSubmit, nil, arg2, { response = { answers = answers } })
        if not success then
            if sduiContext then
                sduiContext.dependencies.logger.reportError(
                    SduiCoreSystem.SduiErrors.SduiErrorType.FailedToExecuteAction,
                    {
                        componentType = SduiCoreSystem.SduiComponentType.CustomForm,
                        propName = "onSubmit",
                        message = "CustomForm submit callback failed"
                    },
                    sduiContext.appPage
                )
            end

            error(result, 0)
        end
        return result
    end or nil

    local createElement = React.createElement
    local var6 = CustomFormContainer
    local tbl2 = {
        definition = definition,
        response = bool1 and (var3 or {}) or nil,
        results = results,
        hasInvalidData = hasInvalidData,
        isEditable = tbl1.isDisabled == false,
        disabledMessage = tbl1.disabledMessage,
        isSubmitting = tbl1.isSubmitting,
        errors = SduiCustomFormData.readErrors(tbl1.validationErrors, definition, tbl1.submissionErrorMessage or ""),
        submitLabel = tbl1.submitLabel,
        resultsSummary = tbl1.resultsSummary,
        requiredErrorMessage = tbl1.requiredErrorMessage,
        submissionErrorMessage = tbl1.submissionErrorMessage,
        viewerUserId = 0,
        onSubmit = 0,
        layoutOrder = 0,
        testId = 0
    }
    local localPlayer = Players.LocalPlayer
    local userId = if localPlayer then localPlayer.UserId else nil
    tbl2.viewerUserId = userId and userId > 0 and userId or nil
    tbl2.onSubmit = var1
    tbl2.layoutOrder = tbl1.layoutOrder
    tbl2.testId = tbl1.testId or "--sdui-custom-form"
    return createElement(var6, tbl2)
end)
