-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local Characters = require(CommonMark.text.Characters)
local _InlineContentParser = require(CommonMark.parser.beta.InlineContentParser)
local _InlineContentParserFactory = require(CommonMark.parser.beta.InlineContentParserFactory)
local _InlineParserState = require(CommonMark.parser.beta.InlineParserState)
local Nodes = require(CommonMark.node.Nodes)
local ParsedInline = require(CommonMark.parser.beta.ParsedInline)
local _Position = require(CommonMark.parser.beta.Position)

local byte = string.byte
local gsub = string.gsub
local sub = string.sub

local module = {}
module.__index = module

function module.new()
    return (setmetatable({ _backtickPositions = {}, _scannedToEnd = false }, module))
end

function module:tryParse(arg1)
    local var1 = arg1:scanner()
    local var2 = var1:position()
    local var3 = var1:matchMultiple(96)
    local var4 = var1:position()

    if self._scannedToEnd then
        local _backtickPosition = self._backtickPositions[var3]
        if _backtickPosition == nil or _backtickPosition:compareTo(var2) <= 0 then
            local var5 = Nodes.Text(var1:getSource(var2, var4):getContent())
            return ParsedInline.of(var5, var4)
        end
    end

    while var1:findChar(96) > 0 do
        local var5 = var1:position()
        local var6 = var1:matchMultiple(96)

        self._backtickPositions[var6] = var5
        if var6 ~= var3 then
            continue
        end

        local var7 = Nodes.Code()

        local content = var1:getSource(var4, var5):getContent()
        local var8 = gsub(content, "\n", " ")

        if #var8 >= 3 and byte(var8, 1) == 32 then
            local num1 = #var8

            if byte(var8, num1) == 32 and Characters.hasNonSpace(var8) then
                var8 = sub(var8, 2, #var8 - 1)
            end
        end
        var7.literal = var8
        return ParsedInline.of(var7, var1:position())
    end

    self._scannedToEnd = true

    local var5 = Nodes.Text(var1:getSource(var2, var4):getContent())
    return ParsedInline.of(var5, var4)
end

local Factory = {}
Factory.__index = Factory

function Factory.new()
    return (setmetatable({}, Factory))
end

function Factory.getTriggerCharacters(_): {boolean}
    return { [96] = true }
end

function Factory.create(_)
    return module.new()
end

module.Factory = Factory

return module
