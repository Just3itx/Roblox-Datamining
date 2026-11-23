-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatNetworking = script:FindFirstAncestor("AppChatNetworking")
local CHAT_PLATFORM_BASE_URL = require(AppChatNetworking.url.CHAT_PLATFORM_BASE_URL)

return require(script.Parent.RoduxNetworking).POST(script.Name, function(arg1, isInExperience)
    return arg1(CHAT_PLATFORM_BASE_URL):path("v2"):path("get-modal-sequence"):body(
        { is_in_experience = isInExperience, modal_sequence = "chat_landing_modal" }
    ):setStatusIds(
        { "chat_landing_modal" }
    )
end)
