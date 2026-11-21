-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:20:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function toPascalCase(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if type(arg1) ~= "string" then
        return tostring(arg1)
    end
    return arg1:gsub("^%l", string.upper)
end

local function convertToPascalCase(tbl1)
    local result = ({})
    for value, value2 in tbl1 do
        if type(value) ~= "string" then
            result[value] = value2
        else
            local var1 = toPascalCase(value)

            if type(value2) == "table" then
                result[var1] = convertToPascalCase(value2)
            else
                result[var1] = value2
            end
        end
    end

    return result
end

return convertToPascalCase
