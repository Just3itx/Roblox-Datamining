-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T09:41:02Z
-- Luau bytecode version: 14 | Luau type version: 3
local PlayerContextualMenuParent = script:FindFirstAncestor("PlayerContextualMenu").Parent
local HttpRequest = require(PlayerContextualMenuParent.HttpRequest)

return HttpRequest.config({ requestFunction = HttpRequest.requestFunctions.HttpRbxApi, maxRetryCount = 0 })
