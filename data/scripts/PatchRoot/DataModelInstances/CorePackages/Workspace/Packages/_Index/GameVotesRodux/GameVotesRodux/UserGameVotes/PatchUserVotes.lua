-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local GameVotesRodux = script:FindFirstAncestor("GameVotesRodux")
local GameVotesRoduxParent = GameVotesRodux.Parent
local Promise = require(GameVotesRoduxParent.Promise)
local StatusCodes = require(GameVotesRoduxParent.Http).StatusCodes
local ReasonForNotVoteable = require(GameVotesRodux.Enums.ReasonForNotVoteable)
local VoteStatus = require(GameVotesRodux.Enums.VoteStatus)
local SetUserGameVotes = require(GameVotesRodux.UserGameVotes.SetUserGameVotes)
local GamesPatchUserVotes = require(GameVotesRodux.UserGameVotes.GamesPatchUserVotes)
local ToastType = require(GameVotesRoduxParent.ToastRodux).Enums.ToastType
local SetCurrentToastMessage = require(GameVotesRoduxParent.ToastRodux).Actions.SetCurrentToastMessage
local SetGameVotes = require(GameVotesRodux.GameVotes.SetGameVotes)
local SetNetworkingErrorToast = require(GameVotesRoduxParent.RobloxAppToastsRodux).Thunks.SetNetworkingErrorToast
local PerformFetch = require(GameVotesRoduxParent.Http).PerformFetch

local function getNewGameVotes(arg1, arg2, arg3)
    if arg2 == arg3 then
        return arg1
    end

    local upVotes = arg1 and arg1.upVotes
    local downVotes = arg1 and arg1.downVotes
    if arg3 == VoteStatus.VotedUp then
        upVotes += 1
        if arg2 == VoteStatus.VotedDown then
            downVotes -= 1
        end
    elseif arg3 == VoteStatus.VotedDown then
        downVotes += 1
        if arg2 == VoteStatus.VotedUp then
            upVotes -= 1
        end
    elseif arg3 == VoteStatus.NotVoted then
        if arg2 == VoteStatus.VotedUp then
            upVotes -= 1
        elseif arg2 == VoteStatus.VotedDown then
            downVotes -= 1
        end
    end

    return { upVotes = upVotes, downVotes = downVotes }
end

local function isTooManyRequestsError(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1 and arg1.HttpError == Enum.HttpError.OK and arg1.StatusCode == StatusCodes.TOO_MANY_REQUESTS
end

local function isPlayGameError(arg1)
    if arg1 and arg1.HttpError == Enum.HttpError.OK and arg1.StatusCode == StatusCodes.FORBIDDEN then
        local success, result = pcall(function()
            return HttpService:JSONDecode(arg1.Body)
        end)
        if success and result and result.errors then
            for _, error in ipairs(result.errors) do
                if error.code == 6 then
                    return true
                end
            end
        end
    end
    return false
end

local function fetchKeymapper(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return "luaapp.gamesapi.patch-user-votes" .. arg1
end

local module = { getNewGameVotes = getNewGameVotes }

function module.Patch(arg1, arg2, arg3, arg4)
    assert(
        type(arg2) == "string",
        string.format("PatchUserVotes thunk expects universeId to be a string, was %s", type(arg2))
    )
    assert(type(arg3) == "string", string.format("PatchUserVotes thunk expects vote to be a string, was %s", type(arg3)))

    assert(type(arg4) == "string", string.format("PatchUserVotes thunk expects curVote to be a string, was %s", type(arg4)))

    if arg3 == arg4 then
        return Promise.resolve()
    end

    return PerformFetch.Single(fetchKeymapper(arg2), function(arg5)
        return GamesPatchUserVotes(arg1, arg2, arg3):andThen(function(arg6)
            local var1 = arg5:getState().GameVotes[arg2]
            local newGameVotes = getNewGameVotes(var1, arg4, arg3)

            arg5:dispatch(SetGameVotes(arg2, newGameVotes.upVotes, newGameVotes.downVotes))
            arg5:dispatch(SetUserGameVotes(arg2, true, arg3, ""))
            return Promise.resolve(arg6)
        end, function(arg6)
            if isTooManyRequestsError(arg6) then
                arg5:dispatch(SetUserGameVotes(arg2, false, arg4, ReasonForNotVoteable.FloodCheckThresholdMet))

                arg5:dispatch(
                    SetCurrentToastMessage(
                        {
                            toastType = ToastType.NetworkingError,
                            toastMessage = "Feature.Toast.VoteError.FloodCheckThresholdMet"
                        }
                    )
                )
                return Promise.reject(arg6)
            end

            if not isPlayGameError(arg6) then
                arg5:dispatch(SetNetworkingErrorToast(arg6))
            else
                arg5:dispatch(SetUserGameVotes(arg2, false, arg4, ReasonForNotVoteable.PlayGame))
                arg5:dispatch(
                    SetCurrentToastMessage({ toastType = ToastType.NetworkingError, toastMessage = "Feature.Toast.VoteError.PlayGame" })
                )
            end

            return Promise.reject(arg6)
        end)
    end)
end

function module.GetPatchingStatus(arg1, arg2)
    return PerformFetch.GetStatus(arg1, (fetchKeymapper(arg2)))
end

return module
