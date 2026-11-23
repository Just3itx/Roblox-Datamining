-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:01:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local AppChatNetworking = script:FindFirstAncestor("AppChatNetworking")
local AppChatNetworkingParent = AppChatNetworking.Parent

local CHAT_PLATFORM_BASE_URL = require(AppChatNetworking.url.CHAT_PLATFORM_BASE_URL)
local default = require(AppChatNetworking.url.HttpRequest).default
local GetFFlagEnableSocialCards = require(AppChatNetworkingParent.SharedFlags).GetFFlagEnableSocialCards

return function(arg1, input: string, input2: string?)
    arg1 = arg1 or default

    local str1 = `conversation_id={HttpService:UrlEncode(input)}`
    if input2 ~= nil and input2 ~= "" then
        str1 = `{str1}&cursor={HttpService:UrlEncode(input2)}`
    end

    local str2 = `{str1}&include_cards={if GetFFlagEnableSocialCards() then "true" else "false"}`
    return arg1(`{CHAT_PLATFORM_BASE_URL}/v1/get-conversation-messages?{str2}`, "GET")
end
