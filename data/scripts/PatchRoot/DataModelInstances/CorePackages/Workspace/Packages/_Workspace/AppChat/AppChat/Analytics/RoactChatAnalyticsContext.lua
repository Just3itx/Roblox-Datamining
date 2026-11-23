-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:00:49Z
-- Luau bytecode version: 14 | Luau type version: 3
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local React = require(AppChatParent.React)
local DefaultAnalytics = require(script.Parent.DefaultAnalytics)

return React.createContext(DefaultAnalytics)
