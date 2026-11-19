-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:51:19Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local _Types = require(scriptParent.Types)
local assertEqual = require(scriptParent.assertEqual)

local function map(tbl1, func1: (...any) -> (...any))
    local result = ({})
    for value, value2 in tbl1 do
        local var1 = func1(value2, value)
        assertEqual(var1 == nil, false, "Returned nil from a Dash.map handler")
        result[value] = var1
    end
    return result
end

return map
