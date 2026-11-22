-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:51:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local ProfileShareLinksParent = script:FindFirstAncestor("ProfileShareLinks").Parent
local Dash = require(ProfileShareLinksParent.Dash)
local EventTypes = require(ProfileShareLinksParent.SocialLuaAnalytics).Analytics.Enums.EventTypes
local EventNames = require(script.Parent.EventNames)

return {
    [EventNames.ProfileShareLinkActivated] = {
        context = "",
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = EventNames.ProfileShareLinkActivated
        },
        formatRulesForAdditionalInfo = {
            context = Dash.identity,
            shareType = Dash.identity,
            stamp = Dash.identity
        }
    }
}
