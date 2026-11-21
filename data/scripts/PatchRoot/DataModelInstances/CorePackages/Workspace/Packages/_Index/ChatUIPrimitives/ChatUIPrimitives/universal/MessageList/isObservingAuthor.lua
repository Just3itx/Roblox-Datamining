-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:40:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _Types = require(script.Parent.Parent.Types)

local function isObservingAuthor(arg1, userId: string?): boolean
    return not (arg1 == nil or userId == nil) and arg1.userId == userId
end

return isObservingAuthor
