-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:51:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Squads = script:FindFirstAncestor("Squads")
local dependencies = require(Squads.dependencies)

local Cryo = dependencies.Cryo
local React = dependencies.React

return function(num1: number, num2: number, num3: number)
    return React.useMemo(function()
        if num3 == nil then
            return num1 == 0
        end

        local var1 = Cryo.List.toSet(num3)

        if num1 < #num3 then
            return false
        end

        for value, _ in num2 do
            if not var1[tostring(value)] then
                return false
            end
        end

        return true
    end, { num1, num2, num3 })
end
