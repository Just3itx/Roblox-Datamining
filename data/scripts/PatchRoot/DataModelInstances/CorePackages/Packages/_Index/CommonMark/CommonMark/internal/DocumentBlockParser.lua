-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local AbstractBlockParser = require(CommonMark.parser.block.AbstractBlockParser)
local BlockContinue = require(CommonMark.parser.block.BlockContinue)
local _Node = require(CommonMark.node.Node)
local Nodes = require(CommonMark.node.Nodes)
local _ParserState = require(CommonMark.parser.block.ParserState)

local var1 = setmetatable({}, { __index = AbstractBlockParser })
var1.__index = var1

function var1.new()
    return (setmetatable({ _document = Nodes.Document() }, var1))
end

function var1.isContainer(_): boolean
    return true
end

function var1.canContain(_, _): boolean
    return true
end

function var1:getBlock()
    return self._document
end

function var1.tryContinue(_, arg1)
    return BlockContinue.atIndex(arg1:getIndex())
end

return var1
