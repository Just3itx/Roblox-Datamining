-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:50:58Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function get(tbl1, tbl2, arg1)
    if tbl1 == nil then
        return arg1
    end

    for _, value in tbl2 do
        if type(tbl1) ~= "table" then
            return arg1
        end

        tbl1 = tbl1[value]

        if tbl1 == nil then
            return arg1
        end
    end

    return tbl1
end

return get
