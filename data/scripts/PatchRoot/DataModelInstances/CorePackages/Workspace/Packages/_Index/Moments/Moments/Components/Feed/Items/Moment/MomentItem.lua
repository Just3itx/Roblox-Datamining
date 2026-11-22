-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local AppComposition = require(MomentsParent.AppComposition)
local Foundation = require(MomentsParent.Foundation)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local _MomentsTypes = require(MomentsParent.MomentsTypes)
local React = require(MomentsParent.React)
local ReactUtils = require(MomentsParent.ReactUtils)
local SharedFlags = require(MomentsParent.SharedFlags)
local Signals = require(MomentsParent.Signals)
local SignalsReact = require(MomentsParent.SignalsReact)

local FoundationText = Foundation.Text
local View = Foundation.View

local useCompositionLayout = AppComposition.useCompositionLayout
local useDeviceInsets = MomentsCommon.Hooks.useDeviceInsets
local useTokens = Foundation.Hooks.useTokens

local GradientBackdrop = MomentsCommon.Components.GradientBackdrop

local momentLayout = require(script.Parent.momentLayout)
local MomentContext = require(script.Parent.MomentContext)
local MomentImpressionMemory = require(script.Parent.MomentImpressionMemory)
local useMomentsHost = require(Moments.MomentsHostContext).useMomentsHost
local AvatarActionBar = require(script.Parent.AvatarActionBar)
local CallToAction = require(script.Parent.CallToAction)
local Scrubber = require(script.Parent.Scrubber)
local TopContent = require(script.Parent.TopContent)
local VideoScrim = require(script.Parent.VideoScrim)
local PlaybackToggleIndicator = require(script.Parent.PlaybackToggleIndicator)
local MomentOverlayInsetContext = require(script.Parent.MomentOverlayInsetContext)
local MomentPushedFeedSafeAreaContext = require(script.Parent.MomentPushedFeedSafeAreaContext)
local ReactionEffectsContext = require(script.Parent.Reactions.ReactionEffectsContext)
local MomentGestureLayer = require(script.Parent.Reactions.MomentGestureLayer)
local ReactionExplosionLayer = require(script.Parent.Reactions.ReactionExplosionLayer)
local FFlagMomentsFeedAboveNavBar = require(Moments.Flags.FFlagMomentsFeedAboveNavBar)
local GetFFlagMomentsRenderPostAssets = require(MomentsParent.MomentsCommon.GetFFlagMomentsRenderPostAssets)
local FFlagMomentsAvatarLookTryOn = require(MomentsParent.SharedFlags).FFlagMomentsAvatarLookTryOn
local FFlagMomentsRenderAvatarPostsInFeed = SharedFlags.FFlagMomentsRenderAvatarPostsInFeed
local GetFFlagMomentsDisplayWakeLock = require(Moments.Flags.GetFFlagMomentsDisplayWakeLock)
local FFlagMomentsFixOverlayRemountImpressions = require(Moments.Flags.FFlagMomentsFixOverlayRemountImpressions)
local FFlagMomentsRecommendationContentType = require(Moments.Flags.FFlagMomentsRecommendationContentType)
local useDisplayWakeLock = require(Moments.Hooks.useDisplayWakeLock)
local useIsPlaying = require(Moments.Hooks.useIsPlaying)
local useMomentsSession = require(Moments.Stores.GetMomentsStore.MomentsSessionContext).useMomentsSession
local deriveMomentFromPost = require(Moments.Utils.deriveMomentFromPost)
local MomentsGetPostAssetStore = require(MomentsParent.DataHydration.MomentsGetPostAssetStore)
local FFlagMomentsComments = SharedFlags.FFlagMomentsComments
local VideoLiftContainer = if FFlagMomentsComments then require(script.Parent.VideoLift.VideoLiftContainer) else nil
local useCommentsChromeTransparency = if FFlagMomentsComments then require(script.Parent.useCommentsChromeTransparency) else nil
local useCommentsEvents = if FFlagMomentsComments then require(Moments.Components.Comments.useCommentsEvents) else nil

local function DisplayWakeLockEffect()
    local var1 = useIsPlaying()
    useDisplayWakeLock(var1)
    return nil
end

