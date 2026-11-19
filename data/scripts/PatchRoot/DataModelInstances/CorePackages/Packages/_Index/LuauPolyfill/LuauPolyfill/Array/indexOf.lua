-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T04:41:20Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _types = require(scriptParentParent.types)

return function(arg1, arg2, num1: number?)
    local num2 = num1 or 1
    local num3 = #arg1

    if num2 < 1 then
        num2 = math.max(num3 - math.abs(num2), 1)
    end

    for i = num2, num3 do
        if arg1[i] == arg2 then
            return i
        end
    end

    return -1
end
