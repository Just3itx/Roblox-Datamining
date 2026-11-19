-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:20:56Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local AutolinkInlineParser = require(CommonMark.internal.inline.AutolinkInlineParser)
local BackslashInlineParser = require(CommonMark.internal.inline.BackslashInlineParser)
local BackticksInlineParser = require(CommonMark.internal.inline.BackticksInlineParser)
local Bracket = require(CommonMark.internal.Bracket)
local Characters = require(CommonMark.text.Characters)
local CoreLinkProcessor = require(CommonMark.internal.inline.CoreLinkProcessor)
local Delimiter = require(CommonMark.internal.Delimiter)
local _DelimiterProcessor = require(CommonMark.parser.delimiter.DelimiterProcessor)
local EmphasisDelimiterProcessor = require(CommonMark.internal.inline.EmphasisDelimiterProcessor)
local EntityInlineParser = require(CommonMark.internal.inline.EntityInlineParser)
local Escaping = require(CommonMark.internal.util.Escaping)
local HtmlInlineParser = require(CommonMark.internal.inline.HtmlInlineParser)
local _InlineContentParser = require(CommonMark.parser.beta.InlineContentParser)
local _InlineContentParserFactory = require(CommonMark.parser.beta.InlineContentParserFactory)
local _InlineParserContext = require(CommonMark.parser.InlineParserContext)
local Integer = require(CommonMark.internal.port.Integer)
local _LinkInfo = require(CommonMark.parser.beta.LinkInfo)
local _LinkProcessor = require(CommonMark.parser.beta.LinkProcessor)
local LinkResult = require(CommonMark.parser.beta.LinkResult)
local LinkScanner = require(CommonMark.internal.util.LinkScanner)
local _Node = require(CommonMark.node.Node)
local Nodes = require(CommonMark.node.Nodes)
local _Position = require(CommonMark.parser.beta.Position)
local Scanner = require(CommonMark.parser.beta.Scanner)
local _SourceLines = require(CommonMark.parser.SourceLines)
local SourceSpans = require(CommonMark.node.SourceSpans)
local StaggeredDelimiterProcessor = require(CommonMark.internal.StaggeredDelimiterProcessor)

local _byte = string.byte
local gsub = string.gsub
local sub = string.sub

local END = Scanner.END

local module = {}
module.__index = module

local getDefaultInlineTypes = table.freeze(
    {
        "Code",
        "HtmlInline",
        "Autolink",
        "Entity",
        "BackslashEscape",
        "Emphasis",
        "Link",
        "Image",
        "HardLineBreak"
    }
)

local tbl1 = ({})
for _, value in ipairs(getDefaultInlineTypes) do
    tbl1[value] = true
end
table.freeze(tbl1)

function module.getDefaultInlineTypes()
    return getDefaultInlineTypes
end

function module.checkEnabledInlineTypes(tbl2)
    for _, value in ipairs(tbl2) do
        if not tbl1[value] then
            local str1 = table.concat(getDefaultInlineTypes, ", ")
            error(`Can't enable inline type {value}, possible options are: [{str1}]`)
        end
    end
end

local function calculateEnabledInlineTypes(_context)
    local getEnabledInlineTypes = _context.getEnabledInlineTypes
    local enabledInlineTypes = if getEnabledInlineTypes == nil then nil else getEnabledInlineTypes(_context)

    if enabledInlineTypes == nil then
        return tbl1
    end
    module.checkEnabledInlineTypes(enabledInlineTypes)
    local enabledInlineTypes2 = ({})
    for _, value in ipairs(enabledInlineTypes) do
        enabledInlineTypes2[value] = true
    end
    return enabledInlineTypes2
end

local function addDelimiterProcessorForChar<T>(num1: number, arg1: T, tbl2) -- Luacid: Inlined by compiler; 3 call sites recovered
    local var2 = tbl2[num1]
    tbl2[num1] = arg1
    if var2 ~= nil then
        error(`Delimiter processor conflict with delimiter char '{string.char(num1)}'`)
    end
end

