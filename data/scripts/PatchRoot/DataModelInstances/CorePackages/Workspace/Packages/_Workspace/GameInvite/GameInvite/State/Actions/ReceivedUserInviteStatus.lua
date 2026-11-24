-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:50:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameInviteParent = script:FindFirstAncestor("GameInvite").Parent

return require(GameInviteParent.Rodux).makeActionCreator(script.Name, function(arg1, inviteStatus)
    return {
        userId = tostring(arg1),
        inviteStatus = inviteStatus
    }
end)
