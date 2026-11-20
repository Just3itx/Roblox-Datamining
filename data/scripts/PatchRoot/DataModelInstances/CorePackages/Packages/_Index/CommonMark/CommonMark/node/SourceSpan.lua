-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:10:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
module.__index = module

local function new(_lineIndex: number, _columnIndex: number, _inputIndex: number, _length: number)
    if _lineIndex < 0 then
        error(`lineIndex {_lineIndex} must be >= 0`)
    end
    if _columnIndex < 0 then
        error(`columnIndex {_columnIndex} must be >= 0`)
    end
    if _inputIndex < 0 then
        error(`inputIndex {_inputIndex} must be >= 0`)
    end
    if _length < 0 then
        error(`length {_length} must be >= 0`)
    end
    return (setmetatable(
        {
            _lineIndex = _lineIndex,
            _columnIndex = _columnIndex,
            _inputIndex = _inputIndex,
            _length = _length
        },
        module
    ))
end

function module.of(_lineIndex: number, _columnIndex: number, _inputIndex: number, _length: number)
    return (new(_lineIndex, _columnIndex, _inputIndex, _length))
end

function module:getLineIndex()
    return self._lineIndex
end

function module:getColumnIndex()
    return self._columnIndex
end

function module:getInputIndex()
    return self._inputIndex
end

function module:getLength()
    return self._length
end

function module:subSpan(num1: number, num2: number?)
    local _length = self._length
    if num2 == nil then
        return self:subSpan(num1, _length)
    end
    if num1 < 0 then
        error(`beginIndex {num1} + must be >= 0`)
    end
    if _length < num1 then
        error(`beginIndex {num1} must be <= length {_length}`)
    end
    if num2 < 0 then
        error(`endIndex {num2} + must be >= 0`)
    end
    if _length < num2 then
        error(`endIndex {num2} must be <= length {_length}`)
    end
    if num2 < num1 then
        error(`beginIndex {num1} must be <= endIndex {num2}`)
    end
    if num1 == 0 and num2 == _length then
        return self
    end
    return (new(self._lineIndex, self._columnIndex + num1, self._inputIndex + num1, num2 - num1))
end

function module:equals(arg1): boolean
    if self == arg1 then
        return true
    end
    if arg1 == nil then
        return false
    end

    return self._lineIndex == arg1._lineIndex
        and self._columnIndex == arg1._columnIndex
        and self._inputIndex == arg1._inputIndex
        and self._length == arg1._length
end

function module:toString(): string
    return `SourceSpan\{line={self._lineIndex}, column={self._columnIndex}, input={self._inputIndex}, length={self._length}}`
end

return module
