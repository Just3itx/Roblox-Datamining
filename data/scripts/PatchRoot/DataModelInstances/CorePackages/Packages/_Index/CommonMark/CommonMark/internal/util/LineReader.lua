-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:21:15Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local Characters = require(CommonMark.text.Characters)

local byte = string.byte
local sub = string.sub

local module = {}
module.__index = module

function module.new(_input: string)
    return (setmetatable({ _input = _input, _position = 0, _limit = #_input, _lineTerminator = nil }, module))
end

local line = nil

function module:readLine()
    local _input = self._input

    if _input == nil then
        error("LineReader is closed")
    end

    local _position = self._position
    if self._limit <= _position then
        return line(self, nil, nil)
    end

    local lineBreak = Characters.findLineBreak(_input, _position)
    if lineBreak == -1 then
        self._position = self._limit
        return line(self, sub(_input, _position + 1, self._limit), nil)
    elseif byte(_input, lineBreak + 1) == 10 then
        self._position = lineBreak + 1
        return line(self, sub(_input, _position + 1, lineBreak), "\n")
    elseif byte(_input, lineBreak + 1 + 1) == 10 then
        self._position = lineBreak + 2
        return line(self, sub(_input, _position + 1, lineBreak), "\r\n")
    else
        self._position = lineBreak + 1
        return line(self, sub(_input, _position + 1, lineBreak), "\r")
    end
end

function module:getLineTerminator()
    return self._lineTerminator
end

function module:close()
    if self._input == nil then
        return
    end
    self._input = nil
end

line = function(arg1, str1: string?, _lineTerminator: string?): string?
    arg1._lineTerminator = _lineTerminator
    return str1
end

return module
