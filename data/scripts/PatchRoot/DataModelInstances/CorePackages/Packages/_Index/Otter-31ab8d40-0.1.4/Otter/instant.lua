-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T11:30:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function step(arg1, _, _)
    return {
        value = arg1.__targetValue,
        complete = true
    }
end

local function instant(arg1)
    return { __targetValue = arg1, step = step }
end

return instant
