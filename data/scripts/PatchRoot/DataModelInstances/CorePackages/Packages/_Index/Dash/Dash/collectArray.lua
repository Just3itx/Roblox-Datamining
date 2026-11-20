-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local _Types = require(scriptParent.Types)

local insert = table.insert

local function collectArray(tbl1, func1: (...any) -> (...any))
    local result = {}
    for value, value2 in tbl1 do
        local var1 = func1(value, value2)
        if var1 ~= nil then
            insert(result, var1)
        end
    end
    return result
end

return collectArray
