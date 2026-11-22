-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:30:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local MomentsCommon = require(MomentsParent.MomentsCommon)
local SignalsReact = require(MomentsParent.SignalsReact)

local useMomentMediaController = MomentsCommon.Media.useMomentMediaController
local useMomentsSurfaceReadyTracking = MomentsCommon.Performance.useMomentsSurfaceReadyTracking

local _FeedTypes = require(script.Parent.FeedTypes)

local function SurfaceReadyTracker(tbl1)
    local pager = tbl1.pager

    local var1 = SignalsReact.useSignalState(pager.getCurrentItem)
    local momentId = if var1 == nil or var1.kind ~= "moment" then nil else var1.moment.momentId
    local isVideo = not (var1 == nil or var1.kind ~= "moment") and var1.moment.metadata.captureType == Enum.CaptureType.Video
    local var2 = useMomentMediaController(momentId or "")

    local var3 = useMomentsSurfaceReadyTracking
    local tbl2 = { controller = 0, isVideo = 0, enabled = 0 }
    if not momentId then
        var2 = nil
    end

    tbl2.controller = var2
    tbl2.isVideo = isVideo
    tbl2.enabled = momentId ~= nil
    var3(tbl2)

    return nil
end

return SurfaceReadyTracker
