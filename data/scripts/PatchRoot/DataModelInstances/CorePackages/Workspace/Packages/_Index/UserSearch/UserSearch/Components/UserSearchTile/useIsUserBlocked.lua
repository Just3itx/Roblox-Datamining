-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:01:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserSearchParent = script:FindFirstAncestor("UserSearch").Parent

local useSelector = require(UserSearchParent.RoactUtils).Hooks.RoactRodux.useSelector

local function useIsUserBlocked(str1: string)
    return useSelector(function(arg1): boolean
        local playerContextualMenu = arg1.PlayerContextualMenu
        if not playerContextualMenu then
            return false
        end

        local userBlocking = playerContextualMenu.UserBlocking
        local var1 = if userBlocking then userBlocking.isBlockedByMe else playerContextualMenu.IsBlockedByMe
        return if var1 then var1[str1] == true else false
    end)
end

return useIsUserBlocked
