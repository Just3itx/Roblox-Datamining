-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector

return function(str1: string?)
    return useSelector(function(arg1)
        return if str1 then arg1.Users[str1] else nil
    end)
end
