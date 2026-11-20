-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:00:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local AsciiMatcher = require(CommonMark.text.AsciiMatcher)
local _CharMatcher = require(CommonMark.text.CharMatcher)
local _InlineContentParser = require(CommonMark.parser.beta.InlineContentParser)
local _InlineContentParserFactory = require(CommonMark.parser.beta.InlineContentParserFactory)
local _InlineParserState = require(CommonMark.parser.beta.InlineParserState)
local Nodes = require(CommonMark.node.Nodes)
local ParsedInline = require(CommonMark.parser.beta.ParsedInline)

local _byte = string.byte
local find = string.find
local sub = string.sub

local module = {}
module.__index = module

local var1 = AsciiMatcher.builder():c(60):c(62):build()

local function isUri(str1: string): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local _, var2 = find(str1, "^[A-Za-z][A-Za-z0-9.+%-]*:")
    if var2 == nil then
        return false
    end
    local var3 = var2 - 1
    return not (var3 < 2 or var3 > 32) and find(str1, "[%z\1- <>]", var2 + 1) == nil
end

local function isDomainLabel(str1: string): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not (#str1 > 63) and (find(str1, "^[A-Za-z0-9]$") ~= nil or find(str1, "^[A-Za-z0-9][A-Za-z0-9%-]*[A-Za-z0-9]$") ~= nil)
end

local function isEmail(str1: string)
    local _, var2 = find(str1, "^[A-Za-z0-9.!#$%%&'*+/=?^_`{|}~%-]+@")
    if var2 == nil then
        return false
    end
    local var3 = var2 + 1
    while true do
        local var4 = find(str1, ".", var3, true)
        local var5 = var4 == nil and #str1 or var4 - 1

        if not isDomainLabel((sub(str1, var3, var5))) then
            break
        end

        if var4 == nil then
            return true
        end
        var3 = var4 + 1
    end

    return false
end

function module.new()
    return (setmetatable({}, module))
end

function module.tryParse(_, arg1)
    local var2 = arg1:scanner()
    var2:next()
    local var3 = var2:position()
    if var2:findMatcher(var1) > 0 then
        if var2:peek() ~= 62 then
            return ParsedInline.none()
        end

        local source = var2:getSource(var3, var2:position())
        local content = source:getContent()
        var2:next()

        local var4 = nil

        if isUri(content) then
            var4 = content
        elseif isEmail(content) then
            var4 = "mailto:" .. content
        end

        if var4 ~= nil then
            local var5 = Nodes.Link(var4, nil)
            local var6 = Nodes.Text(content)
            var6:setSourceSpans(source:getSourceSpans())
            var5:appendChild(var6)
            return ParsedInline.of(var5, var2:position())
        end
    end
    return ParsedInline.none()
end

local Factory = {}
Factory.__index = Factory

function Factory.new()
    return (setmetatable({}, Factory))
end

function Factory.getTriggerCharacters(_): {boolean}
    return { [60] = true }
end

function Factory.create(_)
    return module.new()
end

module.Factory = Factory

module._isUri = isUri
module._isEmail = isEmail

return module
