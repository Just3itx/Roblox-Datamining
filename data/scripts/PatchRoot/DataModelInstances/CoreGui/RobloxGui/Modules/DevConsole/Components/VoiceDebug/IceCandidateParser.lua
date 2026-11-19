-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:50:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = { candidateType = nil, protocol = nil, priority = nil, component = nil }

local function parseIceCandidate(str1: string?)
    if str1 == nil or str1 == "" then
        return tbl1
    end

    local tbl2 = {}
    for value in string.gmatch(str1, "%S+") do
        table.insert(tbl2, value)
    end

    local var1 = nil
    for value, value2 in tbl2 do
        if value2 == "typ" then
            var1 = tbl2[value + 1]
            break
        end
    end

    if var1 == nil then
        return tbl1
    end

    return {
        candidateType = var1,
        protocol = tbl2[3],
        priority = tbl2[4],
        component = tbl2[2]
    }
end

return parseIceCandidate
