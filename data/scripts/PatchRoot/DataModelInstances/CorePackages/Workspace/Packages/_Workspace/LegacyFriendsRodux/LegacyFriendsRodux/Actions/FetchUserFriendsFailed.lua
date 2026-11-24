-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LegacyFriendsRoduxParent = script:FindFirstAncestor("LegacyFriendsRodux").Parent

return require(LegacyFriendsRoduxParent.Rodux).makeActionCreator(script.Name, function(userId, response)
    return { userId = userId, response = response }
end)
