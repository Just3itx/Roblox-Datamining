-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local FocusNavigationEventNameEnum = require(script.Parent.FocusNavigationEventNameEnum)

return {
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.Escape] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.ButtonY] = FocusNavigationEventNameEnum.Search,
    [Enum.KeyCode.Slash] = FocusNavigationEventNameEnum.Search,
    [Enum.KeyCode.PageUp] = FocusNavigationEventNameEnum.ScrollUp,
    [Enum.KeyCode.LeftBracket] = FocusNavigationEventNameEnum.ScrollUp,
    [Enum.KeyCode.PageDown] = FocusNavigationEventNameEnum.ScrollDown,
    [Enum.KeyCode.RightBracket] = FocusNavigationEventNameEnum.ScrollDown
}
