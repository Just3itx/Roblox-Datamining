-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:50:43Z
-- Luau bytecode version: 14 | Luau type version: 3
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local UserBlockingNetworking = require(AppChatParent.UserBlockingNetworking)

local RoduxNetworking = require(script.Parent.RoduxNetworking)

return UserBlockingNetworking.config({ roduxNetworking = RoduxNetworking })
