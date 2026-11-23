-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:01:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
return {
    InAppAchievementManager = require(script.InAppAchievementManager),
    InExpAchievementManager = require(script.InExpAchievementManager),
    Reducers = {
        LocalUserGameVoteCounter = require(script.Reducers.LocalUserGameVoteCounter)
    },
    Requests = {
        GetUserRecentExperiences = require(script.Requests.GetUserRecentExperiences),
        GetUserVoteCount = require(script.Requests.GetUserVoteCount),
        GetXboxLoginConsecutiveDays = require(script.Requests.GetXboxLoginConsecutiveDays)
    },
    ["jest.config"] = script["jest.config"]
}
