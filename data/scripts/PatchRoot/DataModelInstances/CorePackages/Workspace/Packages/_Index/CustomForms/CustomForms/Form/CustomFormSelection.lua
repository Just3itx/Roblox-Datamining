-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:41:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return {
    selectOption = function(tbl1, tbl2, str1: string)
        local var1 = table.clone(tbl1)
        local var2 = tbl2.fieldType == "Radio" and {} or table.clone(tbl1[tbl2.fieldId] or {})
        var2[str1] = tbl2.fieldType == "Radio" or not var2[str1]
        var1[tbl2.fieldId] = var2
        return var1
    end,
    buildResponse = function(tbl1, tbl2)
        local answers = {}
        local tbl4 = {}
        for _, section in tbl1.sections do
            for _, field in section.fields do
                local optionIds = {}
                for _, option in field.options do
                    if (tbl2[field.fieldId] or {})[option.optionId] then
                        table.insert(optionIds, option.optionId)
                    end
                end
                if #optionIds == 0 or field.fieldType == "Radio" and #optionIds ~= 1 then
                    table.insert(tbl4, field.fieldId)
                end
                table.insert(answers, { fieldId = field.fieldId, optionIds = optionIds })
            end
        end
        return #tbl4 == 0 and { answers = answers } or nil, tbl4
    end,
    draftKey = function(tbl1): string
        local tbl2 = {}
        local function append(str1: string) -- Luacid: Inlined by compiler; 8 call sites recovered
            table.insert(tbl2, `{#str1}:{str1}`)
        end
        append(tbl1.formId)
        append(tostring(#tbl1.sections))
        for _, section in tbl1.sections do
            append(section.id)
            append(tostring(#section.fields))
            for _, field in section.fields do
                append(field.fieldId)
                append(field.fieldType)
                append(tostring(#field.options))
                for _, option in field.options do
                    append(option.optionId)
                end
            end
        end
        return table.concat(tbl2, ":")
    end
}
