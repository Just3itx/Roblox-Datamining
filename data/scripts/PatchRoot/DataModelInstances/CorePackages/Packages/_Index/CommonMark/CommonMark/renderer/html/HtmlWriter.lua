-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:20:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local Escaping = require(CommonMark.internal.util.Escaping)
local _LinkedHashMap = require(CommonMark.internal.port.LinkedHashMap)

local byte = string.byte

local module = {}
module.__index = module

function module.new(_buffer)
    return (setmetatable({ _buffer = _buffer, _n = #_buffer, _lastChar = 0 }, module))
end

function module.raw(arg1, str1: string)
    arg1:append(str1)
end

function module.text(arg1, str1: string)
    arg1:append(Escaping.escapeHtml(str1))
end

function module.tag(arg1, str1: string, arg2, bool1: boolean?)
    arg1:append("<")
    arg1:append(str1)
    if arg2 ~= nil and not arg2:isEmpty() then
        for value, value2 in arg2:entrySet() do
            arg1:append(" ")
            arg1:append(Escaping.escapeHtml(value))
            if value2 ~= nil then
                arg1:append("=\"")
                arg1:append(Escaping.escapeHtml(value2))
                arg1:append("\"")
            end
        end
    end
    if bool1 then
        arg1:append(" /")
    end

    arg1:append(">")
end

function module:line()
    if self._lastChar ~= 0 and self._lastChar ~= 10 then
        self:append("\n")
    end
end

function module:append(str1: string)
    self._n += 1
    self._buffer[self._n] = str1
    local num1 = #str1
    if num1 ~= 0 then
        self._lastChar = byte(str1, num1)
    end
end

return module
