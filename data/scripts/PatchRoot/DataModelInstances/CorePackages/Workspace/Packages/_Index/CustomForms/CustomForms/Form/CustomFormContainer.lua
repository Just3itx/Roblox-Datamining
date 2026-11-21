-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CustomFormsParent = script:FindFirstAncestor("CustomForms").Parent
local React = require(CustomFormsParent.React)

local CustomFormView = require(script.Parent.CustomFormView)
local CustomFormSelection = require(script.Parent.CustomFormSelection)
local useCustomFormViewModel = require(script.Parent.useCustomFormViewModel)

local function CustomFormBody(arg1)
    local var1 = useCustomFormViewModel(arg1)
    return React.createElement(CustomFormView, var1)
end

return React.memo(function(arg1) -- name: CustomFormContainer
    local var1 = table.clone(arg1)

    var1.key = `{CustomFormSelection.draftKey(arg1.definition)}:{arg1.response ~= nil}`
    return React.createElement(CustomFormBody, var1)
end)
