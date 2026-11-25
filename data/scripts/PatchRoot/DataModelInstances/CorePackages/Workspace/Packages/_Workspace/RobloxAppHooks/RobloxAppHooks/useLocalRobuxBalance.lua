-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:00:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxAppHooksParent = script:FindFirstAncestor("RobloxAppHooks").Parent
local useSelector = require(RobloxAppHooksParent.RoactUtils).Hooks.RoactRodux.useSelector
local useLocalUserId = require(script.Parent.useLocalUserId)

return function()
    local var1 = useLocalUserId()
    return useSelector(function(arg1)
        return arg1.UserRobux[var1]
    end)
end
