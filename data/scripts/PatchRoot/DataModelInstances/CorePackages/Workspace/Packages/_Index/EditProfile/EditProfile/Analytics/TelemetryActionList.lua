-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
local EditProfileParent = script:FindFirstAncestor("EditProfile").Parent
local _SocialLuaAnalytics = require(EditProfileParent.SocialLuaAnalytics)

return {
    defaults = {
        throttlingThousandths = game:DefineFastInt("EditProfileAnalyticsThrottlingThousandths", 1000),
        links = ""
    }
}
