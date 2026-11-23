-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local SignalsReact = require(BuildExperienceParent.SignalsReact)

local DataHydration = require(BuildExperienceParent.DataHydration)
local getGameInfoStore = DataHydration.Game.getGameInfoStore
local getVotesStore = DataHydration.Game.getVotesStore
local DataStatus = DataHydration.DataStatus

local function useInstantStats(num1: number)
    local str1 = tostring(num1)
    local var1 = getGameInfoStore(false).getAndFetchGameInfo(str1)
    local var2 = getVotesStore(false).getAndFetchVote(str1)
    local var3 = SignalsReact.useSignalState(var1.data)
    local var4 = SignalsReact.useSignalState(var1.status)
    local var5 = SignalsReact.useSignalState(var2.data)
    local var6 = SignalsReact.useSignalState(var2.status)

    local bool1 = var4 == DataStatus.NotReady
    local likesLoading = var6 == DataStatus.NotReady

    return {
        visits = if var3 == nil then nil else var3.totalVisits,
        players = if var3 == nil then nil else var3.playerCount,
        likes = if var5 == nil then nil else var5.upVotes,
        visitsLoading = bool1,
        playersLoading = bool1,
        likesLoading = likesLoading
    }
end

return useInstantStats
