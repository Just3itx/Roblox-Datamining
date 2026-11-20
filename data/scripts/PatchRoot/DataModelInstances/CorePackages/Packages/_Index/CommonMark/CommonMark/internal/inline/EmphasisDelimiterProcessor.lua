-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local _DelimiterProcessor = require(CommonMark.parser.delimiter.DelimiterProcessor)
local _DelimiterRun = require(CommonMark.parser.delimiter.DelimiterRun)
local Nodes = require(CommonMark.node.Nodes)
local SourceSpans = require(CommonMark.node.SourceSpans)

local module = {}
module.__index = module

function module.new(_delimiterChar: number, tbl1)
    local _minLength = if tbl1 == nil or tbl1.minLength == nil then 1 else tbl1.minLength
    if _minLength ~= 1 and _minLength ~= 2 then
        error(`EmphasisLikeDelimiterProcessor minLength must be 1 or 2, got {_minLength}`)
    end
    return (setmetatable({
        _delimiterChar = _delimiterChar,
        _minLength = _minLength,
        _createEmphasis = if tbl1 ~= nil and tbl1.createEmphasis ~= nil then tbl1.createEmphasis else Nodes.Emphasis,
        _createStrongEmphasis = if tbl1 ~= nil and tbl1.createStrongEmphasis ~= nil then tbl1.createStrongEmphasis else Nodes.StrongEmphasis,
        _rejectsByMultipleOf3Rule = true
    }, module))
end

function module:getOpeningCharacter()
    return self._delimiterChar
end

function module:getClosingCharacter()
    return self._delimiterChar
end

function module:getMinLength()
    return self._minLength
end

function module:process(arg1, arg2)
    if (arg1:canClose() or arg2:canOpen())
        and arg2:originalLength() % 3 ~= 0
        and (arg1:originalLength() + arg2:originalLength()) % 3 == 0
    then
        return 0
    end

    local var1, num1

    if arg1:length() >= 2 and arg2:length() >= 2 then
        var1 = self._createStrongEmphasis(string.char(self._delimiterChar, self._delimiterChar))
        num1 = 2
    else
        var1 = self._createEmphasis(string.char(self._delimiterChar))
        num1 = 1
    end

    local var2 = SourceSpans.empty()
    var2:addAllFrom((arg1:getOpeners(num1)))

    local opener = arg1:getOpener()
    for value in Nodes.between(opener, arg2:getCloser()) do
        var1:appendChild(value)
        var2:addAll(value:getSourceSpans())
    end

    var2:addAllFrom((arg2:getClosers(num1)))

    var1:setSourceSpans(var2:getSourceSpans())
    opener:insertAfter(var1)

    return num1
end

return module
