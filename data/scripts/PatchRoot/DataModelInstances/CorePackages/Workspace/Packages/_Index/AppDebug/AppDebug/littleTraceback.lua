-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function littleTraceback(num1: number?)
    local num2 = 1 + (num1 or 5)
    local var1 = debug.traceback()

    local var2 = nil
    local num3 = 1
    for _ = 1, num2 do
        local _, var3 = var1:find("\n", num3, true)
        if not var3 then
            return var1:sub(var2 or 1)
        end
        num3 = var3 + 1
        var2 = var2 or num3
    end

    return var1:sub(var2 or 1, num3 - 1)
end

return littleTraceback
