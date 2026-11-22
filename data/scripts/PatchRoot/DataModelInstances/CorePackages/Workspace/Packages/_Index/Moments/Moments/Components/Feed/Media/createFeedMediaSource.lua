-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:30:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local _Signals = require(MomentsParent.Signals)
local _MomentsCommon = require(MomentsParent.MomentsCommon)

local _FeedTypes = require(Moments.Components.Feed.FeedTypes)
local FFlagMomentsModeratedMomentPage = require(Moments.Flags.FFlagMomentsModeratedMomentPage)
local FFlagMomentsRenderAvatarPostsInFeed = require(MomentsParent.SharedFlags).FFlagMomentsRenderAvatarPostsInFeed
local FFlagMomentsServeEDPVideos = require(MomentsParent.SharedFlags).FFlagMomentsServeEDPVideos
local GameGetPlayabilityStore = if FFlagMomentsServeEDPVideos then require(MomentsParent.DataHydration.GameGetPlayabilityStore) else nil
local isVideoEligibleForPlayability = if FFlagMomentsServeEDPVideos then require(MomentsParent.VideoUtils).isVideoEligibleForPlayability else nil
local toMediaItem = require(script.Parent.toMediaItem)

local function hasMedia(arg1): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
    if FFlagMomentsRenderAvatarPostsInFeed and arg1.kind == "avatarMoment" then
        return arg1.moment.metadata ~= nil
    end
    if arg1.kind ~= "moment" then
        return false
    end
    local moment = arg1.moment
    return not (moment == nil) and moment.metadata ~= nil
end

local function createFeedMediaSource(arg1, getPlaybackActive, getCanAutoPlay)
    local var1 = FFlagMomentsServeEDPVideos and {} or nil
    local var2 = FFlagMomentsServeEDPVideos and function(arg2, arg3)
        if not hasMedia(arg2) then
            return false
        end
        local moment = arg2.moment
        if moment.entityType ~= "edpVideo" then
            return true
        end

        local universeId = moment.metadata.universeId
        if universeId == nil or universeId <= 0 then
            return false
        end
        local str1 = tostring(universeId)
        local var2 = var1[str1]
        if var2 == nil then
            var2 = GameGetPlayabilityStore(false).getPlayability(str1)
            var1[str1] = var2
        end
        local var3 = var2.status(arg3)
        return isVideoEligibleForPlayability(var3 == "Ready", var2.data(arg3))
    end or nil

    local function getItems(arg2)
        local result = {}

        for _, value in (arg1.getItems(arg2)) do
            if FFlagMomentsServeEDPVideos and not var2(value, arg2) then
                continue
            end

            local var3 = toMediaItem(value, { includeLocalTts = true })
            if var3 ~= nil then
                table.insert(result, var3)
            end
        end

        return result
    end

    local function func2(arg2)
        local items = arg1.getItems(arg2)
        local currentIndex = arg1.getCurrentIndex(arg2)
        local num1 = 0
        local var3 = currentIndex - 1
        local itemsLen = #items

        for i = 1, math.min(var3, itemsLen) do
            if if FFlagMomentsServeEDPVideos then var2(items[i], arg2) else hasMedia(items[i]) then
                num1 += 1
            end
        end
        local item = items[currentIndex]
        if item ~= nil and (if FFlagMomentsServeEDPVideos then var2(item, arg2) else hasMedia(item)) then
            return num1 + 1
        end

        return num1 + 0.5
    end

    local tbl1 = { getActiveIndex = 0, getItems = 0, getPlaybackActive = 0, getCanAutoPlay = 0 }
    if not (FFlagMomentsModeratedMomentPage or FFlagMomentsServeEDPVideos) then
        func2 = arg1.getCurrentIndex
    end

    tbl1.getActiveIndex = func2

    tbl1.getItems = getItems
    tbl1.getPlaybackActive = getPlaybackActive
    tbl1.getCanAutoPlay = getCanAutoPlay
    return tbl1
end

return createFeedMediaSource
