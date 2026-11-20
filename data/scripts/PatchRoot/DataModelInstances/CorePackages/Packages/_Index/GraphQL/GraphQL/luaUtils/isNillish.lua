-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:00:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local null = require(script.Parent.null)

return {
    isNillish = function(arg1): boolean
        return arg1 == nil or arg1 == null
    end,
    isNotNillish = function(arg1): boolean
        return not (arg1 == nil) and arg1 ~= null
    end
}
