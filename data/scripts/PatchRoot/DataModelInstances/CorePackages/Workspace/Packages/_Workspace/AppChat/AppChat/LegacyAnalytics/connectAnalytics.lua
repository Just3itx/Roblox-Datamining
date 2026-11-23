-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
local AppChat = script:FindFirstAncestor("AppChat")

local AnalyticsContext = require(script.Parent.AnalyticsContext)

return require(AppChat.SocialLibraries).Context.getConnect(AnalyticsContext)
