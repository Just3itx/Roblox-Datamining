-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:20:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Signals = require(MomentsParent.Signals)
local SignalsReact = require(MomentsParent.SignalsReact)

local GameGetGameInfoStore = require(MomentsParent.DataHydration.GameGetGameInfoStore)

local FFlagMomentsServeEDPVideos = require(MomentsParent.SharedFlags).FFlagMomentsServeEDPVideos

local useSignalState = SignalsReact.useSignalState

local tbl1 = { name = nil, creatorName = nil, isCreatorVerified = false, rootPlaceId = nil }

local computed = Signals.createComputed(function()
    return nil
end)

return function(num1: number?)
    local var1 = if num1 and num1 ~= 0 then tostring(num1) else nil
    local var2 = if var1 then GameGetGameInfoStore(false).getAndFetchGameInfo(var1).data else computed
    local var3 = useSignalState(var2)

    if var3 == nil then
        return tbl1
    end

    local creator = var3.creator
    local tbl2 = {
        name = var3.name,
        creatorName = if creator then creator.name else nil,
        isCreatorVerified = if creator then creator.hasVerifiedBadge == true else false,
        rootPlaceId = if FFlagMomentsServeEDPVideos then tonumber(var3.rootPlaceId) else nil
    }
    return tbl2
end
