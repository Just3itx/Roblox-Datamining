-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:31:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericChallenges = script:FindFirstAncestor("GenericChallenges")
local constants = require(GenericChallenges.Utils.constants)

return function(forbiddenStatusCode: number, tbl1): boolean
    return forbiddenStatusCode == constants.forbiddenStatusCode
        and tbl1[constants.challengeTypeHeader] ~= nil
        and tbl1[constants.challengeIdHeader] ~= nil
        and tbl1[constants.challengeMetadataHeader] ~= nil
end
