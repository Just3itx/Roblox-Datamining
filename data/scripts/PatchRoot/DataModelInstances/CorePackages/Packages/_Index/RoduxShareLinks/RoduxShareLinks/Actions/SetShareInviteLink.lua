-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:21:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxShareLinksParent = script:FindFirstAncestor("RoduxShareLinks").Parent
return require(RoduxShareLinksParent.Rodux).makeActionCreator(script.Name, function(shareInviteLink: string)
    return { shareInviteLink = shareInviteLink }
end)
