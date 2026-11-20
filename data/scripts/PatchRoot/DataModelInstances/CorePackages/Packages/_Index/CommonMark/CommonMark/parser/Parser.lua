-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:20:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local _BlockParserFactory = require(CommonMark.parser.block.BlockParserFactory)
local Definitions = require(CommonMark.internal.Definitions)
local _DelimiterProcessor = require(CommonMark.parser.delimiter.DelimiterProcessor)
local DocumentParser = require(CommonMark.internal.DocumentParser)
local _Extension = require(CommonMark.Extension)
local IncludeSourceSpans = require(CommonMark.parser.IncludeSourceSpans)
local _InlineContentParserFactory = require(CommonMark.parser.beta.InlineContentParserFactory)
local _InlineParser = require(CommonMark.parser.InlineParser)
local _InlineParserContext = require(CommonMark.parser.InlineParserContext)
local InlineParserContextImpl = require(CommonMark.internal.InlineParserContextImpl)
local _InlineParserFactory = require(CommonMark.parser.InlineParserFactory)
local InlineParserImpl = require(CommonMark.internal.InlineParserImpl)
local _LinkProcessor = require(CommonMark.parser.beta.LinkProcessor)
local _Node = require(CommonMark.node.Node)
local _PostProcessor = require(CommonMark.parser.PostProcessor)

local module = {}
module.__index = module

function module.new(arg1)
    local self = setmetatable({
        _blockParserFactories = DocumentParser.calculateBlockParserFactories(arg1._blockParserFactories, arg1._enabledBlockTypes),
        _inlineParserFactory = arg1:getInlineParserFactory(),
        _postProcessors = arg1._postProcessors,
        _inlineContentParserFactories = arg1._inlineContentParserFactories,
        _delimiterProcessors = arg1._delimiterProcessors,
        _linkProcessors = arg1._linkProcessors,
        _linkMarkers = arg1._linkMarkers,
        _includeSourceSpans = arg1._includeSourceSpans,
        _maxOpenBlockParsers = arg1._maxOpenBlockParsers,
        _maxInlineNesting = arg1._maxInlineNesting,
        _enabledInlineTypes = arg1._enabledInlineTypes,
        _linkReferenceDefinitions = arg1._linkReferenceDefinitions
    }, module)

    local inlineParserContextImpl = InlineParserContextImpl.new(
        self._inlineContentParserFactories,
        self._delimiterProcessors,
        self._linkProcessors,
        self._linkMarkers,
        self._maxInlineNesting,
        Definitions.new(),
        self._enabledInlineTypes
    )
    self._inlineParserFactory:create(inlineParserContextImpl)
    return self
end

local Builder = {}
Builder.__index = Builder

function module.builder()
    return Builder.new()
end

function module.parse(arg1, str1: string)
    return arg1:postProcess((arg1:createDocumentParser():parse(str1)))
end

function module.parseReader(arg1, str1: string)
    return arg1:postProcess((arg1:createDocumentParser():parseReader(str1)))
end

function module:createDocumentParser()
    return DocumentParser.new(
        self._blockParserFactories,
        self._inlineParserFactory,
        self._inlineContentParserFactories,
        self._delimiterProcessors,
        self._linkProcessors,
        self._linkMarkers,
        self._includeSourceSpans,
        self._maxOpenBlockParsers,
        self._maxInlineNesting,
        self._enabledInlineTypes,
        self._linkReferenceDefinitions
    )
end

function module:postProcess(arg1)
    for _, _postProcessor in ipairs(self._postProcessors) do
        arg1 = _postProcessor:process(arg1)
    end
    return arg1
end

function Builder.new()
    return (setmetatable({
        _blockParserFactories = {},
        _inlineContentParserFactories = {},
        _delimiterProcessors = {},
        _linkProcessors = {},
        _postProcessors = {},
        _linkMarkers = {},
        _enabledBlockTypes = DocumentParser.getDefaultBlockParserTypes(),
        _enabledInlineTypes = nil,
        _linkReferenceDefinitions = true,
        _inlineParserFactory = nil,
        _includeSourceSpans = IncludeSourceSpans.NONE,
        _maxOpenBlockParsers = 100,
        _maxInlineNesting = 100
    }, Builder))
end

function Builder.build(arg1)
    return module.new(arg1)
end

function Builder.extensions<T>(arg1: T, tbl2): T
    for _, value in ipairs(tbl2) do
        local extendParser = value.extendParser
        if extendParser ~= nil then
            extendParser(arg1)
        end
    end
    return arg1
end

function Builder:enabledBlockTypes(_enabledBlockTypes)
    DocumentParser.checkEnabledBlockTypes(_enabledBlockTypes)
    self._enabledBlockTypes = _enabledBlockTypes
    return self
end

function Builder:enabledInlineTypes(_enabledInlineTypes)
    if _enabledInlineTypes ~= nil then
        InlineParserImpl.checkEnabledInlineTypes(_enabledInlineTypes)
    end
    self._enabledInlineTypes = _enabledInlineTypes
    return self
end

function Builder:linkReferenceDefinitions(_linkReferenceDefinitions: boolean)
    self._linkReferenceDefinitions = _linkReferenceDefinitions
    return self
end

function Builder:includeSourceSpans(_includeSourceSpans)
    self._includeSourceSpans = _includeSourceSpans
    return self
end

function Builder:maxOpenBlockParsers(_maxOpenBlockParsers: number)
    if _maxOpenBlockParsers < 0 then
        error("maxOpenBlockParsers must be >= 0")
    end
    self._maxOpenBlockParsers = _maxOpenBlockParsers
    return self
end

function Builder:maxInlineNesting(_maxInlineNesting: number)
    if _maxInlineNesting < 0 then
        error("maxInlineNesting must be >= 0")
    end
    self._maxInlineNesting = _maxInlineNesting
    return self
end

function Builder:customBlockParserFactory(arg1)
    table.insert(self._blockParserFactories, arg1)
    return self
end

function Builder:customInlineContentParserFactory(arg1)
    table.insert(self._inlineContentParserFactories, arg1)
    return self
end

function Builder:customDelimiterProcessor(arg1)
    table.insert(self._delimiterProcessors, arg1)
    return self
end

function Builder:linkProcessor(arg1)
    table.insert(self._linkProcessors, arg1)
    return self
end

function Builder:linkMarker(num1: number)
    self._linkMarkers[num1] = true
    return self
end

function Builder:postProcessor(arg1)
    table.insert(self._postProcessors, arg1)
    return self
end

function Builder:inlineParserFactory(_inlineParserFactory)
    self._inlineParserFactory = _inlineParserFactory
    return self
end

local tbl2 = {
    create = function(_, arg1)
        return (InlineParserImpl.new(arg1))
    end
}

function Builder:getInlineParserFactory()
    local _inlineParserFactory = self._inlineParserFactory
    return if _inlineParserFactory == nil then tbl2 else _inlineParserFactory
end

module.Builder = Builder

return module
