-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:40:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local __DEV__ = _G.__DEV__
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local isArray = require(scriptParent.isArray)
local _ES7Types = require(scriptParentParentParent.ES7Types)

return function(tbl1: {any}, ...): number
    if __DEV__ and not isArray(tbl1) then
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
