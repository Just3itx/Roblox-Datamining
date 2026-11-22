-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T16:20:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _networkingShareLinkTypes = require(script.Parent.networkingShareLinkTypes)

local networkRequests = script.Parent.networkRequests
local createGenerateLink = require(networkRequests.createGenerateLink)
local createGetOrGenerateLink = require(networkRequests.createGetOrGenerateLink)
local createResolveLinkFromLinkId = require(networkRequests.createResolveLinkFromLinkId)
local createResolveLinkFromLinkIdV2 = require(networkRequests.createResolveLinkFromLinkIdV2)
local createGetMetadata = require(networkRequests.createGetMetadata)

return function(arg1)
    return {
        GenerateLink = createGenerateLink(arg1),
        GetOrGenerateLink = createGetOrGenerateLink(arg1),
        ResolveLinkFromLinkId = createResolveLinkFromLinkId(arg1),
        ResolveLinkFromLinkIdV2 = createResolveLinkFromLinkIdV2(arg1),
        GetMetadata = createGetMetadata(arg1)
    }
end
