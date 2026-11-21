-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:41:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _CustomFormContainer = require(script.Parent.CustomFormContainer)

local function sampleProps()
    return {
        definition = {
            formId = "form_001",
            title = "Choose a session",
            sections = {{
                id = "section_01",
                header = "Your choices",
                fields = {
                    {
                        fieldId = "field_radio",
                        fieldType = "Radio",
                        label = "When?",
                        options = {
                            { optionId = "option_am", label = "Morning" },
                            { optionId = "option_pm", label = "Afternoon" }
                        }
                    },
                    {
                        fieldId = "field_checkbox",
                        fieldType = "Checkbox",
                        label = "Which topics?",
                        options = {
                            { optionId = "option_build", label = "Building" },
                            { optionId = "option_code", label = "Coding" }
                        }
                    }
                }
            }}
        },
        isEditable = true,
        submitLabel = "Submit",
        requiredErrorMessage = "Choose an option",
        submissionErrorMessage = "Could not submit",
        disabledMessage = "You cannot submit this form",
        layoutOrder = 1,
        testId = "custom-form"
    }
end

return sampleProps
