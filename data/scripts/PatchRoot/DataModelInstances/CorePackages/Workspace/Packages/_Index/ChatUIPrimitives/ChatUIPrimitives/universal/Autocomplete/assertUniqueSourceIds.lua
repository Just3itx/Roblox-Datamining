-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function assertUniqueSourceIds(tbl1)
    local tbl2 = {}
    for _, value in tbl1 do
        assert(type(value.id) == "string" and value.id ~= "", "Autocomplete source id is required")
        assert(tbl2[value.id] == nil, "Duplicate autocomplete source id: " .. value.id)
        tbl2[value.id] = true
    end
end

return assertUniqueSourceIds
