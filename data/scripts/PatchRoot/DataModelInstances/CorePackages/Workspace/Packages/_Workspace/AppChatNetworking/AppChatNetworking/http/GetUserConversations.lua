-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local AppChatNetworking = script:FindFirstAncestor("AppChatNetworking")
local AppChatNetworkingParent = AppChatNetworking.Parent

local CHAT_PLATFORM_BASE_URL = require(AppChatNetworking.url.CHAT_PLATFORM_BASE_URL)
local default = require(AppChatNetworking.url.HttpRequest).default
local GetFFlagIsSquadEnabled = require(AppChatNetworkingParent.SharedFlags).GetFFlagIsSquadEnabled
local GetFFlagEnableSocialCards = require(AppChatNetworkingParent.SharedFlags).GetFFlagEnableSocialCards

local function appendQueryArgs(str1: string, tbl1): string
    local tbl2 = {}
    for value, value2 in tbl1 do
        if value2 ~= nil then
            table.insert(tbl2, `{HttpService:UrlEncode(value)}={HttpService:UrlEncode(tostring(value2))}`)
        end
    end

    if #tbl2 == 0 then
        return str1
    end

    return `{str1}?{table.concat(tbl2, "&")}`
end

return function(arg1, cursor: string?)
    arg1 = arg1 or default

    local tbl1 = { cursor = 0, include_cards = 0, include_user_data = true, check_for_group_up = 0 }
    if cursor == nil or cursor == "" then
        cursor = nil
    end

    tbl1.cursor = cursor
    tbl1.include_cards = not not GetFFlagEnableSocialCards()

    tbl1.check_for_group_up = not not GetFFlagIsSquadEnabled()

    return arg1(appendQueryArgs(`{CHAT_PLATFORM_BASE_URL}/v1/get-user-conversations`, tbl1), "GET")
end
