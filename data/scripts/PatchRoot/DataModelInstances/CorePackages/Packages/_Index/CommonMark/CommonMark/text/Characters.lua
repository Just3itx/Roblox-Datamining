-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:41:03Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local UnicodeLetters = require(CommonMark.internal.data.UnicodeLetters)
local UnicodePunctuation = require(CommonMark.internal.data.UnicodePunctuation)
local UnicodeSpaceSeparators = require(CommonMark.internal.data.UnicodeSpaceSeparators)
local Utf8 = require(CommonMark.internal.port.Utf8)

local byte = string.byte
local char = string.char
local find = string.find

local module = {}

function module.find(num1: number, str1: string, num2: number)
    local var1 = find(str1, char(num1), num2 + 1, true)
    return if var1 then var1 - 1 else -1
end

function module.findLineBreak(str1: string, num1: number)
    local var1 = find(str1, "[\n\r]", num1 + 1)
    return if var1 then var1 - 1 else -1
end

function module.isBlank(str1: string): boolean
    return module.skipSpaceTab(str1, 0, #str1) == #str1
end

function module.hasNonSpace(str1: string): boolean
    local num1 = #str1
    return module.skip(32, str1, 0, num1) ~= num1
end

local function isInRanges(tbl1, num1: number)
    local num2 = #tbl1 // 2
    local num3 = 1

    while num3 <= num2 do
        local num4 = (num3 + num2) // 2
        if num1 < tbl1[num4 * 2 - 1] then
            num2 = num4 - 1
        else
            if not (tbl1[num4 * 2] < num1) then
                return true
            end

            num3 = num4 + 1
        end
    end
    return false
end

function module.isLetter(str1: string, num1: number): boolean
    local var1 = Utf8.codePointAt(str1, num1)

    return (isInRanges(UnicodeLetters, var1))
end

function module.isSpaceOrTab(str1: string, num1: number)
    if num1 < #str1 then
        local var1 = byte(str1, num1 + 1)
        if var1 == 32 or var1 == 9 then
            return true
        end
    end
    return false
end

function module.isPunctuationCodePoint(num1: number): boolean
    if isInRanges(UnicodePunctuation, num1) then
        return true
    end

    return num1 == 36
        or num1 == 43
        or num1 == 60
        or num1 == 61
        or num1 == 62
        or num1 == 94
        or num1 == 96
        or num1 == 124
        or num1 == 126
end

function module.isWhitespaceCodePoint(num1: number): boolean
    return num1 == 32 or num1 == 9 or num1 == 10 or num1 == 12 or num1 == 13 or UnicodeSpaceSeparators[num1] == true
end

function module.skip(num1: number, str1: string, num2: number, num3: number)
    for i = num2, num3 - 1 do
        if byte(str1, i + 1) ~= num1 then
            return i
        end
    end
    return num3
end

function module.skipBackwards(num1: number, str1: string, num2: number, num3: number)
    for i = num2, num3, -1 do
        if byte(str1, i + 1) ~= num1 then
            return i
        end
    end
    return num3 - 1
end

function module.skipSpaceTab(str1: string, num1: number, num2: number)
    for i = num1, num2 - 1 do
        local var1 = byte(str1, i + 1)
        if var1 ~= 32 and var1 ~= 9 then
            return i
        end
    end
    return num2
end

function module.skipSpaceTabBackwards(str1: string, num1: number, num2: number)
    for i = num1, num2, -1 do
        local var1 = byte(str1, i + 1)
        if var1 ~= 32 and var1 ~= 9 then
            return i
        end
    end
    return num2 - 1
end

return module
