-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:01:12Z
-- Luau bytecode version: 14 | Luau type version: 3
local CommonMark = script:FindFirstAncestor("CommonMark")
local _AttributeProvider = require(CommonMark.renderer.html.AttributeProvider)
local _AttributeProviderContext = require(CommonMark.renderer.html.AttributeProviderContext)
local _AttributeProviderFactory = require(CommonMark.renderer.html.AttributeProviderFactory)
local _DefaultUrlSanitizer = require(CommonMark.renderer.html.DefaultUrlSanitizer)
local _HtmlNodeRendererContext = require(CommonMark.renderer.html.HtmlNodeRendererContext)
local _HtmlNodeRendererFactory = require(CommonMark.renderer.html.HtmlNodeRendererFactory)
local _HtmlWriter = require(CommonMark.renderer.html.HtmlWriter)
local _NodeRenderer = require(CommonMark.renderer.NodeRenderer)
local _UrlSanitizer = require(CommonMark.renderer.html.UrlSanitizer)

return {
    AttributeProvider = nil,
    AttributeProviderContext = nil,
    AttributeProviderFactory = nil,
    DefaultUrlSanitizer = nil,
    HtmlNodeRendererContext = nil,
    HtmlNodeRendererFactory = nil,
    HtmlWriter = nil,
    NodeRenderer = nil,
    UrlSanitizer = nil
}
