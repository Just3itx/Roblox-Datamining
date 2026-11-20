-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:00:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local AbstractBlockParser = require(CommonMark.parser.block.AbstractBlockParser)
local BlockContinue = require(CommonMark.parser.block.BlockContinue)
local _BlockParserFactory = require(CommonMark.parser.block.BlockParserFactory)
local BlockStart = require(CommonMark.parser.block.BlockStart)
local Characters = require(CommonMark.text.Characters)
local _MatchedBlockParser = require(CommonMark.parser.block.MatchedBlockParser)
local _Node = require(CommonMark.node.Node)
local Nodes = require(CommonMark.node.Nodes)
local _ParserState = require(CommonMark.parser.block.ParserState)
local Parsing = require(CommonMark.internal.util.Parsing)
local _SourceLine = require(CommonMark.parser.SourceLine)

local var1 = setmetatable({}, { __index = AbstractBlockParser })
var1.__index = var1

function var1.new()
    return (setmetatable({ _block = Nodes.IndentedCodeBlock(), _lines = {} }, var1))
end

function var1:getBlock()
    return self._block
end

function var1.tryContinue(_, arg1)
    if arg1:getIndent() >= Parsing.CODE_BLOCK_INDENT then
        return BlockContinue.atColumn(arg1:getColumn() + Parsing.CODE_BLOCK_INDENT)
    elseif arg1:isBlank() then
        return BlockContinue.atIndex(arg1:getNextNonSpaceIndex())
    end
    return BlockContinue.none()
end

function var1:addLine(arg1)
    table.insert(self._lines, arg1:getContent())
end

function var1:closeBlock()
    local _lines = self._lines
    local num1 = #_lines - 1

    while num1 >= 0 and Characters.isBlank(_lines[num1 + 1]) do
        num1 -= 1
    end

    local tbl1 = ({})
    local num2 = 0
    for i = 0, num1 do
        local num3 = num2 + 1
        tbl1[num3] = _lines[i + 1]
        num2 = num3 + 1
        tbl1[num2] = "\n"
    end

    local literal = table.concat(tbl1)
    self._block.literal = literal
end

local Factory = {}
Factory.__index = Factory

function Factory.new()
    return (setmetatable({}, Factory))
end

function Factory.tryStart(_, arg1, _)
    if arg1:getIndent() >= Parsing.CODE_BLOCK_INDENT
        and not arg1:isBlank()
        and arg1:getActiveBlockParser():getBlock().kind ~= "Paragraph"
    then
        return BlockStart.of(var1.new()):atColumn(arg1:getColumn() + Parsing.CODE_BLOCK_INDENT)
    end
    return BlockStart.none()
end

var1.Factory = Factory

return var1