local function addDelimiterProcessors(tbl2, tbl3)
    for _, value in ipairs(tbl2) do
        local openingCharacter = value:getOpeningCharacter()
        local closingCharacter = value:getClosingCharacter()
        if openingCharacter == closingCharacter then
            local var2 = tbl3[openingCharacter]
            if var2 ~= nil and var2:getOpeningCharacter() == var2:getClosingCharacter() then
                local staggeredDelimiterProcessor

                if getmetatable(var2) == StaggeredDelimiterProcessor then
                    staggeredDelimiterProcessor = var2
                else
                    staggeredDelimiterProcessor = StaggeredDelimiterProcessor.new(openingCharacter)
                    staggeredDelimiterProcessor:add(var2)
                end
                staggeredDelimiterProcessor:add(value)
                tbl3[openingCharacter] = staggeredDelimiterProcessor
            else
                addDelimiterProcessorForChar(openingCharacter, value, tbl3)
            end
        else
            addDelimiterProcessorForChar(openingCharacter, value, tbl3)
            addDelimiterProcessorForChar(closingCharacter, value, tbl3)
        end
    end
end

local function calculateDelimiterProcessors(customDelimiterProcessors, enabledInlineTypes)
    local delimiterProcessors = {}

    if enabledInlineTypes.Emphasis then
        addDelimiterProcessors({ EmphasisDelimiterProcessor.new(42), EmphasisDelimiterProcessor.new(95) }, delimiterProcessors)
    end

    addDelimiterProcessors(customDelimiterProcessors, delimiterProcessors)
    return delimiterProcessors
end

local function calculateLinkMarkers(customLinkMarkers, enabledInlineTypes) -- Luacid: Inlined by compiler; 1 call site recovered
    local linkMarkers = ({})
    for k in pairs(customLinkMarkers) do
        linkMarkers[k] = true
    end
    if enabledInlineTypes.Image then
        linkMarkers[33] = true
    end
    return linkMarkers
end

local function calculateSpecialCharacters(_linkMarkers, _delimiterProcessors, _inlineContentParserFactories, _bracketsEnabled: boolean): {boolean}
    local var2 = table.clone(_linkMarkers)
    for k in pairs(_delimiterProcessors) do
        var2[k] = true
    end
    for _, value in ipairs(_inlineContentParserFactories) do
        for k in pairs(value:getTriggerCharacters()) do
            var2[k] = true
        end
    end
    if _bracketsEnabled then
        var2[91] = true
        var2[93] = true
    end
    var2[33] = true
    var2[10] = true
    return var2
end

function module.new(_context)
    local self = setmetatable({ _nestingDepths = {}, _delimiterIndexes = {}, _disallowWalked = {} }, module)
    self._context = _context
    local _enabledInlineTypes = calculateEnabledInlineTypes(_context)
    self._enabledInlineTypes = _enabledInlineTypes
    local customLinkProcessors = _context:getCustomLinkProcessors()
    local customLinkMarkers = _context:getCustomLinkMarkers()
    self._bracketsEnabled = _enabledInlineTypes.Link == true
        or _enabledInlineTypes.Image == true
        or #customLinkProcessors > 0
        or next(customLinkMarkers) ~= nil
    self._inlineContentParserFactories = self:calculateInlineContentParserFactories(_context:getCustomInlineContentParserFactories())
    self._delimiterProcessors = calculateDelimiterProcessors(_context:getCustomDelimiterProcessors(), _enabledInlineTypes)
    self._linkProcessors = self:calculateLinkProcessors(customLinkProcessors)
    self._linkMarkers = calculateLinkMarkers(customLinkMarkers, _enabledInlineTypes)
    self._maxInlineNesting = _context:getMaxInlineNesting()
    self._limitInlineNesting = self._maxInlineNesting ~= Integer.MAX_VALUE
    self._specialCharacters = calculateSpecialCharacters(
        self._linkMarkers,
        self._delimiterProcessors,
        self._inlineContentParserFactories,
        self._bracketsEnabled
    )
    return self
end

