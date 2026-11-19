-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return require(script.Parent.Parent.ActionCreator)("SetPlayerIsFollowing", function(player, isFollowing)
    return {
        player = player,
        userId = player.UserId,
        isFollowing = isFollowing
    }
end)
