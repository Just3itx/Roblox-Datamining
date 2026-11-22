-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local React = require(MomentsParent.React)
local Foundation = require(MomentsParent.Foundation)
local _MomentsTypes = require(MomentsParent.MomentsTypes)

local FFlagMomentsServeEDPVideos = require(MomentsParent.SharedFlags).FFlagMomentsServeEDPVideos
local FFlagMomentsPostFeedback = require(MomentsParent.SharedFlags).FFlagMomentsPostFeedback

local View = Foundation.View

local ActionRail = require(script.Parent.ActionRail)
local MomentContext = require(script.Parent.Parent.MomentContext)
local VideoInfo = require(script.Parent.VideoInfo)

return React.memo(function(tbl1) -- name: TopContent
    local var1 = if FFlagMomentsPostFeedback then MomentContext.useMoment().store.getData(false) else nil
    local bool1 = not (var1 == nil or var1.kind ~= "experience") and var1.isPending == true
    local createElement = React.createElement
    local var2 = View
    local tbl2 = {
        LayoutOrder = tbl1.LayoutOrder,
        tag = "row align-x-left align-y-bottom gap-large size-full-0 auto-y"
    }
    local tbl3 = {
        VideoInfo = React.createElement(VideoInfo, { LayoutOrder = 1, moment = if FFlagMomentsServeEDPVideos then tbl1.moment else nil }),
        ActionRail = if bool1 then nil else React.createElement(ActionRail, { LayoutOrder = 2, moment = tbl1.moment, onOpenComments = tbl1.onOpenComments })
    }
    return createElement(var2, tbl2, tbl3)
end)
