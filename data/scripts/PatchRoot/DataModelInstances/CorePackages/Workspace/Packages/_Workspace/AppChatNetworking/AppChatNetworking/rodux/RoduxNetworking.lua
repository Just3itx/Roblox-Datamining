-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:11:19Z
-- Luau bytecode version: 14 | Luau type version: 3
local AppChatNetworking = script:FindFirstAncestor("AppChatNetworking")
local AppChatNetworkingParent = AppChatNetworking.Parent
local RoduxNetworking = require(AppChatNetworkingParent.RoduxNetworking)
local HttpRequest = require(AppChatNetworking.url.HttpRequest)

return RoduxNetworking.config(
    {
        keyPath = "ChatAppReducer.networkStatus",
        networkImpl = HttpRequest.default,
        killRequestWithFilteredIds = true
    }
)
