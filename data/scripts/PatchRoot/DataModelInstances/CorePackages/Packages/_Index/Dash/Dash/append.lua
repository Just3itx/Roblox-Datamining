-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:41:12Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local None = require(scriptParent.None)
local forEachArgs = require(scriptParent.forEachArgs)
local forEach = require(scriptParent.forEach)
local insert = table.insert

local function append<T>(tbl1, ...): T
    forEachArgs(function(tbl2)
        if tbl2 == None or tbl2 == nil then
            return
        end
        forEach(tbl2, function(arg1)
            insert(tbl1, arg1)
        end)
    end, ...)

    return tbl1
end

return append
