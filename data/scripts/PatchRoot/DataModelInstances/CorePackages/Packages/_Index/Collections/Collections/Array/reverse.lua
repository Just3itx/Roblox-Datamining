-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:01:15Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _ES7Types = require(scriptParentParentParent.ES7Types)

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