function module:calculateInlineContentParserFactories(tbl2)
    local var2 = table.clone(tbl2)
    local _enabledInlineTypes = self._enabledInlineTypes
    if _enabledInlineTypes.BackslashEscape then
        table.insert(var2, BackslashInlineParser.Factory.new(_enabledInlineTypes.HardLineBreak == true))
    end
    if _enabledInlineTypes.Code then
        table.insert(var2, BackticksInlineParser.Factory.new())
    end
    if _enabledInlineTypes.Entity then
        table.insert(var2, EntityInlineParser.Factory.new())
    end
    if _enabledInlineTypes.Autolink then
        table.insert(var2, AutolinkInlineParser.Factory.new())
    end
    if _enabledInlineTypes.HtmlInline then
        table.insert(var2, HtmlInlineParser.Factory.new())
    end
    return var2
end

function module:calculateLinkProcessors(tbl2)
    local var2 = table.clone(tbl2)
    local _enabledInlineTypes = self._enabledInlineTypes
    if _enabledInlineTypes.Link or _enabledInlineTypes.Image then
        table.insert(var2, CoreLinkProcessor.new(_enabledInlineTypes.Link == true, _enabledInlineTypes.Image == true))
    end
    return var2
end

function module:createInlineContentParsers()
    local inlineContentParsers = ({})
    for _, value in ipairs(self._inlineContentParserFactories) do
        local var2 = value:create()
        for k in pairs(value:getTriggerCharacters()) do
            local inlineContentParser = inlineContentParsers[k]
            if inlineContentParser == nil then
                inlineContentParser = {}
                inlineContentParsers[k] = inlineContentParser
            end
            table.insert(inlineContentParser, var2)
        end
    end
    return inlineContentParsers
end

function module.scanner(arg1)
    return arg1._scanner
end

function module.parse(arg1, arg2, arg3)
    arg1:reset(arg2)

    while true do
        local var2 = arg1:parseInline()
        if var2 == nil then
            break
        end

        for _, value in ipairs(var2) do
            arg3:appendChild(value)
        end
    end

    arg1:processDelimiters(nil)
    arg1:mergeChildTextNodes(arg3)
end

function module:reset(arg1)
    self._scanner = Scanner.of(arg1)
    self._includeSourceSpans = #arg1:getSourceSpans() > 0
    self._trailingSpaces = 0
    self._lastDelimiter = nil
    self._lastBracket = nil
    table.clear(self._disallowWalked)
    table.clear(self._nestingDepths)
    table.clear(self._delimiterIndexes)
    self._delimiterCount = 0
    self._inlineParsers = self:createInlineContentParsers()
end

function module:text(arg1)
    local var2 = Nodes.Text(arg1:getContent())
    var2:setSourceSpans(arg1:getSourceSpans())
    return var2
end

function module:parseInline()
    local _scanner = self._scanner
    local var2 = _scanner:peek()

    if var2 == 91 and self._bracketsEnabled then
        return { self:parseOpenBracket() }
    end

    if var2 == 93 and self._bracketsEnabled then
        return { self:parseCloseBracket() }
    end

    if var2 == 10 then
        return { self:parseLineBreak() }
    end

    if var2 == END then
        return nil
    end

    if self._linkMarkers[var2] then
        local var3 = _scanner:position()
        local var4 = self:parseLinkMarker()
        if var4 ~= nil then
            return var4
        end

        _scanner:setPosition(var3)
    end

    if not self._specialCharacters[var2] then
        return { self:parseText() }
    end

    local _inlineParser = self._inlineParsers[var2]
    if _inlineParser ~= nil then
        local var3 = _scanner:position()
        for _, value in ipairs(_inlineParser) do
            local var4 = value:tryParse(self)
            if var4 ~= nil then
                local node = var4:getNode()
                _scanner:setPosition(var4:getPosition())
                if self._includeSourceSpans and #node:getSourceSpans() == 0 then
                    node:setSourceSpans(_scanner:getSource(var3, _scanner:position()):getSourceSpans())
                end
                return { node }
            end

            _scanner:setPosition(var3)
        end
    end

    local _delimiterProcessor = self._delimiterProcessors[var2]
    if _delimiterProcessor ~= nil then
        local var3 = self:parseDelimiters(_delimiterProcessor, var2)
        if var3 ~= nil then
            return var3
        end
    end

    return { self:parseText() }
