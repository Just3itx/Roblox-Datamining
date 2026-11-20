-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = ({})

local function prettyPrintVector3(vec1: vector, num1: number?): string
    local num2 = num1 or 2
    if not tbl1[num2] then
        local str1 = string.format("%%.%df", num2)
        tbl1[num2] = string.format("%s, %s, %s", str1, str1, str1)
    end
    return string.format(tbl1[num2], vec1.X, vec1.Y, vec1.Z)
end

return prettyPrintVector3
