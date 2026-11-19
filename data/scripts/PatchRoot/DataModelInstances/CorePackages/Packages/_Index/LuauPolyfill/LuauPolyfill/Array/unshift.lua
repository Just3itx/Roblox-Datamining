-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:51:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local isArray = require(scriptParent.isArray)
local scriptParentParent = scriptParent.Parent
local _types = require(scriptParentParent.types)

return function(tbl1: {any}, ...): number
    if _G.__DEV__ and not isArray(tbl1) then
        error(string.format("Array.unshift called on non-array %s", typeof(tbl1)))
    end

    local select2 = select
    local var1 = select2("#", ...)
    if var1 > 0 then
        for i = var1, 1, -1 do
            local select = select
            table.insert(tbl1, 1, (select(i, ...)))
        end
    end

    return #tbl1
end
