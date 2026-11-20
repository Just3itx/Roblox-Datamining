-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:00:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local AsciiMatcher = require(CommonMark.text.AsciiMatcher)
local _CharMatcher = require(CommonMark.text.CharMatcher)
local Html5Entities = require(CommonMark.internal.util.Html5Entities)
local _InlineContentParser = require(CommonMark.parser.beta.InlineContentParser)
local _InlineContentParserFactory = require(CommonMark.parser.beta.InlineContentParserFactory)
local _InlineParserState = require(CommonMark.parser.beta.InlineParserState)
local Nodes = require(CommonMark.node.Nodes)
local ParsedInline = require(CommonMark.parser.beta.ParsedInline)
local _Position = require(CommonMark.parser.beta.Position)
local _Scanner = require(CommonMark.parser.beta.Scanner)

local _byte = string.byte

local module = {}
module.__index = module

local var1 = AsciiMatcher.builder():range(48, 57):range(65, 70):range(97, 102):build()
local var2 = AsciiMatcher.builder():range(48, 57):build()
local var3 = AsciiMatcher.builder():range(65, 90):range(97, 122):build()
local var4 = var3:newBuilder():range(48, 57):build()

function module.new()
    return (setmetatable({}, module))
end

function module.tryParse(arg1, arg2)
    local var5 = arg2:scanner()
    local var6 = var5:position()

    var5:next()

    local var7 = var5:peek()
    if var7 == 35 then
        var5:next()
        if var5:nextChar(120) or var5:nextChar(88) then
            local var8 = var5:match(var1)
            if var8 >= 1 and var8 <= 6 and var5:nextChar(59) then
                return arg1:entity(var5, var6)
            end
        else
            local var8 = var5:match(var2)
            if var8 >= 1 and var8 <= 7 and var5:nextChar(59) then
                return arg1:entity(var5, var6)
            end
        end
    elseif var3:matches(var7) then
        var5:match(var4)
        if var5:nextChar(59) then
            return arg1:entity(var5, var6)
        end
    end

    return ParsedInline.none()
end

function module.entity(_, arg1, arg2)
    local content = arg1:getSource(arg2, arg1:position()):getContent()
    return ParsedInline.of(Nodes.Text(Html5Entities.entityToString(content)), arg1:position())
end

local Factory = {}
Factory.__index = Factory

function Factory.new()
    return (setmetatable({}, Factory))
end

function Factory.getTriggerCharacters(_): {boolean}
    return { [38] = true }
end

function Factory.create(_)
    return module.new()
end

module.Factory = Factory

return module
