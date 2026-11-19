-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:21:17Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local module = { CODE_BLOCK_INDENT = 4 }

function module.columnsToNextTabStop(num1: number): number
    return 4 - num1 % 4
end

return module
