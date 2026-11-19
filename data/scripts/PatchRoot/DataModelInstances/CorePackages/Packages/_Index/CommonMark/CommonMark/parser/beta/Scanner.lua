-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:31:24Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CommonMark = script:FindFirstAncestor("CommonMark")
local _CharMatcher = require(CommonMark.text.CharMatcher)
local Position = require(CommonMark.parser.beta.Position)
local SourceLine = require(CommonMark.parser.SourceLine)
local SourceLines = require(CommonMark.parser.SourceLines)
local _SourceSpan = require(CommonMark.node.SourceSpan)
local Utf8 = require(CommonMark.internal.port.Utf8)

local byte = string.byte
local char = string.char
local find = string.find
local sub = string.sub

local module = {}
module.__index = module

module.END = 0

function module.new(_lines, _lineIndex: number, _index: number)
    local self = setmetatable(
        {
            _lines = _lines,
            _lineIndex = _lineIndex,
            _index = _index,
            _line = SourceLine.of("", nil),
            _lineLength = 0
        },
        module
    )

    if #_lines > 0 then
        self:checkPosition(_lineIndex, _index)
        self:setLine(_lines[_lineIndex + 1])
    end
    return self
end

function module.of(arg1)
    return module.new(arg1:getLines(), 0, 0)
end

function module:peek()
    if not (self._index < self._lineLength) then
        return if self._lineIndex < #self._lines - 1 then 10 else 0
    end

    return byte(self._line:getContent(), self._index + 1)
end

function module:peekCodePoint()
    if self._index < self._lineLength then
        return Utf8.codePointAt(self._line:getContent(), self._index)
    end
    return if self._lineIndex < #self._lines - 1 then 10 else 0
end

function module:peekPreviousCodePoint()
    if self._index > 0 then
        return Utf8.codePointBefore(self._line:getContent(), self._index)
    end
    return if self._lineIndex > 0 then 10 else 0
end

function module:hasNext(): boolean
    return self._index < self._lineLength or self._lineIndex < #self._lines - 1
end

function module:next()
    self._index += 1
    if not (self._index > self._lineLength) then
        return
    end

    self._lineIndex += 1
    if self._lineIndex < #self._lines then
        self:setLine(self._lines[self._lineIndex + 1])
    else
        self:setLine(SourceLine.of("", nil))
    end
    self._index = 0
end

function module.nextChar(arg1, num1: number): boolean
    if arg1:peek() ~= num1 then
        return false
    end

    arg1:next()
    return true
end

function module:nextString(str1: string): boolean
    if not (self._index < self._lineLength and self._index + #str1 <= self._lineLength) then
        return false
    end

    if sub(self._line:getContent(), self._index + 1, self._index + #str1) ~= str1 then
        return false
    end
    self._index += #str1
    return true
end

function module.matchMultiple(arg1, num1: number): number
    local num2 = 0

    while arg1:peek() == num1 do
        num2 += 1
        arg1:next()
    end
    return num2
end

function module.match(arg1, arg2): number
    local num1 = 0

    while arg2:matches(arg1:peek()) do
        num1 += 1
        arg1:next()
    end
    return num1
end

function module.whitespace(arg1): number
    local num1 = 0

    while true do
        local var1 = arg1:peek()
        if var1 ~= 32 and var1 ~= 9 and var1 ~= 10 and var1 ~= 11 and var1 ~= 12 and var1 ~= 13 then
            break
        end

        num1 += 1
        arg1:next()
    end
    return num1
end

local tbl1 = ({})

local function findCharPattern(num1: number) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = tbl1[num1]
    if var1 == nil then
        var1 = "[\0" .. (if num1 >= 48 and num1 <= 57 or num1 >= 65 and num1 <= 90 or num1 >= 97 and num1 <= 122 then "" else "%") .. char(num1) .. "]"
        tbl1[num1] = var1
    end
    return var1
end

function module:findChar(num1: number)
    local num2 = 0

    while true do
        if self._index < self._lineLength then
            local var1 = find(self._line:getContent(), findCharPattern(num1), self._index + 1)
            local _index = if var1 ~= nil then var1 - 1 else self._lineLength
            num2 += _index - self._index
            self._index = _index
        end
        local var1 = self:peek()
        if var1 == 0 then
            return -1
        end

        if var1 == num1 then
            return num2
        end
        num2 += 1
        self:next()
    end
end

function module.findMatcher(arg1, arg2)
    local num1 = 0

    while true do
        local var1 = arg1:peek()
        if var1 == 0 then
            break
        end
        if arg2:matches(var1) then
            return num1
        end
        num1 += 1
        arg1:next()
    end

    return -1
end

function module:position()
    return Position.new(self._lineIndex, self._index)
end

function module:setPosition(arg1)
    self:checkPosition(arg1.lineIndex, arg1.index)
    self._lineIndex = arg1.lineIndex
    self._index = arg1.index
    self:setLine(self._lines[self._lineIndex + 1])
end

function module:getSource(arg1, arg2)
    if arg1.lineIndex ~= arg2.lineIndex then
        local var1 = SourceLines.empty()

        local var2 = self._lines[arg1.lineIndex + 1]
        var1:addLine(var2:substring(arg1.index, #var2:getContent()))

        for i = arg1.lineIndex + 1, arg2.lineIndex - 1 do
            var1:addLine(self._lines[i + 1])
        end

        var1:addLine(self._lines[arg2.lineIndex + 1]:substring(0, arg2.index))
        return var1
    end

    local var1 = self._lines[arg1.lineIndex + 1]
    local content = var1:getContent()

    if arg1.index < 0 or arg1.index > arg2.index or arg2.index > #content then
        error(`begin {arg1.index}, end {arg2.index}, length {#content}`)
    end
    local var2 = sub(content, arg1.index + 1, arg2.index)

    local sourceSpan = var1:getSourceSpan()
    local var3 = if sourceSpan == nil then nil else sourceSpan:subSpan(arg1.index, arg2.index)
    return SourceLines.of(SourceLine.of(var2, var3))
end

function module:setLine(_line)
    self._line = _line
    self._lineLength = #_line:getContent()
end

function module:checkPosition(num1: number, num2: number)
    if num1 < 0 or #self._lines <= num1 then
        error(`Line index {num1} out of range, number of lines: {#self._lines}`)
    end
    local var1 = self._lines[num1 + 1]
    if num2 < 0 or #var1:getContent() < num2 then
        error(`Index {num2} out of range, line length: {#var1:getContent()}`)
    end
end

return module
