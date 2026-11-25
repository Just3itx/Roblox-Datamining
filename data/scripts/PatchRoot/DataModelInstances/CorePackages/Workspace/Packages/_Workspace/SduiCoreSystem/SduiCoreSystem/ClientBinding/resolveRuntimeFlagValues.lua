-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:51:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local str1 = game:DefineFastString("SduiRuntimeFlagNames", "")

local var1 = nil
local num1 = 0

local function getNames()
    if var1 ~= nil then
        return var1, num1
    end

    local tbl1 = {}
    local tbl2 = ({})
    for _, value in string.split(str1, ",") do
        local var2 = string.match(value, "^%s*(.-)%s*$") or ""
        if var2 == "" or tbl2[var2] then
            continue
        end
        if #tbl1 >= 16 or #var2 > 128 or string.match(var2, "^[A-Za-z0-9_]+$") == nil then
            num1 += 1
        else
            tbl2[var2] = true
            table.insert(tbl1, var2)
        end
    end

    table.sort(tbl1)
    var1 = tbl1
    return tbl1, num1
end

local function resolveRuntimeFlagValues(func1: (...any) -> (...any))
    local var2, num2 = getNames()
    local tbl1 = ({})
    local num3 = 0
    for _, value in var2 do
        local var3, var4 = func1(value)
        if var3 and type(var4) == "boolean" then
            tbl1[value] = var4
        else
            num3 += 1
        end
    end
    return tbl1, num2, num3
end

return resolveRuntimeFlagValues
