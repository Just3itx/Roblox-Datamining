-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local EditProfileParent = script:FindFirstAncestor("EditProfile").Parent
local Enums = require(EditProfileParent.SocialLuaAnalytics).Analytics.Enums
local Contexts = Enums.Contexts
local EventTypes = Enums.EventTypes

return {
    [require(script.Parent.Enums.EventNames).UsernameSaved] = {
        context = Contexts.EditProfile,
        eventType = EventTypes.UsernameSaved
    }
}
