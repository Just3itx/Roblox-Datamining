-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local AbstractBlockParser = require(CommonMark.parser.block.AbstractBlockParser)
local BlockContinue = require(CommonMark.parser.block.BlockContinue)
local _BlockParserFactory = require(CommonMark.parser.block.BlockParserFactory)
local BlockStart = require(CommonMark.parser.block.BlockStart)
local _MatchedBlockParser = require(CommonMark.parser.block.MatchedBlockParser)
local Nodes = require(CommonMark.node.Nodes)
local _ParserState = require(CommonMark.parser.block.ParserState)

local byte = string.byte
local sub = string.sub

local var1 = setmetatable({}, { __index = AbstractBlockParser })
var1.__index = var1

function var1.new(literal: string)
    local _block = Nodes.ThematicBreak()
    _block.literal = literal
    return (setmetatable({ _block = _block }, var1))
end

function var1:getBlock()
    return self._block
end

function var1.tryContinue(_, _)
    return BlockContinue.none()
end

local function isThematicBreak(content: string, nextNonSpaceIndex: number)
    local num1 = 0
    local num2 = 0
    local num3 = 0
    for i = nextNonSpaceIndex, #content - 1 do
        local var2 = byte(content, i + 1)
        if var2 == 45 then
            num1 += 1
        elseif var2 == 95 then
            num2 += 1
        elseif var2 == 42 then
            num3 += 1
        elseif var2 ~= 32 and var2 ~= 9 then
            return false
        end
    end

    return num1 >= 3 and num2 == 0 and num3 == 0 or num2 >= 3 and num1 == 0 and num3 == 0 or num3 >= 3 and num1 == 0 and num2 == 0
end

local Factory = {}
Factory.__index = Factory

function Factory.new()
    return (setmetatable({}, Factory))
end

function Factory.tryStart(_, arg1, _)
    if arg1:getIndent() >= 4 then
        return BlockStart.none()
    end
    local nextNonSpaceIndex = arg1:getNextNonSpaceIndex()
    local content = arg1:getLine():getContent()
    if not isThematicBreak(content, nextNonSpaceIndex) then
        return BlockStart.none()
    end

    local var2 = sub(content, arg1:getIndex() + 1, #content)
    return BlockStart.of(var1.new(var2)):atIndex(#content)
end

var1.Factory = Factory

return var1
