-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T16:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

return require(scriptParentParentParent.Rodux).makeActionCreator(script.Name, function(shareInviteLink: string)
    return { shareInviteLink = shareInviteLink }
end)
