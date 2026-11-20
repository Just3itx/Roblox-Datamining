-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:00:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Number = LuauPolyfill.Number
local String = LuauPolyfill.String
local isNaN = Number.isNaN
local HttpService = game:GetService("HttpService")

local syntaxError = require(scriptParentParent.error.syntaxError).syntaxError
local _source = require(script.Parent.source)

local tokenKind = require(scriptParent.tokenKind)

local Token = require(scriptParent.ast).Token
local TokenKind = tokenKind.TokenKind

local toUnicodeString = require(scriptParentParent.luaUtils.toUnicodeString)
local dedentBlockStringValue = require(scriptParent.blockString).dedentBlockStringValue

local readBlockString = nil
local readString = nil

local char2hex = nil

local function uniCharCode(arg1, arg2, arg3, arg4): number
    local var1 = char2hex(arg1)
    local var2 = char2hex(arg2)
    local var3 = char2hex(arg3)
    local var4 = char2hex(arg4)

    if var1 < 0 or var2 < 0 or var3 < 0 or var4 < 0 then
        return -1
    end
    return bit32.bor(bit32.lshift(var1, 12), bit32.lshift(var2, 8), bit32.lshift(var3, 4), var4)
end

char2hex = function(arg1)
    if arg1 >= 48 and arg1 <= 57 then
        return arg1 - 48
    end

    if arg1 >= 65 and arg1 <= 70 then
        return arg1 - 55
    end

    if arg1 >= 97 and arg1 <= 102 then
        return arg1 - 87
    end

    return -1
end