end

function module:parseDelimiters(arg1, num1: number)
    local var2 = self:scanDelimiters(arg1, num1)
    if var2 == nil then
        return nil
    end

    local characters = var2.characters

    local delimiter = Delimiter.new(characters, num1, var2.canOpen, var2.canClose, self._lastDelimiter)
    self._lastDelimiter = delimiter
    self._delimiterCount += 1
    self._delimiterIndexes[delimiter] = self._delimiterCount
    if delimiter.previous ~= nil then
        delimiter.previous.next = delimiter
    end

    return characters
end

function module:parseOpenBracket()
    local _scanner = self._scanner
    local var2 = _scanner:position()
    _scanner:next()
    local var3 = _scanner:position()

    local var4 = self:text(_scanner:getSource(var2, var3))

    self:addBracket(Bracket.link(var4, var2, var3, self._lastBracket, self._lastDelimiter))

    return var4
end

function module:parseLinkMarker()
    local _scanner = self._scanner
    local var2 = _scanner:position()
    _scanner:next()
    local var3 = _scanner:position()
    if not _scanner:nextChar(91) then
        return nil
    end

    local var4 = _scanner:position()
    local var5 = self:text(_scanner:getSource(var2, var3))
    local var6 = self:text(_scanner:getSource(var3, var4))

    self:addBracket(Bracket.withMarker(var5, var2, var6, var3, var4, self._lastBracket, self._lastDelimiter))

    return { var5, var6 }
end

function module:parseCloseBracket()
    local _scanner = self._scanner
    local var2 = _scanner:position()
    _scanner:next()
    local var3 = _scanner:position()

    local _lastBracket = self._lastBracket
    if _lastBracket == nil then
        return self:text(_scanner:getSource(var2, var3))
    end

    if not _lastBracket.allowed then
        self:removeLastBracket()
        return self:text(_scanner:getSource(var2, var3))
    end

    local var4 = self:parseLinkOrImage(_lastBracket, var2)
    if var4 ~= nil then
        return var4
    end
    _scanner:setPosition(var3)

    self:removeLastBracket()
    return self:text(_scanner:getSource(var2, var3))
end

function module:parseLinkOrImage(arg1, arg2)
    local _scanner = self._scanner
    local var2 = self:parseLinkInfo(arg1, arg2)
    if var2 == nil then
        return nil
    end
    local var3 = _scanner:position()

    for _, _linkProcessor in ipairs(self._linkProcessors) do
        local var4 = _linkProcessor:process(var2, _scanner, self._context)
        if var4 == nil then
            _scanner:setPosition(var3)
        else
            local node = var4:getNode()
            local position = var4:getPosition()
            local var5 = var4:isIncludeMarker()

            local type = var4:getType()
            if type == LinkResult.Type.WRAP then
                _scanner:setPosition(position)
                return self:wrapBracket(arg1, node, var5)
            end

            if type == LinkResult.Type.REPLACE then
                _scanner:setPosition(position)
                return self:replaceBracket(arg1, node, var5)
            end
        end
    end
    return nil
end

local tbl2 = {}
tbl2.__index = tbl2

function tbl2.new(destination: string, title: string?)
    return (setmetatable({ destination = destination, title = title }, tbl2))
end

local tbl3 = {}
tbl3.__index = tbl3

function tbl3.new(_marker, _openingBracket, _scanner, _textStart, _textEnd, _label: string?, _destination: string?, _title: string?, _afterTextBracket)
    return (setmetatable({
        _marker = _marker,
        _openingBracket = _openingBracket,
        _text = nil,
        _scanner = _scanner,
        _textStart = _textStart,
        _textEnd = _textEnd,
        _label = _label,
        _destination = _destination,
        _title = _title,
        _afterTextBracket = _afterTextBracket
    }, tbl3))
