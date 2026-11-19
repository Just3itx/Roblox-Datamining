-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local NaN = require(scriptParentParent.Number).NaN

return function(str1: string, num1: number)
    num1 = if typeof(num1) ~= "number" then 1 else num1

    local var1, var2 = utf8.len(str1)
    local str2 = tostring(var2)
    assert(var1 ~= nil, ("string `%s` has an invalid byte at position %s"):format(str1, str2))
    if var1 < num1 or num1 < 1 then
        return NaN
    end

    local num2 = utf8.offset(str1, num1)
    local var3 = utf8.codepoint(str1, num2, num2)

    return if var3 == nil then NaN else var3
end
