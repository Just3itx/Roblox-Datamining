-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local SignalsReact = require(MomentsParent.SignalsReact)
local _MomentsStoreTypes = require(MomentsParent.DataHydration.MomentsStoreTypes)
local MomentsGetMomentsUserStore = require(MomentsParent.DataHydration.MomentsGetMomentsUserStore)

local function usePendingMomentRecord(momentId: string)
    for _, value in (SignalsReact.useSignalState(MomentsGetMomentsUserStore(false).getPendingUserMoments)) do
        if value == nil then
            continue
        end

        for _, value2 in value do
            if value2.moment.momentId == momentId then
                return if value2.publishedMoment == nil then value2 else nil
            end
        end
    end
    return nil
end

return usePendingMomentRecord
