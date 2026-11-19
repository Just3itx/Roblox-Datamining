-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:20:33Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local FontScales = require(Foundation.Components.Text.FontScales)

return function(num1: number, num2: number, num3: number): number
    if num1 <= 0 or num2 <= 0 then
        return 0
    end

    num3 = if num3 <= 1 then 1 else num3

    num1 = math.floor(num1)

    local var1 = FontScales[Font.fromEnum(Enum.Font.BuilderSans).Family]
    local var2 = if var1 == nil then 0 else (num1 / var1 * (num3 * var1) - num1) / 2

    local num4 = math.ceil((num2 - 1) * num3 * num1)
    local num5 = if var2 >= 1 then math.ceil(var2) else math.floor(var2)
    return num4 + num1 + num5
end
