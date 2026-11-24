-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local constants = require(script.Parent.constants)
local GenericChallengesParent = script:FindFirstAncestor("GenericChallenges").Parent

local Base64 = require(GenericChallengesParent.AuthCommon).Utils.Base64

local HttpService = game:GetService("HttpService")

return function(tbl1)
    assert(tbl1.challengeId ~= nil, "challenge id must not be nil")
    assert(tbl1.challengeType ~= nil, "challenge type must not be nil")
    assert(tbl1.metadata ~= nil, "metadata must not be nil")
    return {
        [constants.challengeIdHeader] = tbl1.challengeId,
        [constants.challengeTypeHeader] = tbl1.challengeType,
        [constants.challengeMetadataHeader] = Base64.Encode(HttpService:JSONEncode(tbl1.metadata))
    }
end
