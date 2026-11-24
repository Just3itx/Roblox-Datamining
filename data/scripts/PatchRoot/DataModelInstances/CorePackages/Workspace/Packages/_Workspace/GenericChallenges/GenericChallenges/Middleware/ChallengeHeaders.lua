-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:21:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericChallenges = script:FindFirstAncestor("GenericChallenges")
local constants = require(GenericChallenges.Utils.constants)
local GenericType = require(GenericChallenges.Types.GenericType)
local GenericChallengesParent = GenericChallenges.Parent

local Base64 = require(GenericChallengesParent.AuthCommon).Utils.Base64

local HttpService = game:GetService("HttpService")

local module = ({})
module.__index = module

function module.new(tbl1)
    local tbl2 = {
        challengeId = tbl1[constants.challengeIdHeader]
    }
    local input = Base64.Decode(tbl1[constants.challengeMetadataHeader])
    tbl2.challengeMetadata = {
        raw = tbl1[constants.challengeMetadataHeader],
        decoded = input,
        typed = HttpService:JSONDecode(input)
    }
    tbl2.challengeType = {
        raw = tbl1[constants.challengeTypeHeader],
        typed = GenericType.fromRawValue(tbl1[constants.challengeTypeHeader])
    }
    return (setmetatable(tbl2, module))
end

return module
