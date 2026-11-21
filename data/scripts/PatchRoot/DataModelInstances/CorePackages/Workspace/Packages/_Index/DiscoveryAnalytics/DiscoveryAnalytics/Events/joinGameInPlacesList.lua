-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

return function(arg1, playerId: string, placeId: string, rootPlaceId: number, gameInstanceId, joinAttemptJoinId, source)
    assert(type(playerId) == "string", "Expected playerId to be a string")
    assert(type(placeId) == "string", "Expected placeId to be a string")
    assert(type(rootPlaceId) == "number", "Expected rootPlaceId to be a number")

    if gameInstanceId then
        assert(type(gameInstanceId) == "string", "Expected gameInstanceId to be a string")
    end

    if joinAttemptJoinId then
        assert(type(joinAttemptJoinId) == "string", "Expected joinAttemptId to be a string")
    end

    if source then
        assert(type(source) == "string", "Expected source to be a string")
    end

    local userId = Players.LocalPlayer.UserId
    arg1:setRBXEventStream("PlacesList", "joinGameInPlacesList", {
        uid = tostring(userId),
        playerId = playerId,
        placeId = placeId,
        rootPlaceId = rootPlaceId,
        gameInstanceId = gameInstanceId,
        joinAttemptJoinId = joinAttemptJoinId,
        source = source
    })
end
