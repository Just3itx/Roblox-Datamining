-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:11:09Z
-- Luau bytecode version: 14 | Luau type version: 3
local SocialLuaAnalyticsParent = script:FindFirstAncestor("SocialLuaAnalytics").Parent

local LuaSocialLibrariesDeps = require(SocialLuaAnalyticsParent.LuaSocialLibrariesDeps)

return {
    t = require(SocialLuaAnalyticsParent.t),
    tutils = require(SocialLuaAnalyticsParent.tutils),
    RoduxPresence = LuaSocialLibrariesDeps.RoduxPresence.config({ keyPath = "SocialLuaAnalytics.Presence" }),
    llama = LuaSocialLibrariesDeps.llama,
    enumerate = require(SocialLuaAnalyticsParent.enumerate),
    LuauPolyfill = require(SocialLuaAnalyticsParent.LuauPolyfill),
    Rodux = require(SocialLuaAnalyticsParent.Rodux),
    Dash = require(SocialLuaAnalyticsParent.Dash)
}
