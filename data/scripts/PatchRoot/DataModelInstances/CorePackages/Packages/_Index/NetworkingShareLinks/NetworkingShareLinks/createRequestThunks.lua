-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T11:20:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _networkingShareLinkTypes = require(script.Parent.networkingShareLinkTypes)

local networkRequests = script.Parent.networkRequests
local createGenerateLink = require(networkRequests.createGenerateLink)
local createGetOrGenerateLink = require(networkRequests.createGetOrGenerateLink)
local createResolveLinkFromLinkId = require(networkRequests.createResolveLinkFromLinkId)

return function(arg1)
    return {
        ResolveLinkFromLinkId = createResolveLinkFromLinkId(arg1),
        GenerateLink = createGenerateLink(arg1),
        GetOrGenerateLink = createGetOrGenerateLink(arg1)
    }
end
