-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
local SocialTabsPageParent = script:FindFirstAncestor("SocialTabsPage").Parent

local HttpRequest = require(SocialTabsPageParent.HttpRequest)

local maxRetryCount = game:DefineFastInt("SocialTabsPageHttpRetryCount", 3)

return HttpRequest.config({ requestFunction = HttpRequest.requestFunctions.RequestInternal, maxRetryCount = maxRetryCount })
