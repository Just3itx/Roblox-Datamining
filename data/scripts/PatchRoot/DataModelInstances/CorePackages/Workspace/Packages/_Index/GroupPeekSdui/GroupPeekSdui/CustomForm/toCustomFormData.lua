-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:41:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {
    Radio = "CUSTOM_FORM_FIELD_TYPE_RADIO",
    Checkbox = "CUSTOM_FORM_FIELD_TYPE_CHECKBOX"
}

local function list(arg1) -- Luacid: Inlined by compiler; 6 call sites recovered
    return if type(arg1) == "table" then arg1 else {}
end

local function toDefinition(formId: string, arg1)
    local tbl2 = {}
    local tbl3 = {}
    local formSpecs = if type(arg1) == "table" then arg1.formSpecs else nil
    local sections = if type(formSpecs) == "table" then formSpecs.sections else nil

    for _, value in (list(sections)) do
        local fields = {}

        for _, value2 in (list(value.fieldSpecs)) do
            local options = {}

            for _, value3 in (list(value2.options)) do
                table.insert(options, { option_id = value3.optionId, label = value3.label })
            end
            local tbl6 = {
                field_id = value2.fieldId,
                field_type = tbl1[value2.type],
                label = value2.label,
                options = options
            }
            table.insert(fields, tbl6)
            table.insert(tbl3, tbl6)
        end
        table.insert(tbl2, { id = value.id, header = value.header, fields = fields })
    end
    return {
        form_id = formId,
        title = if type(arg1) == "table" then arg1.title else nil,
        description = if type(arg1) == "table" then arg1.description else nil,
        sections = tbl2
    }, tbl3
end

local function toResults(arg1)
    if type(arg1) ~= "table" then
        return nil
    end
    local fieldResults = {}

    for _, value in (list(arg1.fieldResults)) do
        local optionResults = {}

        for _, value2 in (list(value.optionResults)) do
            table.insert(
                optionResults,
                {
                    option_id = value2.optionId,
                    vote_count = value2.voteCount,
                    percentage = value2.percentage
                }
            )
        end

        table.insert(fieldResults, { field_id = value.fieldId, option_results = optionResults })
    end
    return {
        total_responses = arg1.totalResponses,
        field_results = fieldResults
    }
end

local function toViewerResponse(arg1, tbl2)
    local values = if type(arg1) == "table" then arg1.values else nil

    if type(values) ~= "table" then
        return nil
    end
    local answers = {}
    for _, value in tbl2 do
        local var1 = values[value.field_id]
        if type(var1) ~= "table" then
            continue
        end

        local tbl4 = ({})
        if type(var1.choiceOptionId) == "string" then
            tbl4[var1.choiceOptionId] = true
        end

        for _, value2 in (list(var1.multiChoiceOptionIds)) do
            tbl4[value2] = true
        end
        local optionIds = {}
        for _, option in value.options do
            if tbl4[option.option_id] then
                table.insert(optionIds, option.option_id)
            end
        end
        if #optionIds > 0 then
            table.insert(answers, { field_id = value.field_id, option_ids = optionIds })
        end
    end

    return { answers = answers }
end

local function toCustomFormData(formId: string, arg1, tbl2)
    local form = if type(arg1) == "table" then arg1.form else nil
    local formDefinition, tbl4 = toDefinition(formId, form)
    return {
        form_definition = formDefinition,
        viewer_response = toViewerResponse(if type(arg1) == "table" then arg1.userResponse else nil, tbl4),
        results = toResults(if type(arg1) == "table" then arg1.results else nil),
        is_editable = if tbl2 then tbl2.is_editable else nil,
        disabled_message = if tbl2 then tbl2.disabled_message else nil
    }
end

return toCustomFormData
