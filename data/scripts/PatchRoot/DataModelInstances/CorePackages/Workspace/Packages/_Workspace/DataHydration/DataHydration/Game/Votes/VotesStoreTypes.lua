-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:30:43Z
-- Luau bytecode version: 14 | Luau type version: 3
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local t = require(DataHydrationParent.t)
local _Signals = require(DataHydrationParent.Signals)

local var1 = t.interface({ id = t.number, upVotes = t.number, downVotes = t.number })
return {
    votesResponseValidator = t.interface({ data = t.array(var1) }),
    userVoteResponseValidator = t.interface({ userVote = t.optional(t.boolean), canVote = t.boolean, reasonForNotVoteable = t.optional(t.string) }),
    ReasonNotVoteable = {
        PlayGame = "PlayGame",
        FloodCheckThresholdMet = "FloodCheckThresholdMet",
        AssetNotVoteable = "AssetNotVoteable"
    },
    PLAY_GAME_ERROR_CODE = 6
}
