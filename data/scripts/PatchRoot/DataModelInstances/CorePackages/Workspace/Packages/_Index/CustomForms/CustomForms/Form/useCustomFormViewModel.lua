-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CustomFormsParent = script:FindFirstAncestor("CustomForms").Parent
local React = require(CustomFormsParent.React)

local _CustomFormView = require(script.Parent.CustomFormView)
local CustomFormSelection = require(script.Parent.CustomFormSelection)

local function isPromise(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return type(arg1) == "table" and type(arg1.andThen) == "function"
end

local function useCustomFormViewModel(tbl1)
    local definition = tbl1.definition
    local var1, var2 = React.useState({})
    local var3, var4 = React.useState(false)
    local var5, var6 = React.useState(false)

    local var7, var8 = React.useState(false)
    local var9 = React.useRef(0)
    React.useEffect(function()
        return function()
            local var10 = var9
            var10.current += 1
        end
    end, {})
    local submitRef = React.useRef(nil)

    local var11, var12 = React.useState(0)

    local response = tbl1.response
    local bool1 = response ~= nil
    local bool2 = tbl1.hasInvalidData == true
    local isSubmitting = tbl1.isSubmitting == true or var7
    if response == nil then
        response = var1
    end

    local var14 = tbl1.errors or {
        fields = {},
        form = {}
    }
    local onSubmit = tbl1.onSubmit
    local isEditable = tbl1.isEditable == true and not (isSubmitting or bool1) and not bool2 and type(onSubmit) == "function"
    local var15, var16 = CustomFormSelection.buildResponse(definition, response)
    local tbl2 = ({})
    for _, value in var16 do
        tbl2[value] = true
    end
    local testId = tbl1.testId or "--custom-form"

    local function change(arg1, str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
        if isEditable then
            var2(function(arg2)
                return CustomFormSelection.selectOption(arg2, arg1, str1)
            end)
            var6(false)
        end
    end

    local function submit()
        if not isEditable then
            return
        end
        var4(true)
        if not var15 or not onSubmit then
            return
        end

        local success, result = pcall(onSubmit, var15, submitRef.current)
        var6(not success)

        if not success or not isPromise(result) then
            return
        end

        local var17 = var9
        var17.current += 1
        local current = var9.current
        var8(true)
        local function settle() -- Luacid: Inlined by compiler; 1 call site recovered
            if var9.current == current then
                var8(false)
            end
        end
        local var18 = result:andThen(settle, function()
            settle()

            if var9.current == current then
                var6(true)
            end
        end)

        if type(var18) == "table" and type(var18.finally) == "function" then
            var18:finally(settle)
        end
    end

    local results = tbl1.results
    local sections = {}
    for _, section in definition.sections do
        local fields = {}
        for _, field in section.fields do
            local str1 = `{testId}--field-{field.fieldId}`
            local var17 = response[field.fieldId] or {}
            local field2 = if results then results.fields[field.fieldId] else nil
            local showResults = bool1 and field2 ~= nil
            local bool5 = field.fieldType == "Radio" and not showResults and var11 > 0
            local options = {}
            local str2 = ""
            for _, option in field.options do
                local isChosen = var17[option.optionId] == true
                if isChosen then
                    str2 = option.optionId
                end

                local var18 = if showResults and field2 then field2[option.optionId] or {
                    voteCount = "0",
                    percentage = 0
                } else nil
                local tbl6 = {
                    optionId = option.optionId,
                    label = option.label,
                    isChosen = isChosen,
                    result = if var18 then {
                        percentage = var18.percentage
                    } else nil,
                    onActivated = 0,
                    testId = 0
                }

                function tbl6.onActivated()
                    change(field, option.optionId)
                end
                tbl6.testId = `{str1}--option-{option.optionId}`
                table.insert(options, tbl6)
            end

            local tbl6 = {
                fieldId = field.fieldId,
                fieldType = field.fieldType,
                label = if field.label == definition.title then nil else field.label,
                options = options,
                showResults = showResults,
                rowWidth = if bool5 then var11 else nil,
                selectedRadio = str2,
                onRadioChanged = 0,
                errors = 0,
                requiredMessage = 0,
                testId = 0
            }

            function tbl6.onRadioChanged(str3: string)
                change(field, str3)
            end
            tbl6.errors = var14.fields[field.fieldId] or {}
            tbl6.requiredMessage = if var3 and tbl2[field.fieldId] and not bool1 then tbl1.requiredErrorMessage else nil

            tbl6.testId = str1
            table.insert(fields, tbl6)
        end

        table.insert(
            sections,
            {
                id = section.id,
                header = section.header,
                fields = fields,
                testId = `{testId}--section-{section.id}`
            }
        )
    end
    local resultsSummary = tbl1.resultsSummary
    local module = {
        title = definition.title,
        description = if definition.description == definition.title then nil else definition.description,
        sections = sections,
        isEditable = isEditable,
        isSubmitting = isSubmitting,
        summary = 0,
        disabledMessage = 0,
        formErrors = 0,
        failureMessage = 0,
        submitLabel = 0,
        submitRef = 0,
        onSubmit = 0,
        onSectionsSizeChanged = 0,
        viewerUserId = 0,
        layoutOrder = 0,
        testId = 0
    }

    if not bool1 or not results or type(resultsSummary) ~= "string" or resultsSummary == "" then
        resultsSummary = nil
    end

    module.summary = resultsSummary
    module.disabledMessage = if tbl1.isEditable == true or bool1 then nil else tbl1.disabledMessage
    module.formErrors = var14.form
    module.failureMessage = if bool2 or var5 then tbl1.submissionErrorMessage else nil
    module.submitLabel = if bool1 then nil else tbl1.submitLabel
    module.submitRef = submitRef
    module.onSubmit = submit
    function module.onSectionsSizeChanged(arg1)
        var12(arg1.AbsoluteSize.X)
    end
    module.viewerUserId = tbl1.viewerUserId
    module.layoutOrder = tbl1.layoutOrder
    module.testId = testId
    return module
end

return useCustomFormViewModel
