-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatNetworking = script:FindFirstAncestor("AppChatNetworking")

local CHAT_PLATFORM_BASE_URL = require(AppChatNetworking.url.CHAT_PLATFORM_BASE_URL)
local default = require(AppChatNetworking.url.HttpRequest).default

return function(arg1)
    return (arg1 or default)(`{CHAT_PLATFORM_BASE_URL}/v1/metadata`, "GET")
end
