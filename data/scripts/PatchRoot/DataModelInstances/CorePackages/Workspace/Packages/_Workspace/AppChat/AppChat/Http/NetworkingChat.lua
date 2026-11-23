-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:50:44Z
-- Luau bytecode version: 14 | Luau type version: 3
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local NetworkingChat = require(AppChatParent.LuaSocialLibrariesDeps).NetworkingChat

local RoduxNetworking = require(script.Parent.RoduxNetworking)

return NetworkingChat.config({ roduxNetworking = RoduxNetworking })
