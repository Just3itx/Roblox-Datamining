-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:01:17Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _ES7Types = require(scriptParentParentParent.ES7Types)

return function(arg1, num1: number?, num2: number?)
    if typeof(arg1) ~= "table" then
        error(string.format("Array.slice called on %s", typeof(arg1)))
    end
    local num3 = #arg1

    local num4 = num1 or 1

    if num2 == nil or num3 + 1 < num2 then
        num2 = num3 + 1
    end

    if num3 + 1 < num4 then
        return {}
    end

    local result = ({})

    if num4 < 1 then
        num4 = math.max(num3 - math.abs(num4), 1)
    end
    if num2 < 1 then
        num2 = math.max(num3 - math.abs(num2), 1)
    end

    local num5 = 1

    while num4 < num2 do
        result[num5] = arg1[num4]
        num4 += 1
        num5 += 1
    end

    return result
end
