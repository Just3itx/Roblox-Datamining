-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:20:38Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local _BlockParser = require(CommonMark.parser.block.BlockParser)
local _BlockParserFactory = require(CommonMark.parser.block.BlockParserFactory)
local BlockQuoteParser = require(CommonMark.internal.BlockQuoteParser)
local _BlockStart = require(CommonMark.parser.block.BlockStart)
local Characters = require(CommonMark.text.Characters)
local Definitions = require(CommonMark.internal.Definitions)
local _DelimiterProcessor = require(CommonMark.parser.delimiter.DelimiterProcessor)
local DocumentBlockParser = require(CommonMark.internal.DocumentBlockParser)
local FencedCodeBlockParser = require(CommonMark.internal.FencedCodeBlockParser)
local HeadingParser = require(CommonMark.internal.HeadingParser)
local HtmlBlockParser = require(CommonMark.internal.HtmlBlockParser)
local IncludeSourceSpans = require(CommonMark.parser.IncludeSourceSpans)
local IndentedCodeBlockParser = require(CommonMark.internal.IndentedCodeBlockParser)
local _InlineContentParserFactory = require(CommonMark.parser.beta.InlineContentParserFactory)
local InlineParserContextImpl = require(CommonMark.internal.InlineParserContextImpl)
local _InlineParserFactory = require(CommonMark.parser.InlineParserFactory)
local Integer = require(CommonMark.internal.port.Integer)
local LineReader = require(CommonMark.internal.util.LineReader)
local _LinkProcessor = require(CommonMark.parser.beta.LinkProcessor)
local ListBlockParser = require(CommonMark.internal.ListBlockParser)
local _MatchedBlockParser = require(CommonMark.parser.block.MatchedBlockParser)
local _Nodes = require(CommonMark.node.Nodes)
local ParagraphParser = require(CommonMark.internal.ParagraphParser)
local _ParserState = require(CommonMark.parser.block.ParserState)
local Parsing = require(CommonMark.internal.util.Parsing)
local SourceLine = require(CommonMark.parser.SourceLine)
local SourceLines = require(CommonMark.parser.SourceLines)
local SourceSpan = require(CommonMark.node.SourceSpan)
local ThematicBreakParser = require(CommonMark.internal.ThematicBreakParser)

local byte = string.byte
local find = string.find
local gsub = string.gsub
local rep = string.rep
local sub = string.sub

local getDefaultBlockParserTypes = {
    "BlockQuote",
    "Heading",
    "FencedCodeBlock",
    "HtmlBlock",
    "ThematicBreak",
    "ListBlock",
    "IndentedCodeBlock"
}

local var1 = table.freeze({
    BlockQuote = BlockQuoteParser.Factory.new(),
    Heading = HeadingParser.Factory.new(),
    FencedCodeBlock = FencedCodeBlockParser.Factory.new(),
    HtmlBlock = HtmlBlockParser.Factory.new(),
    ThematicBreak = ThematicBreakParser.Factory.new(),
    ListBlock = ListBlockParser.Factory.new(),
    IndentedCodeBlock = IndentedCodeBlockParser.Factory.new()
})

local tbl2 = {}
tbl2.__index = tbl2

function tbl2.new(_matchedBlockParser)
    return (setmetatable({ _matchedBlockParser = _matchedBlockParser }, tbl2))
end

function tbl2:getMatchedBlockParser()
    return self._matchedBlockParser
end