local function OverlayInfoFrame(tbl1)
    local var1 = useTokens()
    local var2 = MomentOverlayInsetContext.useMomentOverlayInset()
    local horizontalPadding = tbl1.horizontalPadding
    local verticalPadding = tbl1.verticalPadding
    local safeAreaInsets = tbl1.safeAreaInsets
    local var3 = if safeAreaInsets == nil then 0 else safeAreaInsets.left
    local var4 = if safeAreaInsets == nil then 0 else safeAreaInsets.right
    local var5 = if safeAreaInsets == nil then 0 else safeAreaInsets.bottom

    local var6 = if FFlagMomentsFeedAboveNavBar then 0 else var2

    local offset = math.max(verticalPadding, var5) + var6
    if var2 > 0 then
        offset = var1.Padding.Medium + var6
    end

    local padding = {
        top = UDim.new(0, verticalPadding),
        left = UDim.new(0, math.max(horizontalPadding, var3)),
        right = UDim.new(0, math.max(horizontalPadding, var4)),
        bottom = UDim.new(0, offset)
    }
    return React.createElement(View, {
        tag = "col align-x-center align-y-bottom gap-large position-bottom-center anchor-bottom-center size-full-0 auto-y",
        testId = "--moments-info-frame-overlay",
        padding = padding,
        sizeConstraint = {
            MaxSize = tbl1.maxSize
        },
        onAbsoluteSizeChanged = tbl1.onAbsoluteSizeChanged,
        ZIndex = 2
    }, tbl1.children)
end

