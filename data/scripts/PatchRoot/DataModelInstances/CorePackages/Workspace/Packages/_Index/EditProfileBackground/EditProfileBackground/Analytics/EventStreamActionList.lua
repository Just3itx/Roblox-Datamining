-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local EditProfileBackgroundParent = script:FindFirstAncestor("EditProfileBackground").Parent
local Enums = require(EditProfileBackgroundParent.SocialLuaAnalytics).Analytics.Enums
local Contexts = Enums.Contexts
local EventTypes = Enums.EventTypes

local EventNames = require(script.Parent.Enums.EventNames)
local ButtonNames = require(script.Parent.Enums.ButtonNames)

return {
    [EventNames.EditProfileBackgroundOpened] = {
        context = Contexts.EditProfile,
        eventType = EventTypes.PageLoad,
        additionalInfo = {
            btn = ButtonNames.EditProfileBackgroundOpened
        }
    },
    [EventNames.BackgroundSelected] = {
        context = Contexts.EditProfile,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = ButtonNames.BackgroundSelected
        }
    }
}
