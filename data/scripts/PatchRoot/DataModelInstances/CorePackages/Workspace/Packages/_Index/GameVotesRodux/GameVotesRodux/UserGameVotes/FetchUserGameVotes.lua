-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:00:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameVotesRodux = script:FindFirstAncestor("GameVotesRodux")
local GameVotesRoduxParent = GameVotesRodux.Parent
local Promise = require(GameVotesRoduxParent.Promise)
local PerformFetch = require(GameVotesRoduxParent.Http).PerformFetch
local Logging = require(GameVotesRoduxParent.AppCommonLib).Logging
local SetNetworkingErrorToast = require(GameVotesRoduxParent.RobloxAppToastsRodux).Thunks.SetNetworkingErrorToast
local GetUserGameVotes = require(GameVotesRodux.UserGameVotes.GetUserGameVotes)
local SetUserGameVotes = require(GameVotesRodux.UserGameVotes.SetUserGameVotes)
local VoteStatus = require(GameVotesRodux.Enums.VoteStatus)

local function getUserVoteStatus(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    if arg1 == true then
        return VoteStatus.VotedUp
    elseif arg1 == false then
        return VoteStatus.VotedDown
    elseif arg1 == nil then
        return VoteStatus.NotVoted
    end

    return nil
end

local module = {}

local function fetchKeymapper(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return "luaapp.gamesapi.user-game-votes" .. arg1
end

function module.Fetch(arg1, arg2)
    assert(
        type(arg2) == "string",
        string.format("FetchUserGameVotes thunk expects universeId to be a string, was %s", type(arg2))
    )

    return PerformFetch.Single(fetchKeymapper(arg2), function(arg3)
        return GetUserGameVotes(arg1, arg2):andThen(function(arg4)
            local responseBody = arg4.responseBody

            if responseBody == nil or responseBody.canVote == nil or responseBody.reasonForNotVoteable == nil then
                Logging.warn("Response from GetUserGameVotes is malformed!")
                return Promise.reject({ HttpError = Enum.HttpError.OK })
            end

            local userVote = responseBody.userVote
            local userVoteStatus = if userVote == true then getUserVoteStatus(true) elseif userVote == false then getUserVoteStatus(false) elseif userVote == nil then getUserVoteStatus(nil) else nil

            if userVoteStatus then
                arg3:dispatch(SetUserGameVotes(arg2, responseBody.canVote, userVoteStatus, responseBody.reasonForNotVoteable))

                return Promise.resolve(arg4)
            end

            Logging.warn("Response from GetUserGameVotes is malformed!")
            return Promise.reject({ HttpError = Enum.HttpError.OK })
        end, function(arg4)
            arg3:dispatch(SetNetworkingErrorToast(arg4))
            return Promise.reject(arg4)
        end)
    end)
end

function module.GetFetchingStatus(arg1, arg2)
    return PerformFetch.GetStatus(arg1, (fetchKeymapper(arg2)))
end

return module
