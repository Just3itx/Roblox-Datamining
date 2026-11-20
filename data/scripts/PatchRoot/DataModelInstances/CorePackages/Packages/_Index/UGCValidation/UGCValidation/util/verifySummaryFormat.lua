-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function verifySummaryFormat(arg1, arg2)
    if arg1 == nil or typeof(arg1) ~= "table" then
        return false
    end

    local tbl1 = ({})
    for _, value in arg2 do
        tbl1[value] = true
    end

    for _, value in arg2 do
        if arg1[value] == nil or typeof(arg1[value]) ~= "number" then
            return false
        end
    end

    for value, _ in arg1 do
        if not tbl1[value] then
            return false
        end
    end

    return true
end

return verifySummaryFormat
