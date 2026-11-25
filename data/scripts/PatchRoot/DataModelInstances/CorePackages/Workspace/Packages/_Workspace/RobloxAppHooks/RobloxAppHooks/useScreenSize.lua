-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxAppHooksParent = script:FindFirstAncestor("RobloxAppHooks").Parent
local useSelector = require(RobloxAppHooksParent.RoactUtils).Hooks.RoactRodux.useSelector

return function()
    return useSelector(function(arg1)
        return arg1.ScreenSize
    end)
end
