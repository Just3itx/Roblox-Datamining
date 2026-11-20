-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:01:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local _typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

tbl1.HydrationContentType = {
    fromNumber = function(num1: number)
        if num1 == 0 then
            return "HYDRATION_CONTENT_TYPE_INVALID"
        elseif num1 == 1 then
            return "HYDRATION_CONTENT_TYPE_BADGE"
        elseif num1 == 2 then
            return "HYDRATION_CONTENT_TYPE_UNIVERSE"
        elseif num1 == 3 then
            return "HYDRATION_CONTENT_TYPE_CREATOR"
        elseif num1 == 4 then
            return "HYDRATION_CONTENT_TYPE_EVENT"
        elseif num1 == 5 then
            return "HYDRATION_CONTENT_TYPE_SONG"
        elseif num1 == 6 then
            return "HYDRATION_CONTENT_TYPE_GAME_PASS"
        elseif num1 == 7 then
            return "HYDRATION_CONTENT_TYPE_MEDIA_ASSET"
        elseif num1 == 8 then
            return "HYDRATION_CONTENT_TYPE_SOCIAL_LINK"
        elseif num1 == 9 then
            return "HYDRATION_CONTENT_TYPE_GAME_DEVELOPER_PRODUCT"
        elseif num1 == 10 then
            return "HYDRATION_CONTENT_TYPE_GAME_SUBSCRIPTION"
        elseif num1 == 11 then
            return "HYDRATION_CONTENT_TYPE_MARKETPLACE_ASSET"
        elseif num1 == 12 then
            return "HYDRATION_CONTENT_TYPE_MARKETPLACE_BUNDLE"
        elseif num1 == 13 then
            return "HYDRATION_CONTENT_TYPE_MARKETPLACE_LOOK"
        elseif num1 == 14 then
            return "HYDRATION_CONTENT_TYPE_MARKETPLACE_CATALOG_CATEGORY"
        elseif num1 == 15 then
            return "HYDRATION_CONTENT_TYPE_MARKETPLACE_CATALOG_SORT"
        elseif num1 == 16 then
            return "HYDRATION_CONTENT_TYPE_AGE_RECOMMENDATION"
        elseif num1 == 17 then
            return "HYDRATION_CONTENT_TYPE_UNIVERSE_USER_FOLLOW"
        elseif num1 == 18 then
            return "HYDRATION_CONTENT_TYPE_UNIVERSE_USER_VOTE"
        elseif num1 == 19 then
            return "HYDRATION_CONTENT_TYPE_USER_PROFILE"
        elseif num1 == 20 then
            return "HYDRATION_CONTENT_TYPE_UNIVERSE_USER_FAVORITE"
        elseif num1 == 21 then
            return "HYDRATION_CONTENT_TYPE_PLAYABILITY"
        elseif num1 == 22 then
            return "HYDRATION_CONTENT_TYPE_UNIVERSE_USER_FOLLOW_LIMIT"
        elseif num1 == 23 then
            return "HYDRATION_CONTENT_TYPE_UNIVERSE_USER_VOTE_FEEDBACK_METADATA"
        elseif num1 == 24 then
            return "HYDRATION_CONTENT_TYPE_MOMENT"
        elseif num1 == 25 then
            return "HYDRATION_CONTENT_TYPE_COMMUNITY"
        elseif num1 == 26 then
            return "HYDRATION_CONTENT_TYPE_COMMUNITY_USER_MEMBERSHIP"
        elseif num1 == 27 then
            return "HYDRATION_CONTENT_TYPE_FRIEND_RECOMMENDATION"
        elseif num1 == 28 then
            return "HYDRATION_CONTENT_TYPE_UNIVERSE_PRIVATE_SERVER"
        elseif num1 == 29 then
            return "HYDRATION_CONTENT_TYPE_NOTIFICATION_BADGE"
        elseif num1 == 30 then
            return "HYDRATION_CONTENT_TYPE_COLLECTIBLE_ITEM"
        elseif num1 == 31 then
            return "HYDRATION_CONTENT_TYPE_LEADERBOARD_STATS"
        end

        if num1 == 32 then
            return "HYDRATION_CONTENT_TYPE_MARKETPLACE_ASSET_USER_FAVORITE"
        elseif num1 == 33 then
            return "HYDRATION_CONTENT_TYPE_MARKETPLACE_BUNDLE_USER_FAVORITE"
        elseif num1 == 34 then
            return "HYDRATION_CONTENT_TYPE_BUY_ROBUX_ONE_TIME_PRODUCT"
        elseif num1 == 35 then
            return "HYDRATION_CONTENT_TYPE_BUY_ROBUX_SUBSCRIPTION_PRODUCT"
        elseif num1 == 36 then
            return "HYDRATION_CONTENT_TYPE_BUY_ROBUX_PENDING_TRANSFER"
        elseif num1 == 37 then
            return "HYDRATION_CONTENT_TYPE_BUY_ROBUX_BONUS_ITEM"
        elseif num1 == 38 then
            return "HYDRATION_CONTENT_TYPE_USER_LIBRARY_SAVED_STATE"
        elseif num1 == 39 then
            return "HYDRATION_CONTENT_TYPE_GAME_PASS_VOTE"
        end

        return nil
    end,
    toNumber = function(arg1): number
        if arg1 == "HYDRATION_CONTENT_TYPE_INVALID" then
            return 0
        elseif arg1 == "HYDRATION_CONTENT_TYPE_BADGE" then
            return 1
        elseif arg1 == "HYDRATION_CONTENT_TYPE_UNIVERSE" then
            return 2
        elseif arg1 == "HYDRATION_CONTENT_TYPE_CREATOR" then
            return 3
        elseif arg1 == "HYDRATION_CONTENT_TYPE_EVENT" then
            return 4
        elseif arg1 == "HYDRATION_CONTENT_TYPE_SONG" then
            return 5
        elseif arg1 == "HYDRATION_CONTENT_TYPE_GAME_PASS" then
            return 6
        elseif arg1 == "HYDRATION_CONTENT_TYPE_MEDIA_ASSET" then
            return 7
        elseif arg1 == "HYDRATION_CONTENT_TYPE_SOCIAL_LINK" then
            return 8
        elseif arg1 == "HYDRATION_CONTENT_TYPE_GAME_DEVELOPER_PRODUCT" then
            return 9
        elseif arg1 == "HYDRATION_CONTENT_TYPE_GAME_SUBSCRIPTION" then
            return 10
        elseif arg1 == "HYDRATION_CONTENT_TYPE_MARKETPLACE_ASSET" then
            return 11
        elseif arg1 == "HYDRATION_CONTENT_TYPE_MARKETPLACE_BUNDLE" then
            return 12
        elseif arg1 == "HYDRATION_CONTENT_TYPE_MARKETPLACE_LOOK" then
            return 13
        elseif arg1 == "HYDRATION_CONTENT_TYPE_MARKETPLACE_CATALOG_CATEGORY" then
            return 14
        elseif arg1 == "HYDRATION_CONTENT_TYPE_MARKETPLACE_CATALOG_SORT" then
            return 15
        elseif arg1 == "HYDRATION_CONTENT_TYPE_AGE_RECOMMENDATION" then
            return 16
        elseif arg1 == "HYDRATION_CONTENT_TYPE_UNIVERSE_USER_FOLLOW" then
            return 17
        elseif arg1 == "HYDRATION_CONTENT_TYPE_UNIVERSE_USER_VOTE" then
            return 18
        elseif arg1 == "HYDRATION_CONTENT_TYPE_USER_PROFILE" then
            return 19
        elseif arg1 == "HYDRATION_CONTENT_TYPE_UNIVERSE_USER_FAVORITE" then
            return 20
        elseif arg1 == "HYDRATION_CONTENT_TYPE_PLAYABILITY" then
            return 21
        elseif arg1 == "HYDRATION_CONTENT_TYPE_UNIVERSE_USER_FOLLOW_LIMIT" then
            return 22
        elseif arg1 == "HYDRATION_CONTENT_TYPE_UNIVERSE_USER_VOTE_FEEDBACK_METADATA" then
            return 23
        elseif arg1 == "HYDRATION_CONTENT_TYPE_MOMENT" then
            return 24
        elseif arg1 == "HYDRATION_CONTENT_TYPE_COMMUNITY" then
            return 25
        elseif arg1 == "HYDRATION_CONTENT_TYPE_COMMUNITY_USER_MEMBERSHIP" then
            return 26
        elseif arg1 == "HYDRATION_CONTENT_TYPE_FRIEND_RECOMMENDATION" then
            return 27
        elseif arg1 == "HYDRATION_CONTENT_TYPE_UNIVERSE_PRIVATE_SERVER" then
            return 28
        elseif arg1 == "HYDRATION_CONTENT_TYPE_NOTIFICATION_BADGE" then
            return 29
        elseif arg1 == "HYDRATION_CONTENT_TYPE_COLLECTIBLE_ITEM" then
            return 30
        elseif arg1 == "HYDRATION_CONTENT_TYPE_LEADERBOARD_STATS" then
            return 31
        end

        if arg1 == "HYDRATION_CONTENT_TYPE_MARKETPLACE_ASSET_USER_FAVORITE" then
            return 32
        elseif arg1 == "HYDRATION_CONTENT_TYPE_MARKETPLACE_BUNDLE_USER_FAVORITE" then
            return 33
        elseif arg1 == "HYDRATION_CONTENT_TYPE_BUY_ROBUX_ONE_TIME_PRODUCT" then
            return 34
        elseif arg1 == "HYDRATION_CONTENT_TYPE_BUY_ROBUX_SUBSCRIPTION_PRODUCT" then
            return 35
        elseif arg1 == "HYDRATION_CONTENT_TYPE_BUY_ROBUX_PENDING_TRANSFER" then
            return 36
        elseif arg1 == "HYDRATION_CONTENT_TYPE_BUY_ROBUX_BONUS_ITEM" then
            return 37
        elseif arg1 == "HYDRATION_CONTENT_TYPE_USER_LIBRARY_SAVED_STATE" then
            return 38
        elseif arg1 == "HYDRATION_CONTENT_TYPE_GAME_PASS_VOTE" then
            return 39
        end

        return arg1
    end,
    fromName = function(str1: string)
        if str1 == "HYDRATION_CONTENT_TYPE_INVALID" then
            return "HYDRATION_CONTENT_TYPE_INVALID"
        elseif str1 == "HYDRATION_CONTENT_TYPE_BADGE" then
            return "HYDRATION_CONTENT_TYPE_BADGE"
        elseif str1 == "HYDRATION_CONTENT_TYPE_UNIVERSE" then
            return "HYDRATION_CONTENT_TYPE_UNIVERSE"
        elseif str1 == "HYDRATION_CONTENT_TYPE_CREATOR" then
            return "HYDRATION_CONTENT_TYPE_CREATOR"
        elseif str1 == "HYDRATION_CONTENT_TYPE_EVENT" then
            return "HYDRATION_CONTENT_TYPE_EVENT"
        elseif str1 == "HYDRATION_CONTENT_TYPE_SONG" then
            return "HYDRATION_CONTENT_TYPE_SONG"
        elseif str1 == "HYDRATION_CONTENT_TYPE_GAME_PASS" then
            return "HYDRATION_CONTENT_TYPE_GAME_PASS"
        elseif str1 == "HYDRATION_CONTENT_TYPE_MEDIA_ASSET" then
            return "HYDRATION_CONTENT_TYPE_MEDIA_ASSET"
        elseif str1 == "HYDRATION_CONTENT_TYPE_SOCIAL_LINK" then
            return "HYDRATION_CONTENT_TYPE_SOCIAL_LINK"
        elseif str1 == "HYDRATION_CONTENT_TYPE_GAME_DEVELOPER_PRODUCT" then
            return "HYDRATION_CONTENT_TYPE_GAME_DEVELOPER_PRODUCT"
        elseif str1 == "HYDRATION_CONTENT_TYPE_GAME_SUBSCRIPTION" then
            return "HYDRATION_CONTENT_TYPE_GAME_SUBSCRIPTION"
        elseif str1 == "HYDRATION_CONTENT_TYPE_MARKETPLACE_ASSET" then
            return "HYDRATION_CONTENT_TYPE_MARKETPLACE_ASSET"
        elseif str1 == "HYDRATION_CONTENT_TYPE_MARKETPLACE_BUNDLE" then
            return "HYDRATION_CONTENT_TYPE_MARKETPLACE_BUNDLE"
        elseif str1 == "HYDRATION_CONTENT_TYPE_MARKETPLACE_LOOK" then
            return "HYDRATION_CONTENT_TYPE_MARKETPLACE_LOOK"
        elseif str1 == "HYDRATION_CONTENT_TYPE_MARKETPLACE_CATALOG_CATEGORY" then
            return "HYDRATION_CONTENT_TYPE_MARKETPLACE_CATALOG_CATEGORY"
        elseif str1 == "HYDRATION_CONTENT_TYPE_MARKETPLACE_CATALOG_SORT" then
            return "HYDRATION_CONTENT_TYPE_MARKETPLACE_CATALOG_SORT"
        elseif str1 == "HYDRATION_CONTENT_TYPE_AGE_RECOMMENDATION" then
            return "HYDRATION_CONTENT_TYPE_AGE_RECOMMENDATION"
        elseif str1 == "HYDRATION_CONTENT_TYPE_UNIVERSE_USER_FOLLOW" then
            return "HYDRATION_CONTENT_TYPE_UNIVERSE_USER_FOLLOW"
        elseif str1 == "HYDRATION_CONTENT_TYPE_UNIVERSE_USER_VOTE" then
            return "HYDRATION_CONTENT_TYPE_UNIVERSE_USER_VOTE"
        elseif str1 == "HYDRATION_CONTENT_TYPE_USER_PROFILE" then
            return "HYDRATION_CONTENT_TYPE_USER_PROFILE"
        elseif str1 == "HYDRATION_CONTENT_TYPE_UNIVERSE_USER_FAVORITE" then
            return "HYDRATION_CONTENT_TYPE_UNIVERSE_USER_FAVORITE"
        elseif str1 == "HYDRATION_CONTENT_TYPE_PLAYABILITY" then
            return "HYDRATION_CONTENT_TYPE_PLAYABILITY"
        elseif str1 == "HYDRATION_CONTENT_TYPE_UNIVERSE_USER_FOLLOW_LIMIT" then
            return "HYDRATION_CONTENT_TYPE_UNIVERSE_USER_FOLLOW_LIMIT"
        elseif str1 == "HYDRATION_CONTENT_TYPE_UNIVERSE_USER_VOTE_FEEDBACK_METADATA" then
            return "HYDRATION_CONTENT_TYPE_UNIVERSE_USER_VOTE_FEEDBACK_METADATA"
        elseif str1 == "HYDRATION_CONTENT_TYPE_MOMENT" then
            return "HYDRATION_CONTENT_TYPE_MOMENT"
        elseif str1 == "HYDRATION_CONTENT_TYPE_COMMUNITY" then
            return "HYDRATION_CONTENT_TYPE_COMMUNITY"
        elseif str1 == "HYDRATION_CONTENT_TYPE_COMMUNITY_USER_MEMBERSHIP" then
            return "HYDRATION_CONTENT_TYPE_COMMUNITY_USER_MEMBERSHIP"
        elseif str1 == "HYDRATION_CONTENT_TYPE_FRIEND_RECOMMENDATION" then
            return "HYDRATION_CONTENT_TYPE_FRIEND_RECOMMENDATION"
        elseif str1 == "HYDRATION_CONTENT_TYPE_UNIVERSE_PRIVATE_SERVER" then
            return "HYDRATION_CONTENT_TYPE_UNIVERSE_PRIVATE_SERVER"
        elseif str1 == "HYDRATION_CONTENT_TYPE_NOTIFICATION_BADGE" then
            return "HYDRATION_CONTENT_TYPE_NOTIFICATION_BADGE"
        elseif str1 == "HYDRATION_CONTENT_TYPE_COLLECTIBLE_ITEM" then
            return "HYDRATION_CONTENT_TYPE_COLLECTIBLE_ITEM"
        elseif str1 == "HYDRATION_CONTENT_TYPE_LEADERBOARD_STATS" then
            return "HYDRATION_CONTENT_TYPE_LEADERBOARD_STATS"
        end

        if str1 == "HYDRATION_CONTENT_TYPE_MARKETPLACE_ASSET_USER_FAVORITE" then
            return "HYDRATION_CONTENT_TYPE_MARKETPLACE_ASSET_USER_FAVORITE"
        elseif str1 == "HYDRATION_CONTENT_TYPE_MARKETPLACE_BUNDLE_USER_FAVORITE" then
            return "HYDRATION_CONTENT_TYPE_MARKETPLACE_BUNDLE_USER_FAVORITE"
        elseif str1 == "HYDRATION_CONTENT_TYPE_BUY_ROBUX_ONE_TIME_PRODUCT" then
            return "HYDRATION_CONTENT_TYPE_BUY_ROBUX_ONE_TIME_PRODUCT"
        elseif str1 == "HYDRATION_CONTENT_TYPE_BUY_ROBUX_SUBSCRIPTION_PRODUCT" then
            return "HYDRATION_CONTENT_TYPE_BUY_ROBUX_SUBSCRIPTION_PRODUCT"
        elseif str1 == "HYDRATION_CONTENT_TYPE_BUY_ROBUX_PENDING_TRANSFER" then
            return "HYDRATION_CONTENT_TYPE_BUY_ROBUX_PENDING_TRANSFER"
        elseif str1 == "HYDRATION_CONTENT_TYPE_BUY_ROBUX_BONUS_ITEM" then
            return "HYDRATION_CONTENT_TYPE_BUY_ROBUX_BONUS_ITEM"
        elseif str1 == "HYDRATION_CONTENT_TYPE_USER_LIBRARY_SAVED_STATE" then
            return "HYDRATION_CONTENT_TYPE_USER_LIBRARY_SAVED_STATE"
        elseif str1 == "HYDRATION_CONTENT_TYPE_GAME_PASS_VOTE" then
            return "HYDRATION_CONTENT_TYPE_GAME_PASS_VOTE"
        end

        return nil
    end
}

return {
    HydrationContentType = tbl1.HydrationContentType
}
