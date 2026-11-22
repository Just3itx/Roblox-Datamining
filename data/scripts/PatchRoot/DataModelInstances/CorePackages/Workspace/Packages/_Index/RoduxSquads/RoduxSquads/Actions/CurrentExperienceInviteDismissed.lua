-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:10:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxSquadsParent = script:FindFirstAncestor("RoduxSquads").Parent
return require(RoduxSquadsParent.Rodux).makeActionCreator(script.Name, function(notificationId: string)
    return {
        payload = { notificationId = notificationId }
    }
end)