local function readName(source, num1: number, line: number, num2: number, arg1)
    local body = source.body
    local num3 = string.len(body)
    local num4 = num1 + 1
    local num5 = 0

    local function _(): boolean -- Luacid: unused: defined but never referenced
        return num4 ~= num3 + 1
    end
    local function _(): boolean -- Luacid: unused: defined but never referenced
        num5 = String.charCodeAt(body, num4)
        return not isNaN(num5)
    end
    local function func1(): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
        return num5 == 95
    end
    local function func2(): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
        return num5 >= 48 and num5 <= 57
    end
    local function func3(): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
        return num5 >= 65 and num5 <= 90
    end
    local function func4(): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
        return num5 >= 97 and num5 <= 122
    end
    local function func5(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
        return not not func1() or func2() or func3() or func4()
    end

    while true do
        local num6 = num3 + 1

        if num4 == num6 then
            break
        end

        num5 = String.charCodeAt(body, num4)
        if isNaN(num5) or not func5() then
            break
        end

        num4 += 1
    end

    return Token.new(TokenKind.NAME, num1, num4, line, num2, arg1, String.slice(body, num1, num4))
end

local function readComment(source, num1: number, line: number, num2: number, arg1)
    local body = source.body
    local num3 = num1

    repeat
        num1 += 1
        local var1 = String.charCodeAt(body, num1)
    until isNaN(var1) or not (var1 > 31) and var1 ~= 9

    return Token.new(TokenKind.COMMENT, num3, num1, line, num2, arg1, String.slice(body, num3 + 1, num1))
end

function printCharCode(num1: number)
    if isNaN(num1) then
        return TokenKind.EOF
    elseif num1 < 127 then
        return HttpService:JSONEncode(string.char(num1))
    end

    return toUnicodeString(num1)
end

function readDigits(source, num1: number, num2: number)
    local body = source.body

    if not (num2 >= 48 and num2 <= 57) then
        error(syntaxError(source, num1, "Invalid number, expected digit but got: " .. printCharCode(num2) .. "."))
        return
    end

    repeat
        num1 += 1
        local var1 = String.charCodeAt(body, num1)
    until not (var1 >= 48 and var1 <= 57)
    return num1
end

function unexpectedCharacterMessage(num1: number)
    if num1 < 32 and num1 ~= 9 and num1 ~= 10 and num1 ~= 13 then
        return "Cannot contain the invalid character " .. printCharCode(num1) .. "."
    end

    if num1 == 39 then
        return "Unexpected single quote character ('), did you mean to use a double quote (\")?"
    end

    return "Cannot parse the unexpected character " .. printCharCode(num1) .. "."
end

function isNameStart(num1: number): boolean
    local bool1 = num1 == 95
    local bool2 = num1 >= 65 and num1 <= 90
    local bool3 = num1 >= 97 and num1 <= 122
    return bool1 or bool2 or bool3
end

function readNumber(source, num1: number, num2: number, line: number, num3: number, arg1)
    local body = source.body

    local bool1 = false
    local num4

    if num2 == 45 then
        num4 = num1 + 1
        num2 = String.charCodeAt(body, num4)
    else
        num4 = num1
    end

    local num5, var1

    if num2 == 48 then
        num5 = num4 + 1
        var1 = String.charCodeAt(body, num5)
        if var1 >= 48 and var1 <= 57 then
            error(syntaxError(source, num5, "Invalid number, unexpected digit after 0: " .. printCharCode(var1) .. "."))
        end
    else
        num5 = readDigits(source, num4, num2)
        var1 = String.charCodeAt(body, num5)
    end

    if var1 == 46 then
        local var2 = num5 + 1
        local var3 = String.charCodeAt(body, var2)
        num5 = readDigits(source, var2, var3)

        var1 = String.charCodeAt(body, num5)
        bool1 = true
    end

    if var1 == 69 or var1 == 101 then
        bool1 = true

        local var2 = num5 + 1
        local var3 = String.charCodeAt(body, var2)
        if var3 == 43 or var3 == 45 then
            var2 += 1
            var3 = String.charCodeAt(body, var2)
        end
        num5 = readDigits(source, var2, var3)
        var1 = String.charCodeAt(body, num5)
    end

    if var1 == 46 or isNameStart(var1) then
        error(syntaxError(source, num5, "Invalid number, expected digit but got: " .. printCharCode(var1) .. "."))
    end

    return Token.new(bool1 and TokenKind.FLOAT or TokenKind.INT, num1, num5, line, num3, arg1, String.slice(body, num1, num5))
end

local function readToken(tbl1, arg1)
    local source = tbl1.source
    local body = source.body
    local var1 = utf8.len(body)

    assert(var1 ~= nil, "invalid utf8 supplied for token")

    local _end = arg1._end

    while _end <= var1 do
        local var2 = String.charCodeAt(body, _end)

        local line = tbl1.line
        local var3 = _end - tbl1.lineStart

        if var2 == 65279 or var2 == 9 or var2 == 32 or var2 == 44 then
            _end += 1
        elseif var2 == 10 then
            _end += 1
            tbl1.line += 1
            tbl1.lineStart = _end - 1
        elseif var2 == 13 then
            if String.charCodeAt(body, _end + 1) == 10 then
                _end += 2
            else
                _end += 1
            end
            tbl1.line += 1
            tbl1.lineStart = _end - 1
        else
            if var2 == 33 then
                return Token.new(TokenKind.BANG, _end, _end + 1, line, var3, arg1)
            elseif var2 == 35 then
                return readComment(source, _end, line, var3, arg1)
            elseif var2 == 36 then
                return Token.new(TokenKind.DOLLAR, _end, _end + 1, line, var3, arg1)
            elseif var2 == 38 then
                return Token.new(TokenKind.AMP, _end, _end + 1, line, var3, arg1)
            elseif var2 == 40 then
                return Token.new(TokenKind.PAREN_L, _end, _end + 1, line, var3, arg1)
            elseif var2 == 41 then
                return Token.new(TokenKind.PAREN_R, _end, _end + 1, line, var3, arg1)
            end

            if var2 == 46 then
                if String.charCodeAt(body, _end + 1) == 46 and String.charCodeAt(body, _end + 2) == 46 then
                    return Token.new(TokenKind.SPREAD, _end, _end + 3, line, var3, arg1)
                end
            else
                if var2 == 58 then
                    return Token.new(TokenKind.COLON, _end, _end + 1, line, var3, arg1)
                elseif var2 == 61 then
                    return Token.new(TokenKind.EQUALS, _end, _end + 1, line, var3, arg1)
                elseif var2 == 64 then
                    return Token.new(TokenKind.AT, _end, _end + 1, line, var3, arg1)
                elseif var2 == 91 then
                    return Token.new(TokenKind.BRACKET_L, _end, _end + 1, line, var3, arg1)
                elseif var2 == 93 then
                    return Token.new(TokenKind.BRACKET_R, _end, _end + 1, line, var3, arg1)
                elseif var2 == 123 then
                    return Token.new(TokenKind.BRACE_L, _end, _end + 1, line, var3, arg1)
                elseif var2 == 124 then
                    return Token.new(TokenKind.PIPE, _end, _end + 1, line, var3, arg1)
                elseif var2 == 125 then
                    return Token.new(TokenKind.BRACE_R, _end, _end + 1, line, var3, arg1)
                elseif var2 == 34 then
                    if String.charCodeAt(body, _end + 1) == 34 and String.charCodeAt(body, _end + 2) == 34 then
                        return readBlockString(source, _end, line, var3, arg1, tbl1)
                    end
                    return readString(source, _end, line, var3, arg1)
                end

                if var2 == 45
                    or var2 == 48
                    or var2 == 49
                    or var2 == 50
                    or var2 == 51
                    or var2 == 52
                    or var2 == 53
                    or var2 == 54
                    or var2 == 55
                    or var2 == 56
                    or var2 == 57
                then
                    return readNumber(source, _end, var2, line, var3, arg1)
                end

                if var2 == 65
                    or var2 == 66
                    or var2 == 67
                    or var2 == 68
                    or var2 == 69
                    or var2 == 70
                    or var2 == 71
                    or var2 == 72
                    or var2 == 73
                    or var2 == 74
                    or var2 == 75
                    or var2 == 76
                    or var2 == 77
                    or var2 == 78
                    or var2 == 79
                    or var2 == 80
                    or var2 == 81
                    or var2 == 82
                    or var2 == 83
                    or var2 == 84
                    or var2 == 85
                    or var2 == 86
                    or var2 == 87
                    or var2 == 88
                    or var2 == 89
                    or var2 == 90
                    or var2 == 95
                    or var2 == 97
                    or var2 == 98
                    or var2 == 99
                    or var2 == 100
                    or var2 == 101
                    or var2 == 102
                    or var2 == 103
                    or var2 == 104
                    or var2 == 105
                    or var2 == 106
                    or var2 == 107
                    or var2 == 108
                    or var2 == 109
                    or var2 == 110
                    or var2 == 111
                    or var2 == 112
                    or var2 == 113
                    or var2 == 114
                    or var2 == 115
                    or var2 == 116
                    or var2 == 117
                    or var2 == 118
                    or var2 == 119
                    or var2 == 120
                    or var2 == 121
                    or var2 == 122
                then
                    return readName(source, _end, line, var3, arg1)
                end
            end

            error(syntaxError(source, _end, unexpectedCharacterMessage(var2)))
        end
    end
    local line = tbl1.line
    local var2 = _end - tbl1.lineStart
    return Token.new(TokenKind.EOF, var1 + 1, var1 + 1, line, var2, arg1)
end

local Lexer = ({})
Lexer.__index = Lexer

function Lexer.new(source)
    local token = Token.new(TokenKind.SOF, 1, 1, 0, 0, nil)

    return (setmetatable({ source = source, lastToken = token, token = token, line = 1, lineStart = 0 }, Lexer))
end

function Lexer:advance()
    self.lastToken = self.token
    self.token = self:lookahead()
    return self.token
end

function Lexer:lookahead()
    local token = self.token
    if token.kind ~= TokenKind.EOF then
        repeat
            if token.next then
                token = token.next
            else
                local next = readToken(self, token)
                token.next = next
                next.prev = token
                token = next
            end
        until token.kind ~= TokenKind.COMMENT
    end

    return token
end

readBlockString = function(arg1, arg2, arg3, arg4, arg5, arg6)
    local body = arg1.body
    local var1 = arg2 + 3
    local var2 = var1
    local str1 = ""

    while var1 <= string.len(body) and not isNaN(String.charCodeAt(body, var1)) do
        local var3 = String.charCodeAt(body, var1)

        if var3 == 34 and String.charCodeAt(body, var1 + 1) == 34 and String.charCodeAt(body, var1 + 2) == 34 then
            local var4 = str1 .. String.slice(body, var2, var1)
            return Token.new(TokenKind.BLOCK_STRING, arg2, var1 + 3, arg3, arg4, arg5, dedentBlockStringValue(var4))
        end

        if var3 < 32 and var3 ~= 9 and var3 ~= 10 and var3 ~= 13 then
            error(syntaxError(arg1, var1, "Invalid character within String: " .. printCharCode(var3) .. "."))
        end

        if var3 == 10 then
            var1 += 1
            arg6.line += 1
            arg6.lineStart = var1 - 1
        elseif var3 == 13 then
            if String.charCodeAt(body, var1 + 1) == 10 then
                var1 += 2
            else
                var1 += 1
            end
            arg6.line += 1
            arg6.lineStart = var1 - 1
        elseif var3 == 92
            and String.charCodeAt(body, var1 + 1) == 34
            and String.charCodeAt(body, var1 + 2) == 34
            and String.charCodeAt(body, var1 + 3) == 34
        then
            str1 ..= String.slice(body, var2, var1) .. "\"\"\""
            var1 += 4
            var2 = var1
        else
            var1 += 1
        end
    end

    error(syntaxError(arg1, var1, "Unterminated string."))
end

readString = function(arg1, arg2, arg3, arg4, arg5)
    local body = arg1.body
    local var1 = utf8.len(body)
    assert(var1 ~= nil, "invalid utf8 sequence detected")
    local var2 = arg2 + 1
    local var3 = var2
    local str1 = ""

    while var2 <= var1 do
        local var4 = String.charCodeAt(body, var2)

        if isNaN(var4) then
            break
        end

        if var4 == 34 then
            local var5 = str1 .. String.slice(body, var3, var2)
            return Token.new(TokenKind.STRING, arg2, var2 + 1, arg3, arg4, arg5, var5)
        end

        if var4 == 10 or var4 == 13 then
            break
        end

        if var4 < 32 and var4 ~= 9 then
            error(syntaxError(arg1, var2, "Invalid character within String: " .. printCharCode(var4) .. "."))
        end

        var2 += 1
        if var4 ~= 92 then
            continue
        end
        str1 ..= String.slice(body, var3, var2 - 1)
        local var5 = String.charCodeAt(body, var2)
        if var5 == 34 then
            str1 ..= "\""
        elseif var5 == 47 then
            str1 ..= "/"
        elseif var5 == 92 then
            str1 ..= "\\"
        elseif var5 == 98 then
            str1 ..= "\8"
        elseif var5 == 102 then
            str1 ..= "\f"
        elseif var5 == 110 then
            str1 ..= "\n"
        elseif var5 == 114 then
            str1 ..= "\r"
        elseif var5 == 116 then
            str1 ..= "\t"
        elseif var5 == 117 then
            local num1 = uniCharCode(
                String.charCodeAt(body, var2 + 1),
                String.charCodeAt(body, var2 + 2),
                String.charCodeAt(body, var2 + 3),
                String.charCodeAt(body, var2 + 4)
            )
            if num1 < 0 then
                local var6 = String.slice(body, var2 + 1, var2 + 5)
                error(syntaxError(arg1, var2, "Invalid character escape sequence: \\u" .. var6 .. "."))
            end

            str1 ..= utf8.char(num1)
            var2 += 4
        else
            error(syntaxError(arg1, var2, "Invalid character escape sequence: \\" .. utf8.char(var5) .. "."))
        end

        var2 += 1
        var3 = var2
    end

    error(syntaxError(arg1, var2, "Unterminated string."))
end

return {
    Lexer = Lexer,
    isPunctuatorTokenKind = function(arg1): boolean
        return arg1 == TokenKind.BANG
            or arg1 == TokenKind.DOLLAR
            or arg1 == TokenKind.AMP
            or arg1 == TokenKind.PAREN_L
            or arg1 == TokenKind.PAREN_R
            or arg1 == TokenKind.SPREAD
            or arg1 == TokenKind.COLON
            or arg1 == TokenKind.EQUALS
            or arg1 == TokenKind.AT
            or arg1 == TokenKind.BRACKET_L
            or arg1 == TokenKind.BRACKET_R
            or arg1 == TokenKind.BRACE_L
            or arg1 == TokenKind.PIPE
            or arg1 == TokenKind.BRACE_R
    end
}
