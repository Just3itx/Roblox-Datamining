-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local _typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

tbl1.DisplayLocation = {
    fromNumber = function(num1: number)
        if num1 == 0 then
            return "DISPLAY_LOCATION_INVALID"
        elseif num1 == 1 then
            return "DISPLAY_LOCATION_GLOBAL"
        elseif num1 == 2 then
            return "DISPLAY_LOCATION_BADGE_SEE_ALL"
        elseif num1 == 3 then
            return "DISPLAY_LOCATION_BADGE_DETAILS"
        elseif num1 == 4 then
            return "DISPLAY_LOCATION_PROMPTS"
        elseif num1 == 5 then
            return "DISPLAY_LOCATION_EXPERIENCE_DETAILS"
        elseif num1 == 6 then
            return "DISPLAY_LOCATION_DEV_STORE_SEE_ALL"
        elseif num1 == 7 then
            return "DISPLAY_LOCATION_CHARTS"
        elseif num1 == 8 then
            return "DISPLAY_LOCATION_EVENT_DETAILS"
        elseif num1 == 9 then
            return "DISPLAY_LOCATION_MARKETPLACE_LANDING"
        elseif num1 == 10 then
            return "DISPLAY_LOCATION_SEARCH_RESULTS"
        elseif num1 == 11 then
            return "DISPLAY_LOCATION_SEARCH_LANDING"
        elseif num1 == 12 then
            return "DISPLAY_LOCATION_SPOTLIGHT"
        elseif num1 == 13 then
            return "DISPLAY_LOCATION_HOME"
        elseif num1 == 14 then
            return "DISPLAY_LOCATION_SPOTLIGHT_COLLECTION"
        elseif num1 == 15 then
            return "DISPLAY_LOCATION_PARTY_CHAT"
        elseif num1 == 16 then
            return "DISPLAY_LOCATION_MARKETPLACE_FAVORITES_SAVED"
        elseif num1 == 17 then
            return "DISPLAY_LOCATION_PRE_AUTH_LANDING"
        elseif num1 == 18 then
            return "DISPLAY_LOCATION_SETTINGS"
        elseif num1 == 19 then
            return "DISPLAY_LOCATION_BUILD"
        elseif num1 == 20 then
            return "DISPLAY_LOCATION_COMMUNITY_PROFILE"
        elseif num1 == 21 then
            return "DISPLAY_LOCATION_MARKETPLACE_ITEM_DETAILS"
        elseif num1 == 22 then
            return "DISPLAY_LOCATION_HOME_SORT_DETAIL"
        elseif num1 == 23 then
            return "DISPLAY_LOCATION_SANDBOX"
        elseif num1 == 24 then
            return "DISPLAY_LOCATION_GROUP_PROFILE"
        elseif num1 == 25 then
            return "DISPLAY_LOCATION_SEARCH_AUTOCOMPLETE"
        elseif num1 == 26 then
            return "DISPLAY_LOCATION_EXPERIENCE_LEADERBOARD_SEE_ALL"
        elseif num1 == 27 then
            return "DISPLAY_LOCATION_CREATOR_EXPERIENCE_SETTINGS"
        elseif num1 == 28 then
            return "DISPLAY_LOCATION_BUY_ROBUX"
        elseif num1 == 29 then
            return "DISPLAY_LOCATION_USER_LIBRARY"
        elseif num1 == 30 then
            return "DISPLAY_LOCATION_PERKS"
        elseif num1 == 31 then
            return "DISPLAY_LOCATION_NOTIFICATION_STREAM"
        end

        if num1 == 32 then
            return "DISPLAY_LOCATION_USER_PROFILE_FRIEND_RECOMMENDATIONS"
        elseif num1 == 33 then
            return "DISPLAY_LOCATION_GAME_ITEM_DETAILS"
        elseif num1 == 34 then
            return "DISPLAY_LOCATION_CAMPAIGN"
        end

        return nil
    end,
    toNumber = function(arg1): number
        if arg1 == "DISPLAY_LOCATION_INVALID" then
            return 0
        elseif arg1 == "DISPLAY_LOCATION_GLOBAL" then
            return 1
        elseif arg1 == "DISPLAY_LOCATION_BADGE_SEE_ALL" then
            return 2
        elseif arg1 == "DISPLAY_LOCATION_BADGE_DETAILS" then
            return 3
        elseif arg1 == "DISPLAY_LOCATION_PROMPTS" then
            return 4
        elseif arg1 == "DISPLAY_LOCATION_EXPERIENCE_DETAILS" then
            return 5
        elseif arg1 == "DISPLAY_LOCATION_DEV_STORE_SEE_ALL" then
            return 6
        elseif arg1 == "DISPLAY_LOCATION_CHARTS" then
            return 7
        elseif arg1 == "DISPLAY_LOCATION_EVENT_DETAILS" then
            return 8
        elseif arg1 == "DISPLAY_LOCATION_MARKETPLACE_LANDING" then
            return 9
        elseif arg1 == "DISPLAY_LOCATION_SEARCH_RESULTS" then
            return 10
        elseif arg1 == "DISPLAY_LOCATION_SEARCH_LANDING" then
            return 11
        elseif arg1 == "DISPLAY_LOCATION_SPOTLIGHT" then
            return 12
        elseif arg1 == "DISPLAY_LOCATION_HOME" then
            return 13
        elseif arg1 == "DISPLAY_LOCATION_SPOTLIGHT_COLLECTION" then
            return 14
        elseif arg1 == "DISPLAY_LOCATION_PARTY_CHAT" then
            return 15
        elseif arg1 == "DISPLAY_LOCATION_MARKETPLACE_FAVORITES_SAVED" then
            return 16
        elseif arg1 == "DISPLAY_LOCATION_PRE_AUTH_LANDING" then
            return 17
        elseif arg1 == "DISPLAY_LOCATION_SETTINGS" then
            return 18
        elseif arg1 == "DISPLAY_LOCATION_BUILD" then
            return 19
        elseif arg1 == "DISPLAY_LOCATION_COMMUNITY_PROFILE" then
            return 20
        elseif arg1 == "DISPLAY_LOCATION_MARKETPLACE_ITEM_DETAILS" then
            return 21
        elseif arg1 == "DISPLAY_LOCATION_HOME_SORT_DETAIL" then
            return 22
        elseif arg1 == "DISPLAY_LOCATION_SANDBOX" then
            return 23
        elseif arg1 == "DISPLAY_LOCATION_GROUP_PROFILE" then
            return 24
        elseif arg1 == "DISPLAY_LOCATION_SEARCH_AUTOCOMPLETE" then
            return 25
        elseif arg1 == "DISPLAY_LOCATION_EXPERIENCE_LEADERBOARD_SEE_ALL" then
            return 26
        elseif arg1 == "DISPLAY_LOCATION_CREATOR_EXPERIENCE_SETTINGS" then
            return 27
        elseif arg1 == "DISPLAY_LOCATION_BUY_ROBUX" then
            return 28
        elseif arg1 == "DISPLAY_LOCATION_USER_LIBRARY" then
            return 29
        elseif arg1 == "DISPLAY_LOCATION_PERKS" then
            return 30
        elseif arg1 == "DISPLAY_LOCATION_NOTIFICATION_STREAM" then
            return 31
        end

        if arg1 == "DISPLAY_LOCATION_USER_PROFILE_FRIEND_RECOMMENDATIONS" then
            return 32
        elseif arg1 == "DISPLAY_LOCATION_GAME_ITEM_DETAILS" then
            return 33
        elseif arg1 == "DISPLAY_LOCATION_CAMPAIGN" then
            return 34
        end

        return arg1
    end,
    fromName = function(str1: string)
        if str1 == "DISPLAY_LOCATION_INVALID" then
            return "DISPLAY_LOCATION_INVALID"
        elseif str1 == "DISPLAY_LOCATION_GLOBAL" then
            return "DISPLAY_LOCATION_GLOBAL"
        elseif str1 == "DISPLAY_LOCATION_BADGE_SEE_ALL" then
            return "DISPLAY_LOCATION_BADGE_SEE_ALL"
        elseif str1 == "DISPLAY_LOCATION_BADGE_DETAILS" then
            return "DISPLAY_LOCATION_BADGE_DETAILS"
        elseif str1 == "DISPLAY_LOCATION_PROMPTS" then
            return "DISPLAY_LOCATION_PROMPTS"
        elseif str1 == "DISPLAY_LOCATION_EXPERIENCE_DETAILS" then
            return "DISPLAY_LOCATION_EXPERIENCE_DETAILS"
        elseif str1 == "DISPLAY_LOCATION_DEV_STORE_SEE_ALL" then
            return "DISPLAY_LOCATION_DEV_STORE_SEE_ALL"
        elseif str1 == "DISPLAY_LOCATION_CHARTS" then
            return "DISPLAY_LOCATION_CHARTS"
        elseif str1 == "DISPLAY_LOCATION_EVENT_DETAILS" then
            return "DISPLAY_LOCATION_EVENT_DETAILS"
        elseif str1 == "DISPLAY_LOCATION_MARKETPLACE_LANDING" then
            return "DISPLAY_LOCATION_MARKETPLACE_LANDING"
        elseif str1 == "DISPLAY_LOCATION_SEARCH_RESULTS" then
            return "DISPLAY_LOCATION_SEARCH_RESULTS"
        elseif str1 == "DISPLAY_LOCATION_SEARCH_LANDING" then
            return "DISPLAY_LOCATION_SEARCH_LANDING"
        elseif str1 == "DISPLAY_LOCATION_SPOTLIGHT" then
            return "DISPLAY_LOCATION_SPOTLIGHT"
        elseif str1 == "DISPLAY_LOCATION_HOME" then
            return "DISPLAY_LOCATION_HOME"
        elseif str1 == "DISPLAY_LOCATION_SPOTLIGHT_COLLECTION" then
            return "DISPLAY_LOCATION_SPOTLIGHT_COLLECTION"
        elseif str1 == "DISPLAY_LOCATION_PARTY_CHAT" then
            return "DISPLAY_LOCATION_PARTY_CHAT"
        elseif str1 == "DISPLAY_LOCATION_MARKETPLACE_FAVORITES_SAVED" then
            return "DISPLAY_LOCATION_MARKETPLACE_FAVORITES_SAVED"
        elseif str1 == "DISPLAY_LOCATION_PRE_AUTH_LANDING" then
            return "DISPLAY_LOCATION_PRE_AUTH_LANDING"
        elseif str1 == "DISPLAY_LOCATION_SETTINGS" then
            return "DISPLAY_LOCATION_SETTINGS"
        elseif str1 == "DISPLAY_LOCATION_BUILD" then
            return "DISPLAY_LOCATION_BUILD"
        elseif str1 == "DISPLAY_LOCATION_COMMUNITY_PROFILE" then
            return "DISPLAY_LOCATION_COMMUNITY_PROFILE"
        elseif str1 == "DISPLAY_LOCATION_MARKETPLACE_ITEM_DETAILS" then
            return "DISPLAY_LOCATION_MARKETPLACE_ITEM_DETAILS"
        elseif str1 == "DISPLAY_LOCATION_HOME_SORT_DETAIL" then
            return "DISPLAY_LOCATION_HOME_SORT_DETAIL"
        elseif str1 == "DISPLAY_LOCATION_SANDBOX" then
            return "DISPLAY_LOCATION_SANDBOX"
        elseif str1 == "DISPLAY_LOCATION_GROUP_PROFILE" then
            return "DISPLAY_LOCATION_GROUP_PROFILE"
        elseif str1 == "DISPLAY_LOCATION_SEARCH_AUTOCOMPLETE" then
            return "DISPLAY_LOCATION_SEARCH_AUTOCOMPLETE"
        elseif str1 == "DISPLAY_LOCATION_EXPERIENCE_LEADERBOARD_SEE_ALL" then
            return "DISPLAY_LOCATION_EXPERIENCE_LEADERBOARD_SEE_ALL"
        elseif str1 == "DISPLAY_LOCATION_CREATOR_EXPERIENCE_SETTINGS" then
            return "DISPLAY_LOCATION_CREATOR_EXPERIENCE_SETTINGS"
        elseif str1 == "DISPLAY_LOCATION_BUY_ROBUX" then
            return "DISPLAY_LOCATION_BUY_ROBUX"
        elseif str1 == "DISPLAY_LOCATION_USER_LIBRARY" then
            return "DISPLAY_LOCATION_USER_LIBRARY"
        elseif str1 == "DISPLAY_LOCATION_PERKS" then
            return "DISPLAY_LOCATION_PERKS"
        elseif str1 == "DISPLAY_LOCATION_NOTIFICATION_STREAM" then
            return "DISPLAY_LOCATION_NOTIFICATION_STREAM"
        end

        if str1 == "DISPLAY_LOCATION_USER_PROFILE_FRIEND_RECOMMENDATIONS" then
            return "DISPLAY_LOCATION_USER_PROFILE_FRIEND_RECOMMENDATIONS"
        elseif str1 == "DISPLAY_LOCATION_GAME_ITEM_DETAILS" then
            return "DISPLAY_LOCATION_GAME_ITEM_DETAILS"
        elseif str1 == "DISPLAY_LOCATION_CAMPAIGN" then
            return "DISPLAY_LOCATION_CAMPAIGN"
        end

        return nil
    end
}

return {
    DisplayLocation = tbl1.DisplayLocation
}
