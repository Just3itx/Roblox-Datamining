-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local _BlockParser = require(CommonMark.parser.block.BlockParser)

local module = {}
module.__index = module

function module.none()
    return nil
end

function module.of(...)
    return (setmetatable({
        _blockParsers = { ... },
        _newIndex = -1,
        _newColumn = -1,
        _replaceActiveBlockParser = false,
        _replaceParagraphLines = 0
    }, module))
end

function module:getBlockParsers()
    return self._blockParsers
end

function module:getNewIndex()
    return self._newIndex
end

function module:getNewColumn()
    return self._newColumn
end

function module:isReplaceActiveBlockParser()
    return self._replaceActiveBlockParser
end

function module:getReplaceParagraphLines()
    return self._replaceParagraphLines
end

function module:atIndex(_newIndex: number)
    self._newIndex = _newIndex
    return self
end

function module:atColumn(_newColumn: number)
    self._newColumn = _newColumn
    return self
end

function module:replaceActiveBlockParser()
    self._replaceActiveBlockParser = true
    return self
end

function module:replaceParagraphLines(_replaceParagraphLines: number)
    if not (_replaceParagraphLines >= 1) then
        error("Lines must be >= 1")
    end
    self._replaceParagraphLines = _replaceParagraphLines
    return self
end

return module
