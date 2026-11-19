-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:51:04Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function isCallable(arg1): boolean
    return not not (type(arg1) == "function" or type(arg1) == "table" and getmetatable(arg1) and getmetatable(arg1).__call ~= nil)
end

return isCallable
