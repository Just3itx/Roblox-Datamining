-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:40:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local None = require(scriptParent.None)
local _Types = require(scriptParent.Types)

local function union(tbl1, tbl2)
    local var1 = table.clone(tbl1)

    for value, value2 in tbl2 do
        if value2 == None then
            var1[value] = nil
        else
            var1[value] = value2
        end
    end

    return var1
end

return union
