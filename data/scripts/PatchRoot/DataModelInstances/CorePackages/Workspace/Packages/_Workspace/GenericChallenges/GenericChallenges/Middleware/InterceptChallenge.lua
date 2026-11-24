-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:31:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericChallenges = script:FindFirstAncestor("GenericChallenges")
local RenderChallenge = require(script.Parent.RenderChallenge)
local _InitializeHybridCallback = require(script.Parent.InitializeHybridCallback)

local GenericChallengesParent = GenericChallenges.Parent
local Promise = require(GenericChallengesParent.Promise)
local _LuauPolyfill = require(GenericChallengesParent.LuauPolyfill)

return function(tbl1)
    return Promise.new(function(resolve, reject)
        RenderChallenge({
            title = tbl1.title,
            rawResponseHeaders = tbl1.rawResponseHeaders,
            retryRequestCallback = tbl1.retryRequestCallback,
            challengeErrorCallback = tbl1.challengeErrorCallback,
            resolve = resolve,
            reject = reject
        })
    end)
end