local function MomentItem(tbl1)
    local var1 = useTokens()
    local var2 = useCompositionLayout()
    local var3 = useDeviceInsets()
    local nextOrder = ReactUtils.createNextOrder()
    local var4 = MomentPushedFeedSafeAreaContext.useMomentPushedFeedSafeArea()
    if var4 == nil then
        var4 = var3
    end

    local margin = var2.margin
    local moment = tbl1.moment
    local data = tbl1.data

    local mediaSurface = tbl1.mediaSurface
    local var5 = FFlagMomentsRenderAvatarPostsInFeed and tbl1.isStaticMedia == true
    local var6 = FFlagMomentsRenderAvatarPostsInFeed and tbl1.isWorkspaceRendered == true
    local var7

    if GetFFlagMomentsRenderPostAssets() then
        local postAssetId = if tbl1.moment == nil or tbl1.moment.postAsset == nil then nil else tbl1.moment.postAsset.postAssetId

        local var8 = React.useMemo(function()
            return Signals.createComputed(function(arg1)
                if postAssetId == nil then
                    return nil
                end
                return MomentsGetPostAssetStore(false).getCachedPostAsset(postAssetId).data(arg1)
            end)
        end, { postAssetId or false })
        local var9 = SignalsReact.useSignalState(var8)
        local var10 = React.useMemo(function()
            if tbl1.moment == nil or var9 == nil then
                return nil
            end
            return deriveMomentFromPost(tbl1.moment, var9)
        end, { tbl1.moment, var9 or false })
        moment = var10 or tbl1.moment
        if moment ~= nil and tbl1.renderMediaSurface ~= nil then
            mediaSurface = tbl1.renderMediaSurface(moment)
        end
        data = React.useMemo(function()
            if var10 == nil then
                return tbl1.data
            end
            local var11 = table.clone(tbl1.data)
            var11.description = var10.metadata.description or var11.description
            if var11.kind == "experience" then
                var11.placeId = var10.metadata.placeId or var11.placeId
                var11.universeId = var10.metadata.universeId or var11.universeId
                if FFlagMomentsAvatarLookTryOn then
                    var11.outfitId = var10.metadata.outfitId or var11.outfitId
                end
                if var10.metadata.hasAuthoritativePartnerUploadType then
                    var11.isSponsored = var10.metadata.partnerUploadType == "influencer"
                end
            end

            return if var11.description ~= tbl1.data.description
                or var11.kind == "experience"
                    and tbl1.data.kind == "experience"
                    and (var11.placeId ~= tbl1.data.placeId
                        or var11.universeId ~= tbl1.data.universeId
                        or var11.isSponsored ~= tbl1.data.isSponsored
                        or FFlagMomentsAvatarLookTryOn and var11.outfitId ~= tbl1.data.outfitId) then var11 else tbl1.data
        end, { tbl1.data, var9 or false })
        if data == tbl1.data then
            var7 = nil
        else
            var7 = `post:{postAssetId}`
        end
    else
        var7 = nil
    end

    local bool1

    if FFlagMomentsAvatarLookTryOn then
        local openAvatarLookTryOn = useMomentsHost().openAvatarLookTryOn
        local var8 = if data.kind == "experience" then data.outfitId elseif FFlagMomentsRenderAvatarPostsInFeed and data.kind == "avatar" and data.outfit.source.type == "outfit" then data.outfit.source.id else nil
        local id = if FFlagMomentsRenderAvatarPostsInFeed and data.kind == "avatar" and data.outfit.source.type == "look" then data.outfit.source.id else nil

        if openAvatarLookTryOn == nil or var8 == nil then
            bool1 = false
        else
            bool1 = var8 > 0
        end

        if not bool1 then
            if openAvatarLookTryOn == nil then
                bool1 = false
            else
                bool1 = id ~= nil
            end
        end
    else
        bool1 = false
    end

    if FFlagMomentsComments and VideoLiftContainer ~= nil and mediaSurface ~= nil then
        mediaSurface = React.createElement(VideoLiftContainer, { feedItemId = data.feedItemId }, mediaSurface)
    end

    local groupTransparency = if FFlagMomentsComments and useCommentsChromeTransparency ~= nil then useCommentsChromeTransparency(data.feedItemId) else nil
    local var9

    if FFlagMomentsComments and useCommentsEvents ~= nil then
        local var10 = useMomentsSession()

        var9 = useCommentsEvents(
            if moment == nil then nil else moment.recommendationMetadata,
            var10.getMomentsSessionId,
            if FFlagMomentsRecommendationContentType then data.contentType else nil
        )
    else
        var9 = nil
    end

    local size, var11 = React.useBinding(UDim2.fromScale(1, 0))

    local var12 = 2 * var1.Padding.XLarge
    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        var11(UDim2.new(1, 0, 0, arg1.AbsoluteSize.Y + var12))
    end, { var12 })

    local tbl2 = {
        TopContent = React.createElement(TopContent, { LayoutOrder = nextOrder(), moment = moment, onOpenComments = var9 }),
        Scrubber = if var5 then nil else React.createElement(Scrubber, { LayoutOrder = nextOrder() }),
        CallToAction = if FFlagMomentsRenderAvatarPostsInFeed and data.kind == "avatar" and not bool1 then nil else React.createElement(if bool1 then AvatarActionBar else CallToAction, { LayoutOrder = nextOrder() })
    }

    local bottomUiMaxSize = momentLayout.BOTTOM_UI_MAX_SIZE

    local infoFrame = React.createElement(OverlayInfoFrame, {
        horizontalPadding = margin,
        verticalPadding = var1.Padding.XLarge,
        safeAreaInsets = var4,
        maxSize = bottomUiMaxSize,
        onAbsoluteSizeChanged = onAbsoluteSizeChanged
    }, tbl2)

    local createElement = React.createElement
    local provider = MomentContext.Provider
    local tbl3 = { data = data, dataVersion = var7 }
    local tbl4 = { Root = 0, DisplayWakeLock = 0 }
    local createElement2 = React.createElement
    local var14 = View
    local tbl5 = {
        LayoutOrder = tbl1.layoutOrder,
        backgroundStyle = var6 and { Transparency = 1 } or nil,
        tag = {
            ["size-full clip"] = true,
            ["bg-surface-0"] = not var6
        },
        testId = "--moments-item-root"
    }

    local tbl6 = { Video = 0, Overlay = 0, PlaybackIndicator = 0, ReactionExplosionLayer = 0 }

    local createElement3 = React.createElement
    local var15 = View
    local tbl7 = { tag = "size-full", testId = "--moments-item-video", ZIndex = 1 }

    local tbl8 = { Surface = 0, Scrim = 0, GestureLayer = 0 }
    if mediaSurface == nil then
        mediaSurface = React.createElement(View, { tag = "size-full bg-surface-100" }, {
            Label = React.createElement(
                FoundationText,
                {
                    tag = "size-full text-body-large text-align-x-center text-align-y-center content-emphasis",
                    Text = "[ video ]"
                }
            )
        })
    end

    tbl8.Surface = mediaSurface

    tbl8.Scrim = React.createElement(VideoScrim, { ZIndex = 2 })

    tbl8.GestureLayer = React.createElement(MomentGestureLayer, { ZIndex = 3 })
    tbl6.Video = createElement3(var15, tbl7, tbl8)

    tbl6.Overlay = React.createElement(View, {
        tag = "position-bottom-center anchor-bottom-center size-full-0 auto-y",
        testId = "--moments-item-overlay",
        ZIndex = 2,
        GroupTransparency = groupTransparency
    }, {
        Backdrop = React.createElement(GradientBackdrop, { color3 = var1.Color.Common.Scrim.Color3, rotation = 270, size = size }),
        InfoFrame = infoFrame
    })

    tbl6.PlaybackIndicator = if var5 then nil else React.createElement(PlaybackToggleIndicator)

    tbl6.ReactionExplosionLayer = React.createElement(ReactionExplosionLayer)
    tbl4.Root = createElement2(var14, tbl5, tbl6)

    tbl4.DisplayWakeLock = if GetFFlagMomentsDisplayWakeLock() and not var5 then React.createElement(DisplayWakeLockEffect) else nil
    local element3 = createElement(provider, tbl3, tbl4)

    if FFlagMomentsFixOverlayRemountImpressions then
        element3 = React.createElement(MomentImpressionMemory.Provider, nil, element3)
    end

    return React.createElement(ReactionEffectsContext.Provider, nil, element3)
end

return MomentItem
