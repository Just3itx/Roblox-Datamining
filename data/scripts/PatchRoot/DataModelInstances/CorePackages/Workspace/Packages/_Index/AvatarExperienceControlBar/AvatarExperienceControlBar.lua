-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local _useBaseControlBarProps = require(script.useBaseControlBarProps)

local _ControlBarTypes = require(script.ControlBarTypes)

return {
    Enums = {
        MenuItemEnum = require(script.Enums.MenuItemEnum)
    },
    CustomizeControlBar = require(script.CustomizeControlBarContainer),
    AdvancedCustomizationControlBar = require(script.AdvancedCustomizationControlBarContainer),
    UndoRedoBar = require(script.UndoRedoBar.UndoRedoBarContainer),
    IconOnlyMenu = require(script.Components.IconOnlyMenu),
    MenuItemEnum = require(script.Enums.MenuItemEnum),
    ["jest.config"] = script["jest.config"]
}
