-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:30:59Z
-- Luau bytecode version: 14 | Luau type version: 3
local EditProfileBackgroundParent = script:FindFirstAncestor("EditProfileBackground").Parent
local Dash = require(EditProfileBackgroundParent.Dash)
return require(EditProfileBackgroundParent.React).createContext({ fireAnalyticsEvent = Dash.noop })
