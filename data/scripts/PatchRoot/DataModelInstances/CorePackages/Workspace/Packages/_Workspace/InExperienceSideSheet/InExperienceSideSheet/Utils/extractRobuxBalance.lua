-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:31:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function extractRobuxBalance(arg1)
    if typeof(arg1) == "table" then
        local var1 = arg1.robux or arg1.Robux
        if typeof(var1) == "number" then
            return var1
        end
    end
    return nil
end

return extractRobuxBalance
