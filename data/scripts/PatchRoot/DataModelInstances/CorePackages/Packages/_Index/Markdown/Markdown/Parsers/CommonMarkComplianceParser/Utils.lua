-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:30:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Markdown = script:FindFirstAncestor("Markdown")
local Constants = require(Markdown.Parsers.Constants)
local _Types = require(Markdown.Types)

local tbl1 = {
    BOLD = { char = "*", length = 1 },
    BOLD_2 = { char = "*", length = 2 },
    ITALIC = { char = "_", length = 1 },
    ITALIC_2 = { char = "_", length = 2 },
    STRIKE = { char = "~", length = 1 },
    INLINE_CODE = { char = "`", length = 1 }
}

local module = {}

function module.getDelimiterInfo(str1: string)
    return tbl1[str1]
end

function module.causesLineBreak(arg1): boolean
    return arg1.name ~= "TEXT" or string.find(arg1.text, "\n", 0, true) ~= nil
end

function module.getTokenNameFromCharAndLength(arg1, num1: number): string
    if arg1 == "`" then
        return "INLINE_CODE"
    elseif arg1 == "~" then
        return "STRIKE"
    end

    if num1 == 2 then
        if arg1 == "*" then
            return "BOLD_2"
        end

        return "ITALIC_2"
    end

    if arg1 == "*" then
        return "BOLD"
    end

    return "ITALIC"
end

function module.canDelimitersMatch(arg1, arg2): boolean
    if arg1.runLength == 0 or arg2.runLength == 0 then
        return false
    end

    if arg1.canOpen and arg1.canClose or arg2.canOpen and arg2.canClose then
        if arg1.runLength % 3 == 0 and arg2.runLength % 3 == 0 then
            return true
        end

        return (arg1.runLength + arg2.runLength) % 3 ~= 0
    end

    return true
end

function module.addDelimiterMatch(arg1, arg2)
    local matches = arg1.matches or {}
    arg1.matches = matches

    local matchesLen = #matches
    local num1 = matchesLen + 1

    local startIdx = arg2.with.startIdx
    local num2 = 1

    while num2 <= matchesLen do
        local num3 = math.floor((num2 + matchesLen) / 2)
        if startIdx < matches[num3].with.startIdx then
            matchesLen = num3 - 1
        else
            num2 = num3 + 1
            num3 = num1
        end

        num1 = num3
    end

    table.insert(matches, num1, arg2)
end

function module.isWhitespace(str1: string?): boolean
    return not (str1 and #str1 ~= 0)
        or not (str1:match(Constants.ASCII.WHITESPACE_PATTERN) == nil)
        or not not Constants.UNICODE.WHITESPACE[utf8.codepoint(str1)]
end

function module.isPunctuation(str1: string?): boolean
    if not str1 or #str1 == 0 then
        return false
    end

    if str1:match(Constants.ASCII.PUNCTUATION_PATTERN) then
        return true
    end

    local var1 = utf8.codepoint(str1)
    return not not Constants.UNICODE.PUNCTUATION[var1]
end

function module.isLeftFlanking(prevChar: string?, nextChar: string?)
    return not module.isWhitespace(nextChar)
        and (not module.isPunctuation(nextChar) or module.isWhitespace(prevChar) or module.isPunctuation(prevChar))
end

function module.isRightFlanking(prevChar: string?, nextChar: string?)
    return not module.isWhitespace(prevChar)
        and (not module.isPunctuation(prevChar) or module.isWhitespace(nextChar) or module.isPunctuation(nextChar))
end

function module.canOpenEmphasis(arg1)
    return arg1.char == "`"
        or (if module.isLeftFlanking(arg1.prevChar, arg1.nextChar) then not (arg1.char == "_")
            or not module.isRightFlanking(arg1.prevChar, arg1.nextChar)
            or module.isPunctuation(arg1.prevChar) else false)
end

function module.canCloseEmphasis(arg1)
    return arg1.char == "`"
        or (if module.isRightFlanking(arg1.prevChar, arg1.nextChar) then not (arg1.char == "_")
            or not module.isLeftFlanking(arg1.prevChar, arg1.nextChar)
            or module.isPunctuation(arg1.nextChar) else false)
end

function module.getCharacterContext(str1: string, num1: number, num2: number)
    if #str1 == 0 then
        return {}
    end

    local var1 = nil
    local var2 = nil

    if num1 > 1 then
        local num3 = utf8.offset(str1, -1, num1)
        if num3 then
            var1 = utf8.char(utf8.codepoint(str1, num3))
        end
    end

    local num3 = num1 + num2
    if num3 <= #str1 then
        local num4 = utf8.offset(str1, 1, num3)
        if num4 then
            var2 = utf8.char(utf8.codepoint(str1, num4))
        end
    end

    return { prevChar = var1, nextChar = var2 }
end

function module.isInsideInlineCode(tbl2, offset: number, num1: number?)
    local tbl3 = {}
    local var1 = nil
    for i = num1 or #tbl2, 1, -1 do
        local var2 = tbl2[i]
        if var2.offset <= offset then
            break
        end

        if var2.name ~= "INLINE_CODE" then
            continue
        end

        if var1 and var1.offset - 1 == var2.offset then
            var1.length += 1
            var1.offset -= 1
        else
            var1 = {
                offset = var2.offset,
                length = #var2.text
            }
            table.insert(tbl3, 1, var1)
        end
    end

    local num2 = 1
    local bool1 = false

    while true do
        if not (num2 <= #tbl3) then
            return bool1
        end

        local length = tbl3[num2].length
        local var2 = nil
        for i = num2 + 1, #tbl3 do
            if tbl3[i].length == length then
                var2 = i
                break
            end
        end

        if not var2 then
            return true
        end

        num2 = var2 + 1
    end
end
return module
