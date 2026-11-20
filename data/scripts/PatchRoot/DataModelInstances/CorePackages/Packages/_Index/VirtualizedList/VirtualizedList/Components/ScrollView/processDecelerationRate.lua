-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function processDecelerationRate(arg1)
    return if arg1 == "normal" then 0.985 elseif arg1 == "fast" then 0.9 else arg1
end

return processDecelerationRate
