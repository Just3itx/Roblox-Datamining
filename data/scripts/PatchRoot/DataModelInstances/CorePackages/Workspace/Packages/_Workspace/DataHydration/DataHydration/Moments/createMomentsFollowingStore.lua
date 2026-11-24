-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:41:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local HttpClient = require(DataHydrationParent.HttpClient)
local _MomentsStoreTypes = require(script.Parent.MomentsStoreTypes)
local fetchFollowingMoments = require(script.Parent.Requests.fetchFollowingMoments)

local function createMomentsFollowingStore(arg1)
    local var1 = arg1 or {}

    return {
        getFollowing = function(str1: string?)
            return HttpClient.asPromise(fetchFollowingMoments(str1, var1.network))
        end,
        clear = function() end,
        dispose = function() end
    }
end

return createMomentsFollowingStore
