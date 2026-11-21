-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CustomForms = script:FindFirstAncestor("CustomForms")
local CustomFormsParent = CustomForms.Parent
local React = require(CustomFormsParent.React)

local registerCustomForms = require(CustomForms.Sdui.registerCustomForms).registerCustomForms

return React.memo(function() -- name: SduiCustomFormsRegister
    React.useEffect(function()
        registerCustomForms()
    end, {})
    return nil
end)
