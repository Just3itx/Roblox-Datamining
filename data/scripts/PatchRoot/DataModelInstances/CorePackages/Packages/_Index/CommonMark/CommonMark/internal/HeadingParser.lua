-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:20:41Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local AbstractBlockParser = require(CommonMark.parser.block.AbstractBlockParser)
local BlockContinue = require(CommonMark.parser.block.BlockContinue)
local _BlockParserFactory = require(CommonMark.parser.block.BlockParserFactory)
local BlockStart = require(CommonMark.parser.block.BlockStart)
local Characters = require(CommonMark.text.Characters)
local _InlineParser = require(CommonMark.parser.InlineParser)
local _MatchedBlockParser = require(CommonMark.parser.block.MatchedBlockParser)
local _Node = require(CommonMark.node.Node)
local Nodes = require(CommonMark.node.Nodes)
local _ParserState = require(CommonMark.parser.block.ParserState)
local Parsing = require(CommonMark.internal.util.Parsing)
local Scanner = require(CommonMark.parser.beta.Scanner)
local _SourceLine = require(CommonMark.parser.SourceLine)
local SourceLines = require(CommonMark.parser.SourceLines)

local byte = string.byte

local var1 = setmetatable({}, { __index = AbstractBlockParser })
var1.__index = var1

function var1.new(level: number, _content)
    local _block = Nodes.Heading()
    _block.level = level
    return (setmetatable({ _block = _block, _content = _content }, var1))
end

function var1:getBlock()
    return self._block
end

function var1.tryContinue(_, _)
    return BlockContinue.none()
end

function var1:parseInlines(arg1)
    arg1:parse(self._content, self._block)
end

local function getAtxHeading(arg1)
    local var2 = Scanner.of(SourceLines.of(arg1))
    local var3 = var2:matchMultiple(35)

    if var3 == 0 or var3 > 6 then
        return nil
    elseif not var2:hasNext() then
        return var1.new(var3, SourceLines.empty())
    else
        local var4 = var2:peek()
        if var4 ~= 32 and var4 ~= 9 then
            return nil
        end

        var2:whitespace()
        local var5 = var2:position()
        local var6 = var5
        local bool1 = true

        while var2:hasNext() do
            local var7 = var2:peek()
            if var7 == 35 then
                if bool1 then
                    var2:matchMultiple(35)
                    local var8 = var2:whitespace()

                    if var2:hasNext() then
                        var6 = var2:position()
                    end
                    bool1 = var8 > 0
                else
                    var2:next()
                    var6 = var2:position()
                end
            elseif var7 == 32 or var7 == 9 then
                var2:next()
                bool1 = true
            else
                var2:next()
                var6 = var2:position()
                bool1 = false
            end
        end

        local source = var2:getSource(var5, var6)
        if source:getContent() == "" then
            return var1.new(var3, SourceLines.empty())
        end
        return var1.new(var3, source)
    end
end

local function isSetextHeadingRest(content: string, num1: number, num2: number): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
    local var2 = Characters.skip(num2, content, num1, #content)
    return Characters.skipSpaceTab(content, var2, #content) >= #content
end

local function getSetextHeadingLevel(content: string, nextNonSpaceIndex: number) -- Luacid: Inlined by compiler; 1 call site recovered
    local var2 = byte(content, nextNonSpaceIndex + 1)
    if var2 == 61 then
        if isSetextHeadingRest(content, nextNonSpaceIndex + 1, 61) then
            return 1
        end
    elseif var2 == 45 and isSetextHeadingRest(content, nextNonSpaceIndex + 1, 45) then
        return 2
    end

    return 0
end

local Factory = {}
Factory.__index = Factory

function Factory.new()
    return (setmetatable({}, Factory))
end

function Factory.tryStart(_, arg1, arg2)
    if arg1:getIndent() >= Parsing.CODE_BLOCK_INDENT then
        return BlockStart.none()
    end

    local line = arg1:getLine()
    local nextNonSpaceIndex = arg1:getNextNonSpaceIndex()

    if byte(line:getContent(), nextNonSpaceIndex + 1) == 35 then
        local atxHeading = getAtxHeading(line:substring(nextNonSpaceIndex, #line:getContent()))
        if atxHeading ~= nil then
            return BlockStart.of(atxHeading):atIndex(#line:getContent())
        end
    end

    local setextHeadingLevel = getSetextHeadingLevel(line:getContent(), nextNonSpaceIndex)
    if setextHeadingLevel > 0 then
        local paragraphLines = arg2:getParagraphLines()
        if not paragraphLines:isEmpty() then
            return BlockStart.of(var1.new(setextHeadingLevel, paragraphLines)):atIndex(#line:getContent()):replaceParagraphLines(
                #paragraphLines:getLines()
            )
        end
    end
    return BlockStart.none()
end

var1.Factory = Factory

return var1
