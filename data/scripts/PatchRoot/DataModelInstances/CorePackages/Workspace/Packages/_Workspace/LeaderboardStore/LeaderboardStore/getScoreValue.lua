-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getScoreValue(arg1)
    return if typeof(arg1) == "boolean" then if arg1 then 1 else 0 else arg1
end

return getScoreValue
