-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:39:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UtilsParent = script:FindFirstAncestor("Utils").Parent

local TextSplitBy = require(UtilsParent.Enums.TextSplitBy)

local function isWhitespace(str1: string): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return str1:match("%s") ~= nil
end

local function codepointEnd(_text: string, _codepointIndex: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    local num1 = utf8.offset(_text, _codepointIndex + 1)

    return if num1 == nil then #_text else num1 - 1
end

local tbl1 = {}
tbl1.__index = tbl1

function tbl1.new(_text: string, num1: number, num2: number, num3: number)
    local self = setmetatable({}, tbl1)
    self._text = _text
    self._initialGuess = self:_guessInitialBreak(num1, num2, num3)
    self._index = self._initialGuess

    self:setDirection(1)
    return self
end

function tbl1:_guessInitialBreak(_: number, num1: number, num2: number): number
    return math.max(math.floor(#self._text * num2 / num1), 1)
end

function tbl1:findPossibleBreak()
    local _index = self._index

    while self.direction == 1 and _index <= #self._text or self.direction == -1 and _index > 0 do
        if isWhitespace((self._text:sub(_index, _index))) then
            self._index = _index + self._step

            return _index - 1
        end
        _index += self._step
    end
    return _index
end

function tbl1:setDirection(direction: number)
    self.direction = direction

    if direction ~= 1 then
        self._index = self._initialGuess
    end
    self._step = if direction == 1 then 1 else -1
end

local tbl2 = {}
tbl2.__index = tbl2

function tbl2.new(_text: string, num1: number, num2: number, num3: number)
    local self = setmetatable({}, tbl2)
    self._text = _text
    self._initialGuess = self:_guessInitialBreak(num1, num2, num3)
    self._codepointIndex = self._initialGuess
    self._step = 0
    return self
end

function tbl2:_guessInitialBreak(num1: number, num2: number, num3: number): number
    return math.max(math.floor(num1 * num3 / num2), 1)
end

function tbl2:findPossibleBreak(): number
    self._codepointIndex += self._step
    return codepointEnd(self._text, self._codepointIndex)
end

function tbl2:setDirection(direction)
    self.direction = direction
    self._step = if direction == 1 then 1 else -1
end

local function splitWith(tbl3, func1: (...any) -> (...any), str1: string, num1: number, num2: number, num3: number)
    local var1 = tbl3.new(str1, num1, num2, num3)

    local var2 = var1:findPossibleBreak()
    local str2 = str1:sub(1, var2)
    local num4 = if num3 < func1(str2) then -1 else 1

    var1:setDirection(num4)
    local var3 = var2
    local num5 = 0

    while num5 < num1 do
        var2 = var1:findPossibleBreak()

        str2 = str1:sub(1, var2)
        local num6 = if num3 < func1(str2) then -1 else 1

        if num4 ~= num6 then
            if num4 == 1 then
                return str1:sub(1, var3), var3
            end

            break
        end

        num5 += 1
        var3 = var2
        num4 = num6
    end
    return str2, var2
end

local function split(word, func1: (...any) -> (...any), str1: string, num1: number)
    local var1 = utf8.len(str1)
    if var1 == nil then
        warn("Failed to get string length, it is probably malformed or non utf8")
        return str1
    end

    local var2 = func1(str1)

    if var2 <= num1 then
        return str1
    end

    local tbl3 = if word == TextSplitBy.Word then tbl1 else tbl2
    local str2, var3 = splitWith(tbl3, func1, str1, var1, var2, num1)

    if var3 == 0 or var3 == #str1 then
        return str1
    end

    return str2, (str1:sub(var3 + 1))
end

return split
