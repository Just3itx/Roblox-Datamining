-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:21:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function isValidStat(arg1)
    return arg1:IsA("StringValue")
        or arg1:IsA("IntValue")
        or arg1:IsA("BoolValue")
        or arg1:IsA("NumberValue")
        or arg1:IsA("DoubleConstrainedValue")
        or arg1:IsA("IntConstrainedValue")
end

return isValidStat
