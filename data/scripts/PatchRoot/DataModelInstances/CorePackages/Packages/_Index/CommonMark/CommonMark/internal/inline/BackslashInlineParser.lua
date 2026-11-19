-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:20:47Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local Escaping = require(CommonMark.internal.util.Escaping)
local _InlineContentParser = require(CommonMark.parser.beta.InlineContentParser)
local _InlineContentParserFactory = require(CommonMark.parser.beta.InlineContentParserFactory)
local _InlineParserState = require(CommonMark.parser.beta.InlineParserState)
local Nodes = require(CommonMark.node.Nodes)
local ParsedInline = require(CommonMark.parser.beta.ParsedInline)

local _byte = string.byte
local char = string.char
local find = string.find

local module = {}
module.__index = module

local var1 = "^" .. Escaping.ESCAPABLE .. "$"

function module.new(bool1: boolean?)
    return (setmetatable({ _hardLineBreakEnabled = bool1 ~= false }, module))
end

function module:tryParse(arg1)
    local var2 = arg1:scanner()

    var2:next()

    local var3 = var2:peek()
    if var3 == 10 and self._hardLineBreakEnabled then
        var2:next()
        return ParsedInline.of(Nodes.HardLineBreak(), var2:position())
    end

    if find(char(var3), var1) == nil then
        return ParsedInline.of(Nodes.Text("\\"), var2:position())
    end

    var2:next()
    return ParsedInline.of(Nodes.Text((char(var3))), var2:position())
end

local Factory = {}
Factory.__index = Factory

function Factory.new(_hardLineBreakEnabled: boolean?)
    return (setmetatable({ _hardLineBreakEnabled = _hardLineBreakEnabled }, Factory))
end

function Factory.getTriggerCharacters(_): {boolean}
    return { [92] = true }
end

function Factory:create()
    return module.new(self._hardLineBreakEnabled)
end

module.Factory = Factory

return module
