-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:00:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _proto = require(script.Parent.Parent.Parent.Parent.Parent.proto)
local _typeRegistry = require(script.Parent.Parent.Parent.Parent.Parent.proto.typeRegistry)

local tbl1 = ({})

tbl1.Capability = {
    fromNumber = function(num1: number)
        if num1 == 0 then
            return "CAPABILITY_INVALID"
        elseif num1 == 1 then
            return "CAPABILITY_SUPPORTS_HYDRATION_CLIENT_HINTS"
        elseif num1 == 2 then
            return "CAPABILITY_SUPPORTS_SCALED_PLAY_BUTTON_AND_IMAGE_SIZES"
        elseif num1 == 3 then
            return "CAPABILITY_SUPPORTS_EXTENDED_CLIENT_CAPABILITIES"
        elseif num1 == 4 then
            return "CAPABILITY_SUPPORTS_MULTI_SIZE_POOL"
        elseif num1 == 5 then
            return "CAPABILITY_SUPPORTS_PREFERRED_TEXT_SIZE_LINE_BUDGETS"
        elseif num1 == 6 then
            return "CAPABILITY_SUPPORTS_VIDEO_PLAYER_ACCESS_CONTEXT"
        elseif num1 == 7 then
            return "CAPABILITY_SUPPORTS_LAUNCH_EXPERIENCE_PLAYABILITY_CHECK"
        elseif num1 == 8 then
            return "CAPABILITY_SUPPORTS_UNIVERSE_ITEM_CONNECTIONS_PLAYED"
        elseif num1 == 9 then
            return "CAPABILITY_SUPPORTS_GAME_TILE_FOOTER_TRAILING_COMPONENT"
        elseif num1 == 10 then
            return "CAPABILITY_SUPPORTS_GAME_TILE_ACTIVE_FRIENDS_TREATMENT"
        elseif num1 == 2000 then
            return "CAPABILITY_SUPPORTS_EDP_PERSISTENT_ACTION_BAR_PLAY_BUTTON"
        elseif num1 == 2001 then
            return "CAPABILITY_SUPPORTS_PIN_SHORTCUT_ACTION"
        elseif num1 == 2002 then
            return "CAPABILITY_SUPPORTS_SPLIT_PANE"
        elseif num1 == 2003 then
            return "CAPABILITY_SUPPORTS_EDP_COMMUNITY_SECTION"
        elseif num1 == 2004 then
            return "CAPABILITY_SUPPORTS_EDP_BUILD_TAG"
        elseif num1 == 2005 then
            return "CAPABILITY_SUPPORTS_EDP_UNIVERSE_PRIVATE_SERVER_BINDING"
        elseif num1 == 2006 then
            return "CAPABILITY_SUPPORTS_EDP_EARLY_ACCESS_UPSELL"
        elseif num1 == 2007 then
            return "CAPABILITY_SUPPORTS_CONTAINER_QUERIES"
        elseif num1 == 2008 then
            return "CAPABILITY_SUPPORTS_EDP_INFO_TABLE_STABLE_ITEM_KEYS"
        elseif num1 == 2009 then
            return "CAPABILITY_SUPPORTS_EDP_MEDIA_GALLERY_MOMENT_VIDEO"
        elseif num1 == 2010 then
            return "CAPABILITY_SUPPORTS_LEADERBOARD"
        elseif num1 == 3000 then
            return "CAPABILITY_SUPPORTS_OPEN_EXPERIENCE_STORE_SEE_ALL_WITH_WEBVIEW_FALLBACK_ACTION"
        elseif num1 == 4000 then
            return "CAPABILITY_SUPPORTS_EVENT_RSVP_FACE_PILE"
        elseif num1 == 5000 then
            return "CAPABILITY_SUPPORTS_COMMUNITY_ANNOUNCEMENTS"
        elseif num1 == 5001 then
            return "CAPABILITY_SUPPORTS_GROUP_ANNOUNCEMENTS"
        elseif num1 == 5002 then
            return "CAPABILITY_SUPPORTS_GROUP_CONTENT_REACTIONS"
        elseif num1 == 5003 then
            return "CAPABILITY_SUPPORTS_GROUP_FORUM_POST_TEMPLATE"
        elseif num1 == 6000 then
            return "CAPABILITY_SUPPORTS_FOUNDATION_BADGE_OVERMEDIA_LIGHT"
        elseif num1 == 6001 then
            return "CAPABILITY_SUPPORTS_FOUNDATION_BADGE_SHAPE"
        elseif num1 == 7000 then
            return "CAPABILITY_SUPPORTS_SAFETY_RESOURCE_BANNER"
        elseif num1 == 7001 then
            return "CAPABILITY_SUPPORTS_SEARCH_VIDEO_PREVIEW"
        end

        return nil
    end,
    toNumber = function(arg1)
        if arg1 == "CAPABILITY_INVALID" then
            return 0
        elseif arg1 == "CAPABILITY_SUPPORTS_HYDRATION_CLIENT_HINTS" then
            return 1
        elseif arg1 == "CAPABILITY_SUPPORTS_SCALED_PLAY_BUTTON_AND_IMAGE_SIZES" then
            return 2
        elseif arg1 == "CAPABILITY_SUPPORTS_EXTENDED_CLIENT_CAPABILITIES" then
            return 3
        elseif arg1 == "CAPABILITY_SUPPORTS_MULTI_SIZE_POOL" then
            return 4
        elseif arg1 == "CAPABILITY_SUPPORTS_PREFERRED_TEXT_SIZE_LINE_BUDGETS" then
            return 5
        elseif arg1 == "CAPABILITY_SUPPORTS_VIDEO_PLAYER_ACCESS_CONTEXT" then
            return 6
        elseif arg1 == "CAPABILITY_SUPPORTS_LAUNCH_EXPERIENCE_PLAYABILITY_CHECK" then
            return 7
        elseif arg1 == "CAPABILITY_SUPPORTS_UNIVERSE_ITEM_CONNECTIONS_PLAYED" then
            return 8
        elseif arg1 == "CAPABILITY_SUPPORTS_GAME_TILE_FOOTER_TRAILING_COMPONENT" then
            return 9
        elseif arg1 == "CAPABILITY_SUPPORTS_GAME_TILE_ACTIVE_FRIENDS_TREATMENT" then
            return 10
        elseif arg1 == "CAPABILITY_SUPPORTS_EDP_PERSISTENT_ACTION_BAR_PLAY_BUTTON" then
            return 2000
        elseif arg1 == "CAPABILITY_SUPPORTS_PIN_SHORTCUT_ACTION" then
            return 2001
        elseif arg1 == "CAPABILITY_SUPPORTS_SPLIT_PANE" then
            return 2002
        elseif arg1 == "CAPABILITY_SUPPORTS_EDP_COMMUNITY_SECTION" then
            return 2003
        elseif arg1 == "CAPABILITY_SUPPORTS_EDP_BUILD_TAG" then
            return 2004
        elseif arg1 == "CAPABILITY_SUPPORTS_EDP_UNIVERSE_PRIVATE_SERVER_BINDING" then
            return 2005
        elseif arg1 == "CAPABILITY_SUPPORTS_EDP_EARLY_ACCESS_UPSELL" then
            return 2006
        elseif arg1 == "CAPABILITY_SUPPORTS_CONTAINER_QUERIES" then
            return 2007
        elseif arg1 == "CAPABILITY_SUPPORTS_EDP_INFO_TABLE_STABLE_ITEM_KEYS" then
            return 2008
        elseif arg1 == "CAPABILITY_SUPPORTS_EDP_MEDIA_GALLERY_MOMENT_VIDEO" then
            return 2009
        elseif arg1 == "CAPABILITY_SUPPORTS_LEADERBOARD" then
            return 2010
        elseif arg1 == "CAPABILITY_SUPPORTS_OPEN_EXPERIENCE_STORE_SEE_ALL_WITH_WEBVIEW_FALLBACK_ACTION" then
            return 3000
        elseif arg1 == "CAPABILITY_SUPPORTS_EVENT_RSVP_FACE_PILE" then
            return 4000
        elseif arg1 == "CAPABILITY_SUPPORTS_COMMUNITY_ANNOUNCEMENTS" then
            return 5000
        elseif arg1 == "CAPABILITY_SUPPORTS_GROUP_ANNOUNCEMENTS" then
            return 5001
        elseif arg1 == "CAPABILITY_SUPPORTS_GROUP_CONTENT_REACTIONS" then
            return 5002
        elseif arg1 == "CAPABILITY_SUPPORTS_GROUP_FORUM_POST_TEMPLATE" then
            return 5003
        elseif arg1 == "CAPABILITY_SUPPORTS_FOUNDATION_BADGE_OVERMEDIA_LIGHT" then
            return 6000
        elseif arg1 == "CAPABILITY_SUPPORTS_FOUNDATION_BADGE_SHAPE" then
            return 6001
        elseif arg1 == "CAPABILITY_SUPPORTS_SAFETY_RESOURCE_BANNER" then
            return 7000
        elseif arg1 == "CAPABILITY_SUPPORTS_SEARCH_VIDEO_PREVIEW" then
            return 7001
        end

        return arg1
    end,
    fromName = function(str1: string)
        if str1 == "CAPABILITY_INVALID" then
            return "CAPABILITY_INVALID"
        elseif str1 == "CAPABILITY_SUPPORTS_HYDRATION_CLIENT_HINTS" then
            return "CAPABILITY_SUPPORTS_HYDRATION_CLIENT_HINTS"
        elseif str1 == "CAPABILITY_SUPPORTS_SCALED_PLAY_BUTTON_AND_IMAGE_SIZES" then
            return "CAPABILITY_SUPPORTS_SCALED_PLAY_BUTTON_AND_IMAGE_SIZES"
        elseif str1 == "CAPABILITY_SUPPORTS_EXTENDED_CLIENT_CAPABILITIES" then
            return "CAPABILITY_SUPPORTS_EXTENDED_CLIENT_CAPABILITIES"
        elseif str1 == "CAPABILITY_SUPPORTS_MULTI_SIZE_POOL" then
            return "CAPABILITY_SUPPORTS_MULTI_SIZE_POOL"
        elseif str1 == "CAPABILITY_SUPPORTS_PREFERRED_TEXT_SIZE_LINE_BUDGETS" then
            return "CAPABILITY_SUPPORTS_PREFERRED_TEXT_SIZE_LINE_BUDGETS"
        elseif str1 == "CAPABILITY_SUPPORTS_VIDEO_PLAYER_ACCESS_CONTEXT" then
            return "CAPABILITY_SUPPORTS_VIDEO_PLAYER_ACCESS_CONTEXT"
        elseif str1 == "CAPABILITY_SUPPORTS_LAUNCH_EXPERIENCE_PLAYABILITY_CHECK" then
            return "CAPABILITY_SUPPORTS_LAUNCH_EXPERIENCE_PLAYABILITY_CHECK"
        elseif str1 == "CAPABILITY_SUPPORTS_UNIVERSE_ITEM_CONNECTIONS_PLAYED" then
            return "CAPABILITY_SUPPORTS_UNIVERSE_ITEM_CONNECTIONS_PLAYED"
        elseif str1 == "CAPABILITY_SUPPORTS_GAME_TILE_FOOTER_TRAILING_COMPONENT" then
            return "CAPABILITY_SUPPORTS_GAME_TILE_FOOTER_TRAILING_COMPONENT"
        elseif str1 == "CAPABILITY_SUPPORTS_GAME_TILE_ACTIVE_FRIENDS_TREATMENT" then
            return "CAPABILITY_SUPPORTS_GAME_TILE_ACTIVE_FRIENDS_TREATMENT"
        elseif str1 == "CAPABILITY_SUPPORTS_EDP_PERSISTENT_ACTION_BAR_PLAY_BUTTON" then
            return "CAPABILITY_SUPPORTS_EDP_PERSISTENT_ACTION_BAR_PLAY_BUTTON"
        elseif str1 == "CAPABILITY_SUPPORTS_PIN_SHORTCUT_ACTION" then
            return "CAPABILITY_SUPPORTS_PIN_SHORTCUT_ACTION"
        elseif str1 == "CAPABILITY_SUPPORTS_SPLIT_PANE" then
            return "CAPABILITY_SUPPORTS_SPLIT_PANE"
        elseif str1 == "CAPABILITY_SUPPORTS_EDP_COMMUNITY_SECTION" then
            return "CAPABILITY_SUPPORTS_EDP_COMMUNITY_SECTION"
        elseif str1 == "CAPABILITY_SUPPORTS_EDP_BUILD_TAG" then
            return "CAPABILITY_SUPPORTS_EDP_BUILD_TAG"
        elseif str1 == "CAPABILITY_SUPPORTS_EDP_UNIVERSE_PRIVATE_SERVER_BINDING" then
            return "CAPABILITY_SUPPORTS_EDP_UNIVERSE_PRIVATE_SERVER_BINDING"
        elseif str1 == "CAPABILITY_SUPPORTS_EDP_EARLY_ACCESS_UPSELL" then
            return "CAPABILITY_SUPPORTS_EDP_EARLY_ACCESS_UPSELL"
        elseif str1 == "CAPABILITY_SUPPORTS_CONTAINER_QUERIES" then
            return "CAPABILITY_SUPPORTS_CONTAINER_QUERIES"
        elseif str1 == "CAPABILITY_SUPPORTS_EDP_INFO_TABLE_STABLE_ITEM_KEYS" then
            return "CAPABILITY_SUPPORTS_EDP_INFO_TABLE_STABLE_ITEM_KEYS"
        elseif str1 == "CAPABILITY_SUPPORTS_EDP_MEDIA_GALLERY_MOMENT_VIDEO" then
            return "CAPABILITY_SUPPORTS_EDP_MEDIA_GALLERY_MOMENT_VIDEO"
        elseif str1 == "CAPABILITY_SUPPORTS_LEADERBOARD" then
            return "CAPABILITY_SUPPORTS_LEADERBOARD"
        elseif str1 == "CAPABILITY_SUPPORTS_OPEN_EXPERIENCE_STORE_SEE_ALL_WITH_WEBVIEW_FALLBACK_ACTION" then
            return "CAPABILITY_SUPPORTS_OPEN_EXPERIENCE_STORE_SEE_ALL_WITH_WEBVIEW_FALLBACK_ACTION"
        elseif str1 == "CAPABILITY_SUPPORTS_EVENT_RSVP_FACE_PILE" then
            return "CAPABILITY_SUPPORTS_EVENT_RSVP_FACE_PILE"
        elseif str1 == "CAPABILITY_SUPPORTS_COMMUNITY_ANNOUNCEMENTS" then
            return "CAPABILITY_SUPPORTS_COMMUNITY_ANNOUNCEMENTS"
        elseif str1 == "CAPABILITY_SUPPORTS_GROUP_ANNOUNCEMENTS" then
            return "CAPABILITY_SUPPORTS_GROUP_ANNOUNCEMENTS"
        elseif str1 == "CAPABILITY_SUPPORTS_GROUP_CONTENT_REACTIONS" then
            return "CAPABILITY_SUPPORTS_GROUP_CONTENT_REACTIONS"
        elseif str1 == "CAPABILITY_SUPPORTS_GROUP_FORUM_POST_TEMPLATE" then
            return "CAPABILITY_SUPPORTS_GROUP_FORUM_POST_TEMPLATE"
        elseif str1 == "CAPABILITY_SUPPORTS_FOUNDATION_BADGE_OVERMEDIA_LIGHT" then
            return "CAPABILITY_SUPPORTS_FOUNDATION_BADGE_OVERMEDIA_LIGHT"
        elseif str1 == "CAPABILITY_SUPPORTS_FOUNDATION_BADGE_SHAPE" then
            return "CAPABILITY_SUPPORTS_FOUNDATION_BADGE_SHAPE"
        elseif str1 == "CAPABILITY_SUPPORTS_SAFETY_RESOURCE_BANNER" then
            return "CAPABILITY_SUPPORTS_SAFETY_RESOURCE_BANNER"
        elseif str1 == "CAPABILITY_SUPPORTS_SEARCH_VIDEO_PREVIEW" then
            return "CAPABILITY_SUPPORTS_SEARCH_VIDEO_PREVIEW"
        end

        return nil
    end
}

return {
    Capability = tbl1.Capability
}
