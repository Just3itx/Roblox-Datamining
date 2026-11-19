-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T04:41:27Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local isArray = require(scriptParent.isArray)
local scriptParentParent = scriptParent.Parent
local _types = require(scriptParentParent.types)

return function(tbl1: {any})
    if _G.__DEV__ and not isArray(tbl1) then
        error(string.format("Array.shift called on non-array %s", typeof(tbl1)))
    end

    if #tbl1 > 0 then
        return table.remove(tbl1, 1)
    end
    return nil
end
