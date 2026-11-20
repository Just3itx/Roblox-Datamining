-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
local tbl1 = { Enum.KeyCode.Return, Enum.KeyCode.KeypadEnter, Enum.KeyCode.ButtonA }

return {
    enter = tbl1,
    exit = { Enum.KeyCode.Backspace, Enum.KeyCode.ButtonB },
    stepIncrement = {
        horizontal = { Enum.KeyCode.Right, Enum.KeyCode.DPadRight },
        vertical = { Enum.KeyCode.Up, Enum.KeyCode.DPadUp }
    },
    stepDecrement = {
        horizontal = { Enum.KeyCode.Left, Enum.KeyCode.DPadLeft },
        vertical = { Enum.KeyCode.Down, Enum.KeyCode.DPadDown }
    },
    thumbSwitch = tbl1,
    coarseIncrement = { Enum.KeyCode.ButtonR1 },
    coarseDecrement = { Enum.KeyCode.ButtonL1 },
    analogStep = { Enum.KeyCode.Thumbstick1 },
    thumbstickDeadzone = 0.8
}
