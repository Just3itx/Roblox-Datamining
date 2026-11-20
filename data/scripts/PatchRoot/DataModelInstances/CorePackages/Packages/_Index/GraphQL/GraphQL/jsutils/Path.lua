-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:51:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local Array = require(scriptParentParentParent.LuauPolyfill).Array

local module = {}

function module.addPath(prev, key, typename: string?)
    return { prev = prev, key = key, typename = typename }
end

function module.pathToArray(tbl1)
    local tbl2 = {}

    while tbl1 do
        table.insert(tbl2, tbl1.key)
        tbl1 = tbl1.prev
    end
    return Array.reverse(tbl2)
end

return module
