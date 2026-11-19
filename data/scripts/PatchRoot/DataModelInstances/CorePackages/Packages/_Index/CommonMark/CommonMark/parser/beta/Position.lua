-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:31:23Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local module = {}
module.__index = module

function module.new(lineIndex: number, index: number)
    return (setmetatable({ lineIndex = lineIndex, index = index }, module))
end

function module:equals(arg1): boolean
    if self == arg1 then
        return true
    end
    if arg1 == nil then
        return false
    end

    return self.lineIndex == arg1.lineIndex and self.index == arg1.index
end

local function compare(num1: number, num2: number): number -- Luacid: Inlined by compiler; 2 call sites recovered
    return if num1 < num2 then -1 elseif num1 == num2 then 0 else 1
end

function module:compareTo(arg1)
    local num1 = compare(self.lineIndex, arg1.lineIndex)
    if num1 ~= 0 then
        return num1
    end
    return compare(self.index, arg1.index)
end

return module
