-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:41:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local num1 = 1
local var1 = (setmetatable({}, { __mode = "k" }))

local function idFor(arg1)
    if arg1 == nil then
        return 0
    end
    local var2 = var1[arg1]
    if not var2 then
        var2 = num1
        num1 += 1
        var1[arg1] = var2
    end
    return var2
end

return idFor