local function isParagraphParser(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return getmetatable(arg1) == ParagraphParser
end

function tbl2:getParagraphLines()
    if isParagraphParser(self._matchedBlockParser) then
        return self._matchedBlockParser:getParagraphLines()
    end
    return SourceLines.empty()
end

local tbl3 = {}
tbl3.__index = tbl3

function tbl3.new(_blockParser, _sourceIndex: number)
    return (setmetatable({ _blockParser = _blockParser, _sourceIndex = _sourceIndex }, tbl3))
end

local module = {}
module.__index = module

function module.new(_blockParserFactories, _inlineParserFactory, _inlineContentParserFactories, _delimiterProcessors, _linkProcessors, _linkMarkers, _includeSourceSpans, _maxOpenBlockParsers: number, _maxInlineNesting: number, _enabledInlineTypes, bool1: boolean?)
    local self = setmetatable({
        _line = nil,
        _lineIndex = -1,
        _index = 0,
        _column = 0,
        _columnIsInTab = false,
        _nextNonSpace = 0,
        _nextNonSpaceColumn = 0,
        _indent = 0,
        _blank = false,
        _blockParserFactories = _blockParserFactories,
        _inlineParserFactory = _inlineParserFactory,
        _inlineContentParserFactories = _inlineContentParserFactories,
        _delimiterProcessors = _delimiterProcessors,
        _linkProcessors = _linkProcessors,
        _linkMarkers = _linkMarkers,
        _includeSourceSpans = _includeSourceSpans,
        _maxOpenBlockParsers = _maxOpenBlockParsers,
        _maxInlineNesting = _maxInlineNesting,
        _enabledInlineTypes = _enabledInlineTypes,
        _linkReferenceDefinitions = bool1 ~= false,
        _documentBlockParser = DocumentBlockParser.new(),
        _definitions = Definitions.new(),
        _openBlockParsers = {},
        _allBlockParsers = {}
    }, module)

    self:activateBlockParser(tbl3.new(self._documentBlockParser, 0))
    return self
end

function module.getDefaultBlockParserTypes()
    return getDefaultBlockParserTypes
end

function module.calculateBlockParserFactories(tbl4, tbl5)
    local var2 = table.clone(tbl4)
    for _, value in ipairs(tbl5) do
        table.insert(var2, var1[value])
    end
    return var2
end

function module.checkEnabledBlockTypes(tbl4)
    for _, value in ipairs(tbl4) do
        if var1[value] == nil then
            local str1 = table.concat(getDefaultBlockParserTypes, ", ")
            error(`Can't enable block type {value}, possible options are: [{str1}]`)
        end
    end
end

function module.parse(arg1, str1: string)
    local num1 = 0
    local lineBreak = Characters.findLineBreak(str1, num1)

    while true do
        local bool1 = false

        if lineBreak == -1 then
            if str1 ~= "" and (num1 == 0 or num1 < #str1) then
                local num2 = num1 + 1
                arg1:parseLine(sub(str1, num2), num1)
            end

            return arg1:finalizeAndProcess()
        end

        local num2 = num1 + 1
        arg1:parseLine(sub(str1, num2, lineBreak), num1)

        if lineBreak + 1 < #str1 then
            if byte(str1, lineBreak + 1) == 13 then
                if byte(str1, lineBreak + 1 + 1) == 10 then
                    num1 = lineBreak + 2
                else
                    bool1 = true
                end
            else
                bool1 = true
            end
        else
            bool1 = true
        end

        if bool1 then
            num1 = lineBreak + 1
        end
        lineBreak = Characters.findLineBreak(str1, num1)
    end
end

function module.parseReader(arg1, str1: string)
    local lineReader = LineReader.new(str1)

    local var2 = lineReader:readLine()
    local num1 = 0

    while var2 ~= nil do
        arg1:parseLine(var2, num1)
        num1 += #var2
        local lineTerminator = lineReader:getLineTerminator()
        if lineTerminator ~= nil then
            num1 += #lineTerminator
        end
        var2 = lineReader:readLine()
    end

    return arg1:finalizeAndProcess()
end

function module:getLine()
    return self._line
end

function module:getIndex()
    return self._index
end

function module:getNextNonSpaceIndex()
    return self._nextNonSpace
end

function module:getColumn()
    return self._column
end

function module:getIndent()
    return self._indent
end

function module:isBlank()
    return self._blank
end

function module:getActiveBlockParser()
    local _openBlockParsers = self._openBlockParsers
    return _openBlockParsers[#_openBlockParsers - 1 + 1]._blockParser
end

function module:parseLine(str1: string, num1: number)
    self:setLine(str1, num1)

    local _openBlockParsers = self._openBlockParsers

    local num2 = 1
    for i = 1, #_openBlockParsers - 1 do
        local _openBlockParser = _openBlockParsers[i + 1]
        local _blockParser = _openBlockParser._blockParser
        self:findNextNonSpace()

        local var2 = _blockParser:tryContinue(self)
        if var2 == nil then
            break
        end
        _openBlockParser._sourceIndex = self:getIndex()
        if var2:isFinalize() then
            self:addSourceSpans()
            self:closeBlockParsers(#_openBlockParsers - i)
            return
        end
        if var2:getNewIndex() ~= -1 then
            self:setNewIndex(var2:getNewIndex())
        elseif var2:getNewColumn() ~= -1 then
            self:setNewColumn(var2:getNewColumn())
        end
        num2 += 1
    end

    local num3 = #_openBlockParsers - num2
    local _blockParser = _openBlockParsers[num2 - 1 + 1]._blockParser
    local bool1 = false

    local _index = self._index
    local var2 = _blockParser:getBlock().kind == "Paragraph" or _blockParser:isContainer()

    while var2 do
        _index = self._index
        self:findNextNonSpace()

        if self:isBlank()
            or self._indent < Parsing.CODE_BLOCK_INDENT and Characters.isLetter(self._line:getContent(), self._nextNonSpace)
        then
            self:setNewIndex(self._nextNonSpace)
            break
        end

        local var3 = self:findBlockStart(_blockParser)
        if var3 == nil then
            self:setNewIndex(self._nextNonSpace)
            break
        end

        bool1 = true
        local index = self:getIndex()

        if num3 > 0 then
            self:closeBlockParsers(num3)
            num3 = 0
        end

        if var3:getNewIndex() ~= -1 then
            self:setNewIndex(var3:getNewIndex())
        elseif var3:getNewColumn() ~= -1 then
            self:setNewColumn(var3:getNewColumn())
        end

        local var4 = nil
        if var3:getReplaceParagraphLines() >= 1 or var3:isReplaceActiveBlockParser() then
            local activeBlockParser = self:getActiveBlockParser()

            if isParagraphParser(activeBlockParser) then
                local var5 = if var3:isReplaceActiveBlockParser() then Integer.MAX_VALUE else var3:getReplaceParagraphLines()
                var4 = self:replaceParagraphLines(var5, activeBlockParser)
            elseif var3:isReplaceActiveBlockParser() then
                var4 = self:prepareActiveBlockParserForReplacement(activeBlockParser)
            end
        end

        for _, value in ipairs(var3:getBlockParsers()) do
            self:addChild(tbl3.new(value, index))
            if var4 ~= nil then
                value:getBlock():setSourceSpans(var4)
            end

            var2 = value:isContainer()
            _blockParser = value
        end
    end

    if not bool1 and not self:isBlank() and self:getActiveBlockParser():canHaveLazyContinuationLines() then
        _openBlockParsers[#_openBlockParsers - 1 + 1]._sourceIndex = _index

        self:addLine()
        return
    end

    if num3 > 0 then
        self:closeBlockParsers(num3)
    end

    if not _blockParser:isContainer() then
        self:addLine()
    elseif not self:isBlank() then
        local paragraphParser = ParagraphParser.new(self._linkReferenceDefinitions)
        self:addChild(tbl3.new(paragraphParser, _index))
        self:addLine()
    else
        self:addSourceSpans()
    end
end

local function prepareLine(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    if find(str1, "\0", 1, true) == nil then
        return str1
    end
    return (gsub(str1, "%z", "�"))
end

function module:setLine(str1: string, num1: number)
    self._lineIndex += 1
    self._index = 0
    self._column = 0
    self._columnIsInTab = false
    local var2 = prepareLine(str1)
    local var3 = if self._includeSourceSpans == IncludeSourceSpans.NONE then nil else SourceSpan.of(self._lineIndex, 0, num1, #var2)
    self._line = SourceLine.of(var2, var3)
end

function module:findNextNonSpace()
    local _index = self._index
    local _column = self._column

    self._blank = true
    local content = self._line:getContent()
    local contentLen = #content
    while _index < contentLen do
        local var2 = byte(content, _index + 1)
        if var2 == 32 then
            _index += 1
            _column += 1
        else
            if var2 ~= 9 then
                self._blank = false
                break
            end

            _index += 1
            _column += 4 - _column % 4
        end
    end

    self._nextNonSpace = _index
    self._nextNonSpaceColumn = _column
    self._indent = self._nextNonSpaceColumn - self._column
end

function module:setNewIndex(num1: number)
    if self._nextNonSpace <= num1 then
        self._index = self._nextNonSpace
        self._column = self._nextNonSpaceColumn
    end
    local num2 = #self._line:getContent()
    while self._index < num1 and self._index ~= num2 do
        self:advance()
    end

    self._columnIsInTab = false
end

function module:setNewColumn(_column: number)
    if self._nextNonSpaceColumn <= _column then
        self._index = self._nextNonSpace
        self._column = self._nextNonSpaceColumn
    end
    local num1 = #self._line:getContent()
    while self._column < _column and self._index ~= num1 do
        self:advance()
    end
    if _column < self._column then
        self._index -= 1
        self._column = _column
        self._columnIsInTab = true
        return
    end
    self._columnIsInTab = false
end

function module:advance()
    local var2 = byte(self._line:getContent(), self._index + 1)
    self._index += 1
    if var2 == 9 then
        self._column += Parsing.columnsToNextTabStop(self._column)
        return
    end
    self._column += 1
end

function module:addLine()
    local _line = self._line
    local _index = self._index
    local content

    if self._columnIsInTab then
        local var2 = _index + 1
        local var3 = sub(_line:getContent(), var2 + 1, #_line:getContent())
        local var4 = Parsing.columnsToNextTabStop(self._column)
        content = rep(" ", var4) .. var3
    elseif _index == 0 then
        content = _line:getContent()
    else
        content = sub(_line:getContent(), _index + 1, #_line:getContent())
    end
    local var2 = nil
    if self._includeSourceSpans == IncludeSourceSpans.BLOCKS_AND_INLINES then
        local sourceSpan = _line:getSourceSpan()
        if _index < sourceSpan:getLength() then
            var2 = sourceSpan:subSpan(_index)
        end
    end
    self:getActiveBlockParser():addLine(SourceLine.of(content, var2))
    self:addSourceSpans()
end

function module:addSourceSpans()
    if self._includeSourceSpans == IncludeSourceSpans.NONE then
        return
    end

    local _openBlockParsers = self._openBlockParsers
    local _line = self._line

    for i = 1, #_openBlockParsers - 1 do
        local _openBlockParser = _openBlockParsers[i + 1]

        local num1 = math.min(_openBlockParser._sourceIndex, self._index)
        if #_line:getContent() - num1 ~= 0 then
            _openBlockParser._blockParser:addSourceSpan(_line:getSourceSpan():subSpan(num1))
        end
    end
end

function module:findBlockStart(arg1)
    if #self._openBlockParsers > self._maxOpenBlockParsers then
        return nil
    end

    local var2 = tbl2.new(arg1)
    for _, value in ipairs(self._blockParserFactories) do
        local var3 = value:tryStart(self, var2)
        if var3 ~= nil then
            return var3
        end
    end
    return nil
end

function module:processInlines()
    local inlineParserContextImpl = InlineParserContextImpl.new(
        self._inlineContentParserFactories,
        self._delimiterProcessors,
        self._linkProcessors,
        self._linkMarkers,
        self._maxInlineNesting,
        self._definitions,
        self._enabledInlineTypes
    )
    local var2 = self._inlineParserFactory:create(inlineParserContextImpl)

    for _, _allBlockParser in ipairs(self._allBlockParsers) do
        _allBlockParser:parseInlines(var2)
    end
end

function module:addChild(arg1)
    while not self:getActiveBlockParser():canContain(arg1._blockParser:getBlock()) do
        self:closeBlockParsers(1)
    end

    self:getActiveBlockParser():getBlock():appendChild(arg1._blockParser:getBlock())
    self:activateBlockParser(arg1)
end

function module:activateBlockParser(arg1)
    table.insert(self._openBlockParsers, arg1)
end

function module:deactivateBlockParser()
    return table.remove(self._openBlockParsers)
end

function module:replaceParagraphLines(num1: number, arg1)
    local var2 = arg1:removeLines(num1)

    self:closeBlockParsers(1)
    return var2
end

function module:prepareActiveBlockParserForReplacement(arg1)
    self:deactivateBlockParser()

    arg1:closeBlock()
    arg1:getBlock():unlink()
    return arg1:getBlock():getSourceSpans()
end

function module:finalizeAndProcess()
    self:closeBlockParsers(#self._openBlockParsers)
    self:processInlines()
    return self._documentBlockParser:getBlock()
end

function module:closeBlockParsers(num1: number)
    for _ = 0, num1 - 1 do
        local _blockParser = self:deactivateBlockParser()._blockParser
        self:finalize(_blockParser)

        table.insert(self._allBlockParsers, _blockParser)
    end
end

function module:finalize(arg1)
    self:addDefinitionsFrom(arg1)
    arg1:closeBlock()
end

function module:addDefinitionsFrom(arg1)
    for _, value in ipairs(arg1:getDefinitions()) do
        self._definitions:addDefinitions(value)
    end
end

return module
