-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:41:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return require(script.Parent.Parent.ActionCreator)("SetPlayerLeaderstat", function(player, leaderstat, value)
    return {
        player = player,
        userId = player.UserId,
        leaderstat = leaderstat,
        value = value
    }
end)
