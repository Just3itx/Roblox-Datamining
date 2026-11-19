-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:30:52Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

local React = require(FoundationParent.React)
local useClock = require(FoundationParent.ReactUtils).useClock

local numberRange = NumberRange.new(0, 1)

local function usePulseBinding(num1: number?, numberRange2: NumberRange?)
    local var1 = useClock()

    local num2 = num1 or 1
    local var2 = numberRange2 or numberRange

    return React.useMemo(function()
        return var1:map(function(num3: number)
            return math.map(math.sin(num3 * math.pi / num2) ^ 2, 0, 1, var2.Min, var2.Max)
        end)
    end, { num1, numberRange2 })
end

return usePulseBinding
