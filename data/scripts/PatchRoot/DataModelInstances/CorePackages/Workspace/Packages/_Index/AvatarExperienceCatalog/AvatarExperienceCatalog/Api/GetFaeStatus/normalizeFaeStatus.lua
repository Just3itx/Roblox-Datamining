-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:40:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function normalizeFaeStatus(arg1)
    if type(arg1) ~= "table" then
        return nil, `Type table required, got {type(arg1)}.`
    end

    local features = arg1.features
    if type(features) ~= "table" then
        return nil, `features field is required and must be a table, got {type(features)}.`
    end

    local tbl1 = {}
    for _, value in features do
        if type(value) == "table" and type(value.featureName) == "string" and type(value.access) == "string" then
            table.insert(tbl1, { featureName = value.featureName, access = value.access })
        end
    end

    return { features = tbl1 }, nil
end

return normalizeFaeStatus
