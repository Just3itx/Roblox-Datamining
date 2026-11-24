-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:11:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getFacePileParticipantIds(tbl1, num1: number)
    if #tbl1 <= 1 then
        return { num1 }
    end

    local tbl2 = {}
    for _, value in tbl1 do
        if value ~= num1 then
            table.insert(tbl2, value)
        end
    end

    return if #tbl2 == 0 then { num1 } else tbl2
end

return getFacePileParticipantIds
