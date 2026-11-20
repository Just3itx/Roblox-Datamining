-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:01:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local CaseFolding = require(CommonMark.internal.data.CaseFolding)
local Html5Entities = require(CommonMark.internal.util.Html5Entities)
local Utf8 = require(CommonMark.internal.port.Utf8)

local byte = string.byte
local find = string.find
local gsub = string.gsub
local sub = string.sub

local module = { ESCAPABLE = "[!\"#$%%&'()*+,./:;<=>?@%[\\%]^_`{|}~%-]" }

local str1 = "^\\" .. module.ESCAPABLE

local function findPattern(str2: string, str3: string, num1: number) -- Luacid: Inlined by compiler; 5 call sites recovered
    local var1 = find(str2, str3, num1 + 1)
    return if var1 then var1 - 1 else -1
end

local function matchEntity(str2: string, num1: number)
    local num2 = num1 + 1
    local _, var1 = find(str2, "^#[Xx][0-9A-Fa-f]*;", num2 + 1)
    if var1 ~= nil then
        local var2 = var1 - num2 - 3
        return if var2 >= 1 and var2 <= 6 then var1 else nil
    end
    local _, var2 = find(str2, "^#[0-9]*;", num2 + 1)
    if var2 ~= nil then
        local var3 = var2 - num2 - 2
        return if var3 >= 1 and var3 <= 7 then var2 else nil
    end
    local _, var3 = find(str2, "^[A-Za-z][A-Za-z0-9]*;", num2 + 1)
    if var3 == nil then
        return nil
    end

    local var4 = var3 - num2 - 2
    return if var4 >= 1 and var4 <= 31 then var3 else nil
end

local function findEntityOrEscapedChar(str2: string, num1: number)
    local pattern = findPattern(str2, "[\\&]", num1)

    while pattern ~= -1 do
        local var1 = pattern + 1
        local var2

        if byte(str2, var1) == 92 then
            local _
            _, var2 = find(str2, str1, pattern + 1)
        else
            var2 = matchEntity(str2, pattern)
        end
        if var2 ~= nil then
            return pattern, var2
        end
        pattern = findPattern(str2, "[\\&]", pattern + 1)
    end
    return -1, -1
end

local function encodedLength(num1: number): number -- Luacid: Inlined by compiler; 2 call sites recovered
    return if num1 < 128 then 1 elseif num1 < 2048 then 2 elseif num1 < 65536 then 3 else 4
end

local function findEscapeInUri(str2: string, num1: number)
    local pattern = findPattern(str2, "[^:/?#@!$&'()*+,;=A-Za-z0-9%-._~]", num1)

    if pattern == -1 then
        return -1, -1
    end
    if byte(str2, pattern + 1) ~= 37 then
        return pattern, pattern + encodedLength((Utf8.codePointAt(str2, pattern)))
    end

    local _, var1 = find(str2, "^[0-9A-Fa-f]?[0-9A-Fa-f]?", pattern + 2)
    return pattern, var1
end

local tbl1 = {
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "A",
    "B",
    "C",
    "D",
    "E",
    "F"
}

local function func1(arg1)
    if byte(arg1, 1) ~= 92 then
        return Html5Entities.entityToString(arg1)
    end

    return (sub(arg1, 2, #arg1))
end

local function func2(arg1)
    if byte(arg1, 1) == 37 then
        if #arg1 == 3 then
            return arg1
        end

        return "%25" .. sub(arg1, 2, #arg1)
    end

    local tbl2 = ({})
    for i = 1, #arg1 do
        local var1 = byte(arg1, i)
        tbl2[i] = "%" .. tbl1[var1 // 16 + 1] .. tbl1[var1 % 16 + 1]
    end
    return table.concat(tbl2)
end

local tbl2 = { ["&"] = "&amp;", ["<"] = "&lt;", [">"] = "&gt;", ["\""] = "&quot;" }

function module.escapeHtml(str2: string)
    if find(str2, "[&<>\"]") == nil then
        return str2
    end
    return (gsub(str2, "[&<>\"]", tbl2))
end

local function replaceAll(func3: (...any) -> (...any), str2: string, func4: (...any) -> (...any)): string
    local var1, var2 = func3(str2, 0)

    if var1 == -1 then
        return str2
    end

    local num1 = 0
    local num2 = 0
    local tbl3 = ({})

    while true do
        local num3 = num1 + 1
        tbl3[num3] = sub(str2, num2 + 1, var1)
        num1 = num3 + 1
        local var3 = var1 + 1
        tbl3[num1] = func4((sub(str2, var3, var2)))
        local var4
        var1, var4 = func3(str2, var2)
        if var1 == -1 then
            break
        end

        num2 = var2
        var2 = var4
    end
    if var2 ~= #str2 then
        local num3 = num1 + 1
        tbl3[num3] = sub(str2, var2 + 1, #str2)
    end
    return table.concat(tbl3)
end

function module.unescapeString(str2: string)
    if find(str2, "[\\&]") ~= nil then
        return replaceAll(findEntityOrEscapedChar, str2, func1)
    end
    return str2
end

function module.percentEncodeUrl(str2: string): string
    return replaceAll(findEscapeInUri, str2, func2)
end

local function trim(str2: string)
    local num1 = #str2
    local num2 = 0

    while num2 < num1 do
        if not (byte(str2, num2 + 1) <= 32) then
            break
        end

        num2 += 1
    end

    while num2 < num1 do
        if not (byte(str2, num1 - 1 + 1) <= 32) then
            break
        end

        num1 -= 1
    end
    return (sub(str2, num2 + 1, num1))
end

local function caseFold(str2: string): string
    local pattern = findPattern(str2, "[A-Z\128-\255]", 0)

    if pattern == -1 then
        return str2
    end

    local num1 = 0
    local num2 = 0
    local tbl3 = ({})

    while pattern ~= -1 do
        local var1 = Utf8.codePointAt(str2, pattern)
        local num3 = encodedLength(var1)
        local var2 = CaseFolding[var1]
        if var2 ~= nil then
            local num4 = num1 + 1
            tbl3[num4] = sub(str2, num2 + 1, pattern)
            num1 = num4 + 1
            tbl3[num1] = var2
            num2 = pattern + num3
        end
        pattern = findPattern(str2, "[A-Z\128-\255]", pattern + num3)
    end
    local num3 = num1 + 1
    tbl3[num3] = sub(str2, num2 + 1, #str2)
    return table.concat(tbl3)
end

function module.normalizeLabelContent(str2: string)
    local var1 = trim(str2)

    local str3 = caseFold(var1)

    return (gsub(str3, "[ \t\r\n]+", " "))
end

module._findEntityOrEscapedChar = findEntityOrEscapedChar
module._findEscapeInUri = findEscapeInUri

return module
