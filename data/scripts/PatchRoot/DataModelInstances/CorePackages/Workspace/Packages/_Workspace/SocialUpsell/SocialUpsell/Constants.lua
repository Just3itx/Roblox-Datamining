-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:31:24Z
-- Luau bytecode version: 14 | Luau type version: 3
local SocialUpsell = script:FindFirstAncestor("SocialUpsell")

local _Types = require(SocialUpsell.Types)

return {
    UPSELL_BUTTON_ACTION = { Primary = "Primary", Secondary = "Secondary", Dismiss = "Dismiss" },
    UPSELL_OVERLAY_BUTTON_ACTION = { Primary = "Primary", Dismiss = "Dismiss" },
    UPSELL_LABEL_ITEM_TYPE_COUNTDOWN = "countdown",
    DEFAULT_FAE_ENTRY_POINT_EVENT_CTX = "CommsFae",
    OVERLAY_TYPES = { SocialUpsell = "SocialUpsell" },
    OVERLAY_MENU_NAME = "SocialUpsell",
    OVERLAY_CORE_ACTION_NAME = "SocialUpsell"
}
