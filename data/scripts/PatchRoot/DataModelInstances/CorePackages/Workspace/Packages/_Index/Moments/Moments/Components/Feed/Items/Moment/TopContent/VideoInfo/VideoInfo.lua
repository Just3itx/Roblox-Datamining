-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:21:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local React = require(MomentsParent.React)
local Foundation = require(MomentsParent.Foundation)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local _MomentsTypes = require(MomentsParent.MomentsTypes)
local SignalsReact = require(MomentsParent.SignalsReact)

local MomentContext = require(script.Parent.Parent.Parent.MomentContext)

local FFlagMomentsEngagementMetricsFeature = MomentsCommon.Flags.FFlagMomentsEngagementMetricsFeature
local FFlagMomentsServeEDPVideos = require(MomentsParent.SharedFlags).FFlagMomentsServeEDPVideos
local FFlagMomentsRenderAvatarPostsInFeed = require(MomentsParent.SharedFlags).FFlagMomentsRenderAvatarPostsInFeed
local CreatorAttribution = require(script.Parent.CreatorAttribution)
local DebugInfo = require(script.Parent.DebugInfo)
local Description = require(script.Parent.Description)
local Reactions = require(script.Parent.Reactions)
local StatusChip = require(script.Parent.StatusChip)

local useMomentsSession = require(Moments.Stores.GetMomentsStore.MomentsSessionContext).useMomentsSession

local View = Foundation.View

local GetMomentsCapabilities = MomentsCommon.Stores.GetMomentsCapabilities
local useSignalState = SignalsReact.useSignalState

return React.memo(function(tbl1) -- name: VideoInfo
    local var1 = MomentContext.useMoment()
    local kind = useSignalState(var1.store.getData).kind
    local var2 = kind == "experience" or FFlagMomentsRenderAvatarPostsInFeed and kind == "avatar"
    local bool1 = if FFlagMomentsServeEDPVideos then not (tbl1.moment == nil) and tbl1.moment.entityType == "edpVideo" else nil
    local var3 = if FFlagMomentsEngagementMetricsFeature then useSignalState(GetMomentsCapabilities(false).getIsEngagementMetricsEnabled) else nil
    local var4 = useMomentsSession()

    local tbl2 = {}

    if not useSignalState(var4.getHideDetails) then
        tbl2.DebugInfo = React.createElement(DebugInfo, { LayoutOrder = 0 })

        tbl2.CreatorAttribution = if var2 and not (FFlagMomentsServeEDPVideos and bool1) then React.createElement(CreatorAttribution, { LayoutOrder = 1 }) else nil

        tbl2.Description = React.createElement(Description, { LayoutOrder = 2 })

        tbl2.Reactions = if var2 and (not FFlagMomentsEngagementMetricsFeature or var3) then React.createElement(Reactions, { LayoutOrder = 3 }) else nil

        tbl2.StatusChip = React.createElement(StatusChip, { LayoutOrder = 4 })
    end

    return React.createElement(
        View,
        {
            LayoutOrder = tbl1.LayoutOrder,
            tag = "col align-x-left align-y-bottom grow gap-small auto-y"
        },
        tbl2
    )
end)
