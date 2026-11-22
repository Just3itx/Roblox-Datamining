-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T09:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
local PlayerContextualMenuParent = script:FindFirstAncestor("PlayerContextualMenu").Parent
local RoduxNetworking = require(PlayerContextualMenuParent.LuaSocialLibrariesDeps).RoduxNetworking
local httpRequest = require(script.Parent.httpRequest)

return RoduxNetworking.config({ keyPath = "EventReceievers.NetworkStatus", networkImpl = httpRequest })
