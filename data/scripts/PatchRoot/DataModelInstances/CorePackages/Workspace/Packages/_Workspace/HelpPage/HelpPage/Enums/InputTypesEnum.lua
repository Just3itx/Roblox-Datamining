-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:20:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local tbl1 = {
    InputType = {
        KEYBOARD = "KEYBOARD",
        GAMEPAD = "GAMEPAD",
        TOUCH = "TOUCH",
        SPATIAL_GAMEPAD = "SPATIAL_GAMEPAD"
    }
}

table.freeze(tbl1.InputType)
table.freeze(tbl1)

return tbl1
