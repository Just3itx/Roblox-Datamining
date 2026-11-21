-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:41:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CustomForms = script:FindFirstAncestor("CustomForms")
local _CustomFormSelection = require(CustomForms.Form.CustomFormSelection)

local function isId(arg1): boolean -- Luacid: Inlined by compiler; 8 call sites recovered
    return type(arg1) == "string" and #arg1 > 0
end

local function isOptionalText(arg1): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
    return arg1 == nil or type(arg1) == "string"
end

local function isArray(arg1)
    if type(arg1) ~= "table" then
        return false
    end
    local num1 = 0
    for value in arg1 do
        if type(value) ~= "number" or value < 1 or value % 1 ~= 0 then
            return false
        end
        num1 += 1
    end
    for i = 1, num1 do
        if arg1[i] == nil then
            return false
        end
    end
    return true
end

local function listOrEmpty(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    return if arg1 == nil then {} else arg1
end

local function fieldType(fieldType2) -- Luacid: Inlined by compiler; 1 call site recovered
    if fieldType2 == 1 or fieldType2 == "CUSTOM_FORM_FIELD_TYPE_RADIO" then
        return "Radio"
    end

    if fieldType2 == 2 or fieldType2 == "CUSTOM_FORM_FIELD_TYPE_CHECKBOX" then
        return "Checkbox"
    end

    return nil
end

local function indexFields(arg1)
    local result = {}
    for _, section in arg1.sections do
        for _, field in section.fields do
            result[field.fieldId] = field
        end
    end
    return result
end

local function hasOption(arg1, optionId: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    for _, option in arg1.options do
        if option.optionId == optionId then
            return true
        end
    end
    return false
end

local function readCount(arg1)
    if type(arg1) == "number" then
        if arg1 < 0 or arg1 > 9007199254740991 or arg1 % 1 ~= 0 then
            return nil
        end
        return string.format("%.0f", arg1)
    end

    if type(arg1) == "string" and string.match(arg1, "^%d+$") then
        local var1 = string.gsub(arg1, "^0+", "")
        local var2 = if var1 == "" then "0" else var1
        if #var2 < 19 or #var2 == 19 and var2 <= "9223372036854775807" then
            return var2
        end
    end
    return nil
end

return {
    readDefinition = function(arg1)
        if type(arg1) ~= "table" or not (isId(arg1.formId) and isArray(arg1.sections)) then
            return nil
        end

        if not (isOptionalText(arg1.title) and isOptionalText(arg1.description)) then
            return nil
        end
        local sections = {}
        local tbl2 = {}
        local tbl3 = {}
        local num1 = 0
        for _, section in arg1.sections do
            if type(section) ~= "table" or not isId(section.id) or tbl2[section.id] then
                return nil
            end

            if not (isOptionalText(section.header) and isArray(section.fields)) then
                return nil
            end
            tbl2[section.id] = true
            local fields = {}
            for _, field in section.fields do
                if type(field) ~= "table" or not isId(field.fieldId) or tbl3[field.fieldId] then
                    return nil
                end
                local var1 = fieldType(field.fieldType)
                if not var1 then
                    return nil, true
                end

                if not isOptionalText(field.label) or not isArray(field.options) or #field.options == 0 then
                    return nil
                end
                tbl3[field.fieldId] = true
                num1 += 1
                local options = {}
                local tbl6 = {}
                for _, option in field.options do
                    if type(option) ~= "table" or not isId(option.optionId) or tbl6[option.optionId] then
                        return nil
                    end
                    if type(option.label) ~= "string" then
                        return nil
                    end
                    tbl6[option.optionId] = true
                    table.insert(options, { optionId = option.optionId, label = option.label })
                end
                table.insert(fields, { fieldId = field.fieldId, fieldType = var1, label = field.label, options = options })
            end
            table.insert(sections, { id = section.id, header = section.header, fields = fields })
        end

        if num1 == 0 then
            return nil
        end

        return {
            formId = arg1.formId,
            title = arg1.title,
            description = arg1.description,
            sections = sections
        }
    end,
    readResponse = function(arg1, arg2)
        if type(arg1) ~= "table" then
            return nil
        end

        local var1 = listOrEmpty(arg1.answers)
        if not isArray(var1) then
            return nil
        end
        local tbl1 = indexFields(arg2)
        local result = {}
        for _, value in var1 do
            if type(value) ~= "table" or not isId(value.fieldId) or result[value.fieldId] then
                return nil
            end
            local var2 = tbl1[value.fieldId]
            if not var2 or not isArray(value.optionIds) or #value.optionIds == 0 then
                return nil
            end
            if var2.fieldType == "Radio" and #value.optionIds ~= 1 then
                return nil
            end
            local tbl2 = ({})
            for _, optionId in value.optionIds do
                if not isId(optionId) or not hasOption(var2, optionId) or tbl2[optionId] then
                    return nil
                end
                tbl2[optionId] = true
            end
            result[value.fieldId] = tbl2
        end
        return result
    end,
    readResults = function(arg1, arg2)
        if type(arg1) ~= "table" then
            return nil
        end

        local var1 = listOrEmpty(arg1.fieldResults)
        if not isArray(var1) then
            return nil
        end
        local totalResponses = readCount(if arg1.totalResponses == nil then 0 else arg1.totalResponses)
        if not totalResponses then
            return nil
        end
        local tbl1 = indexFields(arg2)
        local tbl2 = {
            totalResponses = totalResponses,
            fields = {}
        }

        for _, value in var1 do
            if type(value) ~= "table" or not isId(value.fieldId) then
                return nil
            end
            local var3 = tbl1[value.fieldId]
            local var4 = listOrEmpty(value.optionResults)
            if not var3 or tbl2.fields[value.fieldId] or not isArray(var4) then
                return nil
            end
            local tbl3 = {}
            for _, value2 in var4 do
                if type(value2) ~= "table" or not (isId(value2.optionId) and hasOption(var3, value2.optionId)) then
                    return nil
                end
                local voteCount = readCount(if value2.voteCount == nil then 0 else value2.voteCount)
                local percentage = if value2.percentage == nil then 0 else value2.percentage
                if not voteCount or tbl3[value2.optionId] or type(percentage) ~= "number" then
                    return nil
                end
                if percentage < 0 or percentage > 100 or percentage % 1 ~= 0 then
                    return nil
                end
                tbl3[value2.optionId] = { voteCount = voteCount, percentage = percentage }
            end
            for _, option in var3.options do
                if not tbl3[option.optionId] then
                    tbl3[option.optionId] = { voteCount = "0", percentage = 0 }
                end
            end
            tbl2.fields[value.fieldId] = tbl3
        end
        return tbl2
    end,
    readErrors = function(arg1, arg2, str1: string)
        local tbl1 = {
            fields = {},
            form = {}
        }

        if arg1 == nil then
            return tbl1
        end

        local var1

        if type(arg1) == "table" then
            local errors = arg1.errors
            var1 = errors == nil and {} or errors
        else
            var1 = nil
        end

        if not isArray(var1) then
            table.insert(tbl1.form, str1)
            return tbl1
        end
        local tbl2 = indexFields(arg2)
        for _, value in var1 do
            local var2 = if type(value) == "table" and type(value.message) == "string" and value.message ~= "" then value.message else str1
            local fieldId = if type(value) == "table" then value.fieldId else nil

            if type(fieldId) == "string" and tbl2[fieldId] then
                local field = tbl1.fields[fieldId] or {}
                table.insert(field, var2)
                tbl1.fields[fieldId] = field
            else
                table.insert(tbl1.form, var2)
            end
        end
        return tbl1
    end
}
