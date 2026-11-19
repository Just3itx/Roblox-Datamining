-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:01:13Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local _Types = require(scriptParent.Types)
local insert = table.insert

local function values(tbl1)
    local result = {}
    for _, value in tbl1 do
        insert(result, value)
    end
    return result
end

return values
