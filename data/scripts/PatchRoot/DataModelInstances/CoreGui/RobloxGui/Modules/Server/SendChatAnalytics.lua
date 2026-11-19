-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:31:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

return function(eventName: string, additionalArgs)
    additionalArgs = additionalArgs or {}

    assert(additionalArgs ~= nil, "eventTable must not be nil")

    local gameId = game.GameId
    additionalArgs.gameId = tostring(gameId)
    local placeId = game.PlaceId
    additionalArgs.placeId = tostring(placeId)

    RbxAnalyticsService:SendEventDeferred("rcc", "lua_chat_system", eventName, additionalArgs)
end
