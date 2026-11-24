-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:31:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericChallengesParent = script:FindFirstAncestor("GenericChallenges").Parent

local HttpClient = require(GenericChallengesParent.HttpClient)
local ChallengeNetworkWrapper = require(script.Parent.ChallengeNetworkWrapper)
local _InterceptChallenge = require(script.Parent.InterceptChallenge)

return function(arg1, arg2)
    local var1 = arg2 or HttpClient.withRetry(HttpClient.createRequestInternalNetwork())
    return ChallengeNetworkWrapper(var1, arg1)
end
