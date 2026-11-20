-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function expectedFields(arg1, arg2)
    local tbl1 = ({})
    for _, value in ipairs(arg2) do
        tbl1[value] = true
    end

    for k in pairs(tbl1) do
        assert(arg1[k] ~= nil, string.format("Expected field %q", k))
    end

    for k in pairs(arg1) do
        assert(tbl1[k] ~= nil, string.format("Did not expect field %q", k))
    end
end

return expectedFields
