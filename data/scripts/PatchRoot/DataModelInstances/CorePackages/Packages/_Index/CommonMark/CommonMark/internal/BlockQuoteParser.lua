-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:11:23Z
-- Luau bytecode version: 9 | Luau type version: 3
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

local byte = string.byte

local var1 = setmetatable({}, { __index = AbstractBlockParser })
var1.__index = var1

function var1.new()
    return (setmetatable({ _block = Nodes.BlockQuote() }, var1))
end

local function isMarker(arg1, nextNonSpaceIndex: number): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    local content = arg1:getLine():getContent()
    return arg1:getIndent() < Parsing.CODE_BLOCK_INDENT
        and nextNonSpaceIndex < #content
        and byte(content, nextNonSpaceIndex + 1) == 62
end

function var1.isContainer(_): boolean
    return true
end

function var1.canContain(_, _): boolean
    return true
end

function var1:getBlock()
    return self._block
end

function var1.tryContinue(_, arg1)
    local nextNonSpaceIndex = arg1:getNextNonSpaceIndex()

    if not isMarker(arg1, nextNonSpaceIndex) then
        return BlockContinue.none()
    end

    local var2 = arg1:getColumn() + arg1:getIndent() + 1

    if Characters.isSpaceOrTab(arg1:getLine():getContent(), nextNonSpaceIndex + 1) then
        var2 += 1
    end
    return BlockContinue.atColumn(var2)
end

local Factory = {}
Factory.__index = Factory

function Factory.new()
    return (setmetatable({}, Factory))
end

function Factory.tryStart(_, arg1, _)
    local nextNonSpaceIndex = arg1:getNextNonSpaceIndex()

    if not isMarker(arg1, nextNonSpaceIndex) then
        return BlockStart.none()
    end

    local var2 = arg1:getColumn() + arg1:getIndent() + 1

    if Characters.isSpaceOrTab(arg1:getLine():getContent(), nextNonSpaceIndex + 1) then
        var2 += 1
    end
    return BlockStart.of(var1.new()):atColumn(var2)
end

var1.Factory = Factory

return var1
