-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:11:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialProofNetworking = script:FindFirstAncestor("SocialProofNetworking")
local SOCIAL_PROOF_URL = require(SocialProofNetworking.SOCIAL_PROOF_URL)
local _types = require(SocialProofNetworking.types)

return function(tbl1)
    return tbl1.roduxNetworking.POST("GetConnectionsByEntityId", function(arg1, tbl2)
        return (arg1(SOCIAL_PROOF_URL):path("social-proof-api"):path("v1"):path("social-proof"):path("entity"):path("connections"):body(
            {
                entityId = tbl2.entityId,
                entityType = tbl2.entityType,
                connectionType = tbl2.connectionType,
                cursor = tbl2.cursor
            }
        ))
    end)
end
