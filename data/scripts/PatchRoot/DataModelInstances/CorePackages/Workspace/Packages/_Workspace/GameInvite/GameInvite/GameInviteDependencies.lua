-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:41:23Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent

local HttpRequest = require(scriptParentParent.HttpRequest)

local maxRetryCount = game:DefineFastInt("GameInviteHttpRetryCount", 0)

return {
    networkImpl = HttpRequest.config({ requestFunction = HttpRequest.requestFunctions.HttpRbxApi, maxRetryCount = maxRetryCount })
}
