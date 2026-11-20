-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:51:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local AbstractBlockParser = require(CommonMark.parser.block.AbstractBlockParser)
local BlockContinue = require(CommonMark.parser.block.BlockContinue)
local _BlockParserFactory = require(CommonMark.parser.block.BlockParserFactory)
local BlockStart = require(CommonMark.parser.block.BlockStart)
local Characters = require(CommonMark.text.Characters)
local Escaping = require(CommonMark.internal.util.Escaping)
local _MatchedBlockParser = require(CommonMark.parser.block.MatchedBlockParser)
local Nodes = require(CommonMark.node.Nodes)
local _ParserState = require(CommonMark.parser.block.ParserState)
local Parsing = require(CommonMark.internal.util.Parsing)
local _SourceLine = require(CommonMark.parser.SourceLine)

local byte = string.byte
local char = string.char
local sub = string.sub

local unescapeString = Escaping.unescapeString

local var1 = setmetatable({}, { __index = AbstractBlockParser })
var1.__index = var1

function var1.new(_fenceChar: number, _openingFenceLength: number, fenceIndent: number)
    local _block = Nodes.FencedCodeBlock()
    _block.fenceCharacter = char(_fenceChar)
    _block:setOpeningFenceLength(_openingFenceLength)
    _block.fenceIndent = fenceIndent
    return (setmetatable({
        _block = _block,
        _fenceChar = _fenceChar,
        _openingFenceLength = _openingFenceLength,
        _firstLine = nil,
        _otherLines = {}
    }, var1))
end

function var1:getBlock()
    return self._block
end

function var1:tryContinue(arg1)
    local nextNonSpaceIndex = arg1:getNextNonSpaceIndex()
    local index = arg1:getIndex()
    local content = arg1:getLine():getContent()

    if arg1:getIndent() < Parsing.CODE_BLOCK_INDENT
        and nextNonSpaceIndex < #content
        and self:tryClosing(content, nextNonSpaceIndex)
    then
        return BlockContinue.finished()
    end

    local fenceIndent = self._block.fenceIndent
    local contentLen = #content

    while fenceIndent > 0 and index < contentLen do
        if byte(content, index + 1) ~= 32 then
            break
        end

        index += 1
        fenceIndent -= 1
    end

    return BlockContinue.atIndex(index)
end

function var1:addLine(arg1)
    if self._firstLine == nil then
        self._firstLine = arg1:getContent()
        return
    end
    table.insert(self._otherLines, arg1:getContent())
    table.insert(self._otherLines, "\n")
end

local function trim(_firstLine: string)
    local _firstLineLen = #_firstLine
    local num1 = 0

    while num1 < _firstLineLen do
        if not (byte(_firstLine, num1 + 1) <= 32) then
            break
        end

        num1 += 1
    end

    while num1 < _firstLineLen do
        if not (byte(_firstLine, _firstLineLen - 1 + 1) <= 32) then
            break
        end

        _firstLineLen -= 1
    end
    return (sub(_firstLine, num1 + 1, _firstLineLen))
end

function var1:closeBlock()
    self._block.info = unescapeString((trim(self._firstLine)))
    self._block.literal = table.concat(self._otherLines)
end

local function checkOpener(content: string, nextNonSpaceIndex: number, indent: number)
    local num1 = 0
    local num2 = 0
    for i = nextNonSpaceIndex, #content - 1 do
        local var2 = byte(content, i + 1)
        if var2 == 96 then
            num1 += 1
        else
            if var2 ~= 126 then
                break
            end

            num2 += 1
        end
    end

    if num1 >= 3 and num2 == 0 then
        if Characters.find(96, content, nextNonSpaceIndex + num1) ~= -1 then
            return nil
        end
        return var1.new(96, num1, indent)
    elseif num2 >= 3 and num1 == 0 then
        return var1.new(126, num2, indent)
    else
        return nil
    end
end

local Factory = {}
Factory.__index = Factory

function Factory.new()
    return (setmetatable({}, Factory))
end

function Factory.tryStart(_, arg1, _)
    local indent = arg1:getIndent()
    if Parsing.CODE_BLOCK_INDENT <= indent then
        return BlockStart.none()
    end

    local nextNonSpaceIndex = arg1:getNextNonSpaceIndex()
    local var2 = checkOpener(arg1:getLine():getContent(), nextNonSpaceIndex, indent)
    if var2 ~= nil then
        return BlockStart.of(var2):atIndex(nextNonSpaceIndex + var2._block:getOpeningFenceLength())
    end
    return BlockStart.none()
end

var1.Factory = Factory

function var1:tryClosing(str1: string, num1: number): boolean
    local var2 = Characters.skip(self._fenceChar, str1, num1, #str1) - num1
    if var2 < self._openingFenceLength then
        return false
    end

    if Characters.skipSpaceTab(str1, num1 + var2, #str1) ~= #str1 then
        return false
    end

    self._block:setClosingFenceLength(var2)
    return true
end

return var1
