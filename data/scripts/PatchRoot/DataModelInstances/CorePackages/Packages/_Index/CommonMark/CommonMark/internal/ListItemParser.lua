-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:21:00Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local AbstractBlockParser = require(CommonMark.parser.block.AbstractBlockParser)
local BlockContinue = require(CommonMark.parser.block.BlockContinue)
local _Node = require(CommonMark.node.Node)
local Nodes = require(CommonMark.node.Nodes)
local _ParserState = require(CommonMark.parser.block.ParserState)

local var1 = setmetatable({}, { __index = AbstractBlockParser })
var1.__index = var1

function var1.new(markerIndent: number, num1: number)
    local _block = Nodes.ListItem()
    _block.markerIndent = markerIndent
    _block.contentIndent = num1
    return (setmetatable({ _block = _block, _contentIndent = num1, _hadBlankLine = false }, var1))
end

function var1.isContainer(_): boolean
    return true
end

function var1:canContain(_): boolean
    if self._hadBlankLine then
        local parent = self._block:getParent()

        if parent ~= nil and (parent.kind == "BulletList" or parent.kind == "OrderedList") then
            parent.tight = false
        end
    end
    return true
end

function var1:getBlock()
    return self._block
end

function var1:tryContinue(arg1)
    if arg1:isBlank() then
        if self._block:getFirstChild() == nil then
            return BlockContinue.none()
        end
        local block = arg1:getActiveBlockParser():getBlock()

        self._hadBlankLine = block.kind == "Paragraph" or block.kind == "ListItem"
        return BlockContinue.atIndex(arg1:getNextNonSpaceIndex())
    elseif arg1:getIndent() >= self._contentIndent then
        return BlockContinue.atColumn(arg1:getColumn() + self._contentIndent)
    else
        return BlockContinue.none()
    end
end

return var1