end

function tbl3:marker()
    return self._marker
end

function tbl3:openingBracket()
    return self._openingBracket
end

function tbl3:text()
    local _text = self._text
    if _text ~= nil then
        return _text
    end
    local content = self._scanner:getSource(self._textStart, self._textEnd):getContent()
    self._text = content
    return content
end

function tbl3:label()
    return self._label
end

function tbl3:destination()
    return self._destination
end

function tbl3:title()
    return self._title
end

function tbl3:afterTextBracket()
    return self._afterTextBracket
end

local function parseLinkDestination(_scanner)
    local var2 = _scanner:peek()
    local var3 = _scanner:position()
    if not LinkScanner.scanLinkDestination(_scanner) then
        return nil
    end

    local content

    if var2 == 60 then
        local content2 = _scanner:getSource(var3, _scanner:position()):getContent()
        content = sub(content2, 2, #content2 - 1)
    else
        content = _scanner:getSource(var3, _scanner:position()):getContent()
    end

    return Escaping.unescapeString(content)
end

local function parseLinkTitle(_scanner)
    local var2 = _scanner:position()
    if not LinkScanner.scanLinkTitle(_scanner) then
        return nil
    end

    local content = _scanner:getSource(var2, _scanner:position()):getContent()
    local var3 = sub(content, 2, #content - 1)
    return Escaping.unescapeString(var3)
end

local function parseInlineDestinationTitle(_scanner)
    if not _scanner:nextChar(40) then
        return nil
    end

    _scanner:whitespace()
    local var2 = parseLinkDestination(_scanner)
    if var2 == nil then
        return nil
    end

    local var3

    if _scanner:whitespace() >= 1 then
        var3 = parseLinkTitle(_scanner)
        _scanner:whitespace()
    else
        var3 = nil
    end
    if not _scanner:nextChar(41) then
        return nil
    end
    return tbl2.new(var2, var3)
end

function module:parseLinkInfo(arg1, arg2)
    local _scanner = self._scanner

    local var2 = _scanner:position()

    local var3 = parseInlineDestinationTitle(_scanner)
    if var3 ~= nil then
        return tbl3.new(
            arg1.markerNode,
            arg1.bracketNode,
            _scanner,
            arg1.contentPosition,
            arg2,
            nil,
            var3.destination,
            var3.title,
            var2
        )
    end

    _scanner:setPosition(var2)

    local var4 = module.parseLinkLabel(_scanner)
    if var4 == nil then
        _scanner:setPosition(var2)
    end
    if arg1.bracketAfter and (var4 == nil or var4 == "") and arg1.markerNode == nil then
        return nil
    end

    return tbl3.new(arg1.markerNode, arg1.bracketNode, _scanner, arg1.contentPosition, arg2, var4, nil, nil, var2)
end

function module:wrapBracket(arg1, nil1: nil, bool1: boolean)
    local _scanner = self._scanner

    if self._limitInlineNesting and arg1.contentNestingDepth >= self._maxInlineNesting then
        return nil
    end

    local next = arg1.bracketNode:getNext()
    while next ~= nil do
        local next2 = next:getNext()
        nil1:appendChild(next)
        next = next2
    end

    if self._includeSourceSpans then
        local var2 = if bool1 and arg1.markerPosition ~= nil then arg1.markerPosition else arg1.bracketPosition
        nil1:setSourceSpans(_scanner:getSource(var2, _scanner:position()):getSourceSpans())
    end

    self:processDelimiters(arg1.previousDelimiter)
    self:mergeChildTextNodes(nil1)

    if bool1 and arg1.markerNode ~= nil then
        arg1.markerNode:unlink()
    end
    arg1.bracketNode:unlink()
    self:removeLastBracket()

    self:recordNestingDepth(nil1, arg1.contentNestingDepth + 1)

    if arg1.markerNode == nil then
        self:disallowPreviousLinks()
    end

    return nil1
end

function module:replaceBracket<T>(arg1, arg2: T, bool1: boolean): T
    local _scanner = self._scanner

    while self._lastDelimiter ~= nil and self._lastDelimiter ~= arg1.previousDelimiter do
        self:removeDelimiterKeepNode(self._lastDelimiter)
    end

    if self._includeSourceSpans then
        local var2 = if bool1 and arg1.markerPosition ~= nil then arg1.markerPosition else arg1.bracketPosition
        arg2:setSourceSpans(_scanner:getSource(var2, _scanner:position()):getSourceSpans())
    end

    self:removeLastBracket()
    local var2 = if bool1 and arg1.markerNode ~= nil then arg1.markerNode else arg1.bracketNode

    while var2 ~= nil do
        local next = var2:getNext()
        var2:unlink()
        var2 = next
    end

    self:recordNestingDepth(arg2, self:nestingDepthOfSiblings(arg2:getFirstChild(), nil) + 1)

    if arg1.markerNode == nil or not bool1 then
        self:disallowPreviousLinks()
    end

    return arg2
end

function module:addBracket(_lastBracket)
    if self._lastBracket ~= nil then
        self._lastBracket.bracketAfter = true
    end
    self._lastBracket = _lastBracket
end

function module:removeLastBracket()
    local _lastBracket = self._lastBracket
    self._lastBracket = _lastBracket.previous

    if self._lastBracket ~= nil and _lastBracket.contentNestingDepth > self._lastBracket.contentNestingDepth then
        self._lastBracket.contentNestingDepth = _lastBracket.contentNestingDepth
    end
end

function module:disallowPreviousLinks()
    local _lastBracket = self._lastBracket
    while _lastBracket ~= nil and not self._disallowWalked[_lastBracket] do
        self._disallowWalked[_lastBracket] = true
        if _lastBracket.markerNode == nil then
            _lastBracket.allowed = false
        end
        _lastBracket = _lastBracket.previous
    end
end

local function codePointCount(content: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local _, var2 = gsub(content, "[^\128-\191]", "")
    return var2
end

function module.parseLinkLabel(arg1)
    if not arg1:nextChar(91) then
        return nil
    end

    local var2 = arg1:position()
    if not LinkScanner.scanLinkLabelContent(arg1) then
        return nil
    end
    local var3 = arg1:position()

    if not arg1:nextChar(93) then
        return nil
    end

    local content = arg1:getSource(var2, var3):getContent()

    return if codePointCount(content) > 999 then nil else content
end

function module:parseLineBreak()
    self._scanner:next()
    local bool1 = self._trailingSpaces >= 2 and self._enabledInlineTypes.HardLineBreak == true
    self._trailingSpaces = 0
    if bool1 then
        return Nodes.HardLineBreak()
    end
    return Nodes.SoftLineBreak()
end

function module:parseText()
    local _scanner = self._scanner
    local _specialCharacters = self._specialCharacters
    local var2 = _scanner:position()
    _scanner:next()
    local var3

    while true do
        var3 = _scanner:peek()
        if var3 == END or _specialCharacters[var3] then
            break
        end

        _scanner:next()
    end

    local source = _scanner:getSource(var2, _scanner:position())
    local content = source:getContent()

    if var3 == 10 then
        local var4 = Characters.skipBackwards(32, content, #content - 1, 0) + 1
        self._trailingSpaces = #content - var4
        content = sub(content, 1, var4)
    elseif var3 == END then
        content = sub(content, 1, Characters.skipSpaceTabBackwards(content, #content - 1, 0) + 1)
    end

    local var4 = Nodes.Text(content)
    var4:setSourceSpans(source:getSourceSpans())
    return var4
end

local tbl4 = {
    new = function(delimiterChar: number, num1: number): number
        return delimiterChar * 6 + num1
    end
}
local tbl5 = {}
tbl5.__index = tbl5

function tbl5.new(characters, canOpen: boolean, canClose: boolean)
    return (setmetatable({ characters = characters, canOpen = canOpen, canClose = canClose }, tbl5))
end

function module:scanDelimiters(arg1, num1: number)
    local _scanner = self._scanner
    local var2 = _scanner:peekPreviousCodePoint()
    local var3 = _scanner:position()

    if _scanner:matchMultiple(num1) < arg1:getMinLength() then
        _scanner:setPosition(var3)
        return nil
    end

    _scanner:setPosition(var3)
    local tbl6 = {}

    while _scanner:nextChar(num1) do
        table.insert(tbl6, self:text(_scanner:getSource(var3, _scanner:position())))
        var3 = _scanner:position()
    end

    local var4 = _scanner:peekCodePoint()

    local var5 = var2 == END or Characters.isPunctuationCodePoint(var2)
    local var6 = var2 == END or Characters.isWhitespaceCodePoint(var2)
    local var7 = var4 == END or Characters.isPunctuationCodePoint(var4)
    local var8 = var4 == END or Characters.isWhitespaceCodePoint(var4)

    local var9 = not var8 and (not var7 or var6 or var5)
    local var10 = not var6 and (not var5 or var8 or var7)
    local var11, var12

    if num1 == 95 then
        var11 = var9 and (not var10 or var5)
        var12 = var10 and (not var9 or var7)
    else
        var11 = var9 and num1 == arg1:getOpeningCharacter()
        var12 = var10 and num1 == arg1:getClosingCharacter()
    end

    return tbl5.new(tbl6, var11, var12)
end

function module:processDelimiters(arg1)
    local _lastDelimiter = self._lastDelimiter
    local tbl6 = ({})

    while _lastDelimiter ~= nil and _lastDelimiter.previous ~= arg1 do
        _lastDelimiter = _lastDelimiter.previous
    end

    while true do
        while true do
            if _lastDelimiter == nil then
                while self._lastDelimiter ~= nil and self._lastDelimiter ~= arg1 do
                    self:removeDelimiterKeepNode(self._lastDelimiter)
                end
                return
            end

            local _delimiterProcessor = self._delimiterProcessors[_lastDelimiter.delimiterChar]
            if not _lastDelimiter:canClose() or _delimiterProcessor == nil then
                break
            end

            local num1 = tbl4.new(
                _lastDelimiter.delimiterChar,
                _lastDelimiter:originalLength() % 3 + (if _lastDelimiter:canOpen() then 3 else 0)
            )
            local var2 = tbl6[num1]
            local var3 = if var2 == nil or _delimiterProcessor._rejectsByMultipleOf3Rule ~= true then nil else self._delimiterIndexes[var2]
            local openingCharacter = _delimiterProcessor:getOpeningCharacter()

            local previous = _lastDelimiter.previous

            local closer = _lastDelimiter:getCloser()
            local bool1 = false
            local num2 = 0
            local next = nil
            local num3 = 0
            local num4 = 0

            while previous ~= nil and previous ~= arg1 and previous ~= var2 and (var3 == nil or var3 < self._delimiterIndexes[previous]) do
                if self._limitInlineNesting then
                    local next2 = previous:getOpener():getNext()
                    num4 = math.max(num4, self:nestingDepthOfSiblings(next2, closer))
                    closer = previous:getOpener()
                    if self._maxInlineNesting <= num4 then
                        break
                    end
                end

                if previous:canOpen() and previous.delimiterChar == openingCharacter then
                    num2 = _delimiterProcessor:process(previous, _lastDelimiter)
                    if num2 > 0 then
                        num3 = num4 + 1

                        next = previous:getOpener():getNext()
                        bool1 = true
                        break
                    end
                end

                previous = previous.previous
            end

            if not bool1 then
                tbl6[num1] = _lastDelimiter.previous
                if not _lastDelimiter:canOpen() then
                    self:removeDelimiterKeepNode(_lastDelimiter)
                end
                _lastDelimiter = _lastDelimiter.next
            else
                for _ = 0, num2 - 1 do
                    table.remove(previous.characters):unlink()
                end
                for _ = 0, num2 - 1 do
                    table.remove(_lastDelimiter.characters, 1):unlink()
                end

                self:removeDelimitersBetween(previous, _lastDelimiter)

                if next ~= nil then
                    self:recordNestingDepth(next, num3)
                end

                if previous:length() == 0 then
                    self:removeDelimiterAndNodes(previous)
                end

                if _lastDelimiter:length() == 0 then
                    local next2 = _lastDelimiter.next
                    self:removeDelimiterAndNodes(_lastDelimiter)
                    _lastDelimiter = next2
                end
            end
        end

        _lastDelimiter = _lastDelimiter.next
    end
end

function module:recordNestingDepth(arg1, contentNestingDepth: number)
    if not self._limitInlineNesting then
        return
    end
    self._nestingDepths[arg1] = contentNestingDepth
    if self._lastBracket ~= nil and self._lastBracket.contentNestingDepth < contentNestingDepth then
        self._lastBracket.contentNestingDepth = contentNestingDepth
    end
end

function module:nestingDepthOfSiblings(arg1, arg2)
    local num1 = 0

    while arg1 ~= nil and arg1 ~= arg2 do
        local _nestingDepth = self._nestingDepths[arg1]
        if _nestingDepth ~= nil and num1 < _nestingDepth then
            num1 = _nestingDepth
        end

        arg1 = arg1:getNext()
    end
    return num1
end

function module:removeDelimitersBetween(arg1, arg2)
    local previous = arg2.previous
    while previous ~= nil and previous ~= arg1 do
        local previous2 = previous.previous
        self:removeDelimiterKeepNode(previous)
        previous = previous2
    end
end

function module:removeDelimiterAndNodes(arg1)
    self:removeDelimiter(arg1)
end

function module:removeDelimiterKeepNode(arg1)
    self:removeDelimiter(arg1)
end

function module:removeDelimiter(arg1)
    if arg1.previous ~= nil then
        arg1.previous.next = arg1.next
    end
    if arg1.next == nil then
        self._lastDelimiter = arg1.previous
        return
    end
    arg1.next.previous = arg1.previous
end

function module:mergeChildTextNodes(arg1)
    if arg1:getFirstChild() == nil then
        return
    end

    local tbl6 = { arg1 }

    while #tbl6 > 0 do
        self:mergeTextNodesInclusive(table.remove(tbl6), tbl6)
    end
end

function module:mergeTextNodesInclusive(arg1, tbl6)
    local firstChild = arg1:getFirstChild()
    local lastChild = arg1:getLastChild()
    local var2 = nil
    local var3 = nil
    local num1 = 0

    while firstChild ~= nil do
        if firstChild.kind == "Text" then
            if var2 == nil then
                var2 = firstChild
            end

            num1 += #firstChild.literal
            var3 = firstChild
        else
            self:mergeIfNeeded(var2, var3, num1)
            var2 = nil
            var3 = nil
            num1 = 0

            if firstChild:getFirstChild() ~= nil then
                table.insert(tbl6, firstChild)
            end
        end
        if firstChild == lastChild then
            break
        end

        firstChild = firstChild:getNext()
    end

    self:mergeIfNeeded(var2, var3, num1)
end

function module:mergeIfNeeded(arg1, arg2, _: number)
    if arg1 == nil or arg2 == nil or arg1 == arg2 then
        return
    end

    local tbl6 = { arg1.literal }
    local num1 = 1
    local sourceSpans

    if self._includeSourceSpans then
        sourceSpans = SourceSpans.new()
        sourceSpans:addAll(arg1:getSourceSpans())
    else
        sourceSpans = nil
    end

    local next = arg1:getNext()
    local next2 = arg2:getNext()

    while next ~= next2 do
        num1 += 1
        tbl6[num1] = next.literal
        if sourceSpans ~= nil then
            sourceSpans:addAll(next:getSourceSpans())
        end

        local next3 = next:getNext()
        next:unlink()
        next = next3
    end
    arg1.literal = table.concat(tbl6)
    if sourceSpans ~= nil then
        arg1:setSourceSpans(sourceSpans:getSourceSpans())
    end
end

return module
