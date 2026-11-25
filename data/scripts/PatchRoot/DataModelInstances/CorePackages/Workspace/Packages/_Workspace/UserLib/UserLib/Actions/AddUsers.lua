-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserLibParent = script:FindFirstAncestor("UserLib").Parent

return require(UserLibParent.Rodux).makeActionCreator(script.Name, function(users)
    return { users = users }
end)
