-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:50:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.IsPointInRect(arg1, arg2): boolean
    local min = arg1.Min
    local max = arg1.Max
    return arg2.X >= min.X and arg2.Y >= min.Y and arg2.X <= max.X and arg2.Y <= max.Y
end

return module
