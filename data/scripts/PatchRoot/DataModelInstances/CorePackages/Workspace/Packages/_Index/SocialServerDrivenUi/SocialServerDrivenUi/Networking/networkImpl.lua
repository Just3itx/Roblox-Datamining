-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T20:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
local SocialServerDrivenUiParent = script:FindFirstAncestor("SocialServerDrivenUi").Parent

local HttpRequest = require(SocialServerDrivenUiParent.HttpRequest)

local maxRetryCount = game:DefineFastInt("SocialServerDrivenUiHttpRetryCount", 3)

return HttpRequest.config({ requestFunction = HttpRequest.requestFunctions.RequestInternal, maxRetryCount = maxRetryCount })
