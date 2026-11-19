-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:21:02Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local DocumentParser = require(CommonMark.internal.DocumentParser)
local _Extension = require(CommonMark.Extension)
local _IncludeSourceSpans = require(CommonMark.parser.IncludeSourceSpans)
local Parser = require(CommonMark.parser.Parser)

local module = {}

function module.inCanonicalOrder(enabledBlockTypes)
    local tbl1 = ({})
    for _, value in ipairs(enabledBlockTypes) do
        tbl1[value] = true
    end
    local result = {}
    for _, value in ipairs(DocumentParser.getDefaultBlockParserTypes()) do
        if tbl1[value] then
            table.insert(result, value)
            tbl1[value] = nil
        end
    end
    for _, value in ipairs(enabledBlockTypes) do
        if tbl1[value] then
            table.insert(result, value)
            tbl1[value] = nil
        end
    end
    return result
end

local function buildParser(tbl1)
    local var1 = Parser.builder()
    if tbl1.extensions ~= nil then
        var1:extensions(tbl1.extensions)
    end
    if tbl1.enabledBlockTypes ~= nil then
        var1:enabledBlockTypes(module.inCanonicalOrder(tbl1.enabledBlockTypes))
    end
    if tbl1.enabledInlineTypes ~= nil then
        var1:enabledInlineTypes(tbl1.enabledInlineTypes)
    end
    if tbl1.linkReferenceDefinitions ~= nil then
        var1:linkReferenceDefinitions(tbl1.linkReferenceDefinitions)
    end
    if tbl1.includeSourceSpans ~= nil then
        var1:includeSourceSpans(tbl1.includeSourceSpans)
    end
    if tbl1.maxOpenBlockParsers ~= nil then
        var1:maxOpenBlockParsers(tbl1.maxOpenBlockParsers)
    end
    if tbl1.maxInlineNesting ~= nil then
        var1:maxInlineNesting(tbl1.maxInlineNesting)
    end
    return var1:build()
end

local function buildHtmlRenderer(tbl1)
    local var1 = require(CommonMark.renderer.html.HtmlRenderer).builder()
    if tbl1.extensions ~= nil then
        var1:extensions(tbl1.extensions)
    end
    if tbl1.softbreak ~= nil then
        var1:softbreak(tbl1.softbreak)
    end
    if tbl1.escapeHtml ~= nil then
        var1:escapeHtml(tbl1.escapeHtml)
    end
    if tbl1.sanitizeUrls ~= nil then
        var1:sanitizeUrls(tbl1.sanitizeUrls)
    end
    if tbl1.percentEncodeUrls ~= nil then
        var1:percentEncodeUrls(tbl1.percentEncodeUrls)
    end
    return var1:build()
end

local var1 = table.freeze({ __mode = "k" })
local var2 = table.freeze({})

local var3 = (setmetatable({}, var1))
local var4 = (setmetatable({}, var1))

function module.getParser(tbl1)
    if tbl1 == nil then
        tbl1 = var2
    end

    local var5 = var3[tbl1]
    if var5 == nil then
        var5 = buildParser(tbl1)
        var3[tbl1] = var5
    end
    return var5
end

function module.getHtmlRenderer(tbl1)
    if tbl1 == nil then
        tbl1 = var2
    end

    local var5 = var4[tbl1]
    if var5 == nil then
        var5 = buildHtmlRenderer(tbl1)
        var4[tbl1] = var5
    end
    return var5
end

return module
