-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:31:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function isLayeredClothing(arg1)
    return arg1:FindFirstChildWhichIsA("WrapLayer", true)
end

return isLayeredClothing
