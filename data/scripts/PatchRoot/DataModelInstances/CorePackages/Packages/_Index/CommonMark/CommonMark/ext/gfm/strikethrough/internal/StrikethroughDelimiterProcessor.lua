-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local _DelimiterProcessor = require(CommonMark.parser.delimiter.DelimiterProcessor)
local _DelimiterRun = require(CommonMark.parser.delimiter.DelimiterRun)
local Nodes = require(CommonMark.node.Nodes)
local SourceSpans = require(CommonMark.node.SourceSpans)
local Strikethrough = require(CommonMark.ext.gfm.strikethrough.Strikethrough)

local module = {}
module.__index = module

function module.new(bool1: boolean?)
    return (setmetatable({ _requireTwoTildes = bool1 == true }, module))
end

function module.getOpeningCharacter(_): number
    return 126
end

function module.getClosingCharacter(_): number
    return 126
end

function module:getMinLength(): number
    return if self._requireTwoTildes then 2 else 1
end

function module.process(_, arg1, arg2)
    if arg1:length() ~= arg2:length() or not (arg1:length() <= 2) then
        return 0
    end

    local opener = arg1:getOpener()

    local literal = opener.literal
    if arg1:length() ~= 1 then
        literal ..= literal
    end

    local var1 = Strikethrough(literal)

    local sourceSpans = SourceSpans.new()
    sourceSpans:addAllFrom((arg1:getOpeners(arg1:length())))

    for value in Nodes.between(opener, arg2:getCloser()) do
        var1:appendChild(value)
        sourceSpans:addAll(value:getSourceSpans())
    end

    sourceSpans:addAllFrom((arg2:getClosers(arg2:length())))
    var1:setSourceSpans(sourceSpans:getSourceSpans())

    opener:insertAfter(var1)

    return arg1:length()
end

return module
