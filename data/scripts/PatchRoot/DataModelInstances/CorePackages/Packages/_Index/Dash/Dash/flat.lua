-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:30:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local append = require(scriptParent.append)
local forEach = require(scriptParent.forEach)

local function flat(tbl1)
    local result = {}
    forEach(tbl1, function(tbl2)
        append(result, tbl2)
    end)
    return result
end

return flat
