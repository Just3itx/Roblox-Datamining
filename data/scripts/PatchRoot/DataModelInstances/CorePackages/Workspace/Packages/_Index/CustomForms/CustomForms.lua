-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local getSduiCustomFormVerticalRegistry = require(script.Sdui.getSduiCustomFormVerticalRegistry)

local registerCustomForms = require(script.Sdui.registerCustomForms)

return {
    ["jest.config"] = script["jest.config"],
    SduiCustomFormsRegister = require(script.Sdui.SduiCustomFormsRegister),
    registerCustomFormActions = registerCustomForms.registerCustomFormActions,
    registerCustomFormComponents = registerCustomForms.registerCustomFormComponents,
    getSduiCustomFormVerticalRegistry = getSduiCustomFormVerticalRegistry
}
