-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local NaN = require(scriptParentParent.Number).NaN

return function(str1: string, num1: number)
    num1 = if type(num1) ~= "number" then 1 else num1

    local num2 = string.len(str1)
    if num1 < 1 or num2 < num1 then
        return NaN
    end

    local num3 = utf8.offset(str1, num1)

    if num3 == nil or num2 < num3 then
        return NaN
    end

    local var1 = utf8.codepoint(str1, num3, num3)

    return if var1 == nil then NaN else var1
end
