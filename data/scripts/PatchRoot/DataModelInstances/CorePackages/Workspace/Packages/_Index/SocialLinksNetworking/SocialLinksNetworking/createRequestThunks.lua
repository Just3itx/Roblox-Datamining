-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:51:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local networkRequests = script.Parent.networkRequests
local createGetSocialLinks = require(networkRequests.createGetSocialLinks)
local createGetSelfSocialLinks = require(networkRequests.createGetSelfSocialLinks)
local createSetSocialLinks = require(networkRequests.createSetSocialLinks)

return function(tbl1)
    return {
        GetSocialLinks = createGetSocialLinks(tbl1),
        GetSelfSocialLinks = createGetSelfSocialLinks(tbl1),
        SetSocialLinks = createSetSocialLinks(tbl1)
    }
end
