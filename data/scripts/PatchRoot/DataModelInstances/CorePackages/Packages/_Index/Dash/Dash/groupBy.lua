-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:51:00Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local _Types = require(scriptParent.Types)

local insert = table.insert

local function groupBy(tbl1, arg1)
    local result = ({})
    for value, value2 in tbl1 do
        local var1 = if typeof(arg1) == "function" then arg1(value2, value) else value2[arg1]

        if var1 == nil then
            continue
        end

        if result[var1] ~= nil then
            insert(result[var1], value2)
        else
            result[var1] = { value2 }
        end
    end

    return result
end

return groupBy
