-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:30:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {}

function tbl1.cloneFrozen(arg1)
    return (table.freeze(table.clone(arg1)))
end

function tbl1.containsEqual(arg1, arg2, tbl2)
    for _, value in tbl2 do
        if arg1[value] ~= arg2[value] then
            return false
        end
    end
    return true
end

function tbl1.optionalContainsEqual(arg1, arg2, tbl2)
    return arg1 == arg2 or not (arg1 == nil or arg2 == nil) and tbl1.containsEqual(arg1, arg2, tbl2)
end

function tbl1.equal(arg1, arg2)
    if arg1 == arg2 then
        return true
    end

    for value, value2 in arg1 do
        if arg2[value] ~= value2 then
            return false
        end
    end
    for value, value2 in arg2 do
        if arg1[value] ~= value2 then
            return false
        end
    end
    return true
end

return table.freeze(tbl1)
