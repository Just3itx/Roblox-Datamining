-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:50:34Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local _Types = require(scriptParent.Types)

local function collectSet(tbl1, func1: ((...any) -> (...any))?)
    local result = ({})
    for value, value2 in tbl1 do
        if func1 ~= nil then
            value2 = func1(value, value2)
        end
        if value2 ~= nil then
            result[value2] = true
        end
    end
    return result
end

return collectSet
