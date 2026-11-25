-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:00:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local useCoreActionBind = require(script.Parent.useCoreActionBind)
local SelectionInputs = require(script.Parent.SelectionInputs)

local function useSelectionActivateAction(tbl1)
    useCoreActionBind({
        enabled = tbl1.enabled,
        active = tbl1.active,
        actionNamePrefix = tbl1.actionNamePrefix,
        inputs = SelectionInputs.Activate,
        onAction = tbl1.onAction,
        shouldBind = tbl1.shouldBind,
        rebindSignal = tbl1.rebindSignal,
        contextActionService = tbl1.contextActionService
    })
end

return useSelectionActivateAction
