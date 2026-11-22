-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:30:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = ({})

local function isPascalCase(str1: string): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    if tbl1[str1] then
        return true
    end

    if typeof(str1) ~= "string" then
        return false
    end

    local str2 = str1:sub(1, 1)
    local bool1 = str2 == str2:upper()
    if bool1 then
        tbl1[str1] = true
    end
    return bool1
end

local function mapServerBindingProps(tbl2, tbl3)
    local var1 = nil
    local var2 = nil
    for value, value2 in tbl2 do
        local var3 = tbl3[value]
        if var3 ~= nil then
            var1 = var1 or {}
            var1[var3] = value2
        elseif isPascalCase(value) then
            var2 = var2 or {}
            table.insert(var2, value)
        end
    end
    return var1, var2
end

return mapServerBindingProps
