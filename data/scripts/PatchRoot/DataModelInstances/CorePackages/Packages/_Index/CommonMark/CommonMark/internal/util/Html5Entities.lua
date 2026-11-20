-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local HtmlEntities = require(CommonMark.internal.data.HtmlEntities)

local byte = string.byte
local find = string.find
local sub = string.sub

local function parseInt(str1: string, num1: number)
    local var1 = byte(str1, 1)
    local bool1 = var1 == 45
    if bool1 or var1 == 43 then
        str1 = sub(str1, 2)
    end

    if find(str1, if num1 == 16 then "^[0-9A-Fa-f]+$" else "^[0-9]+$") == nil then
        return nil
    end
    local var2 = find(str1, "[^0]")
    local var3 = if var2 then sub(str1, var2) else ""

    if #var3 > 10 then
        return nil
    end
    local num2 = tonumber(var3, num1) or 0
    if bool1 then
        num2 = -num2
    end

    return if num2 < -2147483648 or num2 > 2147483647 then nil else num2
end

local module = {}

function module.entityToString(str1: string)
    if byte(str1, 1) ~= 38 or byte(str1, #str1) ~= 59 then
        return str1
    end

    local var1 = sub(str1, 2, #str1 - 1)
    if byte(var1, 1) ~= 35 then
        local var2 = HtmlEntities[var1]
        return if var2 == nil then str1 else var2
    end

    local var2 = sub(var1, 2)

    local var3 = byte(var2, 1)
    local num1

    if var3 == 120 or var3 == 88 then
        var2 = sub(var2, 2)
        num1 = 16
    else
        num1 = 10
    end

    local var4 = parseInt(var2, num1)
    if var4 == 0 or var4 == nil or var4 < 0 or var4 > 1114111 or var4 >= 55296 and var4 <= 57343 then
        return "�"
    end

    return utf8.char(var4)
end

return module
