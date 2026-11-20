-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GetTextSize = require(script.Parent.GetTextSize)

local function getWrappedTextWithIcon(arg1, arg2, arg3, arg4, arg5)
    local var1 = GetTextSize("  ", arg2, arg3, Vector2.new(0, 0)) - GetTextSize(" ", arg2, arg3, Vector2.new(0, 0))
    local num1 = math.ceil((arg4 + arg5) / var1.X)
    return string.rep(" ", num1) .. arg1
end

return getWrappedTextWithIcon
