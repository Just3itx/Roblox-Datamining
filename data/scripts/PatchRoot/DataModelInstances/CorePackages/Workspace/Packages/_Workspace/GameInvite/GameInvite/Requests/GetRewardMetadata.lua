-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:50:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameInviteParent = script:FindFirstAncestor("GameInvite").Parent
local HttpRequest = require(GameInviteParent.HttpRequest)
local Url = require(GameInviteParent.Http).Url

local FFlagLuaAppDefaultHttpRetry = require(GameInviteParent.SharedFlags).FFlagLuaAppDefaultHttpRetry
local var1 = HttpRequest.config({
    requestFunction = HttpRequest.requestFunctions.RequestInternal,
    maxRetryCount = if FFlagLuaAppDefaultHttpRetry then game:DefineFastInt("GetRewardMetadataHttpRetryCount", 4) else nil
})

local Promise = require(GameInviteParent.Promise)
return function()
    if game.GameId == nil or game.GameId == 0 then
        return Promise.reject("GameId is nil or 0")
    end
    local var2 = Url:makeQueryString({ UniverseId = game.GameId })

    local str1 = string.format("%sreferral-reward-metadata/v1/get-reward-metadata?%s", Url.APIS_URL, var2)
    return var1(str1, "GET")
end
