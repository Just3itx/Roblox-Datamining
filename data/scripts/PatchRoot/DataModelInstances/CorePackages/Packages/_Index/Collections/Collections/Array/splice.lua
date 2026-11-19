-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:01:21Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _ES7Types = require(scriptParentParentParent.ES7Types)

return function(tbl1: {any}, num1: number, num2: number?, ...)
    if #tbl1 < num1 then
        local select2 = select

        for i = 1, select2("#", ...) do
            local select = select
            table.insert(tbl1, (select(i, ...)))
        end
        return {}
    end
    local num3 = #tbl1

    if num1 < 1 then
        num1 = math.max(num3 - math.abs(num1), 1)
    end

    local result = {}

    local num4 = num2 or num3
    if num4 > 0 then
        local num5 = num1 + math.max(0, num4 - 1)

        for _ = num1, math.min(num3, num5) do
            table.insert(result, table.remove(tbl1, num1))
        end
    end

    local select2 = select

    for i = select2("#", ...), 1, -1 do
        local select = select
        table.insert(tbl1, num1, (select(i, ...)))
    end

    return result
end
