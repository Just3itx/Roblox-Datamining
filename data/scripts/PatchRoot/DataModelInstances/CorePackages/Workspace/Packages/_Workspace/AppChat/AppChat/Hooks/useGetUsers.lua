-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector

return function()
    return useSelector(function(arg1)
        return arg1.Users
    end)
end
