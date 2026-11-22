-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local _MomentsTypes = require(MomentsParent.MomentsTypes)

local _FeedTypes = require(Moments.Components.Feed.FeedTypes)

local function getContentType(arg1): string -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1.postAsset ~= nil and arg1.postAsset.isAvatar == true or arg1.metadata.isMomentScene then
        return "Avatar"
    end

    if arg1.entityType == "edpVideo" then
        return "GamePreviewVideo"
    end

    if arg1.metadata.partnerUploadType == "influencer" then
        return "DynamicUpload"
    end

    if arg1.metadata.captureType == Enum.CaptureType.Screenshot then
        return "Static"
    end

    return "Dynamic"
end

local function makeRecommendationAttribution(arg1, arg2, arg3): {contentType: number, itemId: any, tracingId: any}?
    if arg1 == nil then
        return nil
    end

    local feedItemId = arg1.feedItemId
    if feedItemId == nil or feedItemId == "" then
        return nil
    end
    local tbl1 = {
        itemId = feedItemId,
        tracingId = arg1.tracingId,
        contentType = 0
    }

    if not arg3 then
        if arg2 == nil then
            arg3 = nil
        else
            arg3 = getContentType(arg2)
        end
    end

    tbl1.contentType = arg3
    return tbl1
end

return makeRecommendationAttribution
