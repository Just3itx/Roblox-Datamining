-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _types = require(scriptParentParent.types)

return function(arg1)
    local num1 = #arg1
    local num2 = 1

    while num2 < num1 do
        local var1 = arg1[num1]
        local var2 = arg1[num2]
        arg1[num2] = var1
        arg1[num1] = var2
        num2 += 1
        num1 -= 1
    end
    return arg1
end
