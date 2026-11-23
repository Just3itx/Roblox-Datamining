-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:01:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local AppChatNetworking = script:FindFirstAncestor("AppChatNetworking")
local AppChatNetworkingParent = AppChatNetworking.Parent

local CHAT_PLATFORM_BASE_URL = require(AppChatNetworking.url.CHAT_PLATFORM_BASE_URL)
local default = require(AppChatNetworking.url.HttpRequest).default
local GetFFlagIsSquadEnabled = require(AppChatNetworkingParent.SharedFlags).GetFFlagIsSquadEnabled
local GetFFlagEnableSocialCards = require(AppChatNetworkingParent.SharedFlags).GetFFlagEnableSocialCards

return function(arg1, query: string, cursor: string?, limit: number?, placement: string?)
    arg1 = arg1 or default

    local httpService = HttpService
    local input = {
        query = query,
        limit = limit,
        cursor = 0,
        placement = 0,
        include_user_data = true,
        include_participants = true,
        include_messages = true,
        include_cards = 0,
        check_for_group_up = 0
    }

    if cursor == nil or cursor == "" then
        cursor = nil
    end

    input.cursor = cursor
    input.placement = placement

    input.include_cards = not not GetFFlagEnableSocialCards()
    input.check_for_group_up = not not GetFFlagIsSquadEnabled()
    local postBody = httpService:JSONEncode(input)

    return arg1(`{CHAT_PLATFORM_BASE_URL}/v1/search-conversations`, "POST", { postBody = postBody })
end
