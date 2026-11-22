-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:31:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Signals = require(MomentsParent.Signals)
local _MomentsStoreTypes = require(MomentsParent.DataHydration.MomentsStoreTypes)
local _FeedTypes = require(Moments.Components.Feed.FeedTypes)

local function createPendingFeedGetter(num1: number, arg1)
    return Signals.createComputed(function(arg2)
        return arg1.getPendingUserMoments(arg2)[num1] or {}
    end)
end

return createPendingFeedGetter
