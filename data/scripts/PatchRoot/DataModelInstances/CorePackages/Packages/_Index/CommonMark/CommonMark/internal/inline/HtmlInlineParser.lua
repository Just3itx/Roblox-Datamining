-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:20:53Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local AsciiMatcher = require(CommonMark.text.AsciiMatcher)
local _CharMatcher = require(CommonMark.text.CharMatcher)
local _InlineContentParser = require(CommonMark.parser.beta.InlineContentParser)
local _InlineContentParserFactory = require(CommonMark.parser.beta.InlineContentParserFactory)
local _InlineParserState = require(CommonMark.parser.beta.InlineParserState)
local Nodes = require(CommonMark.node.Nodes)
local ParsedInline = require(CommonMark.parser.beta.ParsedInline)
local _Position = require(CommonMark.parser.beta.Position)
local _Scanner = require(CommonMark.parser.beta.Scanner)

local _byte = string.byte

local module = {}
module.__index = module

local var1 = AsciiMatcher.builder():range(65, 90):range(97, 122):build()

local var2 = var1:newBuilder():range(48, 57):c(45):build()

local var3 = var1:newBuilder():c(95):c(58):build()

local var4 = var3:newBuilder():range(48, 57):c(46):c(45):build()

local var5 = AsciiMatcher.builder():c(32):c(9):c(10):c(11):c(12):c(13):c(34):c(39):c(61):c(60):c(62):c(96):build()

local function htmlInline(arg1, arg2)
    local literal = arg2:getSource(arg1, arg2:position()):getContent()
    local var6 = Nodes.HtmlInline()
    var6.literal = literal
    return ParsedInline.of(var6, arg2:position())
end

local function tryOpenTag(arg1, arg2)
    arg1:next()
    arg1:match(var2)
    local bool1 = arg1:whitespace() >= 1

    while bool1 and arg1:match(var3) >= 1 do
        arg1:match(var4)

        bool1 = arg1:whitespace() >= 1
        if not arg1:nextChar(61) then
            continue
        end

        arg1:whitespace()
        local var6 = arg1:peek()
        if var6 == 39 then
            arg1:next()
            if arg1:findChar(39) < 0 then
                return false
            end
            arg1:next()
        elseif var6 == 34 then
            arg1:next()
            if arg1:findChar(34) < 0 then
                return false
            end
            arg1:next()
        elseif arg1:findMatcher(arg2) <= 0 then
            return false
        end

        bool1 = arg1:whitespace() >= 1
    end

    arg1:nextChar(47)
    return arg1:nextChar(62)
end

local function tryClosingTag(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    arg1:next()
    if not (arg1:match(var1) >= 1) then
        return false
    end

    arg1:match(var2)
    arg1:whitespace()
    return arg1:nextChar(62)
end

function module.new()
    return (setmetatable(
        {
            _noProcessingInstructionEnd = false,
            _noCommentEnd = false,
            _noCdataEnd = false,
            _noDeclarationEnd = false
        },
        module
    ))
end

function module.tryParse(arg1, arg2)
    local var6 = arg2:scanner()
    local var7 = var6:position()

    var6:next()

    local var8 = var6:peek()
    if var1:matches(var8) then
        if tryOpenTag(var6, var5) then
            return htmlInline(var7, var6)
        end
    elseif var8 == 47 then
        if tryClosingTag(var6) then
            return htmlInline(var7, var6)
        end
    elseif var8 == 63 then
        if arg1:tryProcessingInstruction(var6) then
            return htmlInline(var7, var6)
        end
    elseif var8 == 33 then
        var6:next()
        local var9 = var6:peek()
        if var9 == 45 then
            if arg1:tryComment(var6) then
                return htmlInline(var7, var6)
            end
        elseif var9 == 91 then
            if arg1:tryCdata(var6) then
                return htmlInline(var7, var6)
            end
        elseif var1:matches(var9) and arg1:tryDeclaration(var6) then
            return htmlInline(var7, var6)
        end
    end

    return ParsedInline.none()
end

function module:tryProcessingInstruction(arg1)
    if self._noProcessingInstructionEnd then
        return false
    end
    arg1:next()
    local var6

    repeat
        var6 = arg1:findChar(63)
        if var6 <= 0 then
            self._noProcessingInstructionEnd = var6 < 0
            return false
        end

        arg1:next()
    until arg1:nextChar(62)

    return true
end

function module:tryComment(arg1)
    if self._noCommentEnd then
        return false
    end

    arg1:next()
    if not arg1:nextChar(45) then
        return false
    end

    if arg1:nextChar(62) or arg1:nextString("->") then
        return true
    end

    while arg1:findChar(45) >= 0 do
        if arg1:nextString("-->") then
            return true
        end
        arg1:next()
    end

    self._noCommentEnd = true
    return false
end

function module:tryCdata(arg1)
    if self._noCdataEnd then
        return false
    end

    arg1:next()

    if arg1:nextString("CDATA[") then
        while arg1:findChar(93) >= 0 do
            if arg1:nextString("]]>") then
                return true
            end
            arg1:next()
        end

        self._noCdataEnd = true
    end

    return false
end

function module:tryDeclaration(arg1): boolean
    if self._noDeclarationEnd then
        return false
    end
    arg1:match(var1)
    if arg1:whitespace() <= 0 then
        return false
    elseif arg1:findChar(62) >= 0 then
        arg1:next()
        return true
    else
        self._noDeclarationEnd = true
        return false
    end
end
local Factory = {}
Factory.__index = Factory

function Factory.new()
    return (setmetatable({}, Factory))
end

function Factory.getTriggerCharacters(_): {boolean}
    return { [60] = true }
end

function Factory.create(_)
    return module.new()
end

module.Factory = Factory

module.tryOpenTag = tryOpenTag
module.tryClosingTag = tryClosingTag

return module
