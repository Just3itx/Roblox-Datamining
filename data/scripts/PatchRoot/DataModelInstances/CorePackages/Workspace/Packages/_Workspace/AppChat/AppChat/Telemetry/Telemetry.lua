-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local SocialLuaAnalytics = require(AppChatParent.SocialLuaAnalytics)

return {
    new = SocialLuaAnalytics.Telemetry.new,
    contexts = SocialLuaAnalytics.Analytics.Enums.Contexts
}
