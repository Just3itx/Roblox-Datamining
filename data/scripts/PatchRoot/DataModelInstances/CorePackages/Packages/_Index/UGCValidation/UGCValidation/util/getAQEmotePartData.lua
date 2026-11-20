-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:21:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getAQEmotePartData(tbl1)
    if not tbl1 then
        return nil
    end
    for k, value in pairs(tbl1) do
        if k ~= "measurement_score" and type(value) == "table" then
            return value
        end
    end
    return nil
end

return getAQEmotePartData
