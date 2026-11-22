-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")

local _types = require(RobloxSubscriptionPurchaseApp.types)

local function deepEqual(arg1, arg2)
    if type(arg1) ~= "table" or type(arg2) ~= "table" then
        return arg1 == arg2
    end

    for value, value2 in arg1 do
        if not deepEqual(value2, arg2[value]) then
            return false
        end
    end
    for value in arg2 do
        if arg1[value] == nil then
            return false
        end
    end
    return true
end

return {
    isChanged = function(arg1, arg2): boolean
        return not deepEqual(arg1, arg2)
    end
}
