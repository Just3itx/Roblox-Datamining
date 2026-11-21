-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameVotesRodux = script:FindFirstAncestor("GameVotesRodux")
local GameVotesRoduxParent = GameVotesRodux.Parent
local Promise = require(GameVotesRoduxParent.Promise)
local PerformFetch = require(GameVotesRoduxParent.Http).PerformFetch
local Logging = require(GameVotesRoduxParent.AppCommonLib).Logging
local SetNetworkingErrorToast = require(GameVotesRoduxParent.RobloxAppToastsRodux).Thunks.SetNetworkingErrorToast
local SetGameVotes = require(GameVotesRodux.GameVotes.SetGameVotes)
local GetGameVotes = require(GameVotesRodux.GameVotes.GetGameVotes)

local module = {}

local function fetchKeymapper(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return "luaapp.gamesapi.game-votes" .. arg1
end

function module.Fetch(arg1, arg2)
    assert(
        type(arg2) == "string",
        string.format("FetchGameVotes thunk expects universeId to be a string, was %s", type(arg2))
    )

    return PerformFetch.Single(fetchKeymapper(arg2), function(arg3)
        return GetGameVotes(arg1, arg2):andThen(function(arg4)
            local responseBody = arg4.responseBody

            if responseBody ~= nil and responseBody.upVotes ~= nil and responseBody.downVotes ~= nil then
                arg3:dispatch(
                    SetGameVotes(
                        arg2,
                        if responseBody.upVotes < 0 then 0 else responseBody.upVotes,
                        if responseBody.downVotes < 0 then 0 else responseBody.downVotes
                    )
                )
                return Promise.resolve(arg4)
            end
            Logging.warn("Response from GetGameVotes is malformed!")
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
