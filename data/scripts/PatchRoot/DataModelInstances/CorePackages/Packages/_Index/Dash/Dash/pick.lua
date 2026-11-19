-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:00:49Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local _Types = require(scriptParent.Types)

local function pick(tbl1, func1: (...any) -> (...any))
    local result = ({})
    for value, value2 in tbl1 do
        if func1(value2, value) then
            result[value] = value2
        end
    end
    return result
end

return pick
