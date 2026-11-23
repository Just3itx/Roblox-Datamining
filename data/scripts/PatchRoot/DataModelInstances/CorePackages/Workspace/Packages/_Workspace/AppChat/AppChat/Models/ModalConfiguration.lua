-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local _AppChatNetworking = require(AppChatParent.AppChatNetworking)

return {
    default = {
        modal_variant = "none",
        modal_layout = { id = "", seen_record_action = "none", dismissed_record_action = "none" }
    }
}
