-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local __DEV__ = _G.__DEV__
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local isArray = require(scriptParent.isArray)
local _ES7Types = require(scriptParentParentParent.ES7Types)

return function(tbl1: {any})
    if __DEV__ and not isArray(tbl1) then
        error(string.format("Array.shift called on non-array %s", typeof(tbl1)))
    end

    if #tbl1 > 0 then
        return table.remove(tbl1, 1)
    end
    return nil
end
