-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local trimStart = require(script.Parent.trimStart)
local trimEnd = require(script.Parent.trimEnd)

return function(str1: string)
    return trimStart(trimEnd(str1))
end
