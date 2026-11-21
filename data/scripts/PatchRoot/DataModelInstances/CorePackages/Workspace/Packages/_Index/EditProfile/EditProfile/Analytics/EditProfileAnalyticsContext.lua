-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
local EditProfileParent = script:FindFirstAncestor("EditProfile").Parent
local Dash = require(EditProfileParent.Dash)
return require(EditProfileParent.React).createContext({ fireAnalyticsEvent = Dash.noop })
