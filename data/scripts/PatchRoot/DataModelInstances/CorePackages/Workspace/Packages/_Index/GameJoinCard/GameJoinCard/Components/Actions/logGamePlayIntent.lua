-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameJoinCardParent = script:FindFirstAncestor("GameJoinCard").Parent
local HttpService = game:GetService("HttpService")

local DiscoveryAnalytics = require(GameJoinCardParent.DiscoveryAnalytics)
local gamePlayIntent = DiscoveryAnalytics.Events.gamePlayIntent
local PeopleListInHomePage = DiscoveryAnalytics.Constants.Context.PeopleListInHomePage

local _Types = require(script.Parent.Types)

local function logGamePlayIntent(arg1)
    local userId = arg1.userId
    if userId == "" then
        return
    end
    local presence = arg1.presence
    local placeId = presence.placeId
    local rootPlaceId = presence.rootPlaceId
    local str1 = if placeId == nil or tostring(placeId) == "" then "" else tostring(placeId)
    local var1 = tonumber(rootPlaceId)
    if str1 == "" or var1 == nil then
        return
    end
    gamePlayIntent(
        arg1.eventIngest,
        PeopleListInHomePage,
        {
            placeId = str1,
            rootPlaceId = var1,
            friendId = userId,
            joinAttemptId = HttpService:GenerateGUID(false)
        }
    )
end
return logGamePlayIntent
