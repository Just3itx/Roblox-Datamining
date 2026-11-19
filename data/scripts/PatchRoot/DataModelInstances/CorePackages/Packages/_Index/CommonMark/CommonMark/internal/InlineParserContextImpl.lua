-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:20:54Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local _Definitions = require(CommonMark.internal.Definitions)
local _DelimiterProcessor = require(CommonMark.parser.delimiter.DelimiterProcessor)
local _InlineContentParserFactory = require(CommonMark.parser.beta.InlineContentParserFactory)
local _InlineParserContext = require(CommonMark.parser.InlineParserContext)
local _LinkProcessor = require(CommonMark.parser.beta.LinkProcessor)
local _LinkReferenceDefinition = require(CommonMark.node.LinkReferenceDefinition)

local module = {}
module.__index = module

function module.new(_inlineContentParserFactories, _delimiterProcessors, _linkProcessors, _linkMarkers, _maxInlineNesting: number, _definitions, _enabledInlineTypes)
    return (setmetatable({
        _inlineContentParserFactories = _inlineContentParserFactories,
        _delimiterProcessors = _delimiterProcessors,
        _linkProcessors = _linkProcessors,
        _linkMarkers = _linkMarkers,
        _maxInlineNesting = _maxInlineNesting,
        _definitions = _definitions,
        _enabledInlineTypes = _enabledInlineTypes
    }, module))
end

function module:getCustomInlineContentParserFactories()
    return self._inlineContentParserFactories
end

function module:getCustomDelimiterProcessors()
    return self._delimiterProcessors
end

function module:getCustomLinkProcessors()
    return self._linkProcessors
end

function module:getCustomLinkMarkers()
    return self._linkMarkers
end

function module:getMaxInlineNesting()
    return self._maxInlineNesting
end

function module:getEnabledInlineTypes()
    return self._enabledInlineTypes
end

function module:getLinkReferenceDefinition(str1: string)
    return self._definitions:getDefinition("LinkReferenceDefinition", str1)
end

function module:getDefinition(str1: string, str2: string)
    return self._definitions:getDefinition(str1, str2)
end

return module
