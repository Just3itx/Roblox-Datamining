-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxAppHooksParent = script:FindFirstAncestor("RobloxAppHooks").Parent

local useSelector = require(RobloxAppHooksParent.RoactUtils).Hooks.RoactRodux.useSelector

return function()
    return useSelector(function(arg1)
        if arg1.TopBar then
            if arg1.TopBar.statusBarHeight then
                return arg1.TopBar.statusBarHeight
            end

            return 0
        end

        return 0
    end)
end
