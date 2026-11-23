-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:11:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Http = require(AppChatParent.Http)
local HttpClient = require(AppChatParent.HttpClient)

local decodeEmojiSets = require(script.Parent.Parent.decodeEmojiSets)

local url = Http.Url.APIS_URL .. "emoji-api/v1/get-emoji-sets?product=PlatformChat"

local function fetchEmojiSets(network)
    return HttpClient.fetch(
        {
            method = "GET",
            url = url,
            analyticsKey = "app-chat.get-emoji-sets",
            network = network,
            decode = decodeEmojiSets
        }
    )
end
return fetchEmojiSets
