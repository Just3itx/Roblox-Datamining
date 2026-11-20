-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:30:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local formatValue = require(scriptParent.formatValue)
local splitOn = require(scriptParent.splitOn)
local startsWith = require(scriptParent.startsWith)

local concat = table.concat
local insert = table.insert

local function format(str1: string, ...)
    local tbl1 = { ... }
    local num1 = 1
    local var1, var2 = splitOn(str1, "{[^{}]*}")
    local tbl2 = {}

    for value, value2 in var1 do
        insert(tbl2, (value2:gsub("{{", "{"):gsub("}}", "}")))
        local var3 = var2[value] and var2[value]:sub(2, -2)
        if not var3 then
            continue
        end
        local var4 = value2:gmatch("{+$")()
        if not var4 or #var4 % 2 ~= 1 then
            local var5 = splitOn(var3, ":")
            local var6 = startsWith(var5[1], "#")
            local var7 = var6 and var5[1]:sub(2) or var5[1]
            local var8 = tonumber(var7)
            local var9 = var5[2]
            local str2 = "nil"
            if var8 then
                str2 = tbl1[var8]
            elseif var7:len() > 0 then
                local var10 = tbl1[1] and tbl1[1][var7]
                if var10 ~= nil then
                    str2 = var10
                end
            else
                str2 = tbl1[num1]
                num1 += 1
            end
            local var10 = var6 and #str2 or str2

            insert(tbl2, formatValue(var10, var9 or ""))
        else
            insert(tbl2, var3)
        end
    end

    return concat(tbl2, "")
end

return format
