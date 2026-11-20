-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:01:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local AbstractBlockParser = require(CommonMark.parser.block.AbstractBlockParser)
local BlockContinue = require(CommonMark.parser.block.BlockContinue)
local DefinitionMap = require(CommonMark.node.DefinitionMap)
local _InlineParser = require(CommonMark.parser.InlineParser)
local LinkReferenceDefinitionParser = require(CommonMark.internal.LinkReferenceDefinitionParser)
local _Node = require(CommonMark.node.Node)
local Nodes = require(CommonMark.node.Nodes)
local _ParserState = require(CommonMark.parser.block.ParserState)
local _SourceLine = require(CommonMark.parser.SourceLine)
local _SourceLines = require(CommonMark.parser.SourceLines)
local _SourceSpan = require(CommonMark.node.SourceSpan)

local var1 = setmetatable({}, { __index = AbstractBlockParser })
var1.__index = var1

function var1.new(bool1: boolean?)
    return (setmetatable(
        {
            _block = Nodes.Paragraph(),
            _linkReferenceDefinitionParser = LinkReferenceDefinitionParser.new(bool1)
        },
        var1
    ))
end

function var1.canHaveLazyContinuationLines(_): boolean
    return true
end

function var1:getBlock()
    return self._block
end

function var1.tryContinue(_, arg1)
    if not arg1:isBlank() then
        return BlockContinue.atIndex(arg1:getIndex())
    end
    return BlockContinue.none()
end

function var1:addLine(arg1)
    self._linkReferenceDefinitionParser:parse(arg1)
end

function var1:addSourceSpan(arg1)
    self._linkReferenceDefinitionParser:addSourceSpan(arg1)
end

function var1:getDefinitions()
    local definitionMap = DefinitionMap.new("LinkReferenceDefinition")
    for _, value in ipairs(self._linkReferenceDefinitionParser:getDefinitions()) do
        definitionMap:putIfAbsent(value.label, value)
    end
    return table.freeze({ definitionMap })
end

function var1:closeBlock()
    for _, value in ipairs(self._linkReferenceDefinitionParser:getDefinitions()) do
        self._block:insertBefore(value)
    end

    if self._linkReferenceDefinitionParser:getParagraphLines():isEmpty() then
        self._block:unlink()
        return
    end
    self._block:setSourceSpans(self._linkReferenceDefinitionParser:getParagraphSourceSpans())
end

function var1:parseInlines(arg1)
    local paragraphLines = self._linkReferenceDefinitionParser:getParagraphLines()
    if not paragraphLines:isEmpty() then
        arg1:parse(paragraphLines, self._block)
    end
end

function var1:getParagraphLines()
    return self._linkReferenceDefinitionParser:getParagraphLines()
end

function var1:removeLines(num1: number)
    return self._linkReferenceDefinitionParser:removeLines(num1)
end

return var1
