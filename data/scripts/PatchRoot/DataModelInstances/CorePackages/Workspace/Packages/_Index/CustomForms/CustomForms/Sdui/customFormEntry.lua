-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:41:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CustomFormsParent = script:FindFirstAncestor("CustomForms").Parent

local SduiInputDataUpdates = require(CustomFormsParent.SduiSharedUtilities).SduiInputDataUpdates

local function isFormData(arg1, formId: string): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
    local formDefinition = if type(arg1) == "table" then arg1.form_definition else nil
    return type(formDefinition) == "table" and formDefinition.form_id == formId
end

local function isForm(tbl1, formId: string): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return (isFormData(tbl1.custom_form, formId))
end

return {
    isFormData = isFormData,
    findForm = function(str1: string, formId: string)
        local inputData = SduiInputDataUpdates.findInputData(str1, function(arg1): boolean
            return isForm(arg1, formId)
        end)
        return if inputData then inputData.custom_form else nil
    end,
    updateForm = function(str1: string, formId: string, func1: (...any) -> (...any))
        return SduiInputDataUpdates.updateInputDataField(str1, function(arg1): boolean
            return isForm(arg1, formId)
        end, "custom_form", function(arg1)
            local var1 = func1(arg1)
            return if isFormData(var1, formId) then var1 else nil
        end)
    end
}
