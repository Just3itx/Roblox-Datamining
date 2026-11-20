-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:20:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local _AttributeProvider = require(CommonMark.renderer.html.AttributeProvider)
local _AttributeProviderContext = require(CommonMark.renderer.html.AttributeProviderContext)
local _AttributeProviderFactory = require(CommonMark.renderer.html.AttributeProviderFactory)
local CoreHtmlNodeRenderer = require(CommonMark.renderer.html.CoreHtmlNodeRenderer)
local DefaultUrlSanitizer = require(CommonMark.renderer.html.DefaultUrlSanitizer)
local Escaping = require(CommonMark.internal.util.Escaping)
local _Extension = require(CommonMark.Extension)
local _HtmlNodeRendererContext = require(CommonMark.renderer.html.HtmlNodeRendererContext)
local _HtmlNodeRendererFactory = require(CommonMark.renderer.html.HtmlNodeRendererFactory)
local HtmlWriter = require(CommonMark.renderer.html.HtmlWriter)
local LinkedHashMap = require(CommonMark.internal.port.LinkedHashMap)
local _Node = require(CommonMark.node.Node)
local _NodeRenderer = require(CommonMark.renderer.NodeRenderer)
local NodeRendererMap = require(CommonMark.internal.renderer.NodeRendererMap)
local _UrlSanitizer = require(CommonMark.renderer.html.UrlSanitizer)

local module = {}
module.__index = module

local tbl1 = {}
tbl1.__index = tbl1

function tbl1.new(_renderer, _htmlWriter)
    local self = setmetatable(
        {
            _renderer = _renderer,
            _htmlWriter = _htmlWriter,
            _attributeProviders = {},
            _nodeRendererMap = NodeRendererMap.new()
        },
        tbl1
    )

    for _, value in ipairs(_renderer._attributeProviderFactories) do
        table.insert(self._attributeProviders, value:create(self))
    end

    for _, value in ipairs(_renderer._nodeRendererFactories) do
        local var1 = value:create(self)
        self._nodeRendererMap:add(var1)
    end
    return self
end

function tbl1:shouldEscapeHtml()
    return self._renderer._escapeHtml
end

function tbl1:shouldOmitSingleParagraphP()
    return self._renderer._omitSingleParagraphP
end

function tbl1:shouldSanitizeUrls()
    return self._renderer._sanitizeUrls
end

function tbl1:urlSanitizer()
    return self._renderer._urlSanitizer
end

function tbl1:encodeUrl(str1: string)
    if self._renderer._percentEncodeUrls then
        return Escaping.percentEncodeUrl(str1)
    end
    return str1
end

function tbl1.extendAttributes(arg1, arg2, str1: string, arg3)
    local var1 = LinkedHashMap.newMap(arg3)
    arg1:setCustomAttributes(arg2, str1, var1)
    return var1
end

function tbl1:getWriter()
    return self._htmlWriter
end

function tbl1:getSoftbreak()
    return self._renderer._softbreak
end

function tbl1:render(arg1)
    self._nodeRendererMap:render(arg1)
end

function tbl1:beforeRoot(arg1)
    self._nodeRendererMap:beforeRoot(arg1)
end

function tbl1:afterRoot(arg1)
    self._nodeRendererMap:afterRoot(arg1)
end

function tbl1:setCustomAttributes(arg1, str1: string, arg2)
    for _, _attributeProvider in ipairs(self._attributeProviders) do
        _attributeProvider:setAttributes(arg1, str1, arg2)
    end
end

local tbl2 = {
    create = function(_, arg1)
        return (CoreHtmlNodeRenderer.new(arg1))
    end
}

function module.new(arg1)
    local _nodeRendererFactories = table.clone(arg1._nodeRendererFactories)

    table.insert(_nodeRendererFactories, tbl2)

    return (setmetatable({
        _softbreak = arg1._softbreak,
        _escapeHtml = arg1._escapeHtml,
        _percentEncodeUrls = arg1._percentEncodeUrls,
        _omitSingleParagraphP = arg1._omitSingleParagraphP,
        _sanitizeUrls = arg1._sanitizeUrls,
        _urlSanitizer = arg1._urlSanitizer,
        _attributeProviderFactories = table.clone(arg1._attributeProviderFactories),
        _nodeRendererFactories = _nodeRendererFactories
    }, module))
end

local Builder = {}
Builder.__index = Builder

function module.builder()
    return Builder.new()
end

function module.renderAppendable(arg1, arg2, tbl4)
    local var1 = tbl1.new(arg1, HtmlWriter.new(tbl4))
    var1:beforeRoot(arg2)
    var1:render(arg2)
    var1:afterRoot(arg2)
end

function module.render(arg1, arg2): string
    local tbl4 = {}
    arg1:renderAppendable(arg2, tbl4)
    return table.concat(tbl4)
end

function Builder.new()
    return (setmetatable({
        _softbreak = "\n",
        _escapeHtml = false,
        _sanitizeUrls = false,
        _urlSanitizer = DefaultUrlSanitizer.new(),
        _percentEncodeUrls = false,
        _omitSingleParagraphP = false,
        _attributeProviderFactories = {},
        _nodeRendererFactories = {}
    }, Builder))
end

function Builder.build(arg1)
    return module.new(arg1)
end

function Builder:softbreak(_softbreak: string)
    self._softbreak = _softbreak
    return self
end

function Builder:escapeHtml(_escapeHtml: boolean)
    self._escapeHtml = _escapeHtml
    return self
end

function Builder:sanitizeUrls(_sanitizeUrls: boolean)
    self._sanitizeUrls = _sanitizeUrls
    return self
end

function Builder:urlSanitizer(_urlSanitizer)
    self._urlSanitizer = _urlSanitizer
    return self
end

function Builder:percentEncodeUrls(_percentEncodeUrls: boolean)
    self._percentEncodeUrls = _percentEncodeUrls
    return self
end

function Builder:omitSingleParagraphP(_omitSingleParagraphP: boolean)
    self._omitSingleParagraphP = _omitSingleParagraphP
    return self
end

function Builder:attributeProviderFactory(arg1)
    table.insert(self._attributeProviderFactories, arg1)
    return self
end

function Builder:nodeRendererFactory(arg1)
    table.insert(self._nodeRendererFactories, arg1)
    return self
end

function Builder.extensions<T>(arg1: T, tbl4): T
    for _, value in ipairs(tbl4) do
        local extendHtmlRenderer = value.extendHtmlRenderer
        if extendHtmlRenderer ~= nil then
            extendHtmlRenderer(arg1)
        end
    end
    return arg1
end

module.Builder = Builder

return module
