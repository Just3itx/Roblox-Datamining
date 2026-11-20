-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {
    maxDistance = 5000,
    maxScreenDivisions = 16,
    limit = math.huge
}

local module = {}

function module.new(tbl2)
    local var1 = table.clone(tbl1)
    if tbl2 then
        for value, value2 in tbl2 do
            var1[value] = value2
        end
    end
    return var1
end

return module
