-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:30:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxUsersParent = script:FindFirstAncestor("RoduxUsers").Parent
return require(RoduxUsersParent.Rodux).makeActionCreator(script.Name, function(payload)
    return { payload = payload }
end)
