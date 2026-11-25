-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local React = require(ProfilePlatformParent.React)
local Foundation = require(ProfilePlatformParent.Foundation)
local BuilderIcons = require(ProfilePlatformParent.BuilderIcons)
local MomentsCommon = require(ProfilePlatformParent.MomentsCommon)
local _MomentsStoreTypes = require(ProfilePlatformParent.DataHydration.MomentsStoreTypes)
local SignalsReact = require(ProfilePlatformParent.SignalsReact)
local ToMediaItem = require(ProfilePlatformParent.Moments.ToMediaItem)
local useSceneOutfitMediaItem = require(script.Parent.useSceneOutfitMediaItem)
local SceneOutfitPoster = require(script.Parent.SceneOutfitPoster)

local MomentEngagementCount = require(script.Parent.MomentEngagementCount)
local FFlagMomentsEngagementMetricsFeature = MomentsCommon.Flags.FFlagMomentsEngagementMetricsFeature
local FFlagProfileMomentSceneOutfitPoster = require(ProfilePlatformParent.SharedFlags).FFlagProfileMomentSceneOutfitPoster
local FFlagMomentsPostFeedback = require(ProfilePlatformParent.SharedFlags).FFlagMomentsPostFeedback
local PostStatusBadge = require(ProfilePlatformParent.Moments.PostStatusBadge)

local View = Foundation.View
local ControlState = Foundation.Enums.ControlState
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance
local useTokens = Foundation.Hooks.useTokens
local useSignalState = SignalsReact.useSignalState

local Analytics = MomentsCommon.Analytics
local GetMomentsCapabilities = MomentsCommon.Stores.GetMomentsCapabilities
local fireAnalyticsEvent = Analytics.fireAnalyticsEvent
local EventNames = Analytics.EventNames
local makeProfileTileFields = require(ProfilePlatform.Analytics.makeProfileTileFields)

local MomentMediaTile = MomentsCommon.Media.MomentMediaTile
local GradientBackdrop = MomentsCommon.Components.GradientBackdrop

local ThumbUp = BuilderIcons.Icon.ThumbUp

local function MomentGridItem(tbl1)
    local moment = tbl1.moment
    local onHoverChanged = tbl1.onHoverChanged
    local var1 = useTokens()
    local bool1 = if FFlagMomentsEngagementMetricsFeature then useSignalState(GetMomentsCapabilities(false).getIsEngagementMetricsEnabled) else nil

    React.useEffect(function()
        if not tbl1.userId or not moment.recommendationMetadata then
            return
        end

        local profileTileImpressionFields = makeProfileTileFields.makeProfileTileImpressionFields(moment, tbl1.userId, "grid", tbl1.index or 0)
        if profileTileImpressionFields then
            fireAnalyticsEvent(EventNames.ProfileMomentTileImpression, profileTileImpressionFields)
        end
    end, {})

    local var2 = React.useMemo(function()
        return (ToMediaItem({ kind = "moment", moment = moment }))
    end, { moment.momentId })

    local var3 = if FFlagProfileMomentSceneOutfitPoster then useSceneOutfitMediaItem(moment, var2) else nil

    local onStateChanged = React.useCallback(function(hover)
        onHoverChanged(hover == ControlState.Hover)
    end, { onHoverChanged })

    if not FFlagMomentsEngagementMetricsFeature or bool1 then
        if moment.metadata.likeCount == nil then
            bool1 = false
        else
            bool1 = moment.metadata.likeCount > 0
        end
    end

    local createElement = React.createElement
    local var5 = View
    local tbl2 = {
        Size = UDim2.fromScale(1, 1),
        onActivated = tbl1.onActivated,
        onStateChanged = onStateChanged,
        stateLayer = {
            affordance = StateLayerAffordance.None
        },
        tag = "clip"
    }
    local tbl3 = { Media = 0, ScenePoster = 0, BottomGradient = 0, Engagement = 0, StatusBadge = 0 }
    local createElement2 = React.createElement
    local var6 = MomentMediaTile
    local tbl4 = { mediaItem = 0, isActive = 0 }
    if var3 ~= nil then
        var2 = var3.mediaItem
    end

    tbl4.mediaItem = var2
    tbl4.isActive = tbl1.isActive
    tbl3.Media = createElement2(var6, tbl4)

    tbl3.ScenePoster = if var3 == nil or var3.scenePoster == nil then nil else React.createElement(SceneOutfitPoster, { content = var3.scenePoster, zIndex = 2 })

    tbl3.BottomGradient = if bool1 then React.createElement(GradientBackdrop, {
        anchorPoint = Vector2.new(0, 1),
        color3 = var1.Color.Common.Scrim.Color3,
        position = UDim2.fromScale(0, 1),
        rotation = -90,
        size = UDim2.fromScale(1, 0.5),
        startingTransparency = 0,
        zIndex = if FFlagProfileMomentSceneOutfitPoster then 3 else 2
    }) else nil

    tbl3.Engagement = if bool1 then React.createElement(View, {
        tag = "row align-x-right align-y-center gap-small position-bottom-right anchor-bottom-right auto-xy padding-small",
        ZIndex = if FFlagProfileMomentSceneOutfitPoster then 4 else 3
    }, {
        Reactions = React.createElement(
            MomentEngagementCount,
            {
                layoutOrder = 1,
                icon = ThumbUp,
                count = moment.metadata.likeCount,
                onMedia = true
            }
        )
    }) else nil

    tbl3.StatusBadge = if FFlagMomentsPostFeedback then React.createElement(PostStatusBadge, { momentId = moment.momentId, ZIndex = 5 }) else nil
    return createElement(var5, tbl2, tbl3)
end

return MomentGridItem
