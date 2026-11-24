-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:20:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _GameProtocolTypes = require(script.Parent.GameProtocolTypes)

local module = {}

function module.new()
    return { referralPage = "LuaChat" }
end

function module.fromPlaceId(placeId, isTeamTest: boolean?)
    local module2 = module.new()

    module2.placeId = placeId
    module2.isTeamTest = isTeamTest

    return module2
end

function module.fromUserId(userId, placeId)
    local module2 = module.new()
    module2.userId = userId
    module2.placeId = placeId
    return module2
end

function module.fromPlaceInstance(placeId, gameInstanceId: string)
    local module2 = module.new()

    module2.placeId = placeId
    module2.gameInstanceId = gameInstanceId

    return module2
end

function module.fromConversationId(placeId, conversationId: string)
    local module2 = module.new()

    module2.placeId = placeId
    module2.conversationId = conversationId

    return module2
end

function module.fromParams(arg1)
    local module2 = module.new()

    for k, value in pairs(arg1) do
        module2[k] = value
    end

    return module2
end

return module
