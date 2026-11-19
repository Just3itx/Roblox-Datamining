-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:41:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local getNumericalApplicationId = require(script.Parent.getNumericalApplicationId)

local function getRolloutEnabledForUser(func1: (...any) -> (...any), arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = func1()
    local numericalApplicationId = getNumericalApplicationId(arg1)

    if numericalApplicationId == nil then
        return var1 >= 100
    end

    return numericalApplicationId % 100 + 1 <= var1
end

return function(func1: (...any) -> (...any), arg1): () -> boolean
    local rolloutEnabledForUser = getRolloutEnabledForUser(func1, arg1)

    return function()
        return rolloutEnabledForUser
    end
end
