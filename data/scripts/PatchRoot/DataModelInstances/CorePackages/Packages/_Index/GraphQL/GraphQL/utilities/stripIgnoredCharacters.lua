-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:10:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local language = scriptParentParent.language
local scriptParentParentParent = scriptParentParent.Parent
local String = require(scriptParentParentParent.LuauPolyfill).String

local source = require(language.source)
local Source = source.Source

local isSource = source.isSource
local TokenKind = require(language.tokenKind).TokenKind
local lexer = require(language.lexer)
local Lexer = lexer.Lexer
local isPunctuatorTokenKind = lexer.isPunctuatorTokenKind
local blockString = require(language.blockString)
local dedentBlockStringValue = blockString.dedentBlockStringValue
local getBlockStringIndentation = blockString.getBlockStringIndentation

local dedentBlockString = nil

local function stripIgnoredCharacters(arg1)
    if not isSource(arg1) then
        arg1 = Source.new(arg1)
    end
    local body = arg1.body
    local lexer2 = Lexer.new(arg1)
    local str1 = ""
    local bool1 = false

    while lexer2:advance().kind ~= TokenKind.EOF do
        local token = lexer2.token
        local kind = token.kind

        local bool2 = not isPunctuatorTokenKind(token.kind)
        if bool1 and (bool2 or token.kind == TokenKind.SPREAD) then
            str1 ..= " "
        end

        local var1 = String.slice(body, token.start, token._end)
        if kind == TokenKind.BLOCK_STRING then
            str1 ..= dedentBlockString(var1)
        else
            str1 ..= var1
        end

        bool1 = bool2
    end

    return str1
end

dedentBlockString = function(str1: string)
    local var1 = String.slice(str1, 4, -3)
    local var2 = dedentBlockStringValue(var1)

    if getBlockStringIndentation(var2) > 0 then
        var2 = "\n" .. var2
    end

    local var3 = utf8.len(var2)
    assert(var3 ~= nil, "invalid utf8 detected: " .. var2)
    local var4 = String.slice(var2, var3)
    local bool1 = var4 == "\"" and String.slice(var2, -4) ~= "\\\"\"\""

    if bool1 or var4 == "\\" then
        var2 ..= "\n"
    end

    return "\"\"\"" .. var2 .. "\"\"\""
end

return { stripIgnoredCharacters = stripIgnoredCharacters }
