-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:50:31Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local _Types = require(scriptParent.Types)

local function collect(tbl1, func1: (...any) -> (...any))
    local result = ({})
    for value, value2 in tbl1 do
        local var1, var2 = func1(value, value2)
        if var1 ~= nil then
            result[var1] = var2
        end
    end
    return result
end

return collect
