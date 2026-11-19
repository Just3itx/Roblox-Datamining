-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:41:02Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local byte = string.byte

local module = {}
module.__index = module

local Builder = {}
Builder.__index = Builder

function module.new(arg1)
    return (setmetatable({ _set = arg1._set }, module))
end

function module:matches(num1: number): boolean
    return self._set[num1] == true
end

function module:newBuilder()
    return Builder.new(table.clone(self._set))
end

function module.builder()
    return Builder.new({})
end

function module:builderMatcher()
    return Builder.new(table.clone(self._set))
end

function Builder.new(_set)
    return (setmetatable({ _set = _set }, Builder))
end

function Builder:c(num1: number)
    if num1 > 127 then
        error("Can only match ASCII characters")
    end
    self._set[num1] = true
    return self
end

function Builder:anyOf(str1: string)
    for i = 0, #str1 - 1 do
        local num1 = i + 1
        self:c(byte(str1, num1))
    end
    return self
end

function Builder:anyOfSet(tbl2)
    for value in tbl2 do
        self:c(value)
    end
    return self
end

function Builder:range(num1: number, num2: number)
    for i = num1, num2 do
        self:c(i)
    end
    return self
end

function Builder.build(arg1)
    return module.new(arg1)
end

module.Builder = Builder

return module
