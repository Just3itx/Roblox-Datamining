-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CustomForms = script:FindFirstAncestor("CustomForms")
local CustomFormsParent = CustomForms.Parent

local Promise = require(CustomFormsParent.Promise)
local SduiCoreSystem = require(CustomFormsParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType

local customFormEntry = require(CustomForms.Sdui.customFormEntry)
local getSduiCustomFormVerticalRegistry = require(CustomForms.Sdui.getSduiCustomFormVerticalRegistry)

local function isId(arg1): boolean -- Luacid: Inlined by compiler; 6 call sites recovered
    return type(arg1) == "string" and arg1 ~= ""
end

local function readAnswers(response)
    if type(response) ~= "table" or type(response.answers) ~= "table" then
        return nil
    end
    local result = {}
    for _, answer in response.answers do
        if type(answer) ~= "table" or not isId(answer.fieldId) or type(answer.optionIds) ~= "table" then
            return nil
        end
        if answer.fieldType ~= "Radio" and answer.fieldType ~= "Checkbox" then
            return nil
        end
        local optionIds = {}
        for _, optionId in answer.optionIds do
            if not isId(optionId) then
                return nil
            end
            table.insert(optionIds, optionId)
        end
        table.insert(result, { fieldId = answer.fieldId, fieldType = answer.fieldType, optionIds = optionIds })
    end
    return result
end

local function reportInvalid(arg1, message: string)
    arg1.dependencies.logger.reportError(
        SduiErrorType.InvalidActionParams,
        {
            name = SduiActionType.SubmitCustomFormResponse,
            message = message
        },
        arg1.appPage
    )
    return Promise.reject(message)
end

local function SduiSubmitCustomFormResponseAction(arg1, _, arg2)
    local var1 = not arg1 and {} or not arg1.actionParams and {} or arg1.actionParams

    local answers = readAnswers(var1.response)
    local configKey = arg2.configKey

    if not (isId(var1.entityId) and isId(var1.formId) and isId(var1.cfVertical) and answers and isId(configKey)) then
        return reportInvalid(arg2, "Missing entityId, formId, cfVertical, response answers, or configKey")
    end
    assert(answers and configKey, "checked above")

    local var3 = getSduiCustomFormVerticalRegistry().getVertical(var1.cfVertical)
    if not var3 then
        return reportInvalid(arg2, `No CustomForm adapter for cfVertical: {var1.cfVertical}`)
    end

    local tbl1 = {
        entityId = var1.entityId,
        formId = var1.formId,
        cfVertical = var1.cfVertical,
        answers = answers,
        current = customFormEntry.findForm(configKey, var1.formId)
    }
    local fetchResults = var3.fetchResults

    return Promise.try(var3.submit, tbl1):catch(function(arg3)
        arg2.dependencies.logger.reportError(
            SduiErrorType.FailedToExecuteAction,
            {
                name = SduiActionType.SubmitCustomFormResponse,
                message = tostring(arg3)
            },
            arg2.appPage
        )
        return Promise.reject(arg3)
    end):andThen(function()
        if not fetchResults then
            return nil
        end

        return Promise.try(fetchResults, tbl1):catch(function(arg3)
            arg2.dependencies.logger.reportError(
                SduiErrorType.FailedToExecuteAction,
                {
                    name = SduiActionType.SubmitCustomFormResponse,
                    message = `Results after submit failed: {tostring(arg3)}`
                },
                arg2.appPage
            )
            return nil
        end)
    end):andThen(function(arg3)
        if arg3 ~= nil and not customFormEntry.isFormData(arg3, tbl1.formId) then
            arg2.dependencies.logger.reportError(SduiErrorType.FailedToUpdateDataStores, {
                name = SduiActionType.SubmitCustomFormResponse,
                message = `Fresh data for form {tbl1.formId} is for another form`
            }, arg2.appPage)
            arg3 = nil
        end
        if not customFormEntry.updateForm(configKey, tbl1.formId, function(arg4)
            if arg3 ~= nil then
                return arg3
            end

            local tbl2 = {}
            for _, value in answers do
                table.insert(tbl2, { field_id = value.fieldId, option_ids = value.optionIds })
            end
            local var4 = table.clone(arg4)
            var4.viewer_response = { answers = tbl2 }
            var4.results = nil
            return var4
        end) then
            arg2.dependencies.logger.reportError(SduiErrorType.FailedToUpdateDataStores, {
                name = SduiActionType.SubmitCustomFormResponse,
                message = `No form {tbl1.formId} under {configKey} to show the response`
            }, arg2.appPage)
        end
    end)
end

return SduiSubmitCustomFormResponseAction
