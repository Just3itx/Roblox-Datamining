-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:01:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local AbstractBlockParser = require(CommonMark.parser.block.AbstractBlockParser)
local BlockContinue = require(CommonMark.parser.block.BlockContinue)
local _BlockParserFactory = require(CommonMark.parser.block.BlockParserFactory)
local BlockStart = require(CommonMark.parser.block.BlockStart)
local ListItemParser = require(CommonMark.internal.ListItemParser)
local _MatchedBlockParser = require(CommonMark.parser.block.MatchedBlockParser)
local _Node = require(CommonMark.node.Node)
local Nodes = require(CommonMark.node.Nodes)
local _ParserState = require(CommonMark.parser.block.ParserState)
local Parsing = require(CommonMark.internal.util.Parsing)

local byte = string.byte
local char = string.char
local sub = string.sub

local var1 = setmetatable({}, { __index = AbstractBlockParser })
var1.__index = var1

function var1.new(_block)
    return (setmetatable({ _block = _block, _hadBlankLine = false, _linesAfterBlank = 0 }, var1))
end

function var1.isContainer(_): boolean
    return true
end

function var1:canContain(arg1): boolean
    if arg1.kind ~= "ListItem" then
        return false
    end

    if self._hadBlankLine and self._linesAfterBlank == 1 then
        self._block.tight = false
        self._hadBlankLine = false
    end
    return true
end

function var1:getBlock()
    return self._block
end

function var1:tryContinue(arg1)
    if arg1:isBlank() then
        self._hadBlankLine = true
        self._linesAfterBlank = 0
    elseif self._hadBlankLine then
        self._linesAfterBlank += 1
    end

    return BlockContinue.atIndex(arg1:getIndex())
end

local tbl1 = {}
tbl1.__index = tbl1

function tbl1.new(listBlock, contentColumn: number)
    return (setmetatable({ listBlock = listBlock, contentColumn = contentColumn }, tbl1))
end

local tbl2 = {}
tbl2.__index = tbl2

function tbl2.new(listBlock, indexAfterMarker: number)
    return (setmetatable({ listBlock = listBlock, indexAfterMarker = indexAfterMarker }, tbl2))
end

local function isSpaceTabOrEnd(content: string, num1: number): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    if not (num1 < #content) then
        return true
    end

    local var2 = byte(content, num1 + 1)
    return var2 == 32 or var2 == 9
end

local function parseOrderedList(content: string, nextNonSpaceIndex: number)
    local num1 = 0
    for i = nextNonSpaceIndex, #content - 1 do
        local var2 = byte(content, i + 1)

        if not (var2 >= 48 and var2 <= 57) then
            if var2 ~= 46 and var2 ~= 41 then
                return nil
            end

            if not (num1 >= 1 and isSpaceTabOrEnd(content, i + 1)) then
                return nil
            end

            local var3 = sub(content, nextNonSpaceIndex + 1, i)
            local var4 = Nodes.OrderedList()

            var4.markerStartNumber = tonumber(var3)
            var4.markerDelimiter = char(var2)
            return tbl2.new(var4, i + 1)
        end

        num1 += 1
        if num1 > 9 then
            return nil
        end
    end
    return nil
end

local function parseListMarker(content: string, nextNonSpaceIndex: number)
    local var2 = byte(content, nextNonSpaceIndex + 1)

    if var2 ~= 45 and var2 ~= 43 and var2 ~= 42 then
        return parseOrderedList(content, nextNonSpaceIndex)
    end

    if not isSpaceTabOrEnd(content, nextNonSpaceIndex + 1) then
        return nil
    end

    local var3 = Nodes.BulletList()
    var3.marker = char(var2)
    return tbl2.new(var3, nextNonSpaceIndex + 1)
end

local function parseList(content: string, nextNonSpaceIndex: number, num1: number, bool1: boolean)
    local var2 = parseListMarker(content, nextNonSpaceIndex)
    if var2 == nil then
        return nil
    end
    local listBlock = var2.listBlock

    local indexAfterMarker = var2.indexAfterMarker
    local var3 = num1 + (indexAfterMarker - nextNonSpaceIndex)

    local bool2 = false
    local var4 = var3

    for i = indexAfterMarker, #content - 1 do
        local var5 = byte(content, i + 1)
        if var5 == 9 then
            var3 += Parsing.columnsToNextTabStop(var3)
        else
            if var5 ~= 32 then
                bool2 = true
                break
            end

            var3 += 1
        end
    end

    if bool1 then
        if listBlock.kind == "OrderedList" and listBlock.markerStartNumber ~= 1 then
            return nil
        end

        if not bool2 then
            return nil
        end
    end

    if not bool2 or var3 - var4 > Parsing.CODE_BLOCK_INDENT then
        var3 = var4 + 1
    end

    return tbl1.new(listBlock, var3)
end

local function listsMatch(block, listBlock): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    if block.kind == "BulletList" and listBlock.kind == "BulletList" then
        return block.marker == listBlock.marker
    end

    if block.kind == "OrderedList" and listBlock.kind == "OrderedList" then
        return block.markerDelimiter == listBlock.markerDelimiter
    end

    return false
end

local Factory = {}
Factory.__index = Factory

function Factory.new()
    return (setmetatable({}, Factory))
end

function Factory.tryStart(_, arg1, arg2)
    local matchedBlockParser = arg2:getMatchedBlockParser()

    if arg1:getIndent() >= Parsing.CODE_BLOCK_INDENT then
        return BlockStart.none()
    end
    local nextNonSpaceIndex = arg1:getNextNonSpaceIndex()
    local var2 = arg1:getColumn() + arg1:getIndent()
    local bool1 = not arg2:getParagraphLines():isEmpty()
    local var3 = parseList(arg1:getLine():getContent(), nextNonSpaceIndex, var2, bool1)
    if var3 == nil then
        return BlockStart.none()
    end

    local contentColumn = var3.contentColumn
    local listItemParser = ListItemParser.new(arg1:getIndent(), contentColumn - arg1:getColumn())

    if getmetatable(matchedBlockParser) == var1 and listsMatch(matchedBlockParser:getBlock(), var3.listBlock) then
        return BlockStart.of(listItemParser):atColumn(contentColumn)
    end

    local var4 = var1.new(var3.listBlock)

    var3.listBlock.tight = true

    return BlockStart.of(var4, listItemParser):atColumn(contentColumn)
end

var1.Factory = Factory

return var1
