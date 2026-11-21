-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:11:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameInfosRoduxParent = script:FindFirstAncestor("GameInfosRodux").Parent

local Cryo = require(GameInfosRoduxParent.Cryo)
local DataHydration = require(GameInfosRoduxParent.DataHydration)
local _DiscoveryTypes = require(GameInfosRoduxParent.DiscoveryTypes)
local tutils = require(GameInfosRoduxParent.tutils)

local tbl1 = { creator = true }

local function toStoreItem(arg1)
    return {
        universeId = arg1.universeId,
        rootPlaceId = arg1.placeId,
        name = arg1.name,
        playerCount = arg1.playerCount,
        contentMaturity = arg1.contentMaturity,
        gameMinimumAge = arg1.minimumAge,
        gameAgeDisplayName = arg1.ageRecommendationDisplayName,
        creator = (arg1.creatorId or arg1.creatorName) and {
            id = arg1.creatorId,
            name = arg1.creatorName
        } or nil
    }
end

local function isUnchanged(arg1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
    if not (arg1 and tutils.shallowEqual(arg1, Cryo.Dictionary.join(arg1, arg2), tbl1)) then
        return false
    else
        local creator = arg2.creator
        if creator == nil then
            return true
        end

        return tutils.shallowEqual(arg1.creator, creator)
    end
end

local function syncVotesToStore(tbl2)
    local votesStore = DataHydration.Game.getVotesStore(false)

    local tbl3 = ({})
    local bool1 = false

    for value, value2 in tbl2 do
        local totalUpVotes = value2.totalUpVotes
        local totalDownVotes = value2.totalDownVotes

        if totalUpVotes == nil or totalDownVotes == nil then
            continue
        end

        local vote = votesStore.getVote(value)
        local var1 = vote and vote.data(false)

        if var1 and var1.upVotes == totalUpVotes and var1.downVotes == totalDownVotes then
            continue
        end

        tbl3[value] = { upVotes = totalUpVotes, downVotes = totalDownVotes }
        bool1 = true
    end

    if bool1 then
        votesStore.updateVoteItems(tbl3)
    end
end

local function syncGameInfosToStore(tbl2)
    local gameInfoStore = DataHydration.Game.getGameInfoStore(false)

    local tbl3 = ({})
    local bool1 = false

    for value, value2 in tbl2 do
        local tbl4 = toStoreItem(value2)
        local gameInfo = gameInfoStore.getGameInfo(value)
        local var1 = if gameInfo then gameInfo.data(false) else nil
        local creator = if var1 then var1.creator else nil

        if creator and tbl4.creator then
            tbl4.creator = Cryo.Dictionary.join(creator, tbl4.creator)
        end

        if not isUnchanged(var1, tbl4) then
            tbl3[value] = tbl4
            bool1 = true
        end
    end

    if bool1 then
        gameInfoStore.updateGameInfos(tbl3, false)
    end

    syncVotesToStore(tbl2)
end

return syncGameInfosToStore
