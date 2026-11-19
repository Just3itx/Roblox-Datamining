-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:50:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContentProvider = game:GetService("ContentProvider")

local function preventTableModification(_, _, _)
    error("Attempt to modify read-only table")
end

local function createReadOnlyTable(tbl1: {ACCOUNT_SETTINGS: string, ACCOUNT_SETTINGS_URL: string, ADS_URL: string, APIS_RCS_URL: string, APIS_URL: string, API_URL: string, AUTH_URL: string, AVATAR_URL: string, BADGES_URL: string, BASE_URL: string, BASE_URL_SECURE: any, BLOG_URL: string, CATALOG_URL: string, CHAT_URL: string, CORP_URL: string, CREATOR_HUB_URL: string, DISCUSSIONS_URL: string, DOMAIN: string, ECONOMY_URL: string, FOLLOWINGS_URL: string, FRIEND_URL: string, GAME_ASSET_URL: string, GAME_I18N_URL: string, GAME_URL: string, LOCALE: string, METRICS_URL: string, NOTIFICATION_URL: string, PREFIX: string, PREMIUM_FEATURES: string, PRESENCE_URL: string, REALTIME_URL: string, THUMBNAILS_URL: string, WEB_URL: string, WWW_URL: string, getPlaceDefaultThumbnailUrl: (any, any, any, any) -> string, getUserFriendsUrl: (any, any) -> string, getUserInventoryUrl: (any, any) -> string, getUserProfileUrl: (any, any) -> string, isVanitySite: (any) -> boolean, makeQueryString: (any, any) -> string}) -- Luacid: Inlined by compiler; 1 call site recovered
    return (setmetatable({}, { __index = tbl1, __newindex = preventTableModification, __metatable = false }))
end

local function parseBaseUrlInformation(): (string, string, string)
    local baseUrl = ContentProvider.BaseUrl

    if baseUrl:sub(#baseUrl) ~= "/" then
        baseUrl ..= "/"
    end

    local _, var1 = baseUrl:find("://")

    local var2, var3 = baseUrl:find("%.", var1 + 1)
    return baseUrl, baseUrl:sub(var1 + 1, var2 - 1), (baseUrl:sub(var3 + 1))
end

local BASE_URL, PREFIX, DOMAIN = parseBaseUrlInformation()

local API_URL = string.format("https://api.%s", DOMAIN)
local APIS_URL = string.format("https://apis.%s", DOMAIN)
local AUTH_URL = string.format("https://auth.%s", DOMAIN)
local ACCOUNT_SETTINGS_URL = string.format("https://accountsettings.%s", DOMAIN)
local AVATAR_URL = string.format("https://avatar.%s", DOMAIN)
local CATALOG_URL = string.format("https://catalog.%s", DOMAIN)
local CHAT_URL = string.format("https://chat.%sv2", DOMAIN)
local CREATOR_HUB_URL = string.format("https://create.%s", DOMAIN)
local FRIEND_URL = string.format("https://friends.%sv1", DOMAIN)
local GAME_ASSET_URL = string.format("https://assetgame.%s", DOMAIN)
local GAME_URL = string.format("https://games.%s", DOMAIN)
local NOTIFICATION_URL = string.format("https://notifications.%s", DOMAIN)
local PRESENCE_URL = string.format("https://presence.%sv1", DOMAIN)
local REALTIME_URL = string.format("https://realtime.%s", DOMAIN)
local WEB_URL = string.format("https://web.%s", DOMAIN)
local WWW_URL = string.format("https://www.%s", DOMAIN)
local ADS_URL = string.format("https://ads.%s", DOMAIN)
local FOLLOWINGS_URL = string.format("https://followings.%s", DOMAIN)
local ECONOMY_URL = string.format("https://economy.%s", DOMAIN)
local THUMBNAILS_URL = string.format("https://thumbnails.%s", DOMAIN)
local ACCOUNT_SETTINGS = string.format("https://accountsettings.%s", DOMAIN)
local PREMIUM_FEATURES = string.format("https://premiumfeatures.%s", DOMAIN)
local LOCALE = string.format("https://locale.%s", DOMAIN)
local BADGES_URL = string.format("https://badges.%s", DOMAIN)
local METRICS_URL = string.format("https://metrics.%sv1", DOMAIN)
local APIS_RCS_URL = string.format("https://apis.rcs.%s", DOMAIN)
local DISCUSSIONS_URL = string.format("https://discussions.%s", DOMAIN)

return (createReadOnlyTable({
    DOMAIN = DOMAIN,
    PREFIX = PREFIX,
    BASE_URL = BASE_URL,
    BASE_URL_SECURE = string.gsub(BASE_URL, "http://", "https://"),
    API_URL = API_URL,
    APIS_URL = APIS_URL,
    AUTH_URL = AUTH_URL,
    ACCOUNT_SETTINGS_URL = ACCOUNT_SETTINGS_URL,
    AVATAR_URL = AVATAR_URL,
    CATALOG_URL = CATALOG_URL,
    CREATOR_HUB_URL = CREATOR_HUB_URL,
    GAME_URL = GAME_URL,
    GAME_ASSET_URL = GAME_ASSET_URL,
    CHAT_URL = CHAT_URL,
    FRIEND_URL = FRIEND_URL,
    PRESENCE_URL = PRESENCE_URL,
    NOTIFICATION_URL = NOTIFICATION_URL,
    REALTIME_URL = REALTIME_URL,
    WEB_URL = WEB_URL,
    WWW_URL = WWW_URL,
    ADS_URL = ADS_URL,
    FOLLOWINGS_URL = FOLLOWINGS_URL,
    ECONOMY_URL = ECONOMY_URL,
    THUMBNAILS_URL = THUMBNAILS_URL,
    BADGES_URL = BADGES_URL,
    ACCOUNT_SETTINGS = ACCOUNT_SETTINGS,
    PREMIUM_FEATURES = PREMIUM_FEATURES,
    LOCALE = LOCALE,
    METRICS_URL = METRICS_URL,
    APIS_RCS_URL = APIS_RCS_URL,
    DISCUSSIONS_URL = DISCUSSIONS_URL,
    BLOG_URL = "https://blog.roblox.com/",
    CORP_URL = "https://corp.roblox.com/",
    GAME_I18N_URL = string.format("https://gameinternationalization.%s", DOMAIN),
    getUserProfileUrl = function(arg1, arg2): string
        return string.format("%susers/%s/profile", arg1.BASE_URL, arg2)
    end,
    getUserFriendsUrl = function(arg1, arg2): string
        return string.format("%susers/%s/friends", arg1.BASE_URL, arg2)
    end,
    getUserInventoryUrl = function(arg1, arg2): string
        return string.format("%susers/%s/inventory", arg1.BASE_URL, arg2)
    end,
    getPlaceDefaultThumbnailUrl = function(arg1, assetId, width, height): string
        return string.format(
            "%sThumbs/Asset.ashx?width=%d&height=%d&assetId=%s&ignorePlaceMediaItems=true",
            arg1.BASE_URL,
            width,
            height,
            tostring(assetId)
        )
    end,
    isVanitySite = function(arg1): boolean
        return arg1.PREFIX ~= "www"
    end,
    makeQueryString = function(_, arg1): string
        local tbl1 = {}

        for k, value in pairs(arg1) do
            if value == nil then
                continue
            end

            if type(value) == "table" then
                for i = 1, #value do
                    table.insert(tbl1, k .. "=" .. value[i])
                end
            else
                table.insert(tbl1, k .. "=" .. tostring(value))
            end
        end

        return table.concat(tbl1, "&")
    end
}))
