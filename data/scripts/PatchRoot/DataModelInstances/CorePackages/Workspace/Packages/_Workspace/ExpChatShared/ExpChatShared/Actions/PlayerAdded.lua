-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:11:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatSharedParent = script:FindFirstAncestor("ExpChatShared").Parent
return require(ExpChatSharedParent.Rodux).makeActionCreator(script.Name, function(arg1, username: string, displayName: string, hasVerifiedBadge: boolean?)
    return {
        userId = tostring(arg1),
        username = username,
        displayName = displayName,
        hasVerifiedBadge = hasVerifiedBadge
    }
end)
