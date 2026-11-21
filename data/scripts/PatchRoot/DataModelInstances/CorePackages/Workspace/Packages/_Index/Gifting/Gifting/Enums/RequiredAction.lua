-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:30:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = { Unknown = "Unknown", PlusMembershipRequired = "PlusMembershipRequired" }

local tbl1 = ({})
for _, value in pairs(module) do
    tbl1[value] = true
end

function module.fromValue(str1: string?): string?
    return if str1 == nil or not tbl1[str1] then nil else str1
end

function module.fromValues(tbl2)
    if type(tbl2) ~= "table" then
        return nil
    end

    local values = {}
    for _, value in tbl2 do
        local value2 = module.fromValue(value)
        if value2 == nil then
            return nil
        end
        table.insert(values, value2)
    end
    return values
end

return module
