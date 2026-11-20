-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function readAQSummaryNumber(tbl1, str1: string, str2: string, num1: number?, num2: number?): number?
    local var1 = tonumber(tbl1[str1])
    if var1 == nil or var1 ~= var1 then
        local error = error
        local var2 = tbl1[str1]
        error(`{str2}: {str1} is not a number: {tostring(var2)}`)
    end
    if num1 ~= nil and var1 < num1 or num2 ~= nil and num2 < var1 then
        local error = error
        local var2 = tbl1[str1]
        error(`{str2}: {str1} is outside [{num1}, {num2}]: {tostring(var2)}`)
    end
    return var1
end

return readAQSummaryNumber
